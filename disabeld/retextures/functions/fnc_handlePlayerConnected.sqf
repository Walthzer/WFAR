#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Reserve slot for connecting player
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

//Prevent duplicates
if (_steamID in GVAR(slots)) exitWith {};

private _slot = GVAR(slots) find "";
if(_slot == -1) exitWith {
    ERROR_1("No Free Dynamics Slots: %1",GVAR(slots));
};
GVAR(slots) set [_slot, _steamID];
missionNamespace setVariable [QGVAR(slots), GVAR(slots), true];