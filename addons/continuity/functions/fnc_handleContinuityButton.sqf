#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * handle the availibilty of the continuity button on the post-lobby map screen.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * call wfar_continuity_fnc_handleContinuityButton;
 *
 * Public: [No]
 */
disableSerialization;
params ["_control"];
TRACE_0("handleContinuityButton",_control);

if (call BIS_fnc_admin > 0) exitWith {};
if ((toLower (vehicleVarName player)) in ["overseer", "zeus"]) exitWith {};

_control ctrlEnable false;