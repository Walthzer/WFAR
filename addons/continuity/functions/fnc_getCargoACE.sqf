#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Returns ACE cargo of object
 *
 * Arguments:
 * 0: _object <OBJECT>
 *
 * Return Value:
 * 0: aceCargoData in [ ['TYPE', KEY, [TYPE DATA]] ] format <ARRAY>
 *
 * Example:
 * [_object] call wfar_continuity_fnc_getCargoACE
 *
 * Public: [No]
 */
params["_object"];
TRACE_1("getCargoACE",_object);


private _cargo = _object getVariable ["ace_cargo_loaded", []];
private _cargoData = [];
{
    //Handle virtual (non-object/classname) cargo
    if (_x isEqualType "") then {
        _cargoData pushBack ["virtual", _x]; 
        continue
    };

    private _objectEdenID = _x getVariable [QGVAR(objectID), -1];
    private _objectKey = if (_objectEdenID > -1) then {_objectEdenID} else {typeOf _x};
    private _customName = _x getVariable ["ace_cargo_customName", ""];

    //Handle BodyBags
    if (typeOf _x == "ACE_bodyBagObject") then {
        private _dogtagsData = _x getVariable ["ace_dogtags_dogtagData", []];
        _cargoData pushBack ["ACE_bodyBagObject", _objectKey, _customName, _dogtagsData];
        continue
    };

    //Handle CSW
    if (_x isKindOf "StaticWeapon") then {
        private _damageData = [_x] call FUNC(getDamageData);
        private _ammo = [];
        {
            _ammo pushBack (_x select [0, 3]);
        } forEach magazinesAllTurrets _x;
        _cargoData pushBack ["StaticWeapon", _objectKey, _customName, [_damageData, _ammo]];
        continue
    };

    //Handle Boxes
    if (_x isKindOf "ThingX") then {
        private _damageData = [_x] call FUNC(getDamageData);
        private _inventoryData = [_x] call FUNC(getObjectInventory);
        _cargoData pushBack ["ThingX", _objectKey, _customName, [_damageData, _inventoryData]];
        continue
    };



} forEach _cargo;

_cargoData