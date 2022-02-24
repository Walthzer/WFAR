#include "\z\ace\addons\main\script_macros.hpp"

#define WFAR_WARNING ([1, 1, 0, 1])
#define WFAR_ERROR ([1, 0, 0, 1])

#define WFAR_MACRO_NOTIFY(arg) [arg, true] call CBA_fnc_notify
#define WFAR_CSNOTIFY_1(colour, size, one) WFAR_MACRO_NOTIFY([ARR_3(one, size, colour)])
#define WFAR_CSNOTIFY_2(colour, size, one, two) WFAR_MACRO_NOTIFY(ARR_2([ARR_3(one, size, colour)], [ARR_3(two, size, colour)]))
#define WFAR_CSNOTIFY_3(colour, size, one, three) WFAR_MACRO_NOTIFY(ARR_3([ARR_3(one, size, colour)], [ARR_3(two, size, colour)], [ARR_3(three, size, colour)]))

#define WFAR_NOTIFY_1(colour, one) WFAR_CSNOTIFY_1(colour, 1, one)
#define WFAR_NOTIFY_2(colour, one, two) WFAR_CSNOTIFY_2(colour, 1, one, two)
#define WFAR_NOTIFY_3(colour, one, two, three) WFAR_CSNOTIFY_3(colour, 1, one, two, three)