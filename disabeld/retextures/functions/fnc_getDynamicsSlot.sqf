#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * return assigned dynamics slot for multiplayer or 0 in singleplayer
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
*/
TRACE_0("getDynamicsSlot");
//Singleplayer, thus slots don't matter
if (!isMultiplayer) exitWith {0};

GVAR(slots) find (wfar_steamID)

