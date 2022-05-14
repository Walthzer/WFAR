#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

if (isServer) then {

    GVAR(fortifyObjects) = [];

    //Init foritfy limit variables
    GVAR(suppliers) = [];
    GVAR(globalSupplyRange) = 50;
    
};