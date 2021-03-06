#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * load data for the 'wfar_vehicles' saveList.
 *
 * Arguments:
 * 0: vehiclesData in 'wfar_vehicles' format <ARRAY> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_listSaveData] call wfar_continuity_fnc_loadVehicles;
 *
 * Public: [No]
 */
params["_vehiclesData"];
TRACE_1("loadVehicles",_listSaveData);

private _loadedVehicles = [];
{
    _x params ["_vehicleKey", "_posASL", "_vectorDirAndUp", "_damageData", "_turretAmmo", "_fuelArray", "_vehicleSatus", "_inventoryData", "_aceCargo", "_flagTexture", "_aceCargoData"];
    private _vehicle = if (_vehicleKey isEqualType 0) then {
        //Is Eden vehicle:
        [_vehicleKey] call FUNC(getObjectByID);
    } else {
        //Is mission vehicle: Create it.
        createVehicle [_vehicleKey, [0,0,0], [], 0];
    };
    _vehicle enableSimulationGlobal false;
    _loadedVehicles pushBack _vehicle;

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

    //TODO: Load _aceCargo

    if ((_flagTexture isEqualType "") && {_flagTexture isNotEqualTo ""}) then {
        _vehicle forceFlagTexture _flagTexture;
    };

    [_vehicle, _aceCargoData] call FUNC(loadCargoAce);

} forEach _vehiclesData;

//Give arma a little time before allowing simulation
[{
    {
        _x enableDynamicSimulation true;
    } forEach _this;
}, _loadedVehicles, 1] call CBA_fnc_waitAndExecute;