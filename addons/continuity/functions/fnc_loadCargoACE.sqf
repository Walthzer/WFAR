#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Applies damage from damageData to object.
 *
 * Arguments:
 * 0: _object <OBJECT>
 * 1: aceCargoData in [ ['TYPE', [TYPE DATA]] ] format <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, _aceCargoData] call wfar_continuity_fnc_loadCargoACE
 *
 * Public: [No]
 */
params["_object", "_aceCargoData"];
TRACE_2("loadCargoACE",_object,_aceCargoData);

//Clear ACE cargo
{
    [_x, _object] call ace_cargo_fnc_removeCargoItem;
} forEach (_object getVariable ["ace_cargo_loaded", []]);

{
    _x params ["_type", "_key", ["_customName", ""], "_data"];

    //Handle virtual (non-object/classname) cargo
    if (_type == "virtual") then {
        [_key, _object, true] call ace_cargo_fnc_loadItem;
        continue
    };

    private _cargoObject = if (_key isEqualType 0) then {
        //Is Eden Object:
        [_key] call FUNC(getObjectByID);
    } else {
        //Is mission Object: Create it.
        _key createVehicle [0,0,0];
    };

    _cargoObject setVariable ["ace_cargo_customName", _customName, true];

    //Handle CSW
    if (_type == "StaticWeapon") then {
        _data params ["_damageData", "_ammo"];
        
        [_cargoObject, _damageData] call FUNC(loadDamageData);

        //Remove ammo in csw's turret:
        {
            _cargoObject removeMagazineTurret [_x select 0, _x select 1];
        } forEach magazinesAllTurrets _cargoObject;

        //Add ammo per saveData
        {
            _cargoObject addMagazineTurret [_x select 0, _x select 1, _x select 2];
        } forEach _ammo;
        
        [_cargoObject, _object, true] call ace_cargo_fnc_loadItem;
        continue
    };

    //Handle Boxes
    if (_type == "ThingX") then {
        _data params ["_damageData", "_inventoryData"];

        [_cargoObject, _damageData] call FUNC(loadDamageData);
        [_cargoObject, _inventoryData] call FUNC(loadObjectInventory);

        [_cargoObject, _object, true] call ace_cargo_fnc_loadItem;
        continue
    };

    //Handle BodyBags
    if (_type == "ACE_bodyBagObject") then {
        _cargoObject setVariable ["ace_dogtags_dogtagData", _data];
        [_cargoObject, _object, true] call ace_cargo_fnc_loadItem;
        continue
    };

} forEach _aceCargoData;