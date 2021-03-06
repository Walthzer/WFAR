#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Use wfar_continuity_idMap HashMap to retrieve an Object by its Eden ID outside of the Eden context.
 *
 * Arguments:
 * 0: Eden ID <NUMBER>
 *
 * Return Value:
 * Object <OBJECT>
 *
 * Example:
 * [50] call wfar_continuity_fnc_getObjectByID
 *
 * Public: [No]
 */
params["_edenID"];

private _object = GVAR(idMap) getOrDefault [_edenID, objNull];

TRACE_2("getObjectByID",_edenID,_object);
_object