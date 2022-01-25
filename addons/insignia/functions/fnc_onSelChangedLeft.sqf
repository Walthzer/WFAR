#include "script_component.hpp"
#include "\z\ace\addons\arsenal\defines.hpp"
/*
 * Author: Walthzer/Shark
 * Handles selection changes on the left panel of the Ace Arsenal.
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
params ["_control", "_curSel"];
TRACE_2("onSelChangedLeft",_control,_curSel);

//If the current panel isn't insignia's, exit:
if !(ace_arsenal_currentLeftPanel == IDC_buttonInsignia) exitWith {false};

private _display = ctrlParent _control;
private _item = _control lbData _curSel;
private _index = GVAR(restrictedInsigniaClassnames) find _item;

//Exit if not a restrictedInsingia
if (_index == -1) exitWith {false};

ace_arsenal_currentInsignia = "";

call ace_arsenal_fnc_showItem;
TOGGLE_RIGHT_PANEL_HIDE

private _config = GVAR(restrictedInsigniaConfigs) select _index;

[_config] call FUNC(setRestrictedInsignia);
[_display, _control, _curSel, _config] call ace_arsenal_fnc_itemInfo;

true

