#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Log a player kick event to database -> Kicked runs before disconnected!
 *
 * Arguments:
 * 0: unique DirectPlay ID <SCALAR>
 * 1: kick type number <SCALAR>
 * 2: kick type <STRING>
 * 3: reason given for the kick by the admin or by other means <STRING>
 * 4: formatted engine message including the given reason <STRING>
 *
 * Return Value:
 * None
 *
 * Public: [No]
 */
params ["_directPlayIDStr", "_kickTypeNumber", "_kickType", "_kickReason", "_kickMessageIncReason"];
TRACE_5("playerKicked",_directPlayIDStr,_kickTypeNumber,_kickType,_kickReason,_kickMessageIncReason);

//Prevent duplicate kicked/disconnect events in log
GVAR(kickedUserIDs) pushBackUnique _directPlayIDStr;

if ((GVAR(directIdMap) getOrDefault [_directPlayIDStr, []]) params [["_steamID", ""], ["_profileName", ""]]) then {
    GVAR(directIdMap) deleteAt _directPlayIDStr; //Consume 
};

[_kickMessageIncReason, _profileName, _steamID] call FUNC(logPlayerEvent);

