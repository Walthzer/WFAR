class CfgWFARContinuity {
    class saveLists {
        class GVARMAIN(boxLoader) {
            debug=1;
            load=QUOTE(FUNC(loadBoxloader));
            save=QUOTE(FUNC(saveBoxloader));
        };
    };
};