#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * generates the 'wfar_fortify' saveList.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: wfar_fortify saveList <ARRAY>
 *
 * Example:
 * call wfar_fortify_fnc_saveFortify;
 *
 * Public: [No]
 */
TRACE_0("saveFortify");

private _fortifySaveList = [];
{
    if (isNull _x) then {continue};
    private _damageData = [_x] call EFUNC(continuity,getDamageData);
    private _side = _x getVariable [QGVAR(objectSide), sideEmpty];
    private _progress = -1;
    if (_x getVariable [QGVAR(requiredBuilders), 0] > 0) then {
        _progress = _x getVariable [QGVAR(progress), 0];
    };

    _fortifySaveList pushBack [typeOf _x, getPosASL _x, [vectorDir _x, vectorUp _x], _damageData, _side, _progress];
} forEach GVAR(fortifyObjects);

_fortifySaveList