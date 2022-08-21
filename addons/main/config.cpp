#include "script_component.hpp"

class CfgPatches
{
    class WASHM_wfar_data
    {
        name="WHITE FOX ASSAULT REGIMENT data";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=1.6;
        requiredaddons[]={ "CBA_main", "A3_Data_F_Enoch_Loadorder" };
        units[]={};
        weapons[]={};
    };
};

delete enableDebugConsole;
enableDebugConsole[] = { "76561198053950415" }; //Shark