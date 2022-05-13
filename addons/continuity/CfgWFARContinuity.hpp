class CfgWFARContinuity {
    class saveLists {
        class GVARMAIN(vehicles) {
            debug=1;
            load=QUOTE(FUNC(loadVehicles));
            save=QUOTE(FUNC(saveVehicles));
        };
        class GVARMAIN(mines) {
            load=QUOTE(FUNC(loadMines));
        };
        class GVARMAIN(csw) {
            load=QUOTE(FUNC(loadCSW));
        };
    };
};