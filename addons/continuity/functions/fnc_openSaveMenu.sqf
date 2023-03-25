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
 * call wfar_continuity_fnc_openSaveMenu;
 *
 * Public: [No]
 */
disableSerialization;
params ["_parentDisplay"];
TRACE_1("openSaveMenu",_parentDisplay);

_display = _parentDisplay createDisplay "wfar_DisplayContinuitySave";
