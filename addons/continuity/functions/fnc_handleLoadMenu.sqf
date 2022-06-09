#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * handle loading and unloading of the Mission load Display
 *
 * Arguments:
 * 0: parent display
 *
 * Return Value:
 * None
 *
 * Example:
 * call wfar_continuity_fnc_openLoadMenu;
 *
 * Public: [No]
 */
disableSerialization;
params ["_mode", "_display", "_args"];
TRACE_3("handleLoadMenu",_mode,_display,_args);

private _ctrlUIDs = _display displayCtrl 102;
private _ctrlSaves = _display displayCtrl 103;
private _ctrlFilter = _display displayCtrl 104;
private _ctrlFile = _display displayCtrl 105;

switch (_mode) do {
    case "ScenarioUIDs_onLBSelChanged": {
        _args params ["_control", "_selectedIndex"];

        if (_selectedIndex < 0) exitWith {WARNING("Empty _ctrlUIDs in onLBSelChanged...aborting")};

        private _missionSave = GVAR(strippedMissionSaves) getOrDefault [parseSimpleArray (_control lbData _selectedIndex), createHashMap];

        lbClear _ctrlSaves;
        {
            private _timeUTC = _y getOrDefault ["timeUTC", "???"];
            private _value = 0;
            if (_timeUTC isEqualType []) then {
                _paddedTime = _timeUTC apply { if (_x < 10) then { "0" + str _x } else { str _x } }; //Add leading 0 to single digits
                //_value = parseNumber (_paddedTime joinString "");
                _timeUTC = format [GVAR(dateFormatString), _paddedTime select 0, _paddedTime select 1, _paddedTime select 2, _paddedTime select 3, _paddedTime select 4];
            };
            private _row = _ctrlSaves lnbAddRow [_x, _y getOrDefault ["savedBy", "404"], _timeUTC];
            //_ctrlSaves lnbSetValue [[_row, 2], _value];
        } forEach _missionSave;

        _ctrlUIDs lnbSort [2];
    };
    case "onLoad": {
        //_ctrlFilter lnbSetData [[0,2], "USEVALUE"];
        [_ctrlFilter, _ctrlSaves] call BIS_fnc_initListNBoxSorting;

        _ctrlFile ctrlEnable false;
        _ctrlFile ctrlSetFade 0.8;
        _ctrlFile ctrlCommit 0;

        {    
            private _paddedTime = _x apply { if (_x < 10) then { "0" + str _x } else { str _x } };
            private _index = _ctrlUIDs lbAdd ( format [GVAR(dateFormatString), _paddedTime select 0, _paddedTime select 1, _paddedTime select 2, _paddedTime select 3, _paddedTime select 4] );
            _ctrlUIDs lbSetData [_index, str _x];
        } forEach (keys GVAR(strippedMissionSaves));

        lbSort [_ctrlUIDs, "DESC"];
        _ctrlUIDs lbSetCurSel 0;

    };
    case "onUnLoad": {
        _args params ["_exitCode"];

        if (_exitCode != 1) exitWith {};
        
        TRACE_1("UnLoad",_exitCode);
        
        private _selectedSaveIndex = lbCurSel _ctrlUIDs;

        if (_selectedSaveIndex < 0) exitWith {WARNING("No save selected...aborting")};

        private _scenarioUID = parseSimpleArray (_ctrlUIDs lbData (_selectedSaveIndex));
        private _selectedSaveName = _ctrlSaves lnbText [lnbCurSelRow _ctrlSaves , 0];
        diag_log (lnbCurSelRow _ctrlSaves);
        [QGVAR(loadMissionEH), [_scenarioUID, _selectedSaveName, profileName]] call CBA_fnc_serverEvent;
    };
};