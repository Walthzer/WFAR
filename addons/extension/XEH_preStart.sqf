#include "script_component.hpp"

#include "XEH_PREP.hpp"

//preload WFAR DLL, prevents stutter later on.
private _wfarDllLoaded = (("wfar" callExtension "") == "hello");
uiNamespace setVariable [QGVAR(wfarDllLoaded), compileFinal (str _wfarDllLoaded)];