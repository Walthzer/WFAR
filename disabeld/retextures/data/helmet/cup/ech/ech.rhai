export const properties = #{
    "hiddenSelectionsTextures[]": [
        "#MATERIAL_SLOT",
        `"\\CUP\\Creatures\\People\\Military\\CUP_Creatures_People_Military_USArmy\\data\\h_gear_01_cb_co.paa"`
    ]
};

export const classes = [
    #{
        displayName: "ECH",
        parent: "CUP_H_USArmy_ECH_MARPAT",
        suffix: ""
    },
    #{
        displayName: "ECH (Goggles)",
        parent: "CUP_H_USArmy_ECH_ESS_MARPAT",
        suffix: "ess"
    },
    #{
        displayName: "ECH (Headset)",
        parent: "CUP_H_USArmy_ECH_Headset_MARPAT",
        suffix: "headset"
    },
    #{
        displayName: "ECH (Headset/Goggles)",
        parent: "CUP_H_USArmy_ECH_ESS_Headset_MARPAT",
        suffix: "ess_headset"
    }
];

export const bases = [
    #{
        class: "marpat_wd",
        displayName: "MARPAT Woodland",
        condition: "true",
        layers: #{
            "0": #{
                data:  "\\CUP\\Creatures\\People\\Military\\CUP_Creatures_People_Military_USArmy\\ACH\\data\\ACH_MARPAT_co.paa"
            }
        }
    },
    #{
        class: "marpat_d",
        displayName: "MARPAT Desert",
        condition: "true",
        layers: #{
            "0": #{
                data: "\\CUP\\Creatures\\People\\Military\\CUP_Creatures_People_Military_USArmy\\ACH\\data\\ACH_MARPAT_des_co.paa"
            }
        }
    }
];

export const materials = [
    #{
        class: "uvmap",
        displayName: "UVmap",
        "steamIDList[]": [`"76561198053950415"`],
        layers: #{
            "1": #{
                "data": "shark.paa"
            }
        }
    },
    #{
        class: "barker",
        displayName: "Barker",
        "steamIDList[]": [`"76561198158672135"`, `"76561198053950415"`],
        layers: #{
            "1": #{
                "data": "barker.paa"
            }
        }
    },
    #{
        class: "libby",
        displayName: "Libby",
        "steamIDList[]": [`"76561198453933280"`, `"76561198053950415"`],
        layers: #{
            "1": #{
                "data": "libby.paa"
            }
        }
    },
    #{
        class: "medic",
        displayName: "Medic",
        condition: "[ARR_2(_thisUnit,1)] call ace_medical_treatment_fnc_isMedic",
        layers: #{
            "1": #{
                "data": "medic.paa"
            }
        }
    },
    #{
        class: "named",
        displayName: "Named",
        condition: "true",
        layers: #{
            "1": #{
                "data": `[_thisUnit] call FUNC(textureNamed)`,
                "angle[]": [180, 0.5, 0.5],
                "position[]": [0.025,0.31]
            }
        }
    },
    #{
        class: "genius",
        displayName: "Genius",
        condition: "true",
        layers: #{
            "1": #{
                "data": "genius.paa"
            }
        }
    }
];