#define PRESET(type, year, version) WFAR_##type##_##year##version
#define MPRESET(year, version) PRESET(MAIN,year,version)
#define QPRESET(type, year, version) QUOTE(PRESET(type,year,version))
#define QMPRESET(year, version) QPRESET(MAIN,year,version)

#define ADDClASS(classname, buildTime) {classname, buildTime}
#define MADDCLASS(classname, buildTime, people) {classname, 10, "Multi", buildTime, people}

class ACEX_Fortify_Presets {
    class MPRESET(2024,A) {
        displayName = QMPRESET(2024,A);
        objects[] = {
            //Normal Fortify behaviour
            ADDClASS("Land_BagFence_Short_F",5),
            ADDClASS("Land_Plank_01_4m_F",5),
            ADDClASS("Land_BagFence_Long_F",10),
            ADDClASS("Land_BagFence_Round_F",10),
            ADDClASS("Land_Plank_01_8m_F",10),
            ADDClASS("Land_BagBunker_Small_F",20),
            ADDClASS("Land_fort_bagfence_round",20),

            //Multiple People Construction
            MADDCLASS("Land_BagBunker_Large_F",60,2),
            MADDCLASS("WarfareBCamp",60,2),
            MADDCLASS("WarfareBDepot",180,3)
        };
    };
};
