#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Log a change in playerAdminState to database
 *
 * Arguments:
 * 0: unique DirectPlay ID <SCALAR>
 * 1: Became admin (TRUE) or logged out (FALSE) <BOOL>
 * 2: User voted in as admin <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: [No]
 */
params ["_directPlayIDStr", "_becameAdmin", "_votedIn"];
TRACE_3("playerKicked",_directPlayIDStr,_becameAdmin,_votedIn);

if !((GVAR(directIdMap) getOrDefault [_directPlayIDStr, []]) params [["_steamID", ""], ["_profileName", ""]]) exitWith {};

private _event = "Changed Admin State :ISSUE:";

if (_becameAdmin) then {
    _event = ["Logged in as Admin", "Voted in as Admin"] select _votedIn;
} else {
    _event = "Logged out of Admin";
};

[_event, _profileName, _steamID] call FUNC(logPlayerEvent);