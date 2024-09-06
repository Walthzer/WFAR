#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Initialise a UI Texture on an object
 *
 * Arguments:
 * 0: object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params ["__", "_name", "_slot", "_assigned"];
TRACE_3("handleSlot",_name,_slot,_assigned);

systemChat "initUITextureObject";


this addEventHandler ["SlotItemChanged", {
    params ["_unit", "_name", "_slot", "_assigned", "_weapon"];
}];