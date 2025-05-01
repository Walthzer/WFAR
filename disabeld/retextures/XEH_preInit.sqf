#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

GVAR(slotMap) = createHashMapFromArray [
    [605, 6],
    [801, 3],
    [701, 4],
    [901, 5],
    [603, 7]
];

GVAR(arsenalActions) = createHashMap;
GVAR(dynamics) = uiNamespace getVariable [QGVAR(dynamics), createHashMap];

if (isServer) exitWith {
    GVAR(slots) = [];
    for "_i" from 0 to ((GVAR(dynamics) get "slotCount") - 1) do {
        GVAR(slots) pushBack "";
    };

    addMissionEventHandler ["PlayerConnected", {call FUNC(handlePlayerConnected)}];
    addMissionEventHandler ["PlayerDisconnected", {call FUNC(handlePlayerDisconnected)}];
};