#include "script_component.hpp"
#include "\z\ace\addons\arsenal\defines.hpp"
/*
 * Author: Walthzer/Shark
 * Initialize restricted insignia into the Insignia panel when opened
 *
 * Arguments:
 * 0: Left panel control <CONTROL>
 * 1: Left panel selection <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params ["_display", "_curSel"];
TRACE_1("initializeInsigniaPanel",_display);

private _ctrlPanel = _display displayCtrl IDC_leftTabContent;

private _allowedInsignia = call (uiNamespace getVariable [QGVAR(allowedRestrictedInsignia), {[]}]);
if (_allowedInsignia isEqualTo []) exitWith {};

//Add allowed insignia to the leftPanel
{
	_x params ["_isMissionConfig", "_class"];

	if (_isMissionConfig == 0) then {
		[QGVAR(restrictedInsignia), _class, _ctrlPanel, "texture"] call ace_arsenal_fnc_addListBoxItem;
	} else {
		private _displayName = getText (missionConfigFile >> QGVAR(restrictedInsignia) >> _class >> "displayName");
		private _className = _class;
		private _lbAdd = _ctrlPanel lbAdd _displayName;

		_ctrlPanel lbSetData [_lbAdd, _className];
		_ctrlPanel lbSetPicture [_lbAdd, getText (_x >> "texture")];
		_ctrlPanel lbSetTooltip [_lbAdd, format ["%1\n%2", _displayName, _className]];
	};

} forEach _allowedInsignia;

//If a restrictedInsignia is currently equipped, update selection
if (GVAR(currentInsignia) isNotEqualTo "") then {
	for "_lbIndex" from 0 to (lbSize _ctrlPanel - 1) do {
		private _currentData = _ctrlPanel lbData _lbIndex;

		if ((_currentData isNotEqualTo "") && {tolower _currentData == GVAR(currentInsignia)}) exitWith {
			_ctrlPanel lbSetCurSel _lbIndex;
		};
	};
};