#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

if (isServer) then {

    private _fnc_addSpareCargo = {
        params ["_vehicle"];

        //Add fuel cans based on vehicle side
        private _config = configOf _vehicle;
        private _fuelCanType = "";
        switch (getNumber(_config >> "side")) do {
            //case WEST: {_fuelCanType = selectRandom ["rhsusf_props_ScepterMFC_OD", "rhsusf_props_ScepterMFC_D"]}; -> only RHS
            case INDEPENDENT;
            case WEST;
            case EAST: {_fuelCanType = "Land_CanisterFuel_F"};
        };

        if (_fuelCanType isNotEqualTo "") then {
            [_fuelCanType, _vehicle, true] call ace_cargo_fnc_loadItem;
        };
    };

    //["Tank", "initPost", _fnc_addSpareCargo] call CBA_fnc_addClassEventHandler; Fuel Cans take up spare track space
    ["Car", "initPost", _fnc_addSpareCargo] call CBA_fnc_addClassEventHandler;
    ["Boat", "initPost", _fnc_addSpareCargo] call CBA_fnc_addClassEventHandler;
};

ADDON = true;