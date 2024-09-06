#include "script_component.hpp"

class CfgPatches
{
    class WASHM_wfar_flags
    {
        name="WHITE FOX ASSAULT REGIMENT SQUAD FLAGS";
        author="Walthzer/Shark";
        url="https://whitefoxassaultreg.wixsite.com/wfar";
        requiredVersion=REQUIRED_VERSION;
        requiredaddons[]={"WASHM_wfar_data"};
        units[]={"WFAR_Flag_WfarWhite","WFAR_Flag_WfarBlack","WFAR_Flag_ISIS"};
        weapons[]={};
    };
};
class CfgVehicles
{
    class FlagCarrier_Asym;
    class WFAR_Flag_WfarWhite: FlagCarrier_Asym
    {
        scope=2;
        scopeCurator=2;
        author="Walthzer/Shark";
        displayName="Flag (WFAR White)";
        editorPreview="";

        class EventHandlers 
        {
            init="(_this select 0) setFlagTexture '\z\wfar\addons\flags\data\WfarWhite.paa'";
        };

    };
    class WFAR_Flag_WfarBlack: WFAR_Flag_WfarWhite
    {
        displayName="Flag (WFAR Black)";
        editorPreview="";

        class EventHandlers 
        {
            init="(_this select 0) setFlagTexture '\z\wfar\addons\flags\data\WfarBlack.paa'";
        };

    };
    class WFAR_Flag_ISIS: WFAR_Flag_WfarWhite
    {
        displayName="Flag (ISIS)";
        editorPreview="";

        class EventHandlers 
        {
            init="(_this select 0) setFlagTexture '\z\wfar\addons\flags\data\ISIS.paa'";
        };

    };
};
