#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Send a specific event to the database
 *
 * Arguments:
 * 0: Event Description <STRING>
 * 1: profileName <ARRAY>
 * 2: steamID <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: [No]
 */
if !(params [["_event", "", [""]], ["_profileName", "PROFILE_NAME", [""]], ["_steamID", "STEAM_ID", [""]]]) exitWith {}; //Stop if we defaulted on a parameter
TRACE_3("logEvent",_event,_profileName,_steamID);

if (_profileName == "__SERVER__") exitWith {};

private _discordData = GVAR(discordIdMap) getOrDefault [_steamID, [] ]; //ID, Name, Discrimenator

//Fix race condition between discord data send and playerConnected event
if (_discordData isEqualTo []) exitWith {
    [{
        params ["_steamID"];
        (count GVAR(discordIdMap) getOrDefault [_steamID, [] ]) == 3;
    },
    {
        params ["_steamID", "_event", "_profileName"];

        private _discordData = GVAR(discordIdMap) getOrDefault [_steamID, [] ]; //ID, Name, Discrimenator

        _json = format["{ values: [ ['MS_ELAPSED_EPOCH', '%1', '%2', '%3#%4', '%5', '%6'] ] }", _event, _profileName, _discordData select 1, _discordData select 2, _steamID, _discordData select 0]; //Extension replaces MS_SINCE_EPOCH value
        "wfar" callExtension ["doHttpRequest", ["https://walthex.com", "/api/wfar/relay/appendPlayerEvent", _json, "application/json"]];
    }, [_steamID, _profileName], 5, {
        
        params ["_steamID", "_event", "_profileName"];

        _json = format["{ values: [ ['MS_ELAPSED_EPOCH', '%1', '%2', 'DISCORD_NAME', '%3', 'DISCORD_ID'] ] }", _event, _profileName, _steamID];
        "wfar" callExtension ["doHttpRequest", ["https://walthex.com", "/api/wfar/relay/appendPlayerEvent", _json, "application/json"]];

    }] call CBA_fnc_waitUntilAndExecute;
};

private _json = "";
if (count _discordData == 3 ) then {
    _json = format["{ values: [ ['MS_ELAPSED_EPOCH', '%1', '%2', '%3#%4', '%5', '%6'] ] }", _event, _profileName, _discordData select 1, _discordData select 2, _steamID, _discordData select 0]; //Extension replaces MS_SINCE_EPOCH value
} else {
    _json = format["{ values: [ ['MS_ELAPSED_EPOCH', '%1', '%2', 'DISCORD_NAME', '%3', 'DISCORD_ID'] ] }", _event, _profileName, _steamID];
};

//{ values: [ ["xx", "Voted in as Admin", "xxx", "xxx#xxx", "xxx", "xxx"] ] }

"wfar" callExtension ["doHttpRequest", ["https://walthex.com", "/api/wfar/relay/appendPlayerEvent", _json, "application/json"]];

