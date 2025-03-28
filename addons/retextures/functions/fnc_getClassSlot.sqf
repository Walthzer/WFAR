#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * return dynamics classSlot for passed config.
 *
 * Arguments:
 * 0: _config <CONFIG>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params["_config"];
TRACE_1("getClassSlot",_config);

if(!isNumber (_config >> QGVAR(classSlot))) exitWith {-1};
getNumber (_config >> QGVAR(classSlot))


