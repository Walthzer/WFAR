#include "script_component.hpp"

//ACE Arsenal item cache format
private _cargo = [
    [[], [], []], // Weapons 0, primary, secondary, handgun
    [[], [], [], []], // WeaponAccessories 1, optic,side,muzzle,bipod
    [ ], // Magazines 2
    [ ], // Headgear 3
    [ ], // Uniform 4
    [ ], // Vest 5
    [ ], // Backpacks 6
    [ ], // Goggles 7
    [ ], // NVGs 8
    [ ], // Binoculars 9
    [ ], // Map 10
    [ ], // Compass 11
    [ ], // Radio slot 12
    [ ], // Watch slot  13
    [ ], // Comms slot 14
    [ ], // WeaponThrow 15
    [ ], // WeaponPut 16
    [ ] // InventoryItems 17
];

//Try to build access list
if (GVAR(arsenalAccess) isEqualTo _cargo && isMultiplayer) then {
    private _playerUID = getPlayerUID player;
    {
        private _index = parseNumber (configName _x);
        private _gear = getArray (_x >> _playerUID);

        GVAR(arsenalAccess) set [_index, _gear];

    } forEach (QUOTE(isArray(_x >> _playerUID)) configClasses (configFile >> "cfgWFARArsenalAccess"));

    uiNamespace setVariable [QGVAR(arsenalAccess), compileFinal (str GVAR(arsenalAccess))];
};

player addEventHandler ["SlotItemChanged", LINKFUNC(handleSlot)];