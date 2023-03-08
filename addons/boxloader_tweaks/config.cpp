#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"WASHM_wfar_data", "boxloader"};
        author = "";
        authors[] = {"Walthzer/Shark"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWFARContinuity.hpp"
#include "CfgVehicles.hpp"