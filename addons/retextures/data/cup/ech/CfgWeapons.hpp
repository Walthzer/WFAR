#define BASE_TYPE helmet


//-----------parents--------------
class CUP_H_USArmy_ECH_MARPAT;
class CUP_H_USArmy_ECH_ESS_MARPAT;
class CUP_H_USArmy_ECH_Headset_MARPAT;
class CUP_H_USArmy_ECH_ESS_Headset_MARPAT;

class CUP_H_USArmy_ECH_MARPAT_des;
class CUP_H_USArmy_ECH_ESS_MARPAT_des;
class CUP_H_USArmy_ECH_Headset_MARPAT_des;
class CUP_H_USArmy_ECH_ESS_Headset_MARPAT_des;
//---------------------------------

#define GEN_ITEMS(name) \
    GEN_TEX_CLASS(ech,CUP_H_USArmy_ECH_MARPAT,"ECH MARPAT (Woodland)",name); \
    GEN_TEX_CLASS(ech_ess,CUP_H_USArmy_ECH_ESS_MARPAT,"ECH MARPAT (Woodland/Goggles)",name); \
    GEN_TEX_CLASS(ech_headset,CUP_H_USArmy_ECH_Headset_MARPAT,"ECH MARPAT (Woodland/Headset)",name); \
    GEN_TEX_CLASS(ech_ess_headset,CUP_H_USArmy_ECH_ESS_Headset_MARPAT,"ECH MARPAT (Woodland/Headset/Goggles)",name); \


//-----------Woodland--------------
#define TEX_CAMO marpat_wd
//---------------------------------
GEN_ITEMS(shark)
GEN_ITEMS(libby)
GEN_ITEMS(barker)
GEN_ITEMS(medic)
GEN_ITEMS(genius)
#undef GEN_ITEMS
//---------------------------------
#undef TEX_CAMO
//---------------------------------

#define GEN_ITEMS(name) \
    GEN_TEX_CLASS(ech,CUP_H_USArmy_ECH_MARPAT_des,"ECH MARPAT (Desert)",name); \
    GEN_TEX_CLASS(ech_ess,CUP_H_USArmy_ECH_ESS_MARPAT_des,"ECH MARPAT (Desert/Goggles)",name); \
    GEN_TEX_CLASS(ech_headset,CUP_H_USArmy_ECH_Headset_MARPAT_des,"ECH MARPAT (Desert/Headset)",name); \
    GEN_TEX_CLASS(ech_ess_headset,CUP_H_USArmy_ECH_ESS_Headset_MARPAT_des,"ECH MARPAT (Desert/Headset/Goggles)",name); \


//-----------Desert----------------
#define TEX_CAMO marpat_des
//---------------------------------
GEN_ITEMS(shark)
GEN_ITEMS(libby)
GEN_ITEMS(barker)
GEN_ITEMS(medic)
GEN_ITEMS(genius)
#undef GEN_ITEMS
//---------------------------------
#undef TEX_CAMO
//---------------------------------


#undef BASE_TYPE