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
TRACE_3("clientCallback",_name,_function,_data);

if !(_name == "WFAR") exitWith {};

switch (_function) do {
    case "discordReady";
    case "discordUnready": { 
        private _arr = parseSimpleArray _data;
        GVAR(discordData) = _arr;

        [QGVAR(syncClientDiscordData), [profileName, _arr]] call CBA_fnc_serverEvent;
    };
    default { };
};