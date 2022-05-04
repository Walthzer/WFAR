#include "script_component.hpp"

class CfgPatches
{
    class WASHM_wfar_retextures
    {
        name="WHITE FOX ASSAULT REGIMENT SQUAD RETEXTURES";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=1.6;
        requiredaddons[]={"WASHM_wfar_data", "rhsusf_c_troops"};
        units[]={};
        weapons[]={
            #include "data\rhsusf\cvc\gecko\weapons.hpp"
            #include "data\rhsusf\mich_covered\jews\weapons.hpp"
            #define FINAL
            #include "data\rhsusf\mich_covered\shark\weapons.hpp"
            #undef FINAL
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgWFARArsenalAccess.hpp"