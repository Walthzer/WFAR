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
            #define FINAL
            #include "data\rhsusf\mich_covered\jews\weapons.hpp"
        };
    };
};

class cfgWeapons {
    class rhsusf_mich_helmet_marpatwd;
    class rhsusf_mich_helmet_marpatwd_headset;

    class rhsusf_mich_helmet_marpatwd_alt;
    class rhsusf_mich_helmet_marpatwd_alt_headset;


    class rhsusf_mich_helmet_marpatwd_norotos;
    class rhsusf_mich_helmet_marpatwd_norotos_headset;

    class rhsusf_mich_helmet_marpatwd_norotos_arc;
    class rhsusf_mich_helmet_marpatwd_norotos_arc_headset;

    #include "data\rhsusf\mich_covered\jews\cfgWeapons.hpp"
};
