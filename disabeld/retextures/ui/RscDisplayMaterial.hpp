class RscPictureKeepAspect;
class GVAR(RscDisplayMaterial)
{
    onLoad=QUOTE(call FUNC(onLoadDisplay));
    idd = 43343;
    class ControlsBackground
    {
        class layer0: RscPictureKeepAspect 
        {
            idc = 0;
            deletable=1;
            text = "#(rgb,8,8,3)color(1,0,0,1)";
            x=0;
            y=0;
            w=1;
            h=1;
        };
    };
};