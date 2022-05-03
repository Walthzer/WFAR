class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_InitPost_EventHandlers {
    class WFAR_Ikarus_Armoured {
        class WFAR_IkarusAddCrew {
            init = QUOTE(_this call FUNC(ikarusAddCrew));
            //init="diag_log 'FIREEEERED'";
        };
    };
};