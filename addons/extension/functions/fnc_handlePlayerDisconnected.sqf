#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Log a player disconnection event to the database
 *
 * Arguments:
 * 0: unique DirectPlay ID <SCALAR>
 * 1: steamID <STRING>
 * 2: profileName <STRING>
 * 3: didJiP <BOOL>
 * 4: machine ID <SCALAR>
 * 5: PlayerID <STRING>
 *
 * Return Value:
 * None
 *
 * Public: [No]
 */
params ["_directPlayID", "_steamID", "_profileName", "_didJiP", "_machineID", "_directPlayIDStr"];
TRACE_6("disconnected",_directPlayID,_steamID,_profileName,_didJiP,_machineID,_directPlayIDStr);

if (_profileName == "__SERVER__") exitWith {};

//Prevent duplicate kicked/disconnect events in log
if (_directPlayIDStr in GVAR(kickedUserIDs)) exitWith {
    GVAR(kickedUserIDs) = GVAR(kickedUserIDs) select {_x != _directPlayIDStr}; //Clear for next kick
};

GVAR(directIdMap) deleteAt _directPlayIDStr;

["Disconnected", _profileName, _steamID] call FUNC(logPlayerEvent);

