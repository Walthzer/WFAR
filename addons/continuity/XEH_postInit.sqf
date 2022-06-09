#include "script_component.hpp"

if (isServer) then {
    [QGVAR(loadMissionEH), {
        params ["_scenarioUID", "_selectedSaveName", ["_loadedBy", "Nil"]];
        TRACE_2("loadMissionEH",_scenarioUID,_selectedSaveName);
        private _missionSave = GVAR(missionSaves) getOrDefault [_scenarioUID, []];
		if (_missionSave isEqualTo []) exitWith {WARNING("Tried loading non-existant missionSave...aborting")};

		private _saveData = _missionSave getOrDefault [_selectedSaveName, []];
		if (_saveData isEqualTo []) exitWith {WARNING("saveData isn't hashmap...aborting")};

		[_saveData] call FUNC(loadMissionFromSaveData);

        [QGVAR(notify), ["Save: '%1' loaded by %2", _selectedSaveName, _loadedBy]] call CBA_fnc_globalEvent;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(saveMissionEH), {_this call FUNC(saveToProfile)}] call CBA_fnc_addEventHandler;

    private _filteredName = missionName regexReplace [REGEX_STRING, ""]; //filter %~~% tokens from missionName
    GVAR(missionKey) = format ["%1.%2", _filteredName, worldName];

    if (GVAR(enabled)) then {

        //Dummy unit 
        GVAR(unitDummy) = createAgent ["B_Soldier_F", DUMMY_POSITION, [], 0, "NONE"];
        hideObjectGlobal GVAR(unitDummy);
        GVAR(unitDummy) enableSimulationGlobal false;

        call FUNC(loadSavesFromProfile);

        //GVAR(missionSaves) = createHashMapFromArray [[[2022,6,5,1,38,2,0], createHashMap], [systemTimeUTC, createHashMap],[[2012,6,5,1,38,2,0], createHashMap]];

/*         //Has continuity ever saved this mission?
        if (keys GVAR(missionSaves) isNotEqualTo []) then {

            if (GVAR(scenarioUID) in GVAR(missionSaves)) then {
                //We have save data for this specific scenario -> load newest save
                private _scenarioSaves = GVAR(missionSaves) get GVAR(scenarioUID);

                private _lastestTime = [];
                private _latestSaveData = [];
                {
                    private _currentSaveData = _y; //Hashmap iteration: _y is value
                    private _timeUTC = _currentSaveData getOrDefault ["timeUTC", []];
                    //Skip date comparison on first iteration
                    if (_lastestTime isEqualTo []) then {
                        _lastestTime = _timeUTC;
                        _latestSaveData = _currentSaveData;
                        continue
                    };

                    //Compare UTC date's and find the latest -> the greatest
                    {
                        if (_x > (_lastestTime select _forEachIndex)) exitWith { 
                            _lastestTime = _timeUTC;
                            _latestSaveData = _currentSaveData;
                        };
                        if (_x < (_lastestTime select _forEachIndex)) exitWith {continue};
                    } forEach _timeUTC;

                } forEach _scenarioSaves;
                
                private _startTime = diag_tickTime;
                [_latestSaveData] call FUNC(loadMissionFromSaveData);
                GVAR(loadTime) = diag_tickTime - _startTime;
            } else {
                //We have save data for a different version of this scenario -> Flag it
                [QGVAR(handleSaveDateMismatch), [GVAR(scenarioUID), keys GVAR(missionSaves)]] call CBA_fnc_globalEvent;
            }; */

        //Enable Continuity AutoSaving if demanded by settings:
        if (GVAR(autoSaveInterval) > 0) then {
            GVAR(lastAutoSaveIndex) = -1;
            [{
                params ["_args", "_handle"];
                if (GVAR(autoSaveInterval) == 0) exitWith {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                };
                if (GVAR(lastAutoSaveIndex) < 0) exitWith {GVAR(lastAutoSaveIndex) = 0}; // Prevent Immediate Autosave

                GVAR(lastAutoSaveIndex) = [1, GVAR(lastAutoSaveIndex) + 1] select ( GVAR(lastAutoSaveIndex) < GVAR(concurrentAutoSaveLimit) );
                [format ["%1# Sauvegarder De L'Auto", GVAR(lastAutoSaveIndex)], "System"] call FUNC(saveToProfile);
            }, GVAR(autoSaveInterval) * 60] call CBA_fnc_addPerFrameHandler;
        };
    };
};
    