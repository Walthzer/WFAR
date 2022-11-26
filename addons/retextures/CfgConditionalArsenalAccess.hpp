class cfgConditionalArsenalAcces
{
    class IDX_VIRT_HEADGEAR
    {
        class medic
        {
            condition = QUOTE( [player] call ace_medical_treatment_fnc_isMedic );  
            items[]={
                #define FINAL
                #include "data\rhsusf\mich_covered\medic\weapons.hpp"
                #undef FINAL
            };
        };
        class engineer
        {
            condition = QUOTE( [player] call ace_common_fnc_isEngineer ); 
            items[]={
                #define FINAL
                #include "data\rhsusf\mich_covered\engineer\weapons.hpp"
                #undef FINAL
            };
        };
    };
};