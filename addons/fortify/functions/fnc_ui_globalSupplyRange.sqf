#include "script_component.hpp"
/*
 * Author: Walthzer/Shark with thanks to ACE_Zeus
 * Initializes the "globalSupplyRange" Zeus module display.
 *
 * Arguments:
 * 0: toggleSupplies controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call rid_eden_fnc_ui_globalSupplyRange
 *
 * Public: [No]
 */
params["_controlGroup"];

// Generic Init
private _display = ctrlParent _controlGroup;
private _ctrlButtonOK = _display displayCtrl 1; //IDC_OK
private _module = missionNamespace getVariable [QUOTE(BIS_fnc_initCuratorAttributes_target), objNull];
TRACE_1("Module",_module);

_controlGroup ctrlRemoveAllEventHandlers "setFocus";

(_display displayCtrl 300002) ctrlSetText (str GVAR(globalSupplyRange));

private _fnc_verifyRangeInput = {
    params["_ctrlEditRange"];

    private _rangeText = ctrlText _ctrlEditRange;
    _ctrlEditRange ctrlSetText (str (parseNumber _rangeText));
};

private _fnc_onUnload = {
    private _module = missionNamespace getVariable [QUOTE(BIS_fnc_initCuratorAttributes_target), objNull];
    if (isNull _module) exitWith {};

    deleteVehicle _module;
};

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _module = missionNamespace getVariable [QUOTE(BIS_fnc_initCuratorAttributes_target), objNull];
    if (isNull _module) exitWith {};

    GVAR(globalSupplyRange) = parseNumber (ctrlText 300002);

    deleteVehicle _module;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
(_display displayCtrl 300002) ctrlAddEventHandler ["KeyUp", _fnc_verifyRangeInput];