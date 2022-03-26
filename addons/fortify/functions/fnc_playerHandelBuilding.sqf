#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Handel the build action from a buildSite.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Fortify Object <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [wall] call wfar_fortify_fnc_playerHandelBuilding
 *
 * Public: No
 */
params ["_player", "_object"];
TRACE_2("playerHandelBuilding",_player,_object);

private _buildTime = _object getVariable [QGVAR(buildTime), 0];
Private _progress = _object getVariable [QGVAR(progress), 0];
private _requiredBuilders = _object getVariable [QGVAR(requiredBuilders), 0];


private _config = configFile >> "CfgVehicles" >> (typeOf _object);
private _displayName = getText (_config >> "displayName");
private _editorPreview = getText (_config >> "editorPreview");
private _requiredBuildersText = format ["%1/%2 Bobs", "%1", _requiredBuilders];

//Register player as a builder on the object
[QGVAR(modifyBuilders), [_player, _object]] call CBA_fnc_serverEvent;

//Create Building waiting list.
closeDialog 0;
createDialog QGVAR(buildersWaiting_dialog);

(uiNamespace getVariable QGVAR(ctrWaitToolBox)) lbSetText [0, format ["%1m %2s", round (_buildTime / 60), _buildTime mod 60]];
(uiNamespace getVariable QGVAR(ctrWaitToolBox)) lbSetText [1, _displayName];
(uiNamespace getVariable QGVAR(ctrWaitToolBox)) lbSetText [2, _requiredBuildersText];
(uiNamespace getVariable QGVAR(ctrlWaitPicture)) ctrlSetText _editorPreview;

[{
    params ["_args", "_handle"];
    _args params ["_player", "_object", "_buildTime", "_requiredBuildersText"];

    Private _progress = _object getVariable [QGVAR(progress), 0];
    private _isWaitDialogOpen = uiNamespace getVariable [QGVAR(waitDialogOpen), false];
    private _buildTimeRemaining = _buildTime - _progress;

    //Waiting Dialog is closed, or the building is done. Lets stop.
    if (!_isWaitDialogOpen || _buildTimeRemaining <= 0 || (!alive _player) || (isNull _object)) exitWith {
        if (_isWaitDialogOpen) then {closeDialog 0};

        //Remove player from builders
        [QGVAR(modifyBuilders), [_player, _object, true]] call CBA_fnc_serverEvent;

        //Animation reset
        [_player, "", 1] call ace_common_fnc_doAnimation;
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    //Update the dialog
    private _activeBuildersAmount = count (_object getVariable [QGVAR(builders), []]);
    (uiNamespace getVariable QGVAR(ctrWaitToolBox)) lbSetText [0, format ["%1m %2s", floor (_buildTimeRemaining / 60), _buildTimeRemaining mod 60]];
    (uiNamespace getVariable QGVAR(ctrWaitToolBox)) lbSetText [2, format [_requiredBuildersText, _activeBuildersAmount]];

    //Set animation state according to if building is in progress.
    private _isBuilding = _object getVariable [QGVAR(isBuilding), false];
    if (_isBuilding) then {
        if (animationState _player isNotEqualTo "AinvPknlMstpSnonWnonDnon_medic4") then {
            // Perform animation
            [_player, "AinvPknlMstpSnonWnonDnon_medic4"] call ace_common_fnc_doAnimation;
        };
    } else {
        //Animation reset
        [_player, "", 1] call ace_common_fnc_doAnimation;
    };

}, 0.5, [_player, _object, _buildTime, _requiredBuildersText]] call CBA_fnc_addPerFrameHandler;
