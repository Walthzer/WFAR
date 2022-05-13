#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleToggleSupplies),
            QGVAR(moduleglobalSupplyRange)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"WASHM_wfar_data", "wfar_continuity", "ace_zeus"};
        author = "";
        authors[] = {"Walthzer/Shark"};
        VERSION_CONFIG;
    };
};
#include "CfgEden.hpp"
#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgFactionClasses.hpp"
#include "Dialogs.hpp"
#include "ACEX_Fortify_Presets.hpp"
#include "CfgWFARContinuity.hpp"