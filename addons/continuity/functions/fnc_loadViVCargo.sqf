#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Loads ViV Cargo data in game instances
 *
 * Arguments:
 * 0: _object <OBJECT>
 * 1: _vivCargoData <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, _vivCargoData] call wfar_continuity_fnc_loadViVCargo
 *
 * Public: [No]
 */
params["_object", "_vivCargoData"];
TRACE_2("loadViVCargo",_object,_vivCargoData);

//Clear ViV cargo
{
    if (isNull (_x getVariable [QGVAR(objectID), objNull])) then {
        deleteVehicle _x;
    } else {
        _object setVehicleCargo _x;
    }
} forEach (getVehicleCargo _object);

{
    _x params ["_type", "_key", ["_customName", ""], "_data"];

    //Handle Vehicles
    if (_type == "Vehicle") then {

        _vehicle = ([_data] call FUNC(deserializeVehicle)) select 0;
        _object setVehicleCargo _vehicle;
        continue;
    };

    private _cargoObject = if (_key isEqualType 0) then {
        //Is Eden Object:
        [_key] call FUNC(getObjectByID);
    } else {
        //Is mission Object: Create it.
        _key createVehicle [0,0,0];
    };
    _cargoObject setVariable ["ace_cargo_customName", _customName, true];
    _object setVehicleCargo _cargoObject;

    //Handle BodyBags
    if (_type == "ACE_bodyBagObject") then {
        _cargoObject setVariable ["ace_dogtags_dogtagData", _data];
        continue
    };

    //Fallback Generic Objects
    _data params [["_damageData", []], ["_inventoryData", [[[],[]],[[],[]],[],[],[]]], ["_vivCargo", []], ["_aceCargo", []], ["_fuel", -1], ["_supplyRange", -1]];

    //Conditional loading:
    [_cargoObject, _damageData] call FUNC(loadDamageData);
    if (_inventoryData isNotEqualTo [[[],[]],[[],[]],[],[],[]]) then { [_cargoObject, _inventoryData] call FUNC(loadObjectInventory) };
    if (_vivCargo isNotEqualTo []) then { [_cargoObject, _vivCargo] call FUNC(loadViVCargo) };
    if (_aceCargo isNotEqualTo []) then { [_cargoObject, _aceCargo] call FUNC(loadCargoACE) };
    if (_fuel isNotEqualTo -1) then { [_cargoObject, _fuel] call ACE_refuel_fnc_setFuel };
    if (_supplyRange isNotEqualTo -1) then { [_object, _supplyRange] call EFUNC(fortify,registerSupplier) };

} forEach _vivCargoData;