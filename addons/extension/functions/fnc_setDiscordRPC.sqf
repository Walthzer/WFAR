#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Sets or Clears your Discord-RPC (Rich Presence)
 *
 * Arguments:
 * 0: State string to set RPC or Nil to clear RPC <STRING or Nil>
 * 1: Details <STRING> (optional)
 * 2: Reset Time Stamp <STRING> (optional)
 * 3: Large Key <STRING> (optional)
 * 4: Small Key <STRING> (optional)
 *
 * Return Value:
 * 0: Extension Result or False if extension is blocked <ARRAY or BOOL>
 *
 * Example:
 * ["Loading in!", "White Fox Assault Regiment", false, "wfarpatch1024"] call wfar_extension_fnc_setDiscordRPC;
 *
 * Public: [Yes]
 */
params [["_state", "", [""]], ["_details", "White Fox Assault Regiment"], ["_resetTime", false, [false]], ["_largeKey", "wfarpatch1024"], ["_smallKey", ""]];
TRACE_5("setRPC",_state,_details,_resetTime,_largeKey,_smallKey);

if !(hasInterface && GVAR(wfarDllLoaded)) exitWith {false};

if (_state == "") then {
    "wfar" callExtension ["clearPresence", []];
} else {
    "wfar" callExtension ["updatePresence", [_state, _details, str _resetTime, _largeKey]];
};
