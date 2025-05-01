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

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_SlotItemChanged_EventHandlers {
    class CAManBase {
        class GVAR(SlotItemChanged) {
            slotitemchanged = QUOTE(_this call FUNC(handleEquipment));
        };
    };
};