#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Figure out a good descripter of the current state the _unit is in (e.g. vehicle driver of riflemen)
 *
 * Arguments:
 * 0: _unit <OBJECT>
 *
 * Return Value:
 * 0: State <STRING>
 *
 * Example:
 * [_unit, _corpse] call wfar_extension_fnc_getReportable_unitState;
 *
 * Public: [No]
 */
params ["_unit"];
TRACE_1("reportableState",_unit);
private _vehicleName = "";

/*--Roles--
* Infantry -> Medic, Engineer, HAT, MG, Marksmen, Riflemen
* Vehicle -> Driver, Gunner, Commander
*/

private _weaponRoles = [
    [ ["cup_launch_mk153", "javelin"], "Heavy AT"],
    [ ["stinger", "igla", "strela"], "Man Portable AA"],
    [ ["lmg", "mmg", "mg3"], "Machine Gunner"],
    [ ["srifle_m2010", "srifle_m107", "s_rifle_lrr"], "Sniper"],
    [ ["cup_arifle_mk20", "srifle", "dmr"], "Marksmen"]
];


//In vehicle CREW
private _vehicle = vehicle _unit;
if (_vehicle isNotEqualTo _unit) then {
    _vehicleName = getText((configOf _vehicle) >> "displayName");
};

private _state = if ( _vehicleName isNotEqualTo "" && {_unit in [driver _vehicle, gunner _vehicle, commander _vehicle]}) then {
    private _index = [driver _vehicle, gunner _vehicle, commander _vehicle] find _unit;
    if (_index == -1) exitWith { "Limbo" };
    ["Driver", "Gunner", "Commander"] select _index;

} else {

    if ([_unit, 2] call ace_medical_treatment_fnc_isMedic) exitWith { "Seasoned Medic" };
    if ([_unit, 1] call ace_medical_treatment_fnc_isMedic) exitWith { "Medic" };

    if ([_unit] call ace_common_fnc_isEngineer) exitWith { "Engineer" };

    private _weaponNames = toLower (str (weapons _unit));
    private _roleIndex = _weaponRoles findIf { ( ( _x select 0 ) findIf { _x in _weaponNames } ) > -1 };

    //If no special role was found, assign rifleman
    if (_roleIndex == -1) exitWith { "Rifleman" };
    (_weaponRoles select _roleIndex) select 1;
};

if (_vehicleName isNotEqualTo "") exitWith {
    format ["%1 - %2", _state, _vehicleName];
};

_state


