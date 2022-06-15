#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Remove passed actions.
 *
 * Arguments:
 * 0: actions <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[]] call wfar_continuity_fnc_removePullActions;
 *
 * Public: [No]
 */
params["_actions"];
//TRACE_1("removePullActions",_actions);

{
	_x params ["_vehicle", "_path"];
	[_vehicle, 1, _path] call ace_interact_menu_fnc_removeActionFromObject;
} forEach _actions;