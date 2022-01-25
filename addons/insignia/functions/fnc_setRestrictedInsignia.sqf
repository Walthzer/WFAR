#include "script_component.hpp"
#include "\z\ace\addons\arsenal\defines.hpp"
/*
 * Author: Walthzer/Shark
 * BIS_fnc_setUnitInsignia but implemented for restrictedInsignia
 *
 * Arguments:
 * 0: insignia Config <CONFIG>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params ["_config", ["_unit", player]];
TRACE_2("setRestrictedInsignia",_config,_unit);

{
	if (_x == "insignia") exitWith 
	{ 	
			_unit setVariable ["BIS_fnc_setUnitInsignia_class", nil, true];			
			_unit setObjectMaterialGlobal [_forEachIndex, getText (_config >> "material")];
			_unit setObjectTextureGlobal [_forEachIndex, getText (_config >> "texture")];
	};
} forEach getArray (configFile >> "CfgVehicles" >> getText (configFile >> "CfgWeapons" >> uniform _unit >> "ItemInfo" >> "uniformClass") >> "hiddenSelections");
