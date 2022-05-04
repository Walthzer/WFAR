#include "script_component.hpp"

class CfgPatches {
    class WASHM_wfar_scrapyard_ikarus {
        name="WHITE FOX ASSAULT REGIMENT SCRAPYARD-IKARUS";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=REQUIRED_VERSION;
        requiredaddons[]={"WASHM_wfar_data", "WASHM_wfar_scrapyard_people"};
        units[]={
                "WFAR_Ikarus_Armoured_OPFOR",
                "WFAR_Ikarus_Battle_OPFOR"
            };
        weapons[]={};
    };
};

#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgFactionClasses.hpp"



