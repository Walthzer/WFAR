#ifdef BASE_NAME
    #undef BASE_NAME
#endif
#define BASE_NAME ech

class GVAR(BASE_NAME) {
    weapons[]={
        #define FINAL
        #include "weapons.hpp"
        #undef FINAL
    };
    class shark: UItexture {
        displayName = "UV Grid";
        layer2 = TEXTURE(shark);
    };
    class libby: UItexture {
        displayName = "Libby";
        layer2 = TEXTURE(libby);
    };
    class medic: UItexture {
        displayName = "Medical";
        layer2 = TEXTURE(medic);
    };
};