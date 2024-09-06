#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * generates the 'wfar_boxLoader' saveList.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: wfar_boxLoader saveList <ARRAY>
 *
 * Example:
 * call wfar_continuity_fnc_saveBoxloader;
 *
 * Public: [No]
 */
TRACE_0("saveBoxloader");

/*
*   `fort` base class "Land_Boxloader_Fort_Base"
*   `tools` "boxloader_tool_cart"
*/

private _boxLoaderSaveList = [];
{
    if (!isNull attachedTo _x || !isNull isVehicleCargo _x) then {continue};
    private _vehicleEdenID = _x getVariable [QGVAR(objectID), -1];
    private _objectKey = if (_vehicleEdenID > -1) then {_vehicleEdenID} else {typeOf _x};

    _boxLoaderSaveList pushBack [_objectKey, getPosASL _x, [vectorDir _x, vectorUp _x]];
} forEach entities[GVAR(saveTypes)];

_boxLoaderSaveList