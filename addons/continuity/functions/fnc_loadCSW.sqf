#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * load data for the 'wfar_csw' saveList.
 *
 * Arguments:
 * 0: cswData in 'wfar_csw' format <ARRAY> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_listSaveData] call wfar_continuity_fnc_loadCSW;
 *
 * Public: [No]
 */
params["_listSaveData"];
TRACE_1("loadCSW",_listSaveData);

private _loadedObjects = [];
{
    _x params ["_cswKey", "_posASL", "_vectorDirAndUp", "_damageData", "_ammo"];
    private _csw = if (_cswKey isEqualType 0) then {
        //Is Eden vehicle:
        [_cswKey] call FUNC(getObjectByID);
    } else {
        //Is mission vehicle: Create it.
        _cswKey createVehicle _posASL;
    };
    _csw enableSimulationGlobal false;
    _loadedObjects pushBack _csw;

    _csw setPosASL _posASL;
    _csw setVectorDirAndUp _vectorDirAndUp;
    
    if (_damageData isEqualType true && {_damageData == true}) then {
        //CSW was wreck, make it a wreck and go to next CSW:
        _csw setVariable ["ace_cookoff_enable", false];
        _csw setDamage [1, false];
        continue
    };

    [_csw, _damageData] call FUNC(loadDamageData);

    //Remove ammo in csw's turret:
    {
        _csw removeMagazineTurret [_x select 0, _x select 1];
    } forEach magazinesAllTurrets _csw;

    //Add ammo per saveData
    {
        _csw addMagazineTurret [_x select 0, _x select 1, _x select 2];
    } forEach _ammo;


} forEach _listSaveData;

//Give arma a little time before allowing simulation to be enabled
[{
    {
        _x enableDynamicSimulation true;
    } forEach _this;
}, _loadedObjects, 1] call CBA_fnc_waitAndExecute;