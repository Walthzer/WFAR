#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * generates the 'wfar_vehicles' saveList.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: wfar_vehicles saveList <ARRAY>
 *
 * Example:
 * call wfar_continuity_fnc_saveVehicles;
 *
 * Public: [No]
 */
TRACE_0("FunctionStart");

//Save Vehicles: Eden and Mission
/*

_savedVehicle = [
    _vehicleKey, edenID or classname
    _positionASL,
    _vectorDirAndUp,
    _AllHitPointsDamage OR true for wreck, Empty array for no Damage
    _ammo,
    _fuel, ARRAY [_vehicleFuel, _fuelCargo]
    _vehicleStatus, [Lights, Engine, Lock]
    _inventory,
    _cargo,
    _flag

]

*/

private _vehicleSaveList = [];
{
    //Save vehicle under it edenID or classname:
    private _vehicleEdenID = _x getVariable [QGVAR(objectID), -1];
    private _vehicleKey = if (_vehicleEdenID > -1) then {_vehicleEdenID} else {typeOf _x};
    
    if !(alive _x) then {
        //Vehicle is wreck no need to save any other data
        _vehicleSaveList pushBack [_vehicleKey, getPosASL _x, [vectorDir _x, vectorUp _x], true];
        continue
    };

    private _damageData = [_x] call FUNC(getDamageData);

    //Save ammo discarding magazine ID and creator to save data
    private _turretAmmo = [];
    {
        _turretAmmo pushBack (_x select [0, 3]);
    } forEach magazinesAllTurrets _x;

    
    private _fuelCargo = [_x] call ACE_refuel_fnc_getFuel; //Is object using ace refuel?
    private _fuelArray = [fuel _x, _fuelCargo];
    private _inventoryData = [_x] call FUNC(getObjectInventory);

    //ACE Cargo
    //private _cargo = _x getVariable ["ace_cargo_loaded", []];

    _vehicleSaveList pushBack [_vehicleKey, getPosASL _x, [vectorDir _x, vectorUp _x], _damageData, _turretAmmo, _fuelArray, [isLightOn _x, isEngineOn _x, locked _x], _inventoryData, [], getForcedFlagTexture _x];
} foreach entities [["AllVehicles"], ["ParachuteBase", "Man", "StaticWeapon"]];

_vehicleSaveList