#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Add Pull In action for each unit around the passed vehicle
 *
 * Arguments:
 * 0: vehicle <OBJECT>
 *
 * Return Value:
 * 0: Added Actions <ARRAY>
 *
 * Example:
 * [_vehicle] call wfar_continuity_fnc_addPullActions;
 *
 * Public: [No]
 */
params["_vehicle"];

private _actions = [];
private _units = (ASLtoAGL getPosASL _vehicle) nearObjects ["Man", GVAR(AddActionsDistance)];
//TRACE_2("addPullActions",_vehicle,_units);

{
	private _unit = _x;

	_action = [
		format["%1_%2", QGVAR(action), _forEachIndex],
		name _unit,
		"",
		{
			params ["_vehicle", "_player", "_unit"];
			[
				{
					//waitUntil menu is closed
					ace_interact_menu_openedMenuType == -1;
				},
				{
					params ["", "", "_unit"];
					TRACE_1("beforeProgress",_this);
					[
						GVAR(pullDuration),
						_this,
						{
							TRACE_1("ProgressDone",_this);
							(_this select 0 ) params ["_vehicle", "_player", "_unit"];
							[QGVAR(moveInEH), [_vehicle, _player, _unit], _unit] call CBA_fnc_targetEvent;
						},
						{},
						format["Pulling in: %1", name _unit],
						{(_this select 0) call FUNC(canInteract)},
						["isnotinside"]
					] call ace_common_fnc_progressBar;
				},
				[_vehicle, _player, _unit],
				1
			] call CBA_fnc_waitUntilAndExecute;
		},
		{_this call FUNC(canInteract)},
		{},
		_unit,
		{
			private _unit = _actionData select 6;
			_target worldToModelVisual (_unit modelToWorld (_unit selectionPosition "pelvis3"));
		},
		GVAR(reach)

	] call ACE_interact_menu_fnc_createAction;

	_actions pushBack [_vehicle, ([_vehicle, 1, [], _action] call ACE_interact_menu_fnc_addActionToObject)];

} forEach _units;

_actions