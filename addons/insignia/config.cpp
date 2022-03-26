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

#include "CfgEventHandlers.hpp"
#include "CfgUnitInsignia.hpp"
#include "CfgCommands.hpp"
#include "scripted\restrictedInsignia.hpp"
#include "Dialogs.hpp"
