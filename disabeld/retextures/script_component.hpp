#define COMPONENT retextures
#define COMPONENT_BEAUTIFIED Retextures
#include "\z\wfar\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CORE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CORE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CORE
#endif

#define QQUOTE(var) QUOTE(QUOTE(var))

#include "\z\wfar\addons\main\script_macros.hpp"
#include "\z\ace\addons\arsenal\defines.hpp"