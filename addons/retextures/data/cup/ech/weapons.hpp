#define BASE_TYPE helmet

//---------------------------------

#define GEN_CLASSNAMES(name) \
    QUOTE(GEN_TEX_CLASSNAME(ech,name)), \
    QUOTE(GEN_TEX_CLASSNAME(ech_ess,name)), \
    QUOTE(GEN_TEX_CLASSNAME(ech_headset,name)), \
    QUOTE(GEN_TEX_CLASSNAME(ech_ess_headset,name)) \


//-----------Woodland--------------
#define TEX_CAMO marpat_wd
//---------------------------------
GEN_CLASSNAMES(shark),
GEN_CLASSNAMES(libby),
GEN_CLASSNAMES(barker),
GEN_CLASSNAMES(medic),
GEN_CLASSNAMES(genius),
//---------------------------------
#undef TEX_CAMO
//---------------------------------


//-----------Desert----------------
#define TEX_CAMO marpat_des
//---------------------------------
GEN_CLASSNAMES(shark),
GEN_CLASSNAMES(libby),
GEN_CLASSNAMES(barker),
GEN_CLASSNAMES(medic),
GEN_CLASSNAMES(genius)
//---------------------------------
#undef TEX_CAMO
//---------------------------------

#undef GEN_CLASSNAMES
#undef BASE_TYPE