#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * create and initialise the load Menu
 *
 * Arguments:
 * 0: parent display
 *
 * Return Value:
 * None
 *
 * Example:
 * call wfar_continuity_fnc_openLoadMenu;
 *
 * Public: [No]
 */
disableSerialization;
params ["_parentDisplay"];
TRACE_0("openLoadMenu",_parentDisplay);

_display = _parentDisplay createDisplay "wfar_DisplayContinuityLoad";
