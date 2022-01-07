#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Handel the remove action from a buildSite.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Fortify Object <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, bunker] call wfar_fortify_fnc_playerHandelRemoving
 *
 * Public: No
 */
params ["_player", "_object"];
TRACE_2("playerHandelRemoving",_player,_object);

private _onFinish = {
    params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
    _args params ["_player", "_object"];

    deleteVehicle _object;
};

private _condition = {
    params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
    _args params ["_player", "_object"];

    (_object isNotEqualTo objNull)
};

[10, [_player, _object], _onFinish, {}, "Removing Object!", _condition] call ACE_common_fnc_progressBar;

