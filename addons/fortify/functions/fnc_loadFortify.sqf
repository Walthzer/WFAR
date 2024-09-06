#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * load data for the 'wfar_fortify' saveList.
 *
 * Arguments:
 * 0: fortifyData in 'wfar_fortify' format <ARRAY> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_listSaveData] call wfar_fortify_fnc_loadFortify;
 *
 * Public: [No]
 */
params["_listSaveData"];
TRACE_1("loadFortify",_listSaveData);

[{
    //Has fortify loaded presets yet?
    ([ace_fortify_objects_WEST, ace_fortify_objects_EAST, ace_fortify_objects_GUER] findIf {_x isEqualType []}) > -1;
},
{
    params["_listSaveData"];
    LOG("loadFortify - Waiting Finished");
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

        //Add fortify actions to object
        ["acex_fortify_objectPlaced", [EGVAR(continuity,unitDummy), _side, _object]] call CBA_fnc_globalEvent;

    } forEach _listSaveData;

    //Give arma a little time before allowing simulation to be enabled
    [{
        {
            _x enableDynamicSimulation true;
        } forEach _this;
    }, _loadedObjects, 1] call CBA_fnc_waitAndExecute;
}, _this] call CBA_fnc_waitUntilAndExecute;