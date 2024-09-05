#include "script_component.hpp"

class CfgPatches
{
    class WASHM_wfar_retextures
    {
        name="WHITE FOX ASSAULT REGIMENT SQUAD RETEXTURES";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=1.6;
        requiredaddons[]={"WASHM_wfar_data", "cfp_headgear", "CUP_Creatures_Military_USArmy"};
        units[]={};
        weapons[]={
            #define FINAL
            #include "data\cup\ech\weapons.hpp"
            #undef FINAL
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "ui/square.hpp"
#include "CfgWeapons.hpp"
#include "CfgWFARUITextures.hpp"
#include "CfgWFARArsenalAccess.hpp"