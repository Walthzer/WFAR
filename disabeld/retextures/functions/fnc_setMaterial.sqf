#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * apply layers to dynamics display;
 *
 * Arguments:
 * 0: _displayUniqueName <STRING>
 * 1: _material <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
params["_displayUniqueName", "_dynamics"];
TRACE_2("setMaterial",_displayUniqueName,_material);

/*
	Dynamics Material:
	[
		layers:
		[
			[
				data,
				angle,
				position
			]
		]
	]

*/
_material params ["_layers"];

private _display = findDisplay _displayUniqueName;

if !(isClass (_material >> "layers")) exitWith {
    TRACE_1("_material has no layers",_material);
};

[{
	params["_displayUniqueName"];
	!isNull(findDisplay _displayUniqueName);
},{
	params["_displayUniqueName", "_layers"];
	private _display = findDisplay _displayUniqueName;

	{
		private _layer = _x;
		private _idc = _forEachIndex;
		private _ctrl = _display displayCtrl _idc;
		ctrlDelete _ctrl;
		displayUpdate _display;

		_ctrl = _display ctrlCreate ["RscPictureKeepAspect", _idc];

		//Apply texture
		private _prop = getText(_x >> "data");
		if(_prop isEqualTo "") then {continue};
		private _texture = (call compile _prop);
		_ctrl ctrlSetText _texture;

		//Apply rotation
		_prop = getArray(_x >> "angle");
		if(_prop isEqualTo []) then {
			_prop = [0, 0.5, 0.5];
		};
		_ctrl ctrlSetAngle _prop;
		
		//Apply Position
		_prop = getArray(_x >> "position");
		if(_prop isEqualTo []) then {
			_prop = [0,0,1,1];
		};
		_ctrl ctrlSetPosition _prop;

		_ctrl ctrlCommit 0;
		displayUpdate _display;

		[{
			params ["_displayUniqueName", "_ctrl", "_texture"];
			if ((ctrlText _ctrl) != _texture) then {
				systemChat format ["Texutre mismatch: '%1' != '%2'",ctrlText _ctrl, _texture];
				ERROR_2("Texutre mismatch: '%1' != '%2'",ctrlText _ctrl,_texture);

				[{
					params ["_displayUniqueName"];
					displayUpdate (findDisplay _displayUniqueName);
				}, [_displayUniqueName]] call CBA_fnc_execNextFrame;
			}
		}, [_displayUniqueName, _ctrl, _texture]] call CBA_fnc_execNextFrame;

	} forEach _layers;
	displayUpdate _display;
}, [_displayUniqueName,_material]] call CBA_fnc_waitUntilAndExecute;



/*
		//Apply texture
		private _prop = getText(_x >> "data");
		if(_prop isEqualTo "") then {continue};
		private _texture = (call compile _prop);
		_ctrl ctrlSetText _texture;

		//Apply rotation
		_prop = getArray(_x >> "angle");
		if(_prop isEqualTo []) then {
			_prop = [0, 0.5, 0.5];
		};
		_ctrl ctrlSetAngle _prop;
		
		//Apply Position
		_prop = getArray(_x >> "position");
		if(_prop isEqualTo []) then {
			_prop = [0,0,1,1];
		};
		_ctrl ctrlSetPosition _prop;
 */