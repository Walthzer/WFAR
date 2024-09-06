#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Find positions to place scaffolding on the sides of the rectangle.
 *
 * Arguments:
 * 0: boundingRectangle <ARRAY>
 *
 * Return Value:
 * 0: Array of coordinates in modelSpace <ARRAY>
 *
 * Example:
 * [_boundingRectangle] call wfar_fortify_fnc_getScaffoldingPositions
 *
 * Public: No
 */
params ["_rectangle", "_sideCenters"];
TRACE_2("getScaffoldingPositions",_rectangle,_sideCenters);

private _positions = [];
{
    private _sideCenter = _x;
    private _xySelect = _forEachIndex mod 2;
    private _distance = _sideCenter distance2D (_rectangle select _forEachIndex);

    //This whole side doesn't fit a single scaffold, skip this side.
    if (((_distance * 2) / SCAFFOLD_LENGHT) == 0) then {_positions set [_forEachIndex, []]; continue};

    //Check how much scaffolding fit on half this side.
    private _amountOfScaffolds = floor (_distance / SCAFFOLD_LENGHT);
    if (_amountOfScaffolds > 0) then {
        //half a side fits atleast one scaffold, find positions and mirror them to process this side.

        private _halfPositions = [];
        private _mirrorHalfPositions = [];

        private _previousPosition = _sideCenter;
        private _previousMirrorPosition = _sideCenter;
        for "_j" from 1 to _amountOfScaffolds do {

            //_previousPosition params ["_xPos", "_yPos"];
            private _currentPosition = +_previousPosition;
            private _currentMirrorPosition = +_previousMirrorPosition;

            private _offset = [SCAFFOLD_LENGHT, SCAFFOLD_LENGHT / 2] select (_previousPosition isEqualTo _sideCenter);

            _currentPosition set [_xySelect, (_currentPosition select _xySelect) - _offset];
            _currentMirrorPosition set [_xySelect, (_currentMirrorPosition select _xySelect) + _offset];

            //_previousPosition vectorAdd [(_xPos + _offset) * , (_xPos + _offset)];

            _halfPositions pushBack _currentPosition;
            _mirrorHalfPositions pushBack _currentMirrorPosition;

            _previousPosition = _currentPosition;
            _previousMirrorPosition = _currentMirrorPosition;
        };
        //Positions are from center to corner, reverse them into corner to center order.
        reverse _halfPositions;

        _halfPositions append _mirrorHalfPositions;
        _positions pushBack _halfPositions;

    } else {
        //Whole side only fits one scaffold, use side center for position.
        
        _positions pushBack [_sideCenter];
    };

} forEach _sideCenters;

_positions