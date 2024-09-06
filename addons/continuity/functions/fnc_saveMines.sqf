#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * generates the 'wfar_mines' saveList.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: wfar_fortify saveList <ARRAY>
 *
 * Example:
 * call wfar_continuity_fnc_saveMines;
 *
 * Public: [No]
 */
TRACE_0("saveMines");

private _minesSaveList = [];
{
    _minesSaveList pushBack [typeOf _x, getPosASL _x, [vectorDir _x, vectorUp _x]];
} forEach allMines;

_minesSaveList