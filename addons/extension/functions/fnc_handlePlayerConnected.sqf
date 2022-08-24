#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Log a player connection event to the database
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
TRACE_6("connected",_directPlayID,_steamID,_profileName,_didJiP,_machineID,_directPlayIDStr);

//Ignore Server Connecting to itself!
if (_profileName == "__SERVER__") exitWith {false};

GVAR(directIdMap) set [_directPlayIDStr, [_steamID, _profileName]];

["Connected", _profileName, _steamID] call FUNC(logPlayerEvent);