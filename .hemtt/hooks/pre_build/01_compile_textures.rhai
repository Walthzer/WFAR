// Compile material definitions from wfar\retextures\data

//don't rely on C preprocessor

// - compile materials.hpp
//      - Material name from folder structure
//          -- wfar_retextures_material - texture.paa - group - addon - family - camo.rhai
//          => wfar_retextures_material_shark_cup_ech_marpat_wd
//      - Base texture from inheritance
//          -- C++ inheritance-ish 
//      - Overlay texture from paa


// - compile CfgWeapons.hpp
//      - Classname from folder structure
//          -- wfar_retextures - group - texture - addon - family - components - camo.rhai
//          => wfar_retextures_helmet_shark_cup_ech_ * ess_headset * _marpat_wd
//      - Class properties from object maps poly_fill inheritance
//          -- C++ inheritance-ish 
//      