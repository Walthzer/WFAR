#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

if !(hasInterface) exitWith {};

[{
	if (currentMuzzle player == "wfar_axe_axe" && {gestureState player == "<none>" && "lnr" in (animationState player)}) then {
		player playActionNow "wfar_axe_hold";	
	};
}] call CBA_fnc_addPerFrameHandler;

//Reset axe after a chop
player addEventHandler ["GestureDone", {
	params ["_unit", "_gesture"];
	if (_gesture == "wfar_axe_chop") then {
		player playActionNow "wfar_axe_hold";
	};
}];

//Prevent Axe "firing" and do a chop
[player, "DefaultAction",  {currentMuzzle player == "wfar_axe_axe"}, {
	if (gestureState player != "wfar_axe_chop") then {
		player playActionNow "wfar_axe_chop";
	};
	false
}] call ace_common_fnc_addActionEventHandler;

ADDON = true;
