class CfgWFARContinuity {
    class saveLists {
        class GVARMAIN(vehicles) {
            debug=1;
            load=QUOTE(FUNC(loadVehicles));
            save=QUOTE(FUNC(saveVehicles));
        };
        class GVARMAIN(boxes) {
            debug=1;
            load=QUOTE(FUNC(loadBoxes));
            save=QUOTE(FUNC(saveBoxes));
            class types {
                class Reammobox_F {};
            };
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