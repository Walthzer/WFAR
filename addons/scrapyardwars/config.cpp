#include "script_component.hpp"
#include "basicdefines_A3.hpp"

class CfgPatches {
    class ADDON {
        name="WHITE FOX ASSAULT REGIMENT SCRAPYARD-WARS";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=REQUIRED_VERSION;
        requiredaddons[]={"WASHM_wfar_data"};
        units[]={};
        weapons[]={};
    };
};

#include "CfgVehicles.hpp"
#include "CfgMoves.hpp"
#include "CfgEventHandlers.hpp"
