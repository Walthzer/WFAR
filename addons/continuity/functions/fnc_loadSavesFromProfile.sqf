#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Get saves from profileNamespace
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call wfar_continuity_fnc_loadSavesFromProfile;
 *
 * Public: [No]
 */
TRACE_0("loadSavesFromProfile");

private _profileSaves = profileNamespace getVariable [QGVAR(profileSaves), createHashMap];
GVAR(missionSaves) = _profileSaves getOrDefault [GVAR(missionKey), createHashMap];

//broadcast a stripped version of missionSaves -> Remove data heavy savelists:
GVAR(strippedMissionSaves) = createHashMap;
{
	private _scenarioUID = _x;
	private _strippedData = createHashMap;

	{
		private _saveName =_x;
		private _strippedSaveData = createHashMap;

		_strippedSaveData set ["missionNameAndWorld", _y get "missionNameAndWorld"]; 
		_strippedSaveData set ["timeUTC", _y get "timeUTC"];
		_strippedSaveData set ["savedBy", _y get "savedBy"];

		_strippedData set [_saveName, _strippedSaveData];
	} forEach _y;
	GVAR(strippedMissionSaves) set [_scenarioUID, _strippedData];
} forEach GVAR(missionSaves);
publicVariable QGVAR(strippedMissionSaves);