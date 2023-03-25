#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Load vehicle data into a game instance.
 *
 * Arguments:
 * 0: vehiclesData in 'wfar_vehicles' format <ARRAY> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicleData] call wfar_continuity_fnc_deserializeVehicle;
 *
 * Public: [No]
 */
params["_vehicleData"];
TRACE_1("deserializeVehicle",_vehicleData);

private _createdData = [];
_vehicleData params ["_vehicleKey", "_posASL", "_vectorDirAndUp", "_damageData", "_turretAmmo", "_fuelArray", "_vehicleSatus", "_inventoryData", ["_vivCargo", []], "_flagTexture", ["_aceCargo", []], ["_supplyRange", -1]];

private _vehicle = if (_vehicleKey isEqualType 0) then {
    //Is Eden vehicle:
    private _obj = [_vehicleKey] call FUNC(getObjectByID);
    detach _obj; //Handle Eden Vehicle being ViV on missionStart
    _obj;
} else {
    //Is mission vehicle: Create it.
    createVehicle [_vehicleKey, [0,0,0], [], 0];
};
_createdData pushBack _vehicle;
_vehicle enableSimulationGlobal false;

_vehicle setPosASL _posASL;
_vehicle setVectorDirAndUp _vectorDirAndUp;
    
if (_damageData isEqualType true && {_damageData == true}) then {
    //Vehicle was wreck, make it a wreck and go to next vehicle:
    _vehicle setVariable ["ace_cookoff_enable", false];
    _vehicle setDamage [1, false];
    continue
};

[_vehicle, _damageData] call FUNC(loadDamageData);

//Remove ammo in vehicle turrets:
{
    _vehicle removeMagazineTurret [_x select 0, _x select 1];
} forEach magazinesAllTurrets _vehicle;

//Add ammo per saveData
{
    _vehicle addMagazineTurret [_x select 0, _x select 1, _x select 2];
} forEach _turretAmmo;

_fuelArray params ["_fuel", "_fuelCargo"];
_vehicle setFuel _fuel;
[_vehicle, _fuelCargo] call ACE_refuel_fnc_setFuel;

_vehicleSatus params ["_lights", "_engine", "_lock"];
_vehicle engineOn _engine;
_vehicle setPilotLight _lights;
_vehicle lock _lock;

[_vehicle, _inventoryData] call FUNC(loadObjectInventory);

//Handle ViV Cargo
private _loadedViV = [];
{
    _loadedViV pushBack [_vehicle, _x] call FUNC(loadViVCargo);
} forEach _vivCargo;
_createdData pushBack _loadedViV;

if ((_flagTexture isEqualType "") && {_flagTexture isNotEqualTo ""}) then {
    _vehicle forceFlagTexture _flagTexture;
};

[_vehicle, _aceCargo] call FUNC(loadCargoAce);

if (_supplyRange >= 0) then {
    [_vehicle, _supplyRange] call EFUNC(fortify,registerSupplier);
};

_createdData