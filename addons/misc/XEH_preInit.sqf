#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

if (isServer) then {

    private _fnc_addSpareCargo = {
        params ["_vehicle"];
        if (ace_repair_addSpareParts && {_vehicle isKindOf "Tank"}) then {
            [_vehicle, 1, "ACE_Track"] call ace_repair_fnc_addSpareParts;
        };

        //Add fuel cans based on vehicle side
        private _config = configOf _vehicle;
        private _fuelCanType = "";
        switch (getNumber(_config >> "side")) do {
            case WEST: {_fuelCanType = selectRandom ["rhsusf_props_ScepterMFC_OD", "rhsusf_props_ScepterMFC_D"]};
            case INDEPENDENT;
            case EAST: {_fuelCanType = "Land_CanisterFuel_F"};
        };

        if (_fuelCanType isNotEqualTo "") then {
            [_fuelCanType, _vehicle, true] call ace_cargo_fnc_loadItem;
        };
    };

    ["Tank", "initPost", _fnc_addSpareCargo] call CBA_fnc_addClassEventHandler;
    ["Car", "initPost", _fnc_addSpareCargo] call CBA_fnc_addClassEventHandler;
};

ADDON = true;