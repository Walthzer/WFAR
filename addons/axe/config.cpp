#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {"wfar_axe"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"WASHM_wfar_data"};
        author = "";
        authors[] = {"Walthzer/Shark"};
        VERSION_CONFIG;
    };
};

#include "CfgWeapons.hpp"
#include "CfgMovesBasic.hpp"
#include "CfgEventHandlers.hpp"
