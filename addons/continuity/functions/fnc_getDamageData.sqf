#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Returns damage per hitpoint for every hitpoint with damage of object. Returns empty array incase of no damage.
 *
 * Arguments:
 * 0: _object <OBJECT>
 *
 * Return Value:
 * 0: damageData in [ ['HITPOINT', DAMAGE] ] format <ARRAY>
 *
 * Example:
 * [50] call wfar_continuity_fnc_getDamageData
 *
 * Public: [No]
 */
params["_object"];
TRACE_1("getDamageData",_object);

//Store damage information per hitpoitDamage information only if damage exists.
private _hitpointDamage = getAllHitPointsDamage _object;
private _damageData = [];

if (_hitpointDamage isNotEqualTo []) then {
    {
        if (_x > 0.03) then {
            _damageData pushBack [(_hitpointDamage select 0) select _forEachIndex, _x];
        };
    } forEach (_hitpointDamage select 2); //Loop over damage values;
};

TRACE_1("damageData",_damageData);

_damageData