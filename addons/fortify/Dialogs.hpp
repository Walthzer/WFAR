#include "\a3\ui_f\hpp\definecommongrids.inc"
#include "\a3\ui_f\hpp\definecommoncolors.inc"

class RscText;
class RscEdit;
class RscObject;
class RscToolbox;
class RscPicture;
class RscCombo;
class RscCheckBox;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;

class RscDisplayAttributes {
    class Controls {
        class Background;
        class Title;
        class Content: RscControlsGroup {
            class Controls;
        };
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(RscToggleSupplies): RscDisplayAttributes {

    onLoad = QUOTE([ARR_3('onLoad', _this, QQGVAR(RscToggleSupplies))] call ace_zeus_fnc_zeusAttributes);
    onUnload = QUOTE([ARR_3('onUnload', _this, QQGVAR(RscToggleSupplies))] call ace_zeus_fnc_zeusAttributes);

    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class supplies: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_toggleSupplies));
                    idc = 300000;
                    x = 0;
                    y = 0;
                    w = W_PART(26);
                    h = H_PART(2.3);
                    class controls {
                        class hasSuppliesLabel: RscText {
                            idc = -1;
                            text = "Has Supplies:";
                            align = "right";
                            toolTip = "Does this unit actively provide supply?";
                            x = 0;
                            y = H_PART(0.1);
                            w = W_PART(10);
                            h = H_PART(1);
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class hasSupplies: RscCheckBox {
                            idc = 300001;
                            x = W_PART(10.1);
                            y = H_PART(0.1);
                            w = W_PART(1);
                            h = H_PART(1);
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class supplyRangeLabel: hasSuppliesLabel {
                            idc = -1;
                            text = "Supply Range:";
                            toolTip = "Range for the supply, 0 for global range.";
                            y = H_PART(1.3);
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class supplyRange: RscEdit {
                            text = "0";
                            idc = 300002;
                            x = W_PART(10.1);
                            y = H_PART(1.3);
                            w = W_PART(15.9);
                            h = H_PART(1);
                            colorBackground[] = {0, 0, 0, 0.5};
                            autocomplete = "";
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscGlobalSupplyRange): RscDisplayAttributes {

    onLoad = QUOTE([ARR_3('onLoad', _this, QQGVAR(RscGlobalSupplyRange))] call ace_zeus_fnc_zeusAttributes);
    onUnload = QUOTE([ARR_3('onUnload', _this, QQGVAR(RscGlobalSupplyRange))] call ace_zeus_fnc_zeusAttributes);

    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class globalSupplyRange: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_globalSupplyRange));
                    idc = 300000;
                    x = 0;
                    y = 0;
                    w = W_PART(26);
                    h = H_PART(1.1);
                    class controls {
                        class Label: RscText {
                            idc = -1;
                            align = "right";
                            text = "Supply Range:";
                            toolTip = "Global default range for supply, used when object has range 0";
                            x = 0;
                            y = H_PART(0.1);
                            w = W_PART(10);
                            h = H_PART(1);
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class Range: RscEdit {
                            text = "0";
                            idc = 300002;
                            x = W_PART(10.1);
                            y = H_PART(0.1);
                            w = W_PART(15.9);
                            h = H_PART(1);
                            colorBackground[] = {0, 0, 0, 0.5};
                            autocomplete = "";
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
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