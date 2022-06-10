#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

#include "cbaSettings.hpp"

GVAR(idMap) = createHashMap;
GVAR(enabled) = false;

GVAR(dateFormatString) = localize "STR_3DEN_Display3DENSave_textDate";
{
    GVAR(dateFormatString) = GVAR(dateFormatString) regexReplace [_x, "%" + (str (_forEachIndex + 1))];
} forEach ["%Y/", "%m/", "%d/", "%H/", "%M/"];

if (hasInterface) then {

    [QGVAR(notify), {
        params [["_formatString", ""], ["_saveName", "Nil"], ["_savedBy", "Beep Boop"]];
        TRACE_3("notify",_formatString,_saveName,_savedBy);
        if ((call BIS_fnc_admin) > 0 || {!isNull (getAssignedCuratorLogic player) || (toLower (vehicleVarName player)) in ["overseer", "zeus"]}) then {
            systemChat (format [_formatString, _saveName, _savedBy]);
            [format [_formatString, _saveName, _savedBy]] call CBA_fnc_notify;
        };
    }] call CBA_fnc_addEventHandler;

    ["continuity", {
        params ["_text"];
        if ((call BIS_fnc_admin) > 0 || {!isNull (getAssignedCuratorLogic player) || (toLower (vehicleVarName player)) in ["overseer", "zeus"]}) then {

            (_text splitString " ") params [["_command", "load"], ["_saveName", "QuickSave"]];
            _command = toLower _command;
            switch (_command) do {
                case "load": {
                    [findDisplay 46] call FUNC(openLoadMenu);
                };
                case "save": {
                    [QGVAR(saveMissionEH), [_saveName, profileName]] call CBA_fnc_serverEvent;
                };
            };
        };
    }, "all"] call CBA_fnc_registerChatCommand;
};