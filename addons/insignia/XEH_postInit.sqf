#include "script_component.hpp";
#include "\z\ace\addons\arsenal\defines.hpp"

//GVARs
GVAR(currentInsignia) = "";
GVAR(restrictedInsigniaConfigs) = [];
GVAR(restrictedInsigniaClassnames) = [];

private _allowedRestrictedInsignia = call (uiNamespace getVariable [QGVAR(allowedRestrictedInsignia), {[]}]);

//Create permissionlist for restricted insignia
if (isMultiplayer) then {
    if (_allowedRestrictedInsignia isEqualTo []) then {
        private _playerUID = getPlayerUID player; //
        private _playerPermissionList = flatten [getArray (configFile >> QGVAR(permissionList) >> _playerUID), getArray (missionConfigFile >> QGVAR(permissionList) >> _playerUID)];

        if ((count _playerPermissionList) > 0) then {
            {
                private _isMissionConfig = _forEachIndex;
                {
                    private _class = configName _x;
                    if (_class in _playerPermissionList) then {
                        _allowedRestrictedInsignia pushBack [_isMissionConfig, _class];
                    };
                } forEach _x;
            } forEach ["true" configClasses (configFile >> QGVAR(restrictedInsignia)), "true" configClasses (missionConfigFile >> QGVAR(restrictedInsignia))];
        };
        TRACE_2("WFARLIST",_playerPermissionList,_allowedRestrictedInsignia);
        uiNamespace setVariable [QGVAR(allowedRestrictedInsignia), compileFinal (str _allowedRestrictedInsignia)];
    };
};

if ((count _allowedRestrictedInsignia) > 0) then {

    {
        GVAR(restrictedInsigniaConfigs) pushBack _x;
    } forEach ("true" configClasses (missionConfigFile >> QGVAR(restrictedInsignia)));

    {
        GVAR(restrictedInsigniaConfigs) pushBackUnique _x;
    } forEach ("true" configClasses (configFile >> QGVAR(restrictedInsignia)));

    GVAR(restrictedInsigniaClassnames) = GVAR(restrictedInsigniaConfigs) apply {configName _x};

    //add EH to Ace Arsenal Display
    ["ace_arsenal_displayOpened", {
        params ["_arsenalDisplay"];
        TRACE_1("ace_arsenal_displayOpened",_arsenalDisplay);

            systemChat str ((_arsenalDisplay displayCtrl IDC_leftTabContent) ctrlAddEventHandler ["LBSelChanged", QUOTE(_this call FUNC(onSelChangedLeft))]); //)]

    }] call CBA_fnc_addEventHandler; [QGVAR(leftPanelFilled), [_display, _ctrlIDC, GVAR(currentRightPanel)]];

    //Handel insignia tab openend
    ["ace_arsenal_leftPanelFilled", {
        params ["_arsenalDisplay", "_openTabIDC"];
        TRACE_2("ace_arsenal_leftPanelFilled",_arsenalDisplay,_openTabIDC);

        if (_openTabIDC == IDC_buttonInsignia) then {
            [_arsenalDisplay] call FUNC(initializeInsigniaPanel);
        };

    }] call CBA_fnc_addEventHandler;
};
