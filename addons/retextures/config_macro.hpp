#define TEX_DATA(x,y) rgb,##x##,##y##,3
#define TEX_PREFIX DOUBLES(ADDON_NAME,BASE_TYPE)
#define TEX_UI(camo) GVAR(TRIPLES(ui,TEX_PREFIX,camo))
#define TEX_PARAMETER(class,name,texType) QUOTE(class)##,##QUOTE(name)##,##QUOTE(texType)

#define GEN_TEX_CLASSNAME(names,player) GVAR(TRIPLES(TEX_PREFIX,names,DOUBLES(player,TEX_CAMO)))
#define GEN_TEX_CLASS(names,parent,description,player) \
class GEN_TEX_CLASSNAME(names,player): parent { \
    author="Walthzer/Shark"; \
    dlc=""; \
    displayName=description; \
    picture = QUOTE(z\wfar\addons\insignia\scripted\dev_team.paa); \
    hiddenSelectionsTextures[]= \
    { \
        QUOTE(#(TEX_DATA(2048,2048))ui(TEX_PARAMETER(QUOTE(TEX_UI(DOUBLES(player,TEX_CAMO))),"wfar_unique","ca"))), \
        "\CUP\Creatures\People\Military\CUP_Creatures_People_Military_USArmy\data\h_gear_01_cb_co.paa" \
    }; \
} \



#define GEN_TEX_UI(camo,primary) \
class TEX_UI(DOUBLES(primary,camo)): GVAR(ui) { \
    class ControlsBackground: ControlsBackground \
	{ \
        class base: base \
        { \
            text=BASE_PAA; \
        }; \
        class layer1: base \
        { \
            idc = IDCSquareLayer1; \
            text = QPATHTOF(data\##ADDON_NAME##\##FOLDER##\##primary); \
        }; \
    }; \
} \
