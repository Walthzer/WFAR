#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * load data for the 'wfar_boxloader' saveList.
 *
 * Arguments:
 * 0: boxloaderData in 'wfar_boxloader' format <ARRAY> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_listSaveData] call wfar_continuity_fnc_loadBoxloader;
 *
 * Public: [No]
 */
params["_listSaveData"];
TRACE_1("loadBoxloader",_listSaveData);

private _loadedObjects = [];
{
    _x params ["_objectKey", "_posASL", "_vectorDirAndUp"];

    private _object = if (_objectKey isEqualType 0) then {
        //Is Eden vehicle:
        [_objectKey] call FUNC(getObjectByID);
    } else {
        //Is mission vehicle: Create it.
        createVehicle [_objectKey, [0,0,0], [], 0];
    };
    _loadedObjects pushBack _object;

    _object setPosASL _posASL;
    _object setVectorDirAndUp _vectorDirAndUp;

} forEach _listSaveData;


