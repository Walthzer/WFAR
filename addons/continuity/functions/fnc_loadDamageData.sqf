#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Applies damage from damageData to object.
 *
 * Arguments:
 * 0: _object <OBJECT>
 * 1: _damageData in [ ['HITPOINT', DAMAGE] ] format <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [50] call wfar_continuity_fnc_loadDamageData
 *
 * Public: [No]
 */
params["_object", "_damageData"];
TRACE_2("loadDamageData",_object,_damageData);

{
    _object setHitPointDamage [_x select 0, _x select 1, false, GVAR(unitDummy)];
} forEach _damageData;