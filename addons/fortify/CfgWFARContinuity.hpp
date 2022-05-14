class CfgWFARContinuity {
    class saveLists {
        class Fortify {
            debug=1;
            load=QUOTE(FUNC(loadFortify));
            save=QUOTE(FUNC(saveFortify));
        };
    }
};