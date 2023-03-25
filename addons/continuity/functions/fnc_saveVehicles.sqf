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
TRACE_0("saveVehicles");

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
    _vivCargo,
    _flag,
    _aceCargo

]

*/

private _vehicleSaveList = [];
{
    if (!isNull attachedTo _x || !isNull isVehicleCargo _x) then {continue}; //Vehicles in cargo

    _vehicleSaveList pushBack [_x] call FUNC(serializeVehicle);

} foreach entities [["AllVehicles"], ["ParachuteBase", "Man", "StaticWeapon"]];

_vehicleSaveList