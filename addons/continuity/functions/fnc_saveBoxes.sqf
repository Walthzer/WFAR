#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * generate a save list for boxes
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
TRACE_0("saveBoxes");

private _boxesSaveList = [];
{

    private _objectEdenID = _x getVariable [QGVAR(objectID), -1];
    private _objectKey = if (_objectEdenID > -1) then {_objectEdenID} else {typeOf _x};

    private _customName = _x getVariable ["ace_cargo_customName", ""];

    private _damageData = [_x] call FUNC(getDamageData);
    private _inventoryData = [_x] call FUNC(getObjectInventory);
    private _vivCargo = [_x] call FUNC(saveBoxes);
    private _aceCargo = [_x] call FUNC(getCargoACE);
    private _fuel = [_x] call ACE_refuel_fnc_getFuel;

    _boxesSaveList pushBack [_objectKey, getPosASL _x, [vectorDir _x, vectorUp _x], _customName, _damageData, _inventoryData, _vivCargo, _aceCargo, _fuel, _x getVariable [QEGVAR(fortify,supplyRange), -1]];

} forEach entities[GVAR(boxSaveTypes)]; //Dynamic `box` types

_boxesSaveList