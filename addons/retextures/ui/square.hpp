#include "defines.hpp"

class RscPictureKeepAspect;
class GVAR(ui)
{
	idd = -1;
    onLoad=QUOTE(LINKFUNC(onLoadUITexture));
    onUnLoad=QUOTE(LINKFUNC(onLoadUITexture));
	class ControlsBackground
	{
        class base: RscPictureKeepAspect 
        {
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

class GVAR(ui_marpat_wd): GVAR(ui)
{
    class ControlsBackground: ControlsBackground
	{
        class base: base
        {
            text=QUOTE(\CUP\Creatures\People\Military\CUP_Creatures_People_Military_USArmy\ACH\data\ACH_MARPAT_co.paa);
        };
    };
};

class GVAR(ui_marpat_des): GVAR(ui)
{
    class ControlsBackground: ControlsBackground
	{
        class base: base
        {
            text=QUOTE(\CUP\Creatures\People\Military\CUP_Creatures_People_Military_USArmy\ACH\data\ACH_MARPAT_des_co.paa);
        };
    };
};