#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * load data for the 'wfar_mines' saveList.
 *
 * Arguments:
 * 0: minesData in 'wfar_mines' format <ARRAY> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_listSaveData] call wfar_continuity_fnc_loadMines;
 *
 * Public: [No]
 */
params["_listSaveData"];
TRACE_1("loadMines",_listSaveData);

{
    _x params ["_type", "_posASL", "_vectorDirAndUp", "_damageData", "_side", "_progress"];

    private _object = _type createVehicle _posASL;
    _object setPosASL _posASL;
    _object setVectorDirAndUp _vectorDirAndUp;

} foreach _listSaveData;