[
    QGVAR(pullDuration),
    "SLIDER",
    ["Pull Duration: ","How long does it take to pull someone in? (Seconds)"],
    ["WFAR", "Pull In"],
    [1, 30, 7.5, 2, false],
    0
] call CBA_fnc_addSetting;

[
    QGVAR(reach),
    "SLIDER",
    ["Reach: ","How far away can we reach to pull someone in? (Meters)"],
    ["WFAR", "Pull In"],
    [0, 20, 5, 2, false],
    0
] call CBA_fnc_addSetting;

[
    QGVAR(AddActionsDistance),
    "SLIDER",
    ["Action Add Radius: ","Radius for adding Pull Actions to units. (Meters)"],
    ["WFAR", "Pull In"],
    [0, 50, 10, 2, false],
    2
] call CBA_fnc_addSetting;
