#include "script_component.hpp"

if (isServer) then {
    TRACE_0("continuity postInit");
    GVAR(lastAutoSave) = -1;
    GVAR(missionKey) = format ["wfar_continuity_%1.%2", missionName, worldName];

    if (GVAR(enable)) then {
        GVAR(missionSaves) = (profileNamespace getVariable [GVAR(missionKey), createHashMap]);

        //Has continuity ever saved this mission?
        if (count GVAR(missionSaves) > 0) then {

            if (GVAR(scenarioSaveDateUTC) in GVAR(missionSaves)) then {
                //We have save data for this specific scenario -> load it
                [GVAR(missionSaves) get GVAR(scenarioSaveDateUTC)] call FUNC(loadMissionFromSaveData);
            } else {
                //We have save data for a different version of this scenario -> Ask Zeus what to Do
                call FUNC(handleLoadMissionConflict);
            };
        };

        //Enable Continuity AutoSaving if demanded by settings:
        if (GVAR(autoSaveInterval) > 0) then {
            [{
                private _saveData = call FUNC(saveMissionToSaveData);
                GVAR(missionSaves) set [GVAR(scenarioSaveDateUTC), _saveData];
                profileNamespace setVariable [GVAR(missionKey), GVAR(missionSaves)];
                saveProfileNamespace;

                GVAR(lastAutoSave) = time;
            }, GVAR(autoSaveInterval) * 60] call CBA_fnc_addPerFrameHandler;
        };
    };


    [QGVAR(trackObject), {
        params["_object", "_saveList", "_args"];
        
    }] call CBA_fnc_addEventHandler;

    [QGVAR(untrackObject), {
        params["_object"];

        _object setVariable[QGVAR(track), false, true];
    }] call CBA_fnc_addEventHandler;
};