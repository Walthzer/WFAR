[
    QGVAR(autoSaveInterval),
    "SLIDER",
    ["Saving Interval: ","Interval in minutes between Continuity AutoSaves, set to 0 to disable."],
    "WFAR Continuity",
    [0, 60, 0, 0, false],
    2
] call CBA_fnc_addSetting;