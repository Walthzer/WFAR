#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * generates and returns a saveData array for this mission.
 * saveData is build from saveLists in CfgWFARContinuity.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: saveData <ARRAY>
 *
 * Example:
 * private _saveData = call wfar_continuity_fnc_saveMissionToSaveData;
 *
 * Public: [No]
 */
TRACE_0("FunctionStart");
params [["_savedBy", "Nil"]];

private _fnc_getSaveListsConfigs = {
        private _condition = "true";
        #ifdef DEBUG_ENABLED_CONTINUITY
            _condition = QUOTE(getNumber(_x >> 'debug') > 0);
        #endif
        _condition configClasses (configFile >> "CfgWFARContinuity" >> "saveLists");
};

private _saveData = createHashMap;

_saveData set ["missionNameAndWorld", format ["%1.%2", missionName, worldName]];
_saveData set ["timeUTC", systemTimeUTC];

_saveData set ["savedBy", _savedBy];


{
    private _listName = configName _x;
    private _saveFunction = getText (_x >> "save");

    private _listSaveData = call (missionNamespace getVariable[_saveFunction, {WARNING_1("No Save function for saveList: %1",_listName)}]);
    _saveData set [_listName, _listSaveData];

} forEach (call _fnc_getSaveListsConfigs);

_saveData