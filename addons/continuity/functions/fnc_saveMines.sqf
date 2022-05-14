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

if (true) exitWith {};

private _minesSaveList = [];
{
    private _damageData = [_x] call FUNC(getDamageData);
    private _progress = -1;
    if (_x getVariable [QGVAR(requiredBuilders), 0] > 0) then {
        _progress = _x getVariable [QGVAR(progress), 0];
    };

    _minesSaveList pushBack [typeOf _x, getPosASL _x, [vectorDir _x, vectorUp _x], _damageData, _ammo];
} foreach (entities [["StaticWeapon"], [], false, true]);

_minesSaveList