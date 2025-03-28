#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Lookup and call arsenal action function with arguments
 *
 * Arguments:
 * 0: _actionClass <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params["_actionClass"];
TRACE_1("ActionArgsFunction",_actionClass);

if (isNil QGVAR(arsenalActions)) exitWith {
    ERROR("ActionArgsFunction: lookup is nil");
};

if !(_actionClass in (keys GVAR(arsenalActions))) exitWith {
    ERROR("ActionArgsFunction: _actionClass not in lookup");
};

private _actionData = GVAR(arsenalActions) get _actionClass;
_actionData params ["_actionID", ["_function", {}], ["_args", []]];

_args call _function;

