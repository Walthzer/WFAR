#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * generates the 'wfar_boxLoader' saveList.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: wfar_boxLoader saveList <ARRAY>
 *
 * Example:
 * call wfar_continuity_fnc_saveBoxloader;
 *
 * Public: [No]
 */
TRACE_0("saveBoxloader");

/*
*   `fort` base class "Land_Boxloader_Fort_Base"
*   
*/

private _boxLoaderSaveList = [];
{
    if (isNull _x) then {continue};
    private _damageData = [_x] call EFUNC(continuity,getDamageData);
    private _side = _x getVariable [QGVAR(objectSide), sideEmpty];
    private _progress = -1;
    if (_x getVariable [QGVAR(requiredBuilders), 0] > 0) then {
        _progress = _x getVariable [QGVAR(progress), 0];
    };

    _boxLoaderSaveList pushBack [typeOf _x, getPosASL _x, [vectorDir _x, vectorUp _x], _damageData, _side, _progress];
} foreach GVAR(fortifyObjects);

_boxLoaderSaveList