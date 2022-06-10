#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

if (isServer) then {

    ["Tank", "initPost", {
        params ["_vehicle"];
		if !(ace_repair_addSpareParts && _vehicle isKindOf "Tank") exitWith {};

		[_vehicle, 1, "ACE_Track"] call ace_repair_fnc_addSpareParts;

	}] call CBA_fnc_addClassEventHandler;
};

ADDON = true;