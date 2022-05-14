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

if (true) exitWith {};

private _loadedObjects = [];
{
    _x params ["_type", "_posASL", "_vectorDirAndUp", "_damageData", "_side", "_progress"];

    private _object = _type createVehicle _posASL;
    _object enableSimulationGlobal false;
    _loadedObjects pushBack _object;

    _object setPosASL _posASL;
    _object setVectorDirAndUp _vectorDirAndUp;
    
    [_object] call FUNC(loadDamageData);
    _object setVariable [QGVAR(progress),_progress];

    //Add mines actions to object
    ["acex_mines_objectPlaced", [EGVAR(continuity,unitDummy), _side, _object]] call CBA_fnc_globalEvent;

} foreach _listSaveData;

//Give arma a little time before allowing simulation to be enabled
[{
    {
        _x enableDynamicSimulation true;
    } forEach _this;
}, _loadedObjects, 1] call CBA_fnc_waitAndExecute;