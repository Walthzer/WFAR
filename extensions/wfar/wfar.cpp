#define _CRT_SECURE_NO_WARNINGS
#include <string>
#include <cstring>
#include <sstream>

#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <thread>
#include <mutex>
#include <queue>
#include <chrono>
#include <tuple>

#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "openssl/crypto.h"
#include "openssl/ssl.h"
#include "httplib.h"
#include <Windows.h>

//Discord
#define DISCORD_DISABLE_IO_THREAD
#define APPLICATION_ID "986639188722057276"
#include "discord_register.h"
#include "discord_rpc.h"

#ifdef DEBUG
#include "vld.h" //Leak Detector
#include <crtdbg.h>

int _CrtSetReportMode(
    int _CRT_ERROR,
    int _CRTDBG_MODE_DEBUG
);

int _CrtSetReportFile(_CRT_WARN, _CRTDBG_FILE_STDOUT);
#endif // DEBUG

namespace worker 
{
    volatile bool threadRunning{ false };
    volatile bool halt{ false };
}

struct Work {
    enum WorkTypes { Basic, DiscordState, DiscordPresence, HttpRequestWork };
    int type;
};

struct DiscordPresenceWork : Work 
{
    enum Goals { Update, Clear };
    int goal = Clear;
    
    bool resetTimeStamp = false;

    std::string state;
    std::string details;
    std::string smallKey;
    std::string largeKey;

};

struct DiscordStateWork : Work
{
    enum Goals { Start, Stop };
    int goal = Start;
};

struct HttpRequestWork : Work
{
    //enum Goals { Get, Post };
    //int goal = Get;
    int id{-1};
    std::string host{};
    std::string file{};
    std::string params{ "" };
    std::string contentType{ "application/x-www-form-urlencoded" };
};

struct Result
{
    int type{ Work::Basic };
    std::string data;
    bool succes{ 0 };
};

int(*callbackPtr)(char const* name, char const* function, char const* data) = nullptr;

std::thread workerThread;
std::queue<std::unique_ptr<Work>> workerWorkQueue;
std::queue<std::unique_ptr<Result>> workerResultQueue;
std::mutex workerLock;

//Discord
DiscordUser connectedDiscordUser;

int FetchRequestId()
{
    static int id = 0;
    id++;
    return id;
}

std::string QuoteString(std::string input)
{
    if (input[0] == '"')
    {
        return input;
    }
    else
    {
        return ("\"" + input + "\"");
    }
}
std::string QuoteString(const char* input)
{
    std::string inputStr(input);
    return QuoteString(inputStr);
}

std::string CreateSimpleArray(std::vector<std::string> input)
{
    std::string sArray{ '[' };
    for (std::string element : input)
    {
        sArray += element += ',';
    }
    sArray.pop_back();
    sArray += "]";
    return sArray;
}

//auto SendHttpRequest(HttpRequestWork request)
auto SendHttpRequest(std::unique_ptr<HttpRequestWork> request)
{
    httplib::Client client(request->host);
    client.enable_server_certificate_verification(true);

    if (request->params != "")
    {
        return client.Post(request->file, request->params, request->contentType);
    }
    else
    {
        return client.Get(request->file);
    }
}


/*--DISCORD--EVENTS--START--*/
static void handleDiscordReady(const DiscordUser* connectedUser)
{
    connectedDiscordUser = *connectedUser;
}
static void handleDiscordDisconnected(int errcode, const char* message)
{
    connectedDiscordUser = DiscordUser();
}
static void handleDiscordError(int errcode, const char* message)
{
    printf("\nDiscord: error (%d: %s)\n", errcode, message);
}
static void handleDiscordJoin(const char* secret)
{
    return;
}
static void handleDiscordSpectate(const char* secret)
{
    return;
}
static void handleDiscordJoinRequest(const DiscordUser* request)
{
    return;
}
/*--DISCORD--EVENTS--STOP--*/

void InitializeworkerThread()
{

    workerLock.lock();
    worker::threadRunning = true;
    workerLock.unlock();

    //Discord
    bool discordActive = false;
    uint64_t discordTimeStamp = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::system_clock::now().time_since_epoch()).count();

    do {

        while (!workerWorkQueue.empty()) // is there work?
        {
            workerLock.lock();
            std::unique_ptr<Work> workPtr = std::move(workerWorkQueue.front()); // get the the work
            workerWorkQueue.pop(); //Remove the work from the queue
            workerLock.unlock();

            //prepare results container
            std::unique_ptr<Result> resultPtr = std::make_unique<Result>();
            resultPtr->type = workPtr->type;
            resultPtr->data = "null";
            resultPtr->succes = 0; //Default to failed

            switch (workPtr->type)
            {
                case Work::HttpRequestWork: //We have Presence data
                {
                    std::unique_ptr<HttpRequestWork> request(static_cast<HttpRequestWork*>(workPtr.release()));

                    int requestId = request->id; //store id outside of pointer

                    try
                    {
                        auto result = SendHttpRequest(std::move(request));
                        if (result)
                        {
                            if (result->status == 200) {
                                resultPtr->data = CreateSimpleArray(std::vector<std::string>({ std::to_string(requestId), QuoteString(result->body) }));
                            }
                            else
                            {
                                resultPtr->data = CreateSimpleArray(std::vector<std::string>({ std::to_string(requestId), QuoteString("Request Error"), QuoteString(std::to_string(result->status)) }));
                            }
                        }
                        else {
                            auto err = result.error();
                            resultPtr->data = CreateSimpleArray(std::vector<std::string>({ std::to_string(requestId), QuoteString("Client Error"), QuoteString(httplib::to_string(err)) }));
                        }
                    }
                    catch (std::exception e)
                    {
                        resultPtr->data = CreateSimpleArray(std::vector<std::string>({ std::to_string(requestId), QuoteString("General Error"), QuoteString(e.what()) }));
                    }

                    if (callbackPtr)
                    {
                        callbackPtr("WFAR", "doHttpRequest", resultPtr->data.c_str());
                        resultPtr.reset();
                    }

                    break;
                }
                case Work::DiscordPresence: //We have Presence data
                {
                    if (discordActive)
                    {
                        std::unique_ptr<DiscordPresenceWork> presence(static_cast<DiscordPresenceWork*>(workPtr.release()));

                        if (presence->goal == DiscordPresenceWork::Update)
                        {

                            if (presence->resetTimeStamp)
                            {
                                discordTimeStamp = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::system_clock::now().time_since_epoch()).count();
                            }

                            DiscordRichPresence discordPresence;
                            memset(&discordPresence, 0, sizeof(discordPresence));
                            discordPresence.state = presence->state.c_str();
                            discordPresence.details = presence->details.c_str();
                            discordPresence.startTimestamp = discordTimeStamp;
                            discordPresence.largeImageKey = presence->largeKey.c_str();
                            discordPresence.smallImageKey = presence->smallKey.c_str();
                            Discord_UpdatePresence(&discordPresence);

                            resultPtr->data = QuoteString("Updated Presence");
                        }
                        else
                        {
                            Discord_ClearPresence();
                            resultPtr->data = QuoteString("Cleared Presence");
                        }
                    }
                    break;
                }
                case Work::DiscordState:
                {
                    std::unique_ptr<DiscordStateWork> work(static_cast<DiscordStateWork*>(workPtr.release()));

                    if (work->goal == DiscordStateWork::Start)
                    {

                        DiscordEventHandlers handlers;
                        memset(&handlers, 0, sizeof(handlers));
                        handlers.ready = handleDiscordReady;
                        handlers.disconnected = handleDiscordDisconnected;
                        handlers.errored = handleDiscordError;
                        handlers.joinGame = handleDiscordJoin;
                        handlers.spectateGame = handleDiscordSpectate;
                        handlers.joinRequest = handleDiscordJoinRequest;
                        Discord_Initialize(APPLICATION_ID, &handlers, 1, "107410");
                        discordActive = true;

                        resultPtr->data = QuoteString("Started Discord");
                        resultPtr->succes = 1;
                    }
                    else
                    {
                        if (discordActive)
                        {
                            discordActive = false;
                            Discord_Shutdown();

                            resultPtr->data = QuoteString("Stopped Discord");
                            resultPtr->succes = 1;
                        }
                    }
                    break;
                }
                default:
                {
                    resultPtr->data = QuoteString("Unhandeld");
                    break;
                }
            }

            if (resultPtr)
            {
                workerLock.lock();
                workerResultQueue.push(std::move(resultPtr));
                workerLock.unlock();
            }
        }

        if (discordActive) {
            #ifdef DISCORD_DISABLE_IO_THREAD
                Discord_UpdateConnection();
            #endif
            Discord_RunCallbacks();
        };
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    } while (!worker::halt);

    workerLock.lock();
    worker::threadRunning = false;
    workerLock.unlock();

    return;
}

const char* GetArgument(const char** argList, int argCount, int index = 0, const char* fallback = "")
{
    if (index < argCount)
    {
        return *(argList + index);
    }
    return fallback;
}
std::string GetArgumentStripped(const char** argList, int argCount, int index = 0, const char* fallback = "")
{
    std::string fallbackStr(fallback);
    if (index < argCount)
    {
        std::string arg{ GetArgument(argList, argCount, index) };
        if (arg[0] == '\"' && arg.length() >= 3)
        {
            arg.pop_back();
            arg.erase(arg.begin());
            return arg.c_str();
        } else
        {
            return fallbackStr;
        }
    }
    return fallbackStr;
}

//Start of Arma Extension Interfaces
//-----------------------------------------------------------------------------------------------------------
extern "C" {
    __declspec(dllexport) void __stdcall RVExtension(char* output, int outputSize, const char* function);
    __declspec(dllexport) int __stdcall RVExtensionArgs(char* output, int outputSize, const char* function, const char** argv, int argc);
    __declspec (dllexport) void __stdcall RVExtensionRegisterCallback(int(*callbackProc)(char const* name, char const* function, char const* data));
    __declspec(dllexport) void __stdcall RVExtensionVersion(char* output, int outputSize);
}

void __stdcall RVExtensionRegisterCallback(int(*callbackProc)(char const* name, char const* function, char const* data))
{
    callbackPtr = callbackProc;
}

void __stdcall RVExtension(char* output, int outputSize, const char* function) {  
    std::strncpy(output, "hello", outputSize - 1);
}


int __stdcall RVExtensionArgs(char* output, int outputSize, const char* function, const char** argv, int argc)
{

    if (std::strcmp(function, "getResults") == 0) 
    {
        if (!workerResultQueue.empty())
        {
            //prepare simple array format
            std::string outputBuffer{ '[' };

            while (!workerResultQueue.empty())
            {
                //append comma if we added data
                if (outputBuffer.size() > 1)
                {
                    outputBuffer += ',';
                }

                workerLock.lock();
                std::unique_ptr<Result> resultPtr = std::move(workerResultQueue.front()); // get the the result
                workerResultQueue.pop(); //Remove the result from the queue
                workerLock.unlock();

                //Append a the result formatted as a simpleArray
                outputBuffer += CreateSimpleArray(std::vector<std::string>({ std::to_string(resultPtr->type), QuoteString(resultPtr->data), std::to_string(resultPtr->succes) }));
            }
            outputBuffer += ']';
            std::strncpy(output, outputBuffer.c_str(), outputSize - 1);
            return 0;
        }
        else
        {
            std::strncpy(output, "No Results!", outputSize - 1);
            return 0;
        }

    }
    else if (std::strcmp(function, "doHttpRequest") == 0)//We want to set Rich Presence
    { 
        //Exit if we don't have enough arguments
        if (argc < 2)
        {
            std::strncpy(output, "Not Enough Arguments", outputSize - 1);
            return 1;
        }

        //Initialize an HttpRequestWork struct
        std::unique_ptr<HttpRequestWork> request = std::make_unique<HttpRequestWork>();
        request->type = Work::HttpRequestWork; //Set the type, should be in struct.
        int id = FetchRequestId(); //Give request a unique ID for when we get the results
        request->id = id;

        request->host = GetArgumentStripped(argv, argc, 0);
        request->file = GetArgumentStripped(argv, argc, 1);

        if (request->host == "" || request->file == "")
        {
            std::strncpy(output, "Malformed Arguments", outputSize - 1);
            return 1;
        }

        //Switch to Post if we have params
        if (argc > 2)
            request->params = std::string{ GetArgumentStripped(argv, argc, 2) };
        //Allow setting of Content-Type
        if (argc > 3)
            request->contentType = std::string{ GetArgumentStripped(argv, argc, 3, "application/x-www-form-urlencoded")};

        workerLock.lock();
        workerWorkQueue.push(std::move(request));
        workerLock.unlock();

        std::strncpy(output, std::to_string(id).c_str(), outputSize - 1);
        return 0;
    }
    else if (std::strcmp(function, "updatePresence") == 0) { //We want to set Rich Presence
    //Initialize an DiscordPresenceWork struct
        std::unique_ptr<DiscordPresenceWork> DiscordPresenceWorkPtr = std::make_unique<DiscordPresenceWork>();
        DiscordPresenceWorkPtr->type = Work::DiscordPresence; //Set the type, should be in struct.
        DiscordPresenceWorkPtr->goal = DiscordPresenceWork::Update;

        //Change Text on Presence
        DiscordPresenceWorkPtr->state = (GetArgumentStripped(argv, argc, 0, "Rifle'd Man"));
        DiscordPresenceWorkPtr->details = (GetArgumentStripped(argv, argc, 1, "White Fox Assault Regiment"));

        //Should we reset the timeStamp?
        if (argc > 2)
        {
            DiscordPresenceWorkPtr->resetTimeStamp = (GetArgumentStripped(argv, argc, 2, "false") == "true");
        }

        //Set the Pictures
        if (argc > 3)
        {
            DiscordPresenceWorkPtr->largeKey = (GetArgumentStripped(argv, argc, 3));
            if (argc > 4)
            {
                DiscordPresenceWorkPtr->smallKey =(GetArgumentStripped(argv, argc, 4));
            }
        }

        workerLock.lock();
        workerWorkQueue.push(std::move(DiscordPresenceWorkPtr));
        workerLock.unlock();

        std::strncpy(output, "Queueing Done", outputSize - 1);
        return 0;
    }
    else if (std::strcmp(function, "clearPresence") == 0)
    {
        //Initialize an DiscordPresenceWork struct
        std::unique_ptr<DiscordPresenceWork> DiscordPresenceWorkPtr = std::make_unique<DiscordPresenceWork>();
        DiscordPresenceWorkPtr->type = Work::DiscordPresence;
        DiscordPresenceWorkPtr->goal = DiscordPresenceWork::Clear;

        workerLock.lock();
        workerWorkQueue.push(std::move(DiscordPresenceWorkPtr));
        workerLock.unlock();

        std::strncpy(output, "Queueing Done", outputSize - 1);
        return 0;
    }
    else if (std::strcmp(function, "initWorker") == 0) //start worker thread
    { 
        //Start worker Thread if it's not active
        worker::halt = false;
        workerLock.lock();
        bool running = worker::threadRunning;
        workerLock.unlock();
        if (!running) {
            workerThread = std::thread(InitializeworkerThread);
            workerThread.detach();
            std::strncpy(output, "Worker Started", outputSize - 1);
            return 0;
        }
        else {
            std::strncpy(output, "Worker Already Running!", outputSize - 1);
            return 1;
        };
    }
    else if (std::strcmp(function, "stopWorker") == 0) //Stop the worker thread
    { 
        worker::halt = true;
        std::strncpy(output, "Stop Signal Sent", outputSize - 1);
        return 0;
    }
    else if (std::strcmp(function, "statusWorker") == 0) //Status of the worker thread
    { 
        workerLock.lock();
        bool running = worker::threadRunning;
        workerLock.unlock();
        if (!running) {
            std::strncpy(output, "stopped", outputSize - 1);
            return 0;
        }
        else {
            std::strncpy(output, "running", outputSize - 1);
            return 0;
        };
    }
    else if (std::strcmp(function, "initDiscord") == 0)
    {
        //Initialize an DiscordStateWork struct
        std::unique_ptr<DiscordStateWork> WorkPtr = std::make_unique<DiscordStateWork>();
        WorkPtr->type = Work::DiscordState;
        WorkPtr->goal = DiscordStateWork::Start;

        workerLock.lock();
        workerWorkQueue.push(std::move(WorkPtr));
        workerLock.unlock();
        std::strncpy(output, "Discord Start Queued", outputSize - 1);
        return 0;
    }
    else if (std::strcmp(function, "stopDiscord") == 0) //Initialize an DiscordStateWork struct
    {
        std::unique_ptr<DiscordStateWork> WorkPtr = std::make_unique<DiscordStateWork>();
        WorkPtr->type = Work::DiscordState;
        WorkPtr->goal = DiscordStateWork::Stop;

        workerLock.lock();
        workerWorkQueue.push(std::move(WorkPtr));
        workerLock.unlock();
        std::strncpy(output, "Discord Stop Signal Queued.", outputSize - 1);
        return 0;
    }
    else
    {
        std::strncpy(output, "Invalid Function!", outputSize - 1);
        return 0;
    };
}


void __stdcall RVExtensionVersion(char* output, int outputSize) {
    std::strncpy(output, "WFAR - Extension v0.2", outputSize - 1);
}

//-----------------------------------------------------------------------------------------------------------
//End of Arma Extension Interfaces