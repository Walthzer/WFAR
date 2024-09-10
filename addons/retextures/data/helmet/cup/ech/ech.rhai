export const properties = #{
    "hiddenSelectionsTextures[]": [
        "#MATERIAL_SLOT",
        "/CUP/Creatures/People/Military/CUP_Creatures_People_Military_USArmy/data/h_gear_01_cb_co.paa"
    ]
};

export const templates = [
    #{
        camo: "marpat_wd",
        camo_name: "Woodland",
        material_layers: [
            "/CUP/Creatures/People/Military/CUP_Creatures_People_Military_USArmy/ACH/data/ACH_MARPAT_co.paa",
            "#TEXTURE_SLOT"
        ],
        classes: [
            ["","CUP_H_USArmy_ECH_MARPAT","ECH MARPAT (#CAMO)"],
            ["ess","CUP_H_USArmy_ECH_ESS_MARPAT","ECH MARPAT (#CAMO/Goggles)"],
            ["headset","CUP_H_USArmy_ECH_Headset_MARPAT","ECH MARPAT (#CAMO/Headset)"],
            ["ess_headset","CUP_H_USArmy_ECH_ESS_Headset_MARPAT","ECH MARPAT (#CAMO/Headset/Goggles)"]
        ],
    },
    #{
        camo: "marpat_des",
        camo_name: "Desert",
        material_layers: [
            "/CUP/Creatures/People/Military/CUP_Creatures_People_Military_USArmy/ACH/data/ACH_MARPAT_des_co.paa",
            "#TEXTURE_SLOT"
        ]
    }
];