#include "script_component.hpp"

#include "XEH_PREP.hpp"

GVAR(compatibleVehicles) = [];

{
	GVAR(compatibleVehicles) pushBack (configName _x);
} forEach (QUOTE(getNumber(_x >> QQGVAR(enabeld)) > 0) configClasses (configFile >> "CfgVehicles"));

uiNamespace setVariable [QGVAR(compatibleVehicles), compileFinal str GVAR(compatibleVehicles)];