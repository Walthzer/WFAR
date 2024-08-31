#include "script_component.hpp"

class CfgPatches
{
    class wfar_misc_config
    {
        name="WHITE FOX ASSAULT REGIMENT data";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=1.0;
        requiredaddons[]={"A3_Data_F"};
        units[]={};
        weapons[]={};
    };
};
class CfgSurfaces
{
    class Default;
    class GdtThorn: Default
    {
        ACE_canDig = 1;
    };
};
