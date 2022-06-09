class CfgWFARContinuity {
    class saveLists {
        class GVARMAIN(fortify) {
            debug=1;
            load=QUOTE(FUNC(loadFortify));
            save=QUOTE(FUNC(saveFortify));
        };
    }
};