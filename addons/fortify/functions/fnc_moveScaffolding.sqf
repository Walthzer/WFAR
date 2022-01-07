#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Move the scaffolding on the build site of the passed object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * 0: Array of coordinates in modelSpace <ARRAY>
 *
 * Example:
 * [wall] call wfar_fortify_fnc_moveScaffolding
 *
 * Public: No
 */
params ["_object", "_scaffolding", "_buildTime", "_progress"];
TRACE_4("moveScaffolding",_object,_scaffolding,_buildTime,_progress);

private _raiseHeight = linearConversion [
        0,
        (_buildTime * GVAR(scaffoldTickModifier)) / 10,
        (_progress * GVAR(scaffoldTickModifier)) / 10,
        0,
        SCAFFOLD_GROUNDLEVEL,
        true
    ];

debugArray pushBack [diag_frameNo, _raiseHeight];

{
    private _sunkenPosition = _x getVariable [QGVAR(sunkenPostion), []];
    if (_sunkenPosition isEqualTo []) then {continue};
    
    private _newPosition = _sunkenPosition vectorAdd [0, 0, _raiseHeight];
    _x setPosASL _newPosition;
    _x setVectorUp (surfaceNormal _sunkenPosition);
} forEach _scaffolding;
