class CfgWFARContinuity {
    class saveLists {
        class GVARMAIN(vehicles) {
            debug=1;
            load=QUOTE(FUNC(loadVehicles));
            save=QUOTE(FUNC(saveVehicles));
        };
        class GVARMAIN(mines) {
            debug=1;
            load=QUOTE(FUNC(loadMines));
            save=QUOTE(FUNC(saveMines));
        };
        class GVARMAIN(csw) {
            debug=1;
            load=QUOTE(FUNC(loadCSW));
            save=QUOTE(FUNC(saveCSW));
        };
    };
};