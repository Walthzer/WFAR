#define COMPONENT misc
#define COMPONENT_BEAUTIFIED Misc
#include "\z\wfar\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MISC
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MISC
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MISC
#endif

#include "\z\wfar\addons\main\script_macros.hpp"

#define NO_SIDE -1
#define EAST 0			// (Russian)
#define WEST 1			// (NATO)
#define INDEPENDENT 2	// Guerilla 
#define CIVILIAN 3
#define NEUTRAL 4
#define ENEMY 5
#define FRIENDLY 6
#define LOGIC 7