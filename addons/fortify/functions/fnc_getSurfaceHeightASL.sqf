#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * getTerrainHeightASL but uses the top most walkable surface for height instead of terrain.
 *
 * Arguments:
 * 0: Position in ASL <ARRAY>
 * 1: Object to ignore <Object>
 * 2: Object to ignore <Object>
 *
 * Return Value:
 * 0: Height of the found surface in ASL <SCALAR>
 * 1: Intersection Position in ASL <ARRAY>
 * 2: Intersection Surface Normal <ARRAY>
 *
 * Example:
 * [_positionASL, _decal, _object] call wfar_fortify_fnc_getSurfaceHeightASL
 *
 * Public: No
 */
params ["_positionASL", ["_obj0", objNull], ["_obj1", objNull]];
TRACE_3("getSurfaceHeightASL",_positionASL,_obj0,_obj1);

private _positionGround =  +_positionASL;
_positionGround set [2, (getTerrainHeightASL _positionASL) - 1];

private _intersection = lineIntersectsSurfaces [_positionASL, _positionGround, _obj0, _obj1];
(_intersection select 0) params ["_intersectPositionASL", "_surfaceNormal", "_intersectObject"];

TRACE_2("INTERSECTION",_intersectPositionASL,_surfaceNormal);

private _surfaceHeightASL = _intersectPositionASL select 2;

[_intersectPositionASL, _surfaceNormal, _intersectObject]