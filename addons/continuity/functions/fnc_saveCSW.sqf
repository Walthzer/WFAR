#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * generates the 'wfar_csw' saveList.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: wfar_fortify saveList <ARRAY>
 *
 * Example:
 * call wfar_continuity_fnc_saveCSW;
 *
 * Public: [No]
 */
TRACE_0("saveCSW");

private _cswSaveList = [];
{
    if !(isNull attachedTo _x) then {continue}; //Skips ACE cargo csw's
    private _cswEdenID = _x getVariable [QGVAR(objectID), -1];
    private _cswKey = if (_cswEdenID > -1) then {_cswEdenID} else {typeOf _x};
    private _damageData = if (alive _x) then {
        [_x] call FUNC(getDamageData);
    } else {
        true
    };

    private _ammo = [];
    {
        _ammo pushBack (_x select [0, 3]);
    } forEach magazinesAllTurrets _x;

    _cswSaveList pushBack [_cswKey, getPosASL _x, [vectorDir _x, vectorUp _x], _damageData, _ammo];
} forEach (entities "StaticWeapon");

_cswSaveList