#include "defines.hpp"

class RscPictureKeepAspect;
class GVAR(ui)
{
    idd = -1;
    class ControlsBackground
    {
        class base: RscPictureKeepAspect 
        {
            onLoad=QUOTE({_this call FUNC(onLoadUITexture)});
            onUnLoad=QUOTE(LINKFUNC(onLoadUITexture));
            idc = IDCSquareBase;
            text = "";
            x=0;
            y=0;
            w=1;
            h=1;
        };
        class layer1: base 
        {
            idc = IDCSquareLayer1;
            text = "";
        };
        class layer2: base 
        {
            idc = IDCSquareLayer2;
            text = "";
        };
        class layer3: base 
        {
            idc = IDCSquareLayer3;
            text = "";
        };
        class layer4: base 
        {
            idc = IDCSquareLayer4;
            text = "";
        };
        class layer5: base 
        {
            idc = IDCSquareLayer5;
            text = "";
        };
        class layer6: base 
        {
            idc = IDCSquareLayer6;
            text = "";
        };
        
    };
};

#include "cup/ui.hpp"