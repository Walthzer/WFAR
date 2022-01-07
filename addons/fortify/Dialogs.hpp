#include "\a3\ui_f\hpp\definecommongrids.inc"
#include "\a3\ui_f\hpp\definecommoncolors.inc"

class RscText;
class RscObject;
class RscToolbox;
class RscPicture;

class GVAR(buildersWaiting_dialog) {
    idd = WAITING_DIALOG_IDD;
    access = 0;
    movingEnable = 0;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QUOTE(QGVAR(waitDialogOpen)),true)]; uiNamespace setVariable [ARR_2(QUOTE(QGVAR(ctrWaitToolBox)),(_this select 0) displayCtrl 1)]; uiNamespace setVariable [ARR_2(QUOTE(QGVAR(ctrlWaitPicture)),(_this select 0) displayCtrl 2)];);
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QUOTE(QGVAR(waitDialogOpen)),false)]);
    enableSimulation = true;
    class ControlsBackground
    {
        class Background: RscText
        {
            colorBackground[] = {0, 0, 0, 0.9};
            x = GUI_GRID_CENTER_X + 9 * GUI_GRID_CENTER_W;
            y = GUI_GRID_CENTER_Y + 7.1 * GUI_GRID_CENTER_H;
            w = 19.9 * GUI_GRID_CENTER_W;
            h = 10 * GUI_GRID_CENTER_H;
        };
        class top_strip: RscText
        {
            //font = GUI_FONT_MONO;
            shadow = 0;
            text = "Building Statistics";
            colorText[] = {IGUI_TEXT_RGB, 0.8};
            colorBackground[] = {GUI_BCG_DARK_RGB, 0.8};
            x = GUI_GRID_CENTER_X + 9 * GUI_GRID_CENTER_W;
            y = GUI_GRID_CENTER_Y + 6 * GUI_GRID_CENTER_H;
            w = 20 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class buildingStats: RscToolbox
        {
            idc = 1;
            rows = 1;
            columns = 3;
            colorText[] = {GUI_BCG_DARK_RGB,1};
            color[] = {0,0,0,0};
            colorTextSelect[] = {GUI_BCG_DARK_RGB,1};
            colorSelect[] = {0, 0, 0, 0};
            colorTextDisable[] = {0,0,0,0};
            colorDisable[] = {0,0,0,0};
            colorSelectedBg[] = {0,0,0,0};
            strings[] = {"", "", ""};
            x = GUI_GRID_CENTER_X + 9 * GUI_GRID_CENTER_W;
            y = GUI_GRID_CENTER_Y + 7.2 * GUI_GRID_CENTER_H;
            w = 20 * GUI_GRID_CENTER_W;
            h = 1 * GUI_GRID_CENTER_H;
        };
        class buildingImage: RscPicture
        {
            idc = 2;
            shadow = 0;
            style = 48;
            text = "";
            x = GUI_GRID_CENTER_X + 9 * GUI_GRID_CENTER_W;
            y = GUI_GRID_CENTER_Y + 8.3 * GUI_GRID_CENTER_H;
            w = 19.9 * GUI_GRID_CENTER_W;
            h = 9 * GUI_GRID_CENTER_H;
        };
    };
/*     class objects
    {
        class building: RscObject 
        {
            shadow = 0;
            idc = WAITING_DIALOG_OBJECT_IDC;
            type = 80;
            model = "ca\misc3\wf\wf_depot.p3d";
            x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
            y = GUI_GRID_CENTER_Y + 12 * GUI_GRID_CENTER_H;
            z = 9 * GUI_GRID_CENTER_H;
            direction[] = {4,1,4};
            up[] = {1,10,0};
            zoomDuration = 0;
            scale = 0.00694185;
            waitForLoad = 1;
        };
    }; */
};