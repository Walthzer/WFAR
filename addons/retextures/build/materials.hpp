class wfar_retextures {
    slots = 400;
    class helmet {
        class cup {
            class ech {
                class bases {
                    class marpat_wd {
                        condition = QUOTE(true);
                        displayName = QUOTE(MARPAT Woodland);
                        class layers {
                            class 0 {
                                data = QQUOTE("\CUP\Creatures\People\Military\CUP_Creatures_People_Military_USArmy\ACH\data\ACH_MARPAT_co.paa");
                            };
                        };
                    };
                    class marpat_d {
                        condition = QUOTE(true);
                        displayName = QUOTE(MARPAT Desert);
                        class layers {
                            class 0 {
                                data = QQUOTE("\CUP\Creatures\People\Military\CUP_Creatures_People_Military_USArmy\ACH\data\ACH_MARPAT_des_co.paa");
                            };
                        };
                    };
                };
                class materials {
                    class uvmap {
                        displayName = QUOTE(UVmap);
                        steamIDList[] = {"76561198053950415"};
                        class layers {
                            class 1 {
                                data = QQUOTE("\z\wfar\addons\retextures\data\helmet\cup\ech\shark.paa");
                            };
                        };
                    };
                    class barker {
                        displayName = QUOTE(Barker);
                        steamIDList[] = {"76561198158672135","76561198053950415"};
                        class layers {
                            class 1 {
                                data = QQUOTE("\z\wfar\addons\retextures\data\helmet\cup\ech\barker.paa");
                            };
                        };
                    };
                    class libby {
                        displayName = QUOTE(Libby);
                        steamIDList[] = {"76561198453933280","76561198053950415"};
                        class layers {
                            class 1 {
                                data = QQUOTE("\z\wfar\addons\retextures\data\helmet\cup\ech\libby.paa");
                            };
                        };
                    };
                    class medic {
                        condition = QUOTE([ARR_2(_thisUnit,1)] call ace_medical_treatment_fnc_isMedic);
                        displayName = QUOTE(Medic);
                        class layers {
                            class 1 {
                                data = QQUOTE("\z\wfar\addons\retextures\data\helmet\cup\ech\medic.paa");
                            };
                        };
                    };
                    class named {
                        condition = QUOTE(true);
                        displayName = QUOTE(Named);
                        class layers {
                            class 1 {
                                angle[] = {180,0.5,0.5};
                                data = QUOTE([_thisUnit] call FUNC(textureNamed));
                                position[] = {0.025,0.31};
                            };
                        };
                    };
                    class genius {
                        condition = QUOTE(true);
                        displayName = QUOTE(Genius);
                        class layers {
                            class 1 {
                                data = QQUOTE("\z\wfar\addons\retextures\data\helmet\cup\ech\genius.paa");
                            };
                        };
                    };
                };
            };
        };
    };
};
