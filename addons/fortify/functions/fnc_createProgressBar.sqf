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
 * [player, wall] call wfar_fortify_fnc_createProgressBar
 *
 * Public: No
 */
params ["_player", "_object", "_buildTime", "_progress", "_requiredBuilders"];
TRACE_2("createProgressBar",_player,_object);

private _fnc_onCompletion = {
    params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
    _args params ["_player", "_object"];
    TRACE_3("completion",_player,_object,_elapsedTime);

    //Animation reset
    [_player, "", 1] call ace_common_fnc_doAnimation;
};

private _fnc_onFailure = {
    params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
    _args params ["_player", "_object"];
    TRACE_3("failure",_player,_object,_elapsedTime);

    //Animation reset
    [_player, "", 1] call ace_common_fnc_doAnimation;

    //if we stopped due to someone else leaving, return to waiting screen. else clean this player from building.
    if (_errorCode == 3) then {
        [_player, _object] call FUNC(playerHandelBuilding);
    } else {
        //remove player from builders list.
        [QGVAR(modifyBuilders), [_player, _object, true]] call CBA_fnc_serverEvent;
    };

};

private _fnc_condition = {
    params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
    _args params ["_player", "_object", "_requiredBuilders"];
    TRACE_3("condition",_player,_object,_requiredBuilders);

    //If building is stopped, stop the progress bar.
    if !(_object getVariable [QGVAR(isBuilding), false]) exitWith {false};

    // Animation loop (required for longer constructions)
    if (animationState _player isNotEqualTo "AinvPknlMstpSnonWnonDnon_medic4") then {
        // Perform animation
        [_player, "AinvPknlMstpSnonWnonDnon_medic4"] call ace_common_fnc_doAnimation;
    };

    // Return true always
    true
};

[_buildTime - _progress, [_player, _object, _requiredBuilders], _fnc_onCompletion, _fnc_onFailure, "Building the building that needs the building done.", _fnc_condition] call ACE_common_fnc_progressBar;