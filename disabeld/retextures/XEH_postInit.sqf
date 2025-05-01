#include "script_component.hpp"

//Offline compatible steamID checking
if (isMultiplayer) then {
    wfar_steamID = getPlayerUID player;
    profileNamespace setVariable ["wfar_steamID", wfar_steamID];
} else {
    wfar_steamID = profileNamespace getVariable ["wfar_steamID", ""];
};

private _tmpDisplay = findDisplay 46 createDisplay QGVAR(RscDisplayMaterial);
_tmpDisplay closeDisplay 1;