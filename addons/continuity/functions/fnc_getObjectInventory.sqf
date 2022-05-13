#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * get the inventory of the passed object and returns it.
 *
 * Arguments:
 * 0: object <OBJECT>
 *
 * Return Value:
 * 0: inventoryData <ARRAY>
 *
 * Example:
 * private _inventoryData = [_vehicle] call wfar_continuity_fnc_getObjectInventory;
 *
 * Public: [No]
 */
params["_object"];
TRACE_1("getObjectInventory",_object);
/*
[
    [
        ["FirstAidKit","ACE_fieldDressing","ACE_morphine","ACE_tourniquet","V_PlateCarrierGL_tna_F","ACE_packingBandage","U_B_HeliPilotCoveralls"],[4,2,2,2,1,1,1]
    ],
    [
        ["B_AssaultPack_dgtl"],[2]],
    [
        [["30Rnd_65x39_caseless_mag",30],1]],
    [
        [["arifle_MX_F","","","optic_Arco",[],[],""],1]
    ],
    [
        ["V_PlateCarrierGL_tna_F",
            [
                [["ACE_fieldDressing","ACE_packingBandage","ACE_morphine","ACE_tourniquet"],[4,4,4,4]],
                [[],[]],
                [],
                []
            ]
        ],
        ["U_B_HeliPilotCoveralls",[[[],[]],[[],[]],[],[]]],
        ["B_AssaultPack_dgtl",[[["ACE_packingBandage"],[1]],[[],[]],[],[]]],
        ["B_AssaultPack_dgtl",[[[],[]],[[],[]],[[["HandGrenade",1],1]],[[["arifle_MX_F","","","",[],[],""],1]]]]
    ]
]
*/
private _fnc_getContainerCargo = {
    params["_container"];
    [getItemCargo _container, getBackpackCargo _container, (magazinesAmmoCargo _container) call BIS_fnc_consolidateArray, (weaponsItemsCargo _container) call BIS_fnc_consolidateArray];
};

private _inventory = [_object] call _fnc_getContainerCargo;
private _containersData = [];
{
    _containersData pushBack [_x select 0, [_x select 1] call _fnc_getContainerCargo];
} forEach everyContainer _object;

_inventory pushBack _containersData;
_inventory

