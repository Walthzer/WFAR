class CfgMovesBasic {
    class ManActions {
        GVAR(hold) = QGVAR(hold);

        //GVAR(holdStandLowered) = QGVAR(holdStandLowered);
    };

    class Actions {
        class NoActions: ManActions {
            GVAR(hold)[] = {QGVAR(hold), "Gesture"};

            //GVAR(holdStandLowered)[] = {QGVAR(holdStandLowered), "Gesture"};
        };
    };
};

class CfgGesturesMale {
    class Default;

    class BlendAnims {
        GVAR(LeftArm)[] = {
            "LeftShoulder", 1,
            "LeftArm", 1,
            "LeftArmRoll", 1,
            "LeftForeArm", 1,
            "LeftForeArmRoll", 1,
            "LeftHand", 1,
            "LeftHandIndex1", 1,
            "LeftHandIndex2", 1,
            "LeftHandIndex3", 1,
            "LeftHandMiddle1", 1,
            "LeftHandMiddle2", 1,
            "LeftHandMiddle3", 1,
            "LeftHandPinky1", 1,
            "LeftHandMiddle2", 1,
            "LeftHandMiddle3", 1,
            "LeftHandPinky1", 1,
            "LeftHandPinky2", 1,
            "LeftHandPinky3", 1,
            "LeftHandRing", 1,
            "LeftHandRing1", 1,
            "LeftHandRing2", 1,
            "LeftHandRing3", 1,
            "LeftHandThumb1", 1,
            "LeftHandThumb2", 1,
            "LeftHandThumb3", 1
        };

		GVAR(Arms)[] = {
        //extra
        //"spine", 1,
        //"spine1", 1,
        //"spine2", 1,
        //"spine3", 1,
        //"neck", 1,
		//Left Arm
		"LeftShoulder", 1,
		"LeftArm", 1,
		"LeftArmRoll", 1,
		"LeftForeArm", 1,
		"LeftForeArmRoll", 1,
		"LeftHand", 1,
		"LeftHandIndex1", 1,
		"LeftHandIndex2", 1,
		"LeftHandIndex3", 1,
		"LeftHandMiddle1", 1,
		"LeftHandMiddle2", 1,
		"LeftHandMiddle3", 1,
		"LeftHandPinky1", 1,
		"LeftHandMiddle2", 1,
		"LeftHandMiddle3", 1,
		"LeftHandPinky1", 1,
		"LeftHandPinky2", 1,
		"LeftHandPinky3", 1,
		"LeftHandRing", 1,
		"LeftHandRing1", 1,
		"LeftHandRing2", 1,
		"LeftHandRing3", 1,
		"LeftHandThumb1", 1,
		"LeftHandThumb2", 1,
		"LeftHandThumb3", 1,
		//Right Arm
		"RightShoulder", 1,
		"RightArm", 1,
		"RightArmRoll", 1,
		"RightForeArm", 1,
		"RightForeArmRoll", 1,
		"RightHand", 1,
		"RightHandIndex1", 1,
		"RightHandIndex2", 1,
		"RightHandIndex3", 1,
		"RightHandMiddle1", 1,
		"RightHandMiddle2", 1,
		"RightHandMiddle3", 1,
		"RightHandPinky1", 1,
		"RightHandMiddle2", 1,
		"RightHandMiddle3", 1,
		"RightHandPinky1", 1,
		"RightHandPinky2", 1,
		"RightHandPinky3", 1,
		"RightHandRing", 1,
		"RightHandRing1", 1,
		"RightHandRing2", 1,
		"RightHandRing3", 1,
		"RightHandThumb1", 1,
		"RightHandThumb2", 1,
		"RightHandThumb3", 1,
		//Weapons
		"launcher", 1,
		"weapon", 1,
        "MaskStart"

	};
    };

    class States {
        class GVAR(Base): Default {
            actions = "NoActions";
            canPullTrigger = 0;
            connectAs = "";
            connectFrom[] = {};
            connectTo[] = {};
            disableWeapons = 0;
            enableBinocular = 1;
            enableMissile = 1;
            enableOptics = 0;
            equivalentTo = "";
            file = "\A3\anims_f\Data\anim\Sdr\gst\GestureHi.rtm";
            forceAim = 0;
            headBobMode = 0;
            headBobStrength = 0;
            interpolateFrom[] = {};
            interpolateTo[] = {};
            interpolateWith[] = {};
            interpolationRestart = 0;
            interpolationSpeed = 6;
            looped = 0;
            mask = QGVAR(LeftArm);
            minPlayTime = 0.5;
            preload = 0;
            ragdoll = 0;
            relSpeedMax = 1;
            relSpeedMin = 1;
            showHandGun = 0;
            showItemInHand = 0;
            showItemInRightHand = 0;
            showWeaponAim = 1;
            soundEdge[] = {0.5,1};
            soundEnabled = 1;
            soundOverride = "";
            speed = -2;
            static = 0;
            terminal = 0;
            Walkcycles = 1;
            weaponIK = 1;

            leftHandIKBeg = 1;
            leftHandIKCurve[] = {0, 1, 0.1, 0, 0.8, 0, 1, 1};
            leftHandIKEnd = 1;

            rightHandIKBeg = 1;
            rightHandIKCurve[] = {1};
            rightHandIKEnd = 1;
        };

        class GVAR(hold): GVAR(base) {
            file = QPATHTOF(data\anim\hold.rtm);
            enableMissile = 0;
			disableWeapons = 1; //Prevent player from "Firing" Axe
			mask = QGVAR(Arms); //Change mask to allow anim on both arms and weapon

            weaponIK = 4;

            leftHandIKCurve[] = {1};
            rightHandIKCurve[] = {1};

            looped = 1;
            speed = 1;
        };
    };
};
