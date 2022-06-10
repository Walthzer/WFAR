#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Store the current state of the mission to the serverProfile.
 *
 * Arguments:
 * 0: Name of the save <STRING>
 * 1: Who is saving it <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["AutoSave", "System"] call wfar_continuity_fnc_saveToProfile;
 *
 * Public: [No]
 */
params [["_saveName", "Nil"], "_savedBy"];
TRACE_2("saveToProfile",_saveName,_savedBy);

private _saveData = [_savedBy] call FUNC(saveMissionToSaveData); //Get saveData
private _scenarioSaves = GVAR(missionSaves) getOrDefault [GVAR(scenarioUID), createHashMap, true];
_scenarioSaves set [_saveName, _saveData];

GVAR(missionSaves) set [GVAR(scenarioUID), _scenarioSaves];
private _profileSaves = profileNamespace getVariable [QGVAR(profileSaves), createHashMap];
_profileSaves set [GVAR(missionKey), GVAR(missionSaves)];
profileNamespace setVariable [QGVAR(profileSaves), _profileSaves];

saveProfileNamespace;

call FUNC(loadSavesFromProfile);

[QGVAR(notify), ["Mission saved as '%1' by %2", _saveName, _savedBy]] call CBA_fnc_globalEvent;