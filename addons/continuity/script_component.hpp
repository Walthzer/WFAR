#define COMPONENT continuity
#define COMPONENT_BEAUTIFIED Continuity
#include "\z\wfar\addons\main\script_mod.hpp"

#define DEBUG_ENABLED_CONTINUITY
#define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CONTINUITY
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CONTINUITY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CONTINUITY
#endif

#include "\z\wfar\addons\main\script_macros.hpp"

#define DUMMY_POSITION [-1000, -1000, 0]