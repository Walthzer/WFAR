#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * load inventoryData array into object.
 *
 * Arguments:
 * 0: object <OBJECT>
 * 1: inventoryData <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, _inventoryData] call wfar_continuity_fnc_loadInventoryData;
 *
 * Public: [No]
 */
params["_object", "_inventoryData"];
TRACE_2("FunctionStart",_object,_inventoryData);

//Clear object Inventory
clearItemCargoGlobal _object;
clearMagazineCargoGlobal _object; 
clearWeaponCargoGlobal _object;
clearBackpackCargoGlobal _object;

private _containersData = _inventoryData select 4;

private _fnc_addCargoToContainer = {
    params["_container", "_inventoryData"];
    _inventoryData params["_items", "_backpacks", "_magazines", "_weapons"];
    {
        _container addItemCargoGlobal [_x, (_items select 1) select _forEachIndex];
    } forEach (_items select 0);

    {
        _container addBackpackCargoGlobal [_x, (_backpacks select 1) select _forEachIndex];
    } forEach (_backpacks select 0);

    {
        _x params["_magazine", "_count"];
        _magazine params["_magazineClass", "_rounds"];
        _container addMagazineAmmoCargo [_magazineClass, _count, _rounds];
    } forEach _magazines;

    {
        _x params["_weaponConfiguration", "_amount"];
        _container addWeaponWithAttachmentsCargoGlobal [_weaponConfiguration, _amount];
    } forEach _weapons;
};


[_object, _inventoryData] call _fnc_addCargoToContainer;

private _containers = flatten (everyContainer _object);
{
    _x params["_type", "_containerInventoryData"];
    private _index = _containers find _type;
    if (_index == -1 || {_index == count _containers}) then {
        WARNING_2("Invalid Containers Array! Skipping...",_object,_containers);
    };
    private _containerObject = _containers select (_index + 1);
    [_containerObject, _containerInventoryData] call _fnc_addCargoToContainer;
} forEach _containersData;