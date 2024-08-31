#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"wfar_continuity", "boxloader"};
        author = "";
        authors[] = {"Walthzer/Shark"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWFARContinuity.hpp"
#include "CfgVehicles.hpp"