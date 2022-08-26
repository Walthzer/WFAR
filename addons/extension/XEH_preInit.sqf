#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

//Setup GVAR
GVAR(wfarDllLoaded) = call (uiNamespace getVariable [QGVAR(wfarDllLoaded), { false }]);

if (isServer && isDedicated) exitWith {

    GVAR(discordIdMap) = createHashMap;

    GVAR(directIdMap) = createHashMap;
    GVAR(kickedUserIDs) = []; 

    [QGVAR(syncClientDiscordData), {call FUNC(handleClientDiscordData)}] call CBA_fnc_addEventhandler;

    addMissionEventHandler ["ExtensionCallback", {call FUNC(handlePlayerEventCallback)}];

    addMissionEventHandler ["OnUserKicked", {call FUNC(handleUserKicked)}];
    addMissionEventHandler ["OnUserAdminStateChanged", {call FUNC(handleUserAdminStateChanged)}];
    addMissionEventHandler ["PlayerConnected", {call FUNC(handlePlayerConnected)}];
    addMissionEventHandler ["PlayerDisconnected", {call FUNC(handlePlayerDisconnected)}];

    //Only do extension commands if we can use the extension!
    if (GVAR(wfarDllLoaded)) then {
        "wfar" callExtension ["initWorker", []];
    };
};

//Only do extension commands if we can use the extension!
if (GVAR(wfarDllLoaded)) then {

    "wfar" callExtension ["initWorker", []];

    if !(hasInterface) then {break};

    GVAR(discordData) = [];
    GVAR(playerState) = "Loading in!";

    addMissionEventHandler ["ExtensionCallback", {call FUNC(handleClientCallbacks)}];

    [] call FUNC(toggleDiscordConnection);
    call FUNC(setDiscordRPC); //Clear Presence
    [GVAR(playerState)] call FUNC(setDiscordRPC); //update presence

    //Start dynamic rich presence -> updates every 5 seconds
    GVAR(dynamicRpcPFH) = [{

        private _state = [player] call FUNC(getReportablePlayerState);

        private _resetTime = false;
        if (GVAR(hasDied)) then {
            _resetTime = true;
            GVAR(hasDied) = false;
        };

        if (_state != GVAR(playerState) || _resetTime) then {
            GVAR(playerState) = _state;
            [_state, "White Fox Assault Regiment", _resetTime] call FUNC(setDiscordRPC);
        };
    }, 5] call CBA_fnc_addPerFrameHandler;
};