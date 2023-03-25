#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Returns viV cargo of vehicle
 *
 * Arguments:
 * 0: _object <OBJECT>
 *
 * Return Value:
 * 0: vivCargoData in [ ['TYPE', KEY, [TYPE DATA]] ] format <ARRAY>
 *
 * Example:
 * [_object] call wfar_continuity_fnc_getViVCargo
 *
 * Public: [No]
 */
params["_object"];
TRACE_1("getViVCargo",_object);


private _cargo = getVehicleCargo _object 
private _cargoData = [];
{

    private _objectEdenID = _x getVariable [QGVAR(objectID), -1];
    private _objectKey = if (_objectEdenID > -1) then {_objectEdenID} else {typeOf _x};
    private _customName = _x getVariable ["ace_cargo_customName", ""];

    //Handle Vehicles
    if (_x isKindOf "AllVehicles") then {

        if (_x isKindOf "Man" || {_x isKindOf "StaticWeapon" || _x isKindOf "ParachuteBase"}) exitWith {};

        _cargoData pushBack ["Vehicle", _objectKey, _customName, [ [_object] call FUNC(serializeVehicle) ]];
        continue
    };

    //Handle BodyBags
    if (typeOf _x == "ACE_bodyBagObject") then {
        private _dogtagsData = _x getVariable ["ace_dogtags_dogtagData", []];
        _cargoData pushBack ["ACE_bodyBagObject", _objectKey, _customName, _dogtagsData];
        continue
    };

    //Fallback Generic Objects
    //Conditional loading:
    private _damageData = [_x] call FUNC(getDamageData);
    private _inventoryData = [_x] call FUNC(getObjectInventory);
    private _vivCargo = [_x] call FUNC(getViVCargo);
    private _aceCargo = [_x] call FUNC(getCargoACE);
    private _fuel = [_x] call ACE_refuel_fnc_getFuel;
    private _supplyRange = _x getVariable [QEGVAR(fortify,supplyRange), -1];

    _cargoData pushBack ["Generic", _objectKey, _customName, [_damageData, _inventoryData, _vivCargo, _aceCargo, _fuel, _supplyRange]];

} forEach _cargo;

_cargoData