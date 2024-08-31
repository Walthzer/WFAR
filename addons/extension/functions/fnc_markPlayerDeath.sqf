#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Mark the players death
 *
 * Arguments:
 * 0: _unit <OBJECT>
 * 1: _corpse <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _corpse] call wfar_extension_fnc_markPlayerDeath;
 *
 * Public: [No]
 */
params ["_unit", "_corpse"];
TRACE_2("markDeath",_unit,_corpse);

if !(_unit == player) exitWith {};

GVAR(hasDied) = true;