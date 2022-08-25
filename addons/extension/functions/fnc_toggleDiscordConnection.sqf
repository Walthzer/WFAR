#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Makes sure Discord is running or Force Restarts it.
 *
 * Arguments:
 * 0: Start, Stop, Restart? <INT> (optional)
 *
 * Return Value:
 * 0: Extension Result <STRING>
 *
 * Example:
 * [] call wfar_extension_fnc_toggleDiscordConnection;
 *
 * Public: [Yes]
 */
params [["_key", 0, [0, 1, 2]]];
TRACE_1("toggleDiscord",_key);

if !(hasInterface && GVAR(wfarDllLoaded)) exitWith {false};

switch (_key) do {
    case 0: {
        "wfar" callExtension ["initDiscord", []];
    };
    case 1: {
        "wfar" callExtension ["stopDiscord", []];
    };
    case 2;
    default {
        "wfar" callExtension ["stopDiscord", []];
        "wfar" callExtension ["initDiscord", []];
    };
};
