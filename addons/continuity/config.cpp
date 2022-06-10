#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"WASHM_wfar_data"};
        author = "";
        authors[] = {"Walthzer/Shark"};
        VERSION_CONFIG;
    };
};

#include "gui.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgEden.hpp"
#include "CfgWFARContinuity.hpp"