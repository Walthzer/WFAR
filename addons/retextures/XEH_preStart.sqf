#include "script_component.hpp"

#include "XEH_PREP.hpp"

wfar_retextures_hashmap = createHashMap;

wfar_retextures_hashmap set ["slotCount", getNumber (configFile >> "wfar_retextures" >> "slots")];

wfar_retextures_fnc_crawler = {
    params ["_config", ["_path", ""]];

    if (isClass (_config >> "bases")) exitWith { 
        //Found inner class
        private _baseClass = "wfar_retextures" + _path;
        wfar_retextures_hashmap set [_baseClass, _config];
    };
    {
        [_x, _path + "_" + (configName _x)] call wfar_retextures_fnc_crawler;
    } forEach ("true" configClasses (_config));
};
[configFile >> "wfar_retextures"] call wfar_retextures_fnc_crawler;

//store readonly hashmap
uiNamespace setVariable [QGVAR(dynamics), compileFinal wfar_retextures_hashmap];