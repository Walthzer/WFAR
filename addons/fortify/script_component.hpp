#define COMPONENT fortify
#define COMPONENT_BEAUTIFIED Blank
#include "\z\wfar\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_FORTIFY

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_FORTIFY
    #define DEBUG_MODE_FULL
    #define ACTION_HELPER "Sign_Arrow_Direction_Blue_F"
#else
    #define ACTION_HELPER "Helper_base_F"
#endif

#ifdef DEBUG_SETTINGS_FORTIFY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_FORTIFY
#endif

#include "\z\wfar\addons\main\script_macros.hpp"

#define ACTION_DISTANCE 3

#define SCAFFOLD_LENGHT 3.64
#define SCAFFOLD_GROUNDLEVEL 1.6