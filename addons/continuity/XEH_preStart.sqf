#include "script_component.hpp"

#include "XEH_PREP.hpp"

private _boxSaveTypes = ("true" configClasses (configFile >> "CfgWFARContinuity" >> "saveLists" >> QGVARMAIN(boxes) >> "types")) apply { configName _x };
uiNamespace setVariable [QGVAR(boxSaveTypes), compileFinal (str _boxSaveTypes)];

