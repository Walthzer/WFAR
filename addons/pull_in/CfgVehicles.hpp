#define ADD_PULL_IN(varDoor) GVAR(enabeld) = 1; \
    GVAR(door) = varDoor

class CfgVehicles {

    class APC_Tracked_02_base_F;
    class rhsusf_m113tank_base: APC_Tracked_02_base_F {
        ADD_PULL_IN("ramp");

    };
    class APC_Tracked_03_base_F;
    class RHS_M2A2_Base: APC_Tracked_03_base_F {
        ADD_PULL_IN("ramp");

    };

    class Wheeled_APC_F;
    class rhsusf_stryker_base: Wheeled_APC_F {
       ADD_PULL_IN("ramp");
    };
};