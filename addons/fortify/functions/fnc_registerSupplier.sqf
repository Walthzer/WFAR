#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Register an object as a supplier for limited fortify. Call on SERVER.
 *
 * Arguments:
 * 0: Supplier <OBJECT>
 * 1: Supply range (optional, default: 0) <SCALAR>
 * 2: Is Eden attribute <BOOL>
 *
 * Return Value:
 * 0: Index in wfar_fortify_suppliers <SCALAR>
 *
 * Example:
 * [ammobox, 30] call wfar_fortify_fnc_registerSupplier
 *
 * Public: Yes
 */
params [["_object", objNull, [objNull]], ["_range", 0, [0]], ["_isEdenAttribute", false, [false]]];
TRACE_2("registerSupplier",_object,_range);

if (!isServer || _range == -1) exitWith {-1};

_object setVariable [QGVAR(supplyRange), _range, true];

private _index = GVAR(suppliers) pushBackUnique _object;

//handle respawning of objects. Eden respawn module seems to break respawn EH.
[typeOf _object, "initPost", {
    params["_object"];
    private _isSupplier = (_object getVariable[QGVAR(supplyRange), -1]) > -1;
    systemChat str [_object, _isSupplier];
    if (_isSupplier) then {

        GVAR(suppliers) pushBackUnique _object;
        [{GVAR(suppliers) = GVAR(suppliers) select {!isNull _x}}] call CBA_fnc_execNextFrame;
        
        publicVariable QGVAR(suppliers);
    };
}, false] call CBA_fnc_addClassEventHandler;

if (_isEdenAttribute) exitWith {_index};
publicVariable QGVAR(suppliers);

_index

