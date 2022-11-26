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

private _fnc_addItems = {
    params ["_items"];
    {
        ["CfgWeapons", _x, _ctrlPanel] call ace_arsenal_fnc_addListBoxItem;
    } foreach _items;
};

switch (_ctrlIDC) do {
    case IDC_buttonHeadgear: {
        [ GVAR(arsenalAccess) select IDX_VIRT_HEADGEAR ] call _fnc_addItems;

        {
            _x params ["_condition", "_items"];
            if (call _condition) then {
                [_items] call _fnc_addItems;
            };
        } foreach (GVAR(conditionalArsenalAccess) select IDX_VIRT_HEADGEAR);
    };
};

