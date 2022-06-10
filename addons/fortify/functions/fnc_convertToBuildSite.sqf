#include "script_component.hpp"
/*
 * Author: Walthzer/Shark
 * Convert an object into a multiPerson build site.
 *
 * Arguments:
 * 0: Fortify Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [wall] call wfar_fortify_fnc_convertToBuildSite
 *
 * Public: No
 */
params [["_object", objNull], "_buildTime", "_requiredBuilders"];
TRACE_1("convertToBuildSite",_object);

if (isNull _object) exitWith {};

//set flags
_object setVariable [QGVAR(requiredBuilders), _requiredBuilders, true];
_object setVariable [QGVAR(buildTime), _buildTime, true];

hideObjectGlobal _object;

private _bounding2D = [_object] call FUNC(getObjectBounding2D);
_bounding2D params ["_rectangle", "_sideCenters"];

private _scaffoldingPositionsModel = [_rectangle, _sideCenters] call FUNC(getScaffoldingPositions);

#ifdef DEBUG_ENABLED_FORTIFY
addMissionEventHandler ["draw3D", {
    _thisArgs params ["_object", "_sideCenters", "_scaffoldingPositionsModel"];

    private _colours = [[1,0,0,1], [0,1,0,1], [0,0,1,1], [1,1,0,1]];

    {
        {
            private _colour = _colours select (_forEachIndex mod (count _colours));
            private _modelPosition = (_object modelToWorldVisual _x);

            private _groundPosition = +_modelPosition;
            _groundPosition set [2, getTerrainHeightASL _modelPosition];

            drawLine3D [_modelPosition, ASLtoATL _groundPosition, _colour];
            drawLine3D [_modelPosition, ASLtoATL _groundPosition, _colour];
            drawLine3D [_modelPosition, ASLtoATL _groundPosition, _colour];
            drawIcon3D ["", _colour, _modelPosition, 0, 0, 0, str [_forEachIndex, _x]];
        } forEach _x;

    } forEach _scaffoldingPositionsModel;

}, [_object, _rectangle, _scaffoldingPositionsModel]];
#endif


//if we put scaffolding on the ground, create a decal later
createDecal = false;

//Create scaffold objects and action helpers.
private _objectDirection = getDir _object;
private _grassCutters = [];
private _scaffolding = [];
private _actionHelpers = [];
{
    private _scaffoldDirection = (_objectDirection - (90 * _forEachIndex));
    {
        private _scaffoldPosition = (_object modelToWorldWorld _x);

        private _intersection = [_scaffoldPosition, _object] call FUNC(getSurfaceHeightASL);
        _intersection params ["_surfacePositionASL", "_surfaceNormal", "_intersectObject"];

        //If we put scaffolding on the terrain, create the decal
        createDecal = createDecal || {isNull _intersectObject};

        //Cut grass below scaffolds
        _grassCutters pushBack ([_surfacePositionASL] call FUNC(cutGrass));

        //Create the helpers for ACE actions
        private _actionHelper = createVehicle [ACTION_HELPER, ASLtoATL _surfacePositionASL, [], 0, "CAN_COLLIDE"];
        //_actionHelpers pushBack (createSimpleObject [ACTION_HELPER, _position]);
        _actionHelper setVectorUp _surfaceNormal;

        //rotate helper towards mainObject so actions always show in same order.
        _actionHelper setDir (_scaffoldDirection);
        _actionHelpers pushBack _actionHelper;

        private _sunkenPostion = _surfacePositionASL vectorAdd [0, 0, - SCAFFOLD_GROUNDLEVEL];
        private _scaffold = createVehicle ["Land_MobileScafolding_01_F", ASLtoATL _sunkenPostion , [], 0, "CAN_COLLIDE"];
        _scaffold enableSimulation false;
        //private _scaffold = createSimpleObject ["Land_MobileScafolding_01_F", _sunkenPostion];


        _scaffold setVariable [QGVAR(sunkenPostion), _sunkenPostion];
        _scaffold setDir _scaffoldDirection;
        _scaffold setVectorUp _surfaceNormal;

        _scaffolding pushBack _scaffold;
    } forEach _x;

} forEach _scaffoldingPositionsModel;

private _decal = objNull;
if (createDecal) then {
    private _rectangleASL = _rectangle apply {_object modelToWorldWorld _x};
    private _aSide = (_rectangleASL select 0) distance2D (_rectangleASL select 1);
    private _bSide = (_rectangleASL select 0) distance2D (_rectangleASL select 3);
    private _surfaceArea = ceil (_aSide max _bSide);

    _decal = createSimpleObject ["Land_DirtPatch_05_F", getPosATL _object];
    _decal setObjectScale (0.2 * _surfaceArea);

    //dirtPatch is a 1m*1m square at 0.2 scale, calculate from there.
    _object setVariable [QGVAR(decalScale), (0.2 * _surfaceArea), true];
};


//Store build site objects
//_object setVariable [QGVAR(decal), _decal];
//_object setVariable [QGVAR(grassCutters), _grassCutters];
//_object setVariable [QGVAR(scaffolds), _scaffolding];

//Set the scaffolding if progress exists:
private _progress = _object getVariable [QGVAR(progress), 0];
if (_progress > 0 && {((_progress * GVAR(scaffoldTickModifier)) mod 10) == 0}) then {
    [_object, _scaffolding, _buildTime, _progress] call FUNC(moveScaffolding);
};

//Create buildActions for player with JIP compatibility (don't add actions if object is deleted).
private _buildActionsJIPid = [QGVAR(addBuildActions), [_actionHelpers, _object]] call CBA_fnc_globalEventJIP;

//Add building Handler
private _buildHandler = [{
    params ["_args", "_handle"];
    _args params ["_object", "_buildTime", "_requiredBuilders", "_siteObjects", "_buildActionsJIPid"];
    _siteObjects params ["_scaffolding"];

    private _progress = _object getVariable [QGVAR(progress), 0];
    private _activeBuilders = _object getVariable [QGVAR(builders), []];
    private _isBuilding = _object getVariable [QGVAR(isBuilding), false];

    //Has the fortify object been deleted?
    private _objectExist = !isNull _object;

    //Check Builders for players that have left
    _activeBuildersChecked = [];
    {
        private _isObject = _x isEqualType objNull;
        if (_isObject && {isNull _x}) then {continue};

        _activeBuildersChecked pushBack _x;

    } forEach _activeBuilders;

    if (_activeBuilders isNotEqualTo _activeBuildersChecked) then {
        _object setVariable [QGVAR(builders), _activeBuildersChecked, true];
    };
    _activeBuilders = _activeBuildersChecked;
    private _activeBuildersAmount = count _activeBuilders;

    #ifdef DEBUG_ENABLED_FORTIFY
        GVAR(buildingStats) = [_isBuilding, _activeBuilders, _progress];
        publicVariable QGVAR(buildingStats);
    #endif

    //Cleanup if building is completed or canceled
    if (_progress >= _buildTime || !_objectExist) exitWith {
        
        //Stop adding build actions for JIP players.
        [_buildActionsJIPid] call CBA_fnc_removeGlobalEventJIP;

        if (_objectExist) then {
            _object setVariable [QGVAR(isBuilding), false, true];
            _object hideObjectGlobal false;

            //Clean build site but leave the decal.
            {
                if !(isNull _x) then {deleteVehicle _x};
            } forEach (flatten (_siteObjects select [0, 3]));
        } else {
            //Cleanup building site
            {
                if !(isNull _x) then {deleteVehicle _x};
            } forEach (flatten _siteObjects); 
        };

        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (_activeBuildersAmount >= _requiredBuilders) then {

        if (_isBuilding) then {
            //Is this a scaffold tick? every 5 seconds is a scaffold tick.
            if (((_progress * GVAR(scaffoldTickModifier)) mod 10) == 0) then {
                [_object, _scaffolding, _buildTime, _progress] call FUNC(moveScaffolding);
            };

            //Add progress tick with multiplier for larger quanties of builders.
            private _progressTick = floor (_activeBuildersAmount / _requiredBuilders);
            _object setVariable [QGVAR(progress), _progress + _progressTick, true];

        } else {
            //Start the build process.
            _object setVariable [QGVAR(isBuilding), true, true];
        };

    } else {
       if (_isBuilding) then {
           //Not enough builders, halt the build process.
            _object setVariable [QGVAR(isBuilding), false, true];
       };
    };

}, 1, [_object, _buildTime, _requiredBuilders, [_scaffolding, _grassCutters, _actionHelpers, _decal], _buildActionsJIPid]] call CBA_fnc_addPerFrameHandler;