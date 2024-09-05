#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * load each listSaveData in saveData into the mission per load function in CfgWFARContinuity.
 *
 * Arguments:
 * 0: _saveData <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * call wfar_continuity_fnc_loadMissionFromSaveData;
 *
 * Public: [No]
 */
params ["_saveData"];
TRACE_1("loadMissionFromSaveData",_saveData);

//private _saveDataMap = createHashMapFromArray _saveData;

private _fnc_getSaveListsConfigs = {
        private _condition = "true";
        #ifdef DEBUG_ENABLED_CONTINUITY
            _condition = QUOTE(getNumber(_x >> 'debug') > 0);
        #endif
        _condition configClasses (configFile >> "CfgWFARContinuity" >> "saveLists");
};

{
    private _listName = configName _x;
    private _saveFunction = getText (_x >> "load");
    private _listSaveData = _saveData get _listName;

    if (_listSaveData isEqualType []) then {
        [_listSaveData] call (missionNamespace getVariable[_saveFunction, {WARNING_1("No Load function for saveList: %1",_listName)}]);
    };
} forEach (call _fnc_getSaveListsConfigs);
