class CfgWFARContinuity {
    class saveLists {
        class GVARMAIN(boxloader) {
            debug=1;
            load=QUOTE(FUNC(loadBoxloader));
            save=QUOTE(FUNC(saveBoxloader));
            class types {
                class Land_Boxloader_Fort_Base {};
                class boxloader_tool_cart {};
            };
        };
        class GVARMAIN(boxes) {
            class types {
                class Boxloader_Pallet_base_ed {};
                class Boxloader_Pallet_base {};
                class Boxloader_BigPallet_Repair {};
            };
        };
    };
};