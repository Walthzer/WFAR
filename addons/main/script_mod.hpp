// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX z
#define PREFIX wfar

#include "script_version.hpp"

#define VERSION     MAJOR.MINOR
#define VERSION_STR MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define WFAR_TAG WFAR

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.56

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(wfar - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(wfar - COMPONENT)
#endif
