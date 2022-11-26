#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

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

GVAR(arsenalAccess) = call (uiNamespace getVariable [QGVAR(arsenalAccess), {_cargo}]);
GVAR(conditionalArsenalAccess) = call (uiNamespace getVariable [QGVAR(conditionalArsenalAccess), {_cargo}]);

["ace_arsenal_leftPanelFilled", LINKFUNC(fillLeftPanel)] call CBA_fnc_addEventHandler;