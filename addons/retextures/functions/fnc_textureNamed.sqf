#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Generate equipment texture with unit name
 *
 * Arguments:
 * 0: _unit <OBJECT>
 *
 * Return Value:
 * Texture <STRING>
 *
 * Public: No
*/
params["_unit"];
TRACE_1("textureNamed",_unit);

/*
	CPL M. Ricker => M.RICKER
	Gonzalez Aminoa -> AMINOA
*/
private _name = "";
private _nameArray = ((name _unit) splitString ' ');
if(_nameArray isEqualTo []) then {
	_name = "E.NULL";
} else {
	_name = toUpper ((_nameArray select [1 min (count _nameArray)]) joinString "");
};

format ["#(rgb,512,512,3)text(0,1,""PuristaBold"",0.35,""#00000000"",""#000000"",""%1"")", _name]