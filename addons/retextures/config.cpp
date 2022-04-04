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
            "wfar_jews_mich_helmet_marpatwd_norotos",
            "wfar_jews_mich_helmet_marpatd_norotos",
            "wfar_jews_mich_helmet_marpatwd_norotos_arc",
            "wfar_jews_mich_helmet_marpatd_norotos_arc"
        };
    };
};

class cfgWeapons {
    class rhsusf_mich_helmet_marpatwd_norotos;
    class rhsusf_mich_helmet_marpatwd_norotos_arc;

    #include "data\mich_covered_norotos\jews\cfgWeapons.hpp"
};
