#define COMPONENT continuity
#define COMPONENT_BEAUTIFIED Continuity
#include "\z\wfar\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\definecommongrids.inc"
#include "\a3\ui_f\hpp\defineresincl.inc"

// #define DEBUG_ENABLED_CONTINUITY
// #define DISABLE_COMPILE_CACHE
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
#define IDC_BTN_CONFIGURE 25030

#define POS_X(N) QUOTE(((N) * GUI_GRID_W + GUI_GRID_CENTER_X))
#define POS_Y(N) QUOTE(((N) * GUI_GRID_H + GUI_GRID_CENTER_Y))
#define POS_W(N) QUOTE(((N) * GUI_GRID_W))
#define POS_H(N) QUOTE(((N) * GUI_GRID_H))

#define POS_X_LOW(N) QUOTE(((N) * GUI_GRID_W + GUI_GRID_X))
#define POS_Y_LOW(N) QUOTE(((N) * GUI_GRID_H + GUI_GRID_Y))

#define REGEX_STRING "{[^}]*}"