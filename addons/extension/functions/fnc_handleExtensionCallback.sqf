#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Handle Callbacks 
 *
 * Arguments:
 * 0: Callback name <STRING>
 * 1: Callback function <ARRAY>
 * 2: callback data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: [No]
 */
params ["_name", "_function", "_data"];
TRACE_3("callback",_name,_function,_data);
if !(_name == "WFAR") exitWith {};

if ("error" in ( toLower _data )) then {
    ERROR_1("Server Extension Error - Callback -> %1",_data);
};