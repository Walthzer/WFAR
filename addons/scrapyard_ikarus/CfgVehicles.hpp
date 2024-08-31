#define NO_SIDE -1
#define EAST 0
#define WEST 1
#define RESISTANCE 2
#define CIVILIAN 3
#define NEUTRAL 4
#define ENEMY 5
#define FRIENDLY 6
#define LOGIC 7


#define ADDTURRET(baseClass, inc, name, proxy)\
    class baseClass##inc: baseClass##01\
    {\
        gunnerName                 = name;\
        proxyIndex                 = proxy;\
    };\

class CfgVehicles
{

     class LandVehicle;
     class Car: LandVehicle {
          class NewTurret;
     };
     class Car_F: Car
     {
          class AnimationSources {
               class HitGlass1;
          };
          class HitPoints /// we want to use hitpoints predefined for all cars
          {
               class HitLFWheel;
               class HitLF2Wheel;
               class HitRFWheel;
               class HitRF2Wheel;
               class HitBody;
               class HitGlass1;
               class HitGlass2;
               class HitGlass3;
               class HitGlass4;
               class HitGlass5;
               class HitGlass6;
          };
          class Turrets;
          class CargoTurret;
          class EventHandlers;
     };

     class Truck_F: Car_F {};
     class Truck_01_base_F: Truck_F 
     {
          class AICarSteeringComponent;
     };

     class WFAR_Ikarus_base: Truck_01_base_F
     {

          weapons[]={"TruckHorn2"};
          side = -1;
          scope = 0;
          //model="z\wfar\addons\scrapyard_ikarus\ikarus\WFAR_Ikarus.p3d";
          //picture="\Ca\wheeled\data\ico\bus_city_CA.paa";// TODO
          //Icon="\Ca\wheeled\data\map_ico\icomap_bus_CA.paa";// TODO
          mapSize = 11;
          //crew = Citizen1;
          //typicalCargo[]={Profiteer2};

          //ACE configs
          //Ace cookoff
          ace_cookoff_probability = 0.0;

          //ACE vehicle damage
          ace_vehicle_damage_hullDetonationProb = 0.0;
          ace_vehicle_damage_turretDetonationProb = 0.0;
          ace_vehicle_damage_engineDetonationProb = 0.0;
          ace_vehicle_damage_hullFireProb = 0.0;
          ace_vehicle_damage_turretFireProb = 0.0;
          ace_vehicle_damage_engineFireProb = 0.0;
          ace_vehicle_damage_detonationDuringFireProb = 0.0;
          
          hasDriver=1;
          driverAction = "Ikarus_Driver"; /// what action is going the driver take inside the vehicle. Non-existent action makes the vehicle inaccessible
          cargoAction[] =
          {
               "Truck_Cargo01","Truck_Cargo01","Truck_Cargo02","Truck_Cargo02",
               "Truck_Cargo01","Truck_Cargo01","Truck_Cargo01","Truck_Cargo01",
               "Truck_Cargo02","Truck_Cargo02","Truck_Cargo02","Truck_Cargo02",
               "Truck_Cargo03","Truck_Cargo03","Truck_Cargo03","Truck_Cargo03",
               "Truck_Cargo04","Truck_Cargo04","Truck_Cargo04",
               "Ikarus_Cargo","Ikarus_Cargo","Ikarus_Cargo","Ikarus_Cargo"
          };
          getInAction           = "GetInLow";           /// how does driver look while getting in
          getOutAction           = "GetOutLow";           /// and out
          cargoGetInAction[]      = {"GetInLow"};      /// and the same for the rest, if the array has fewer members than the count of crew, the last one is used for the rest
          cargoGetOutAction[] = {"GetOutLow"};      /// that means all use the same in this case
          transportSoldier = 23;

          //steerAheadSimul=1;
          //steerAheadPlan=1.8;
          //predictTurnSimul = 1.2;
          //predictTurnPlan = 1.5;
          preferRoads = 1;
          //precision = 10;

          destrType = "DestructBuilding";

          terrainCoef      = 7;      /// different surface affects this car more, stick to tarmac
          turnCoef           = 7;      /// should match the wheel turn radius
          precision           = 4;      /// how much freedom has the AI for its internal waypoints - lower number means more precise but slower approach to way
          brakeDistance      = 13;      /// how many internal waypoints should the AI plan braking in advance
          acceleration      = 4;      /// how fast acceleration does the AI think the car has

          fireResistance      = 5;      /// lesser protection against fire than tanks
          damageResistance = 0.003;
          armor                = 80;      /// just some protection against missiles, collisions and explosions
          cost               = 50000; /// how likely is the enemy going to target this vehicle

          /// some values from parent class to show how to set them up
          wheelDamageRadiusCoef      = 0.9;                /// for precision tweaking of damaged wheel size
          wheelDestroyRadiusCoef      = 0.4;               /// for tweaking of rims size to fit ground
          maxFordingDepth           = 0.5;               /// how high water would damage the engine of the car
          waterResistance           = 1;               /// if the depth of water is bigger than maxFordingDepth it starts to damage the engine after this time
          crewCrashProtection          = 0.25;               /// multiplier of damage to crew of the vehicle => low number means better protection
          driverLeftHandAnimName      = "drivewheel"; /// according to what bone in model of car does hand move
          driverRightHandAnimName = "drivewheel";     /// beware, non-existent bones may cause game crashes (even if the bones are hidden during play)

          class HitPoints: HitPoints
          {
               /*                
               class HitSLAT_Left_1
               {
                    simulation = "Default";
                    armorComponent = "cage_left_1";
                    name = "cage_left_1_point";
                    armor = -200;
                    minimalHit = 0.3;
                    passThrough = 0;
                    visual = "-";
                    explosionShielding = 2;
                    radius = 0.25;
               }; */

               class HitLFWheel: HitLFWheel /// it is easier to destroy wheels than hull of the vehicle
               {
                    radius=0.3;
                    armor=0.5; 
                    passThrough=0;
               }; 
               class HitLF2Wheel: HitLF2Wheel
               {
                    radius=0.3;
                    armor=0.5; 
                    passThrough=0;
               }; 
               class HitRFWheel: HitRFWheel
               {
                    radius=0.3;
                    armor=0.5; 
                    passThrough=0;
               }; 
               class HitRF2Wheel: HitRF2Wheel
               {
                    radius=0.3;
                    armor=0.5; 
                    passThrough=0;
               }; 

               class HitFuel /// correct points for fuel tank, some of the damage is aFRLied to the whole
               {
                    simulation = "Default";
                    armorComponent = "fuel";
                    name="fuel";
                    material=-1; 
                    armor=0.6; 
                    minimalHit = 0.3;
                    passThrough=0.2; 
                    visual="";
                    explosionShielding = 2;
                    radius = 0.48;
               }; 
               class HitEngine           
               {
                    simulation = "Default";
                    armorComponent = "motor";
                    name="motor";
                    material=-1; 
                    armor=0.6;
                    minimalHit = 0.3;
                    passThrough=0.2;
                    visual="";
                    explosionShielding = 2;
                    radius = 0.48;
               };
               class HitBody /// all damage to the hull is aFRLied to total damage
               {
                    simulation = "Default";
                    armorComponent = "karroserie";
                    name = "karoserie";
                    material=-1; 
                    armor = 1;
                    minimalHit = 0.3;
                    passThrough = 1;
                    visual="camo1";
                    explosionShielding = 2;
               }; 
          };

          hasGunner = 0;
          //#include "ikarus\Sounds.hpp"
          #include "ikarus\Physx.hpp"

          selectionBrakeLights = "brakeLight";

          class Reflectors     /// only front lights are considered to be reflectors to save CPU
          {
               class LightCarHeadL01      /// lights on each side consist of two bulbs with different flares
               {
                    color[]           = {1900, 1800, 1700};          /// approximate colour of standard lights
                    ambient[]          = {5, 5, 5};                    /// nearly a white one
                    position           = "L svetlo";                    /// memory point for start of the light and flare
                    direction           = "konec L svetla";               /// memory point for the light direction
                    hitpoint           = "L svetlo";                    /// point(s) in hitpoint lod for the light (hitPoints are created by engine)
                    selection           = "L svetlo";                    /// selection for artificial glow around the bulb, not much used any more
                    size                = 1;                              /// size of the light point seen from distance
                    innerAngle           = 100;                              /// angle of full light
                    outerAngle           = 179;                              /// angle of some light
                    coneFadeCoef      = 10;                              /// attenuation of light between the above angles
                    intensity           = 1;                              /// strength of the light
                    useFlare           = true;                              /// does the light use flare?
                    dayLight           = false;                         /// switching light off during day saves CPU a lot
                    flareSize           = 1.0;                              /// how big is the flare

                    class Attenuation
                    {
                         start                = 1.0;
                         constant           = 0;
                         linear                = 0;
                         quadratic           = 0.25;
                         hardLimitStart      = 30;          /// it is good to have some limit otherwise the light would shine to infinite distance
                         hardLimitEnd      = 60;          /// this allows adding more lights into scene
                    };
               };

               class LightCarHeadR01: LightCarHeadL01
               {
                    position           = "P svetlo";          /// memory point for start of the light and flare
                    direction           = "konec R svetla";     /// memory point for the light direction
                    hitpoint           = "P svetlo";                    /// point(s) in hitpoint lod for the light (hitPoints are created by engine)
                    selection           = "P svetlo";                    /// selection for artificial glow around the bulb, not much used any more
               };
          };

          aggregateReflectors[] = {{"LightCarHeadR01"}, {"LightCarHeadL01"}};

        class PlayerSteeringCoefficients  /// steering sensitivity configuration
          {
                turnIncreaseConst      = 1.3; // basic sensitivity value, higher value = faster steering
                turnIncreaseLinear = 0.35; // higher value means less sensitive steering in higher speed, more sensitive in lower speeds
                turnIncreaseTime      = 1.5; // higher value means smoother steering around the center and more sensitive when the actual steering angle gets closer to the max. steering angle

                turnDecreaseConst      = 3.5; // basic caster effect value, higher value = the faster the wheels align in the direction of travel
                turnDecreaseLinear = 2.5; // higher value means faster wheel re-centering in higher speed, slower in lower speeds
                turnDecreaseTime      = 0.0; // higher value means stronger caster effect at the max. steering angle and weaker once the wheels are closer to centered position

                maxTurnHundred      = 0.7; // coefficient of the maximum turning angle @ 100km/h; limit goes linearly to the default max. turn. angle @ 0km/h
          };

        //class AICarSteeringComponent: AICarSteeringComponent {};

          /// memory points where do tracks of the wheel appear
          memoryPointTrackFLL = "stopa PLL";
          memoryPointTrackFLR = "stopa PLP";
          memoryPointTrackBLL = "stopa ZLL";
          memoryPointTrackBLR = "stopa ZLP";
          memoryPointTrackFRL = "stopa PPL";
          memoryPointTrackFRR = "stopa PPP";
          memoryPointTrackBRL = "stopa ZPL";
          memoryPointTrackBRR = "stopa ZPP";
          class Damage
          {
               tex[]={};
               mat[]={
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_exterior.rvmat",
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_exterior_damage.rvmat",
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_exterior_destruct.rvmat",

                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_interior.rvmat",
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_interior_damage.rvmat",
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_interior_destruct.rvmat",

                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_windows.rvmat",
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_windows_damage.rvmat",
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_windows_damage.rvmat",

                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_windows_in.rvmat",
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_windows_in_damage.rvmat",
                    "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_windows_in_damage.rvmat"
               };
          };

          memoryPointExhaust = "vyfuk start";
          memoryPointExhaustDir = "vyfuk konec";

          class Exhausts /// specific exhaust effects for the car
          {
               class Exhaust
               {
                    position      = "vyfuk start";            /// name of initial memory point
                    direction      = "vyfuk konec";     /// name of memory point for exhaust direction
                    effect           = "ExhaustsEffect";     /// what particle effect is it going to use
               };
          };

          hiddenSelections[] =
          {
               "Camo1"
          };
          hiddenSelectionsTextures[] =
          {
               "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_exterior_co.paa"
          };
          rarityUrban=0.9;
     };

/*     class WFAR_Ikarus: WFAR_Ikarus_base
    {
        side = 1;
        scope = 2;
        model="z\wfar\addons\scrapyard_ikarus\ikarus\WFAR_Ikarus.p3d";
        displayName="Ikarus";
        class Library {libTextDesc = "WFAR Public Transport";};
          class Turrets {};
        class HitPoints: HitPoints
        {
            class HitGlass1: HitGlass1 {armor=0.25;}; /// it is pretty easy to puncture the glass but not so easy to remove it
            class HitGlass2: HitGlass2 {armor=0.25;};
            class HitGlass3: HitGlass3 {armor=0.25;};
            class HitGlass4: HitGlass4 {armor=0.25;};
            class HitGlass5: HitGlass5 {armor=0.25;};
            class HitGlass6: HitGlass6 {armor=0.25;};
        };
    }; */

    class WFAR_Ikarus_Armoured: WFAR_Ikarus_base {
        side = -1;
        scope = 1;
        model="z\wfar\addons\scrapyard_ikarus\ikarus\WFAR_Ikarus_Armoured.p3d";

        fireResistance      = 8;      /// lesser protection against fire than tanks
        damageResistance = 0.06;
        armor                = 160;      /// just some protection against missiles, collisions and explosions 
        cost = 15000; /// how likely is the enemy going to target this vehicle
          crewCrashProtection = 0.01;
          unloadInCombat = 0; //Prevent AI from getting out in combat

          hiddenSelections[] = {"Camo1", "graffiti_0", "graffiti_1", "graffiti_2", "graffiti_3", "graffiti_4", "graffiti_5", "graffiti_6"};
          hiddenSelectionsTextures[] = 
          {
               "z\wfar\addons\scrapyard_ikarus\ikarus\data\bus_exterior_co.paa",
               "z\wfar\addons\scrapyard_ikarus\data\graffiti.paa",
               "z\wfar\addons\scrapyard_ikarus\data\graffiti.paa",
               "z\wfar\addons\scrapyard_ikarus\data\graffiti.paa",
               "z\wfar\addons\scrapyard_ikarus\data\graffiti.paa",
               "z\wfar\addons\scrapyard_ikarus\data\graffiti.paa",
               "z\wfar\addons\scrapyard_ikarus\data\graffiti.paa",
               "z\wfar\addons\scrapyard_ikarus\data\graffiti.paa"
          };

          class Turrets {};
        class PlateInfos
        {
            // name of section where plate number should generated
            name = "spz";
            // color used for plate number in (r,g,b,a) format
            color[] = {1,1,1,0.8};
            plateFont          = "RobotoCondensed";
            // "#" represent number & "$" represents letter
            plateFormat          = "ALLAH AKBUAR";
            // Required even if you don't use any letters in plateFormat
            plateLetters     = "ABCDEFHIKLMOPRSTVXYZ";
        };

        //     Weak spots parameters
        //      name: selection in HitPoints LOD - create selections first!
        //      radius: radius of weak spot spheres generated around vertices in HitPoints LOD, tweak before armor
        //      armor: multiplier of total vehicle armor required to destroy given component, tweak after radius
        //      explosionShielding: multiplier of damage caused by explosive rounds, tweak after armor
        //     minimalHit: minimum hit required to receive damage, tweak after explosionSielding
        //      passThrough: how much damage is passed to total vehicle damage
        //      visual: section in Resource LODs and CfgModels section of model.cfg
        //      material: unneeded, leave at -1

        // The values are sample. Every vehicle needs to be finetuned separately.
        class HitPoints: HitPoints {
            class HitFuel: HitFuel /// correct points for fuel tank, some of the damage is aFRLied to the whole
            {
                armor=0.6;
                explosionShielding = 5;
            }; 
            class HitEngine: HitEngine           
            {
                armor=0.6;
                explosionShielding = 5;
            };
            //class HitArmourPlate
            //{
                //simulation = "Default";
                //armorComponent = "plateArmour";
                //name = "karoserie";
                //armor = 1;
                //minimalHit = 0.3;
                //passThrough = 0;
                //visual="";
                //explosionShielding = 2;
                //radius = 0.5;
            //};
            class HitBody: HitBody /// all damage to the hull is aFRLied to total damage
            {
                armor = 10;
                minimalHit = 1.5;
                explosionShielding = 5;
            }; 
        };
    };

     class WFAR_Ikarus_Battle: WFAR_Ikarus_Armoured {
          model="z\wfar\addons\scrapyard_ikarus\ikarus\WFAR_Ikarus_Battle.p3d";
          displayName="Battle Bus";
          class Library {libTextDesc = "ISIS TONK";};

          threat[] = {0.7, 0.1, 0.1};

          //ACE configs
          //Ace cookoff
          ace_cookoff_probability = 0.0;

          //ACE vehicle damage
          ace_vehicle_damage_hullDetonationProb = 0.0;
          ace_vehicle_damage_turretDetonationProb = 0.2;
          ace_vehicle_damage_engineDetonationProb = 0.0;
          ace_vehicle_damage_hullFireProb = 0.0;
          ace_vehicle_damage_turretFireProb = 0.2;
          ace_vehicle_damage_engineFireProb = 0.0;
          ace_vehicle_damage_detonationDuringFireProb = 0.0;

          cargoAction[] = {};
          transportSoldier = 0;

          //"passenger_flatground_4_vehicle_passenger_stand_1" -OUT
          //"vehicle_passenger_stand_1_passenger_flatground_4" -IN

          //Kneeling turrets 101 - 106
          //Standing Turrets 201 - 207

          ffvCrewWeighted[] = {};
          class Turrets: Turrets                                        /// just a copilot seat as a turret to enable taking the controls
          {
               class KneelingTurret_01: CargoTurret             /// position for Firing from Vehicles
               {
                    gunnerInAction="passenger_inside_4";
                    gunnerAction="passenger_inside_4";    /// generic animation for sitting inside with rifle ready
                    gunnerCompartments="Compartment1";        /// gunner is not able to switch seats
                    memoryPointsGetInGunner="pos cargo";        /// specific memory points to allow choice of position
                    memoryPointsGetInGunnerDir="pos cargo dir";    /// direction of get in action
                    gunnerName="Right First Gunner";    /// name of the position in the Action menu
                    proxyType="CPGunner";
                    proxyIndex= 101;                    /// what cargo proxy is used according to index in the model
                    maxElev=30;                    /// what is the highest possible elevation of the turret
                    minElev=-20;                    /// what is the lowest possible elevation of the turret
                    maxTurn=25;                    /// what is the left-most possible turn of the turret
                    minTurn=-25;                    /// what is the right-most possible turn of the turret
                    isPersonTurret=2;                    /// enables firing from vehicle functionality
                    ejectDeadGunner=0;                    /// seatbelts included
                    enableyAnimationSource= "";                /// doesn't work unless the said animation source is 1

                    //allowLauncherIn=1;  //Launchers work, but rockets WILL collide with fire geometry!!
                    //allowLauncherOut=1;

                    LODTurnedIn= 1;
                    LODTurnedOut= 1;
                    LODOpticsIn= 1;
                    LODOpticsOut= 1;
               };
               ADDTURRET(KneelingTurret_,02,"Right Second Gunner",102)
               ADDTURRET(KneelingTurret_,03,"Right Third Gunner",103)
               ADDTURRET(KneelingTurret_,04,"Right Fourth Gunner",104)
               ADDTURRET(KneelingTurret_,05,"Right Fifth Gunner",105)
               ADDTURRET(KneelingTurret_,06,"Right Fifth Gunner",106)

               class RearStandingTurret_01: KneelingTurret_01
               {
                    gunnerInAction="passenger_flatground_4_vehicle_passenger_stand_1";
                    gunnerAction="passenger_flatground_4_vehicle_passenger_stand_1";
                    gunnerName="Rear Gunner";
                    proxyIndex= 201;
                    maxElev= 30;
                    minElev= -25;
                    maxTurn= 18;
                    minTurn= -18;
               };
               class StandingTurret_01: KneelingTurret_01
               {
                    gunnerInAction="passenger_flatground_4_vehicle_passenger_stand_1";
                    gunnerAction="passenger_flatground_4_vehicle_passenger_stand_1";
                    gunnerName="Left First Gunner";
                    proxyIndex=207;
                    maxElev=30;
                    minElev=-25;
                    maxTurn=25;
                    minTurn=-25;
               };
               ADDTURRET(StandingTurret_,02,"Left Second Gunner",206)
               ADDTURRET(StandingTurret_,03,"Left Third Gunner",205)
               ADDTURRET(StandingTurret_,04,"Left Fourth Gunner",204)
               ADDTURRET(StandingTurret_,05,"Left Fifth Gunner",203)
               ADDTURRET(StandingTurret_,06,"Left Sixth Gunner",202)
          };

          class PlateInfos
          {
               // name of section where plate number should generated
               name = "spz";
               // color used for plate number in (r,g,b,a) format
               color[] = {1,1,10.8};
               plateFont          = "RobotoCondensed";
               // "#" represent number & "$" represents letter
               plateFormat          = "BATTLE BUS #$";
               // Required even if you don't use any letters in plateFormat
               plateLetters     = "ABCDEFHIKLMOPRSTVXYZ";
          };
    };

     class WFAR_Ikarus_Armoured_OPFOR: WFAR_Ikarus_Armoured
     {
          scope=2;
          scopeCurator=2;
          crew = "cfp_o_is_crewman";//

          side = QUOTE(EAST);
          faction="WFAR_OPFOR";
          editorSubcategory="EdSubcat_APCs";

          displayName="Armoured Bus";
        class Library {libTextDesc = "Islamic State APC";};

     };

     class WFAR_Ikarus_Battle_OPFOR: WFAR_Ikarus_Battle
     {
          scope=2;
          scopeCurator=2;
          crew = "cfp_o_is_crewman";
          ffvCrewWeighted[] = {"cfp_o_is_machinegunner", 0.75, "cfp_o_is_grenadier", 0.15};

          side = QUOTE(EAST);
          faction="WFAR_OPFOR";
          editorSubcategory="EdSubcat_APCs";

          displayName="Battle Bus";
        class Library {libTextDesc = "By Allah's Grace, YOU will see his muzzles flash.";};

     };
};