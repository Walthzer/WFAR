#include "script_component.hpp"

#include "XEH_PREP.hpp"

private _saveTypes = ("true" configClasses (configFile >> "CfgWFARContinuity" >> "saveLists" >> QGVARMAIN(boxloader) >> "types")) apply { configName _x };
uiNamespace setVariable [QGVAR(saveTypes), compileFinal (str _saveTypes)];