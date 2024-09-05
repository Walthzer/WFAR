#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Correctly destroys a UITexture
 *
 * Arguments:
 * 0: UI Texture Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params ["_display"];
TRACE_1("onUnLoadUITexture",_display);

systemChat "UnLoad";
