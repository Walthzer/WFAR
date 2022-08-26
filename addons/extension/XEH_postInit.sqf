#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

if !(hasInterface) exitWith {};

//Only do extension commands if we can use the extension!
if (GVAR(wfarDllLoaded)) then {

    //Make sure server gets proper discordData!
    [{(getPlayerUID player) isNotEqualTo ""},
    {
        [QGVAR(syncClientDiscordData), [getPlayerUID player, GVAR(discordData)]] call CBA_fnc_serverEvent
    }, [], 3] call CBA_fnc_waitUntilAndExecute;
};