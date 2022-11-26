#include "script_component.hpp"

#include "XEH_PREP.hpp"

//ACE Arsenal item cache format
private _conditionalArsenalAccess = [
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

{
    private _cache = [];
    private _index = parseNumber (configName _x);
    {
        private _condition = compile ( getText ( _x >> "condition" ) );
        private _items = getArray ( _x >> "items" );

        _cache pushBack [ _condition, _items];

    } forEach ( "true" configClasses (_x) );

    _conditionalArsenalAccess set [_index, _cache];

} forEach ( "true" configClasses (configFile >> "cfgConditionalArsenalAcces") );

uiNamespace setVariable [QGVAR(conditionalArsenalAccess), compileFinal ( str _conditionalArsenalAccess )];