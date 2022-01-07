#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Remove grass at passed location.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * 0: Array of coordinates in modelSpace <ARRAY>
 *
 * Example:
 * [wall] call wfar_fortify_fnc_cutGrass
 *
 * Public: No
 */
params ["_position"];
TRACE_1("cutGrass",_position);

private _cutter = createVehicle ["Land_ClutterCutter_medium_F", ASLtoATL _position, [], 0, ""];
//deleteVehicle _cutter;

_cutter