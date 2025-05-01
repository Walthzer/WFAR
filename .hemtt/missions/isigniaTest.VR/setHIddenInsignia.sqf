params ["_unit"];

{
	if (_x == "insignia") exitWith 
	{ 	
			_unit setVariable ["BIS_fnc_setUnitInsignia_class", nil, true];			
			_unit setObjectMaterialGlobal [_forEachIndex, "\a3\data_f\default.rvmat"];
			_unit setObjectTextureGlobal [_forEachIndex, "\z\wfar\addons\insignia\scripted\dev_team.paa"];
	};
} forEach getArray (configFile >> "CfgVehicles" >> getText (configFile >> "CfgWeapons" >> uniform _unit >> "ItemInfo" >> "uniformClass") >> "hiddenSelections");