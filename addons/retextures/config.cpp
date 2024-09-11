#include "script_component.hpp"

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
            #include "build\weapons.hpp"
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWFARArsenalAccess.hpp"
#include "ui/RscDisplayMaterial.hpp"

//Build by rhai
#include "build/ui.hpp"
#include "build/CfgWeapons.hpp"