#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Serializes a vehicle for saving
 *
 * Arguments:
 * 0: _vehicle <OBJECT>
 *
 * Return Value:
 * 0: vehicleData <ARRAY>
 *
 * Example:
 * [car] call wfar_continuity_fnc_serializeVehicle;
 *
 * Public: [No]
 */
params ["_vehicle"];
TRACE_1("serializeVehicle",_vehicle);

//Save Vehicles: Eden and Mission
/*

_vehicleData = [
    _vehicleKey, edenID or classname
    _positionASL,
    _vectorDirAndUp,
    _AllHitPointsDamage OR true for wreck, Empty array for no Damage
    _ammo,
    _fuel, ARRAY [_vehicleFuel, _fuelCargo]
    _vehicleStatus, [Lights, Engine, Lock]
    _inventory,
    _vivCargo,
    _flag,
    _aceCargo

]

*/

//Save vehicle under its edenID or classname:
private _vehicleEdenID = _vehicle getVariable [QGVAR(objectID), -1];
private _vehicleKey = if (_vehicleEdenID > -1) then {_vehicleEdenID} else {typeOf _vehicle};

if !(alive _vehicle) exitWith {
    //Vehicle is wreck no need to save any other data
    [_vehicleKey, getPosASL _vehicle, [vectorDir _vehicle, vectorUp _vehicle], true];
};

private _damageData = [_vehicle] call FUNC(getDamageData);

//Save ammo, discarding magazine ID and creator to save data
private _turretAmmo = [];
{
    _turretAmmo pushBack (_x select [0, 3]);
} forEach magazinesAllTurrets _vehicle;


private _fuelCargo = [_vehicle] call ACE_refuel_fnc_getFuel; //Is object using ace refuel?
private _fuelArray = [fuel _vehicle, _fuelCargo];
private _inventoryData = [_vehicle] call FUNC(getObjectInventory);

//ACE Cargo
private _aceCargoData = [_vehicle] call FUNC(getCargoACE);

//Save ViV Cargo
private _vivCargo = [_vehicle] call FUNC(getVIVCargo);

private _supplyRange = _vehicle getVariable [QEGVAR(fortify,supplyRange), -1];

[_vehicleKey, getPosASL _vehicle, [vectorDir _vehicle, vectorUp _vehicle], _damageData, _turretAmmo, _fuelArray, [isLightOn _vehicle, isEngineOn _vehicle, locked _vehicle], _inventoryData, _vivCargo, getForcedFlagTexture _vehicle, _aceCargoData, _supplyRange];
