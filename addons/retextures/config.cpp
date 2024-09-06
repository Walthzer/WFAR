#include "script_component.hpp"
#include "config_macro.hpp"

class CfgPatches
{
    class WASHM_wfar_retextures
    {
        name="WHITE FOX ASSAULT REGIMENT SQUAD RETEXTURES";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=REQUIRED_VERSION;
        requiredaddons[]={"WASHM_wfar_data", "cfp_headgear", "CUP_Creatures_Military_USArmy"};
        units[]={};
        weapons[]={
            #include "data\weapons.hpp"
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "data/ui.hpp"
#include "CfgWeapons.hpp"
#include "CfgWFARArsenalAccess.hpp"