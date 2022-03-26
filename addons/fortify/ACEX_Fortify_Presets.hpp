#define PRESET(type, year, version) WFAR_##type##_##year##version
#define MPRESET(year, version) PRESET(MAIN,year,version)
#define QPRESET(type, year, version) QUOTE(PRESET(type,year,version))
#define QMPRESET(year, version) QPRESET(MAIN,year,version)

#define ADD(classname, buildTime) {classname, buildTime}
#define MADD(classname, buildTime, people) {classname, 10, buildTime, people}

class ACEX_Fortify_Presets {
    class MPRESET(2021,A) {
        displayName = QMPRESET(2021,A);
        objects[] = {
            //Normal Fortify behaviour
            ADD("Land_BagFence_Short_F",5),
            ADD("Land_Plank_01_4m_F",5),
            ADD("Land_BagFence_Long_F",10),
            ADD("Land_BagFence_Round_F",10),
            ADD("Land_Plank_01_8m_F",10),
            ADD("Land_BagBunker_Small_F",20),
            ADD("Land_fort_bagfence_round",20),

            //Multiple People Construction
            MADD("Land_BagBunker_Large_F",60,2),
            MADD("WarfareBCamp",60,2),
            MADD("WarfareBDepot",180,3)
        };
    };
};
