#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Initialise a UI Texture on an equipment item
 *
 * Arguments:
 * 0: object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params ["_unit", "_equipClass", "_equipmentSlot", "_assigned"];
TRACE_3("handleEquipment",_equipClass,_equipmentSlot,_assigned);

//replace generic dynamic with owned slot
//replace non-owned slot with owned slot after transferring data

private _config = configFile >> "CfgWeapons" >> _equipClass;

//Is this equipment dynamic?
if !(isText (_config >> QGVAR(materialClass))) exitWith {};
private _dynamicConfig = GVAR(dynamics) getOrDefault [getText (_config >> QGVAR(materialClass)), configNull];

//Cleanup old actions
if !(isPlayer _unit) exitWith {
    //base
    private _config = ("true" configClasses (_dynamicConfig >> "bases")) select 1;
    [_equipClass, _config, _unit] call FUNC(setMaterial);

    _config = (_dynamicConfig >> "materials" >> "named");
    [_equipClass, _config, _unit] call FUNC(setMaterial);
};


//Ensure equipment matches our dynamics slot
private _classSlot = [_config] call FUNC(getClassSlot);
if(isMultiplayer && {_classSlot != (call FUNC(getDynamicsSlot))}) then {
    private _slotted = getText (_config >> QGVAR(baseClass)) + "_" + str (call FUNC(getDynamicsSlot));
    player linkItem _slotted;
};

private _fnc_addAction = {
    params ["_equipClass", "_equipmentSlot", "_config", "_title", ["_setbase", false]];
    private _allowed = isArray(_config >> "steamIDList") && {(wfar_steamID) in getArray(_config >> "steamIDList")};
    _allowed = _allowed || (isText (_config >> "condition") && {call compile getText (_config >> "condition")});
    if !(_allowed) then { continue };

    if (_setbase) then {
        [_equipClass, _config, player] call FUNC(setMaterial);
    };
    //Add bases actions, with lookups for passing args
    private _actionClass = QGVAR(actions) + "_" + (configName _config);
    private _actionID = ([[GVAR(slotMap) get _equipmentSlot], _actionClass, _title, [
        ["button", getText(_config >> "displayName"), {true}, "", {}, compile format["[""%1""] call %2",_actionClass, FUNC(ActionArgsFunction)]]
    ]] call ace_arsenal_fnc_addAction) select 0;

    //Push to lookup
    GVAR(arsenalActions) set [_actionClass, [
        _actionID,
        FUNC(setMaterial),
        [_equipClass, _config, player]
    ]];
};

//Arsenal Actions
private _setbase = true;
{
    [_equipClass, _equipmentSlot, _x, "Bases", _setbase] call _fnc_addAction;
    if (_setbase) then {
        _setbase = false;
    };
} forEach ("true" configClasses (_dynamicConfig >> "bases"));

{
    [_equipClass, _equipmentSlot, _x, "Decals"] call _fnc_addAction;
} forEach ("true" configClasses (_dynamicConfig >> "materials"));


