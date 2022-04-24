#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Add Crew to FFV turrets if ikarus has a driver.
 *
 * Arguments:
 * 0: vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [wall] call wfar_scrapyard_ikarus_fnc_ikarusAddCrew
 *
 * Public: No
 */
params ["_vehicle"];
TRACE_1("ikarusAddCrew",_vehicle);

private _group = group (driver _vehicle);
if !(local _group) exitWith {LOG("Non-local group")}; //Can't add units to a non-local group

if (isNull (driver _vehicle)) exitWith {LOG("vehicle was spawned empty")}; //Vehicle spawned without crew

private _ffvCrewWeighted = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "ffvCrewWeighted");

private _units = [];
{
    private _unitType = selectRandomWeighted _ffvCrewWeighted;
    private _unit = _group createUnit [_unitType, [0,0,0], [], 0, "CAN_COLLIDE"];

    _unit moveInTurret [_vehicle, _x];

    //FFV doesn't simulate bracing your weapon, compensate with added skill.
    _unit setSkill ["aimingAccuracy", 0.8];
    _unit setSkill ["aimingShake", 0.8];
    _unit setSkill ["aimingSpeed", 0.8];

    _units pushBack _unit;

} forEach (allTurrets [_vehicle, true]);

//Make sure added units are on the same side as the driver.
_units joinSilent _group;

["ace_zeus_addObjects", [flatten [_units, _vehicle]]] call CBA_fnc_serverEvent;