class RscHTML;

class GVAR(htmlDialog) {
    idd = -1;
    access = 0;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(dialog),_this select 0)]);
    movingEnable = 1;
    enableSimulation = 1;
    class ControlsBackground
    {
        class Html: RscHTML
        {
            idc = 1;
            filename = "http://walthzer69.wixsite.com/waltex/_functions/insigniaAccesValidation";
            x = 0;
            y = 0;
            w = 0;
            h = 0;
        };    
    };
};