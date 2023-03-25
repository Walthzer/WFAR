#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * load data for the 'wfar_boxes' saveList.
 *
 * Arguments:
 * 0: boxesData in 'wfar_boxes' format <ARRAY> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_listSaveData] call wfar_continuity_fnc_loadBoxes;
 *
 * Public: [No]
 */
params["_listSaveData"];
TRACE_1("loadBoxes",_listSaveData);

private _createdData = [];
{
    _x params ["_objectKey", "_posASL", "_vectorDirAndUp", "_customName", "_damageData", ["_inventoryData", [[[],[]],[[],[]],[],[],[]]], ["_vivCargo", []], ["_aceCargo", []], ["_fuel", 0], ["_supplyRange", -1]];

    private _object = if (_objectKey isEqualType 0) then {
        //Is Eden box:
        [_objectKey] call FUNC(getObjectByID);
    } else {
        //Is mission vehicle: Create it.
        createVehicle [_objectKey, [0,0,0], [], 0];
    };

    _createdData pushBack _object;
    _object enableSimulationGlobal false;

    _object setPosASL _posASL;
    _object setVectorDirAndUp _vectorDirAndUp;

    if (_customName isNotEqualTo "") then { _object setVariable ["ace_cargo_customName", _customName, true] };

    [_object, _damageData] call FUNC(loadDamageData);
    if (_inventoryData isNotEqualTo [[[],[]],[[],[]],[],[],[]]) then { [_object, _inventoryData] call FUNC(loadObjectInventory) };
    if (_vivCargo isNotEqualTo []) then { [_object, _vivCargo] call FUNC(loadViVCargo) };
    if (_aceCargo isNotEqualTo []) then { [_object, _aceCargo] call FUNC(loadCargoACE) };
    if (_fuel isNotEqualTo -1) then { [_object, _fuel] call ACE_refuel_fnc_setFuel };
    if (_supplyRange isNotEqualTo -1) then { [_object, _supplyRange] call EFUNC(fortify,registerSupplier) };

} forEach _listSaveData;

[{
    params ["_objects"];
    {
        _x enableDynamicSimulation true;
    } forEach _objects;
}, [_createdData], 3] call CBA_fnc_waitAndExecute;

_createdData