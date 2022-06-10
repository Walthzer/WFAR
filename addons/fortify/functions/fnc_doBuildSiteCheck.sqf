#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Checks if passed object needs to be converted to a build site.
 *
 * Arguments:
 * 0: Fortify Object <OBJECT>
 * 1: Side that placed object <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, west] call wfar_fortify_fnc_doBuildSiteCheck
 *
 * Public: No
 */
params ["_object", "_side"];
TRACE_2("doBuildSiteCheck",_object,_side);

//Load build information from registerd fortify preset
private _preset = missionNamespace getVariable [format["ace_fortify_objects_%1", _side], []];

private _index = _preset findIf {(_x select 0) isEqualTo (typeOf _object)};
private _presetKey = format["ace_fortify_objects_%1", _side];
if (_index > -1) then {
    (_preset select _index) params ["_class", "_fortifyBuildTime", ["_buildTime", 0], ["_requiredBuilders", 0]];

    TRACE_2("retrieved from preset",_buildTime,_requiredBuilders);

    if (_buildTime > 0 || _requiredBuilders > 0) then {
        [_object, _buildTime, _requiredBuilders] call FUNC(convertToBuildSite);
    };
};
