#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

GVAR(saveTypes) = call ( uiNamespace getVariable [QGVAR(saveTypes), {}] );