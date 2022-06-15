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
params ["_vehicle", "_player", "_unit"];

private _unitPosition = _unit modelToWorld (_unit selectionPosition "pelvis3");

//Could we load the unit?
if !(alive _unit && {vehicle _unit == _unit} && {animationState _unit in ["", "unconscious"] || (_unit getVariable ["ACE_isUnconscious", false])}) exitWith {false};

//Can we see the unit?
if !([_unit, "FIRE", _vehicle] checkVisibility [eyePos _player, AGLtoASL _unitPosition] > 0.5) exitWith {false};
if ([_vehicle, "FIRE"] intersect [ASLtoAGL (eyePos _player), _unitPosition] isNotEqualTo []) exitWith {false};

true