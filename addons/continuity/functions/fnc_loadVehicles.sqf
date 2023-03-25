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

{
    _x enableSimulationGlobal false;
} forEach entities [["AllVehicles"], ["ParachuteBase", "Man", "StaticWeapon"]];

private _loadedVehicles = [];
{

    _loadedVehicles pushBack [_x] call FUNC(deserializeVehicle);

} forEach _vehiclesData;

//Give arma a little time before allowing simulation
[{
    {
        _x enableDynamicSimulation true;
    } forEach entities [["AllVehicles"], ["ParachuteBase", "Man", "StaticWeapon"]];
}, [], 3] call CBA_fnc_waitAndExecute;