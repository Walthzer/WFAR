#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Run fixes needed on player respawn
 *
 * Arguments:
 * 0: _unit <OBJECT>
 * 1: _corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: [No]
 */
params ["_unit", "_corpse"];
TRACE_2("handleRespawn",_unit,_corpse);

//Disconnect UAV Terminal
_unit connectTerminalToUAV objNull;
_corpse connectTerminalToUAV objNull;