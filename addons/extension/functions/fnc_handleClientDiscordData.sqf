#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Handle Callbacks 
 *
 * Arguments:
 * 0: Callback name <STRING>
 * 1: Callback function <ARRAY>
 * 2: callback data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: [No]
 */
params ["_steamID", "_data"];
TRACE_2("clientDiscordData",_steamID,_data);

if (count _data < 3) exitWith {
    GVAR(discordIdMap) deleteAt _steamID;
};

GVAR(discordIdMap) set [_steamID, _data];