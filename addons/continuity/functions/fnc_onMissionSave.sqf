#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Code that needs to be executed OnMissionLoad in EDEN.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * OnMissionSave = QUOTE(call wfar_continuity_fnc_onMissionSave);
 *
 * Public: [No]
 */

//Prevent Save Loop
if (GVAR(didResave)) exitWith {GVAR(didResave) = false};

//Update the save date of this mission PBO
["WFAR Saved Mission Data"] collect3DENHistory {

    //Store object ID in attribute, see wfar_continuity_fnc_getObjectByID
    {
        {
            _x set3DENAttribute [QGVAR(objectID), get3DENEntityID _x];
        } forEach (all3DENEntities select _x);
    } forEach [0,3,5];

    QGVAR(attributes) set3DENMissionAttribute [QGVAR(scenarioUID), systemTimeUTC];
    
    //OnMissionSave runs AFTER 3DEN saves the mission, resave to save the changes made by this script.
    GVAR(didResave) = true;
    do3DENAction "MissionSave";
};