#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Figure out a good descripter of the current state the player is in (e.g. vehicle driver of riflemen)
 *
 * Arguments:
 * 0: _unit <OBJECT>
 *
 * Return Value:
 * 0: State <STRING>
 *
 * Example:
 * [_unit, _corpse] call wfar_extension_fnc_getReportablePlayerState;
 *
 * Public: [No]
 */
params ["_unit"];
TRACE_1("reportableState"._unit);
private _vehicleName = "";

/*--Roles--
* Infantry -> Medic, Engineer, HAT, MG, Marksmen, Riflemen
* Vehicle -> Driver, Gunner, Commander
*/

//In vehicle CREW
private _vehicle = vehicle player;
if (_vehicle isnotEqualTo player) then {
    _vehicleName = getText((configOf _vehicle) >> "displayName");
};

private _state = if ( _vehicleName isNotEqualTo "" && {player in [driver _vehicle, gunner _vehicle, commander _vehicle]}) then {
    private _index = [driver _vehicle, gunner _vehicle, commander _vehicle] find player;
    if (_index == -1) exitWith { "Limbo" };
    ["Driver", "Gunner", "Commander"] select _index;

} else {

    if ([player, 2] call ace_medical_treatment_fnc_isMedic) exitWith { "Seasoned Medic" };
    if ([player, 1] call ace_medical_treatment_fnc_isMedic) exitWith { "Medic" };

    if ([player] call ace_common_fnc_isEngineer) exitWith { "Engineer" };

    private _weaponNames = toLower str (weapons player);
    private _hatWeapons = ["rhs_weap_SMAW", "rhs_weap_fgm148", "rhs_weap_fim92"];
    if (_hatWeapons findIf {(toLower _x) in _weaponNames} > -1) exitWith { "Heavy AT" }; //is HAT?
    private _mgWeapons = ["rhs_weap_mg42", "rhs_weap_m249", "rhs_weap_fnmag", "rhs_weap_minimi", "rhs_weap_m240", "LMG", "MMG", "MG3"];
    if (_mgWeapons findIf {(toLower _x) in _weaponNames} > -1) exitWith { "Machine Gunner" }; //is MG?
    private _marksmenWeapons = ["rhs_weap_m14", "rhs_weap_m24", "rhs_weap_m40", "rhs_weap_sr25"];
    if (_marksmenWeapons findIf {(toLower _x) in _weaponNames} > -1) exitWith { "Marksmen" }; //is Marksmen?

    "Riflemen"
};

if (_vehicleName isNotEqualTo "") exitWith {
    format ["%1 - %2", _state, _vehicleName];
};

_state


