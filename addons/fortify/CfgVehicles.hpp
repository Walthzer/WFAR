class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Combo;
            class Edit;
            class Checkbox;
            class ModuleDescription;
        };
        class ModuleDescription;
    };
    class ace_zeus_moduleBase;
    class GVAR(moduleBase): ace_zeus_moduleBase {
        author = "Walthzer";
        category = QGVAR(moduleCategory);
    };
    class GVAR(moduleToggleSupplies): GVAR(moduleBase) {
        curatorCanAttach = 1;
        displayName = "Toggle Supplies";
        curatorInfoType = QGVAR(RscToggleSupplies);
    };
    class GVAR(moduleglobalSupplyRange): GVAR(moduleBase) {
        displayName = "Global Range";
        curatorInfoType = QGVAR(RscGlobalSupplyRange);
    };
    class ACE_Module: Module_F {};
    class acex_fortify_setupModule: ACE_Module {
        class Attributes: AttributesBase {
            class GVAR(globalSupplyRange): Edit {
                displayName = "Global supply range";
                tooltip = "Set the range all suppliers with '0 range' will use.";
                property = QGVAR(globalSupplyRange);
                control = "Edit";
                expression = QUOTE(GVAR(globalSupplyRange) = _value);
                defaultValue = "50";
                unique = 0;
                validate = "number";
                typeName = "NUMBER";
            };
        };
    };
};