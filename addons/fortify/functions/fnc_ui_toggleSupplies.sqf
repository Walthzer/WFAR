#include "script_component.hpp"
/*
 * Author: Walthzer/Shark with thanks to ACE_Zeus
 * Initializes the "toggleSupplies" Zeus module display.
 *
 * Arguments:
 * 0: toggleSupplies controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call rid_eden_fnc_ui_toggleSupplies
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

// Validate module target
private _object = attachedTo _module;
TRACE_1("unit",_object);

//Thanks ACE ZEUS Team!
scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _module;
    [_msg] call ace_zeus_fnc_showMessage;
    breakOut "Main";
};

switch (false) do {
    case !(isNull _object): {
        ["PLACE ON AN OBJECT"] call _fnc_errorAndClose;
    };
    case (alive _object): {
        ["OBJECT MUST BE ALIVE"] call _fnc_errorAndClose;
    };
};
//

private _hasSupply = _object in GVAR(suppliers);
(_display displayCtrl 300001) cbSetChecked _hasSupply;

private _supplyRange = _object getVariable [QGVAR(supplyRange), 0];
(_display displayCtrl 300002) ctrlSetText (str _supplyRange);

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
    
    private _object = attachedTo _module;

    private _hasSupplies = _object in GVAR(suppliers);
    private _WantedSupply = cbChecked (_display displayCtrl 300001);
    if (_hasSupplies != _WantedSupply) then {
        if (_WantedSupply) then {
            GVAR(suppliers) pushBackUnique _object;
        } else {
            GVAR(suppliers) = GVAR(suppliers) - [_object];
        };
    };

    private _supplyRange = parseNumber (ctrlText 300002);
    _object setVariable [QGVAR(supplyRange), _supplyRange, true];

    deleteVehicle _module;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
(_display displayCtrl 300002) ctrlAddEventHandler ["KeyUp", _fnc_verifyRangeInput];