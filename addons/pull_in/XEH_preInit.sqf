#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

#include "cbaSettings.hpp"

GVAR(pullActions) = [];
//ace_interact_menu_openedMenuType = -1;
GVAR(compatibleVehicles) = call (uiNamespace getVariable [QGVAR(compatibleVehicles), {[]}]);

if (GVAR(compatibleVehicles) isEqualTo []) exitWith {};

//Event due to locality
[QGVAR(moveInEH), {
	params ["_vehicle", "_player", "_unit"];
	TRACE_3("moveInEH",_vehicle,_player,_unit);
	[_unit, _vehicle, _player] call ace_common_fnc_loadPersonLocal;
}] call CBA_fnc_addEventHandler;

if (hasInterface) then {
	["ace_interactMenuOpened", {
		//Must be inside compatible vehicle and not be self-interacting
		private _vehicle = vehicle player;
		if (_vehicle == player || ace_interact_menu_openedMenuType != 0) exitWith {};

		//Is compatible vehicle
		private _type = typeOf _vehicle;
		if !(_type in GVAR(compatibleVehicles)) exitWith {};

		//Cleanup old actions
		[GVAR(pullActions)] call FUNC(removeActions);

		GVAR(pullActions) = [_vehicle] call FUNC(addActions);

	}] call CBA_fnc_addEventHandler;

	["ace_interactMenuClosed", {
		[GVAR(pullActions)] call FUNC(removePullActions);
	}] call CBA_fnc_addEventHandler;
};