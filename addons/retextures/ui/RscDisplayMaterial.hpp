#include "defines.hpp"

class RscPictureKeepAspect;
class GVAR(RscDisplayMaterial)
{
    idd = -1;
    class ControlsBackground
    {
        class layer0: RscPictureKeepAspect 
        {
            onLoad=QUOTE({_this call FUNC(onLoadUITexture)});
            onUnLoad=QUOTE(LINKFUNC(onLoadUITexture));
            idc = IDCMateriallayer0;
            text = "";
            x=0;
            y=0;
            w=1;
            h=1;
        };
        class layer1: layer0 
        {
            idc = IDCMaterialLayer1;
            text = "";
        };
        class layer2: layer0 
        {
            idc = IDCMaterialLayer2;
            text = "";
        };
        class layer3: layer0 
        {
            idc = IDCMaterialLayer3;
            text = "";
        };
        class layer4: layer0 
        {
            idc = IDCMaterialLayer4;
            text = "";
        };
        class layer5: layer0 
        {
            idc = IDCMaterialLayer5;
            text = "";
        };
        class layer6: layer0 
        {
            idc = IDCMaterialLayer6;
            text = "";
        };
        
    };
};