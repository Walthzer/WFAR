class Extended_Respawn_EventHandlers {
    class CAManBase {
        class GVAR(markDeath) {
            respawn = QUOTE(_this call FUNC(markPlayerDeath));
        };
    };
};

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
