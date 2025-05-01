#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Clean up slot reservation for leaving player
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

private _slot = GVAR(slots) find _steamID;
if(_slot == -1) exitWith {
    LOG_2("Disconnecting player '%1' with no dynamics slot: %2",GVAR(slots),_steamID);
};
GVAR(slots) set [_slot, ""];
missionNamespace setVariable [QGVAR(slots), GVAR(slots), true];

