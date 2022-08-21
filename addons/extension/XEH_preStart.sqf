#include "script_component.hpp"

#include "XEH_PREP.hpp"

//preload WFAR DLL, prevents stutter later on.
private _wfarDllLoaded = (("WFAR" callExtension "") == "hello");
uiNamespace setVariable [QGVAR(wfarDllLoaded), compileFinal (str _wfarDllLoaded)];

if (_wfarDllLoaded) then {
	"WFAR" callExtension ["initWorker", []];
	"WFAR" callExtension ["startDiscord", []];
	"WFAR" callExtension ["updatePresence", ["---BOOTING---", "false", "White Fox Assault Regiment", "wfarpatch1024"]];
};