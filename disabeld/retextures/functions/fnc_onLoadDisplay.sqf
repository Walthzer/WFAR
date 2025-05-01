#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Initialise a UI Texture display
 *
 * Arguments:
 * 0: display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params ["_display"];
TRACE_1("onLoadDisplay",_display);

//displayName
private _displayname = displayUniqueName _display;
systemChat format["onLoad: %1", _displayname];

//Arsenal Actions
private _config = configFile >> "CfgWeapons" >> _displayname;
private _dynamicConfig = GVAR(dynamics) getOrDefault [getText (_config >> QGVAR(materialClass)), configNull];
private _material = ("true" configClasses (_dynamicConfig >> "bases")) select 1;
[_displayname, _material, objNull] call FUNC(setMaterial);