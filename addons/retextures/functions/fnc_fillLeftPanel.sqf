#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Fill out the Left panel.
 *
 * Arguments:
 * 0: Left panel control <CONTROL>
 * 1: Left panel selection <SCALAR>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params ["_display", "_ctrlIDC"];
TRACE_2("fillLeftPanel",_display,_ctrlIDC);

private _ctrlPanel = _display displayCtrl IDC_leftTabContent;

switch (_ctrlIDC) do {
    case IDC_buttonHeadgear: {
        {
            ["CfgWeapons", _x, _ctrlPanel] call ace_arsenal_fnc_addListBoxItem;
        } foreach (GVAR(arsenalAccess) select IDX_VIRT_HEADGEAR);
    };
};

