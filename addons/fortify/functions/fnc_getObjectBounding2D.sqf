#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Get the points of the 2D bounding rectangle from the object boundingBox. In counter-clockwise order.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * 0: Array of coordinates in modelSpace <ARRAY>
 *
 * Example:
 * [wall] call wfar_fortify_fnc_getObjectBounding2D
 *
 * Public: No
 */
params ["_object"];
TRACE_1("getObjectBoundingRectangle", _object);

(3 boundingBoxReal _object) params ["_pBottom", "_pTop"];

//create 2D rectangle from the boundingBox. In counter-clockwise order.
private _rectangle = 
    [
        [_pBottom select 0, _pBottom select 1],
        [_pTop select 0, _pBottom select 1],
        [_pTop select 0, _pTop select 1],
        [_pBottom select 0, _pTop select 1]
    ];

//Centers of the rectangle sides. In counter-clockwise order.
private _sideCenters = 
    [
        [0, _pBottom select 1],
        [_pTop select 0, 0],
        [0, _pTop select 1],
        [_pBottom select 0, 0]
    ];

[_rectangle, _sideCenters]