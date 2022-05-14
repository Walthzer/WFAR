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

// UI grid -> From ACE Zeus 
#define SIZEX ((safeZoneW / safeZoneH) min 1.2)
#define SIZEY (SIZEX / 1.2)
#define W_PART(num) (num * (SIZEX / 40))
#define H_PART(num) (num * (SIZEY / 25))
#define X_PART(num) (W_PART(num) + (safeZoneX + (safeZoneW - SIZEX) / 2))
#define Y_PART(num) (H_PART(num) + (safeZoneY + (safeZoneH - SIZEY) / 2))