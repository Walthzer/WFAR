class RscButtonMenu;
class GVAR(ButtonConfigure_base): RscButtonMenu {
    onLoad = QUOTE([_this select 0] call FUNC(handleContinuityButton));
    onButtonClick = QUOTE([ctrlParent (_this select 0)] call FUNC(openLoadMenu));
    idc = IDC_BTN_CONFIGURE;
    text = "Continuity Menu";
    x = POS_X_LOW(21.2);
    y = POS_Y_LOW(23);
    w = POS_W(10);
    h = POS_H(1);
};

class RscDisplayMainMap;
class RscDisplayGetReady: RscDisplayMainMap {
    class controls {
        class GVAR(ButtonConfigure): GVAR(ButtonConfigure_base) {};
    };
};

class RscDisplayServerGetReady: RscDisplayGetReady {
    class controls {
        class GVAR(ButtonConfigure): GVAR(ButtonConfigure_base) {};
    };
};

class RscDisplayClientGetReady: RscDisplayGetReady {
    class controls {
        class GVAR(ButtonConfigure): GVAR(ButtonConfigure_base) {};
    };
};

class ctrlStaticBackgroundDisable;
class ctrlStaticBackgroundDisableTiles;
class ctrlStaticBackground;

class ctrlStatic;
class ctrlStaticTitle;
class ctrlStaticOverlay;
class ctrlStaticFooter;

class ctrlListBox;
class ctrlListNBox;
class ctrlTree;
class ctrlEdit;

class ctrlButtonOK;
class ctrlButtonCancel;

class wfar_DisplayContinuityLoad
{
	idd=10669;
	onLoad="['onLoad', _this select 0] call wfar_continuity_fnc_handleLoadMenu";
	onUnLoad="['onUnLoad', _this select 0, _this select 1] call wfar_continuity_fnc_handleLoadMenu";
	enableSimulation=1;
	enableDisplay=1;
	textDate="$STR_3DEN_Display3DENSave_textDate";
	class ControlsBackground
	{
		class Background: ctrlStaticBackground
		{
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 0.5) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 - (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 + 10 * (pixelH * pixelGrid * 	0.50)";
			w="180 * (pixelW * pixelGrid * 	0.50)";
			h="(safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) - (10 + 	5) * (pixelH * pixelGrid * 	0.50)";
		};
		class BackgroundFilter: ctrlStatic
		{
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 1/4 - 1) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 - (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 + (12 + 	5) * (pixelH * pixelGrid * 	0.50)";
			w="(	180 * 3/4 - 2) * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
			colorBackground[]={0,0,0,1};
		};
		class BackgroundFiles: ctrlStaticOverlay
		{
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 1/4 - 1) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 - (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 + (12 + 	5) * (pixelH * pixelGrid * 	0.50)";
			w="(	180 * 3/4 - 2) * (pixelW * pixelGrid * 	0.50)";
			h="(safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) - (23 + 	5 * 3 + 3) * (pixelH * pixelGrid * 	0.50)";
		};
		class BackgroundButtons: ctrlStaticFooter
		{
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 0.5) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 + (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 - 2 * (	5 + 1) * (pixelH * pixelGrid * 	0.50)";
			w="180 * (pixelW * pixelGrid * 	0.50)";
			h="(	5 + 2) * (pixelH * pixelGrid * 	0.50)";
		};
	};
	class Controls
	{
		class Dummy: ctrlStatic
		{
		};
		class Title: ctrlStaticTitle
		{
			idc=101;
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 0.5) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 - (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 + 	5 * (pixelH * pixelGrid * 	0.50)";
			w="180 * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
			text="$STR_3den_display3den_menubar_missionopen_text";
		};
		class ScenarioUIDs: ctrlListBox
		{
			idc=102;
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 0.5 - 1) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 - (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 + 11 * (pixelH * pixelGrid * 	0.50)";
			w="(	180 * 1/4 - 1) * (pixelW * pixelGrid * 	0.50)";
			h="(safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) - (23 + 2 * 	5 + 2) * (pixelH * pixelGrid * 	0.50)";
			font="EtelkaMonospacePro";
			sizeEx="3.875 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
			iconFolder="\a3\3DEN\Data\Cfg3DEN\Layer\icon_ca.paa";
			iconFolderDefault="\a3\3DEN\Data\Cfg3DEN\Layer\iconDefault_ca.paa";
            onLBSelChanged="['ScenarioUIDs_onLBSelChanged', ctrlParent (_this select 0), _this] call wfar_continuity_fnc_handleLoadMenu";
		};
		class Saves: ctrlListNBox
		{
			idc=103;
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 1/4 - 1) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 - (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 + (12 + 	5 * 2) * (pixelH * pixelGrid * 	0.50)";
			w="(	180 * 3/4 - 2) * (pixelW * pixelGrid * 	0.50)";
			h="(safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) - (23 + 4 * 	5 + 3) * (pixelH * pixelGrid * 	0.50)";
			columns[]={0,0.33000001,0.66000003};
			font="EtelkaMonospacePro";
			disableOverflow=1;
			sizeEx="3.875 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
		};
		class Filter: ctrlListNBox
		{
			idc=104;
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 1/4 - 1) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 - (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 + (12 + 	5) * (pixelH * pixelGrid * 	0.50)";
			w="(	180 * 3/4 - 2) * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
			disableOverflow=1;
			columns[]={0,0.33000001,0.66000003};
			class Items
			{
				class Name
				{
					text="$STR_3DEN_Display3DENSave_Filter_Name_text";
					value=-1;
				};
				class Terrain
				{
					text="Author";
					value=-1;
				};
				class DateModified
				{
					text="$STR_3DEN_Display3DENSave_Filter_DateModified_text";
					value=-1;
					data="value";
				};
			};
		};
		class NameText: ctrlStatic
		{
			style=1;
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 0.5 - 1) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 + (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 - (4 * 	5 + 3) * (pixelH * pixelGrid * 	0.50)";
			w="(	180 * 1/4 - 1) * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
			text="Save:";
		};
		class Name: ctrlEdit
		{
			idc=105;
			x="((getResolution select 2) * 0.5 * pixelW) - (	180 * 1/4 - 1) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 + (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 - (4 * 	5 + 3) * (pixelH * pixelGrid * 	0.50)";
			w="(	180 * 3/4 - 2) * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
			font="EtelkaMonospacePro";
			sizeEx="3.875 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
		};
		class ButtonOK: ctrlButtonOK
		{
            idc=1;
			x="((getResolution select 2) * 0.5 * pixelW) + (	180 * 0.5 - 50 - 2) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 + (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 - (2 * 	5 + 1) * (pixelH * pixelGrid * 	0.50)";
			w="25 * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
			text="$STR_3den_display3den_menubar_missionopen_text";
		};
		class ButtonCancel: ctrlButtonCancel
		{
			x="((getResolution select 2) * 0.5 * pixelW) + (	180 * 0.5 - 25 - 1) * (pixelW * pixelGrid * 	0.50)";
			y="0.5 + (safezoneH min (	180 * (pixelH * pixelGrid * 	0.50))) * 0.5 - (2 * 	5 + 1) * (pixelH * pixelGrid * 	0.50)";
			w="25 * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
		};
	};
};