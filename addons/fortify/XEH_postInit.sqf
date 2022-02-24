#include "script_component.hpp"
/* [QGVAR(modifySuppliers), {
    params ["_object", ["_remove", false]];
    TRACE_2("modifySuppliers",_object,_remove);

    if(_remove) then {
        [{GVAR(suppliers) = GVAR(suppliers) select {!isNull _x}}] call CBA_fnc_execNextFrame;
    } else {
        GVAR(suppliers) pushBackUnique _object;
    };

}] call CBA_fnc_addEventHandler; */

if (isServer) then {

    //Broadcast variables
    publicVariable QGVAR(suppliers);
    publicVariable QGVAR(globalSupplyRange);

    //debugArray = [];

    //Modify the number of movement ticks for scaffolds
    GVAR(scaffoldTickModifier) = 20;
    
    //TODO update builders of building if player leaves 

    ["acex_fortify_objectPlaced", {
        params ["_unit", "_side", "_object"];
        TRACE_3("objectPlaced",_unit,_side,_object);

        //Load build information from registerd fortify preset
        private _preset = missionNamespace getVariable [format["ace_fortify_objects_%1", _side], []];
        private _presetEntry = _preset select (_preset findIf {(_x select 0) isEqualTo (typeOf _object)});
        _presetEntry params ["_class", "_fortifyBuildTime", ["_buildTime", 0], ["_requiredBuilders", 0]];

        TRACE_2("retrieved from preset",_buildTime,_requiredBuilders);

        if (_buildTime > 0 || _requiredBuilders > 0) then {
            lastFortifyObject = _object;
            [_object, _buildTime, _requiredBuilders] call FUNC(convertToBuildSite);
        };

    }] call CBA_fnc_addEventHandler;

    [QGVAR(modifyBuilders), {
        params ["_unit", "_object", ["_remove", false]];
        TRACE_3("modifyBuilders",_unit,_object,_remove);

        private _builders = _object getVariable [QGVAR(builders), []];

        call ([{_builders pushBackUnique _unit}, {_builders = _builders - [_unit]}] select _remove);

        _object setVariable [QGVAR(builders), _builders, true];

    }] call CBA_fnc_addEventHandler;
};



if (!hasInterface) exitWith {};

[QGVAR(addBuildActions), {
    params ["_actionHelpers", "_object"];
    TRACE_2("addBuildActions",_actionHelpers,_object);

    private _buildStatement = {
        params ["_target", "_player", "_object"];
        [_player, _object] call FUNC(playerHandelBuilding);
    };
    private _removeStatement = {
        params ["_target", "_player", "_object"];
        [_player, _object] call FUNC(playerHandelRemoving);
    };

    {
        private _buildAction = [format ["buildAction_%1", _forEachIndex], "Build", ["\z\ace\addons\explosives\UI\Defuse_ca.paa", "#00c800"], _buildStatement, {true}, {}, _object, {[-0.1,0,0.5]}, 3.5] call ace_interact_menu_fnc_createAction; 
        private _removeAction = [format ["removeAction_%1", _forEachIndex], "Remove", ["\a3\ui_f\data\igui\cfg\simpletasks\types\danger_ca.paa", "#c80000"], _removeStatement, {true}, {}, _object, {[0.1,0,0.5]}, 3.5] call ace_interact_menu_fnc_createAction; 
        
        [_x, 0, [], _buildAction] call ACE_interact_menu_fnc_addActionToObject;
        [_x, 0, [], _removeAction] call ACE_interact_menu_fnc_addActionToObject;

    } forEach _actionHelpers;

    //Object remove action
    private _mainCondition = {
        params ["_target", "_player", "_object"];
        !(isHidden _object);
    };

    private _removeAction = [format ["removeAction", _forEachIndex], "Remove", ["\a3\ui_f\data\igui\cfg\simpletasks\types\danger_ca.paa", "#c80000"], _removeStatement, _mainCondition, {}, _object, {[0,0,0.5]}, 7] call ace_interact_menu_fnc_createAction;
    [_object, 0, [], _removeAction] call ACE_interact_menu_fnc_addActionToObject;

/*     //Create scaled floor decal.
    private _decalScale = _object getVariable [QGVAR(decalScale), 1];
    private _decal = createVehicle ["Land_DirtPatch_05_F", getPosATL _object, [], 0, "CAN_COLLIDE"];
    _decal setObjectScale _decalScale; */

}] call CBA_fnc_addEventHandler;


//Limit fortify to in range of supplies
[{
    params ["_unit", "_object"];
    if ([_unit] call ace_common_fnc_isEngineer) then {
        private _supplierIndex = GVAR(suppliers) findIf {
                if (alive _x) then {
                    private _range = _x getVariable[QGVAR(supplyRange), 0];
                    if (_range == 0) then {_range = GVAR(globalSupplyRange)};
                    
                    (_range == -1 || {(_object distance _x) <= _range});
                } else {
                    false
                };
            };

        if (_supplierIndex > -1) then {
            true
        } else {
            WFAR_NOTIFY_1(WFAR_WARNING, "Too Far From Supplies!");
            false
        };
    } else {
        WFAR_NOTIFY_2(WFAR_ERROR, "You are not worthy", "to wield the power of Thor!");
        false
    }
}] call ACE_fortify_fnc_addDeployHandler;