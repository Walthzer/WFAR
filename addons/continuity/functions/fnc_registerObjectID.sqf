#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Inserts an Object into the wfar_continuity_idMap at its Eden ID position to provide a lookup table from (Eden ID -> Object).
 * Also gives the object a variable that holds it EdenID.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Eden ID <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_this,50] call wfar_continuity_fnc_registerObjectID
 *
 * Public: [No]
 */
params["_object", "_edenID"];
TRACE_2("registerObjectID",_object,_edenID);

if (_object isEqualType "") then {
	_object = missionNamespace getVariable [_object, objNull];
};
if (isNull _object) exitWith {};

GVAR(idMap) set [_edenID, _object];
_object setVariable [QGVAR(objectID), _edenID, true];