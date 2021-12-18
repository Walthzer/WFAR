#include "script_component.hpp"

class CfgPatches
{
    class WASHM_wfar_insignia
    {
        name="WHITE FOX ASSAULT REGIMENT SQUAD INSIGNIA";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=1.6;
        requiredaddons[]={"WASHM_wfar_data"};
        units[]={};
        weapons[]={};
    };
};
class CfgUnitInsignia
{
    class Dagger
    {
        displayName="Dagger Squad";
        author="Velez";
        texture="\z\wfar\addons\insignia\squad\dagger.paa";
        textureVehicle="";
    };
    class Legion
    {
        displayName="Legion Squad";
        author="Velez";
        texture="\z\wfar\addons\insignia\squad\legion.paa";
        textureVehicle="";
    };
    class Titan
    {
        displayName="Titan Squad";
        author="Velez";
        texture="\z\wfar\addons\insignia\squad\titan.paa";
        textureVehicle="";
    };
    class TitanCharlie
    {
        displayName="Titan-Charlie Team";
        author="Ferris";
        texture="\z\wfar\addons\insignia\squad\titancharlie.paa";
        textureVehicle="";
    };
    class WierdWolf
    {
        displayName="Alpha 1-1";
        author="Barker";
        texture="\z\wfar\addons\insignia\squad\wierdwolf.paa";
        textureVehicle="";
    };

    class G_Mask
    {
        displayName="Gas Mask";
        author="PFC G. Mask";
        texture="\z\wfar\addons\insignia\players\g_mask.paa";
        textureVehicle="";
    };
};
