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
            #include "data\cup\ech\medic\weapons.hpp"
            #include "data\cup\ech\withStupid\weapons.hpp"
            #include "data\cup\ech\barker\weapons.hpp"
            #include "data\cup\ech\libby\weapons.hpp"
            #include "data\cup\ech\shark\weapons.hpp"
            #define FINAL
            #include "data\cfp\cvc\shark\weapons.hpp"
            #undef FINAL
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgWFARArsenalAccess.hpp"
#include "CfgConditionalArsenalAccess.hpp"