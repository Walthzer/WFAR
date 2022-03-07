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
		class Turrets
		{
			class MainTurret: NewTurret {};
		};
		class EventHandlers;
	};

	class Truck_F: Car_F {};
	class Truck_01_base_F: Truck_F {};

	class WFAR_Ikarus_base: Truck_01_base_F
	{
		weapons[]={TruckHorn2};
		side = 0;
		scope = 0;
		//model="\z\wfar\addons\scrapyardwars\ikarus\WFAR_Ikarus.p3d";
		//picture="\Ca\wheeled\data\ico\bus_city_CA.paa";// TODO
		//Icon="\Ca\wheeled\data\map_ico\icomap_bus_CA.paa";// TODO
		mapSize = 11;
		//crew = Citizen1;
		//typicalCargo[]={Profiteer2};

		driverAction = Ikarus_Driver; /// what action is going the driver take inside the vehicle. Non-existent action makes the vehicle inaccessible
		cargoAction[] =
		{
			Truck_Cargo01,Truck_Cargo01,Truck_Cargo01,Truck_Cargo01,
			Truck_Cargo01,Truck_Cargo01,Truck_Cargo01,Truck_Cargo01,
			Truck_Cargo02,Truck_Cargo02,Truck_Cargo02,Truck_Cargo02,
			Truck_Cargo03,Truck_Cargo03,
			Truck_Cargo04,Truck_Cargo04,Truck_Cargo04,Truck_Cargo04,Truck_Cargo04,
			Ikarus_Cargo,Ikarus_Cargo,Ikarus_Cargo,Ikarus_Cargo
		};
		getInAction 		= GetInLow; 		/// how does driver look while getting in
		getOutAction 		= GetOutLow; 		/// and out
		cargoGetInAction[] 	= {"GetInLow"}; 	/// and the same for the rest, if the array has fewer members than the count of crew, the last one is used for the rest
		cargoGetOutAction[] = {"GetOutLow"}; 	/// that means all use the same in this case
		transportSoldier = 23;

/* 		steerAheadSimul=1;
		steerAheadPlan=1.8;
		predictTurnSimul = 1.2;
		predictTurnPlan = 1.5; */
		preferRoads = 1;
		//precision = 10;

		destrType = "DestructBuilding";

		terrainCoef 	= 7; 	/// different surface affects this car more, stick to tarmac
		turnCoef 		= 7; 	/// should match the wheel turn radius
		precision 		= 4; 	/// how much freedom has the AI for its internal waypoints - lower number means more precise but slower approach to way
		brakeDistance 	= 13; 	/// how many internal waypoints should the AI plan braking in advance
		acceleration 	= 4; 	/// how fast acceleration does the AI think the car has

		fireResistance 	= 5; 	/// lesser protection against fire than tanks
		damageResistance = 0.003;
		armor 			= 80; 	/// just some protection against missiles, collisions and explosions
		cost			= 50000; /// how likely is the enemy going to target this vehicle

		/// some values from parent class to show how to set them up
		wheelDamageRadiusCoef 	= 0.9; 			/// for precision tweaking of damaged wheel size
		wheelDestroyRadiusCoef 	= 0.4;			/// for tweaking of rims size to fit ground
		maxFordingDepth 		= 0.5;			/// how high water would damage the engine of the car
		waterResistance 		= 1;			/// if the depth of water is bigger than maxFordingDepth it starts to damage the engine after this time
		crewCrashProtection		= 0.25;			/// multiplier of damage to crew of the vehicle => low number means better protection
		driverLeftHandAnimName 	= "drivewheel"; /// according to what bone in model of car does hand move
		driverRightHandAnimName = "drivewheel";	/// beware, non-existent bones may cause game crashes (even if the bones are hidden during play)

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

		#include "ikarus\Sounds.hpp"
		#include "ikarus\Turrets.hpp"
		#include "ikarus\Physx.hpp"

		selectionBrakeLights = "brzdove svetlo";

		class Reflectors	/// only front lights are considered to be reflectors to save CPU
		{
			class LightCarHeadL01 	/// lights on each side consist of two bulbs with different flares
			{
				color[] 		= {1900, 1800, 1700};		/// approximate colour of standard lights
				ambient[]		= {5, 5, 5};				/// nearly a white one
				position 		= "L svetlo";				/// memory point for start of the light and flare
				direction 		= "konec L svetla";			/// memory point for the light direction
				hitpoint 		= "L svetlo";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)
				selection 		= "L svetlo";				/// selection for artificial glow around the bulb, not much used any more
				size 			= 1;						/// size of the light point seen from distance
				innerAngle 		= 100;						/// angle of full light
				outerAngle 		= 179;						/// angle of some light
				coneFadeCoef 	= 10;						/// attenuation of light between the above angles
				intensity 		= 1;						/// strength of the light
				useFlare 		= true;						/// does the light use flare?
				dayLight 		= false;					/// switching light off during day saves CPU a lot
				flareSize 		= 1.0;						/// how big is the flare

				class Attenuation
				{
					start 			= 1.0;
					constant 		= 0;
					linear 			= 0;
					quadratic 		= 0.25;
					hardLimitStart 	= 30;		/// it is good to have some limit otherwise the light would shine to infinite distance
					hardLimitEnd 	= 60;		/// this allows adding more lights into scene
				};
			};

			class LightCarHeadR01: LightCarHeadL01
			{
				position 		= "P svetlo";		/// memory point for start of the light and flare
				direction 		= "konec R svetla";	/// memory point for the light direction
				hitpoint 		= "P svetlo";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)
				selection 		= "P svetlo";				/// selection for artificial glow around the bulb, not much used any more
			};

			/* class interior_light
			{
				color[] 		= {1000, 1000, 1000};		/// approximate colour of standard lights
				ambient[]		= {4, 4, 4};				/// nearly a white one
				position 		= "interior_light";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir";			/// memory point for the light direction
				hitpoint 		= "interior_light";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)
				selection 		= "interior_light";				/// selection for artificial glow around the bulb, not much used any more
				size 			= 1;						/// size of the light point seen from distance
				innerAngle 		= 180;						/// angle of full light
				outerAngle 		= 179;						/// angle of some light
				coneFadeCoef 	= 0;						/// attenuation of light between the above angles
				intensity 		= 0.5;						/// strength of the light
				useFlare 		= false;						/// does the light use flare?
				dayLight 		= false;					/// switching light off during day saves CPU a lot
				flareSize 		= 0.0;						/// how big is the flare

				class Attenuation
				{
					start 			= 10.0;
					constant 		= 5;
					linear 			= 0;
					quadratic 		= 0.25;
					hardLimitStart 	= 5;		/// it is good to have some limit otherwise the light would shine to infinite distance
					hardLimitEnd 	= 6;		/// this allows adding more lights into scene
				};
			};

			class interior_light0: interior_light
			{
				position 		= "interior_light0";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir0";			/// memory point for the light direction
				hitpoint 		= "interior_light0";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)

			};
			class interior_light1: interior_light
			{
				position 		= "interior_light1";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir1";			/// memory point for the light direction
				hitpoint 		= "interior_light1";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)

			};
			class interior_light2: interior_light
			{
				position 		= "interior_light2";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir2";			/// memory point for the light direction
				hitpoint 		= "interior_light2";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)

			};
			class interior_light3: interior_light
			{
				position 		= "interior_light3";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir3";			/// memory point for the light direction
				hitpoint 		= "interior_light3";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)

			};
			class interior_light4: interior_light
			{
				position 		= "interior_light4";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir4";			/// memory point for the light direction
				hitpoint 		= "interior_light4";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)

			};
			class interior_light5: interior_light
			{
				position 		= "interior_light5";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir5";			/// memory point for the light direction
				hitpoint 		= "interior_light5";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)

			};
			class interior_light6: interior_light
			{
				position 		= "interior_light6";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir6";			/// memory point for the light direction
				hitpoint 		= "interior_light6";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)

			};
			class interior_light7: interior_light
			{
				position 		= "interior_light7";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir7";			/// memory point for the light direction
				hitpoint 		= "interior_light7";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)
			};
			class interior_light8: interior_light
			{
				position 		= "interior_light8";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir8";			/// memory point for the light direction
				hitpoint 		= "interior_light8";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)
			};
			class interior_light9: interior_light
			{
				position 		= "interior_light9";				/// memory point for start of the light and flare
				direction 		= "interior_light_dir9";			/// memory point for the light direction
				hitpoint 		= "interior_light9";				/// point(s) in hitpoint lod for the light (hitPoints are created by engine)
			}; */
		};

		aggregateReflectors[] = {{"LightCarHeadR01"}, {"LightCarHeadL01"}};

 		class PlayerSteeringCoefficients  /// steering sensitivity configuration
		{
			 turnIncreaseConst 	= 1.3; // basic sensitivity value, higher value = faster steering
			 turnIncreaseLinear = 0.35; // higher value means less sensitive steering in higher speed, more sensitive in lower speeds
			 turnIncreaseTime 	= 1.5; // higher value means smoother steering around the center and more sensitive when the actual steering angle gets closer to the max. steering angle

			 turnDecreaseConst 	= 3.5; // basic caster effect value, higher value = the faster the wheels align in the direction of travel
			 turnDecreaseLinear = 2.5; // higher value means faster wheel re-centering in higher speed, slower in lower speeds
			 turnDecreaseTime 	= 0.0; // higher value means stronger caster effect at the max. steering angle and weaker once the wheels are closer to centered position

			 maxTurnHundred 	= 0.7; // coefficient of the maximum turning angle @ 100km/h; limit goes linearly to the default max. turn. angle @ 0km/h
		};

		class AICarSteeringComponent: AICarSteeringComponent
		{
			/* // controls working parameters of steering PID controller (Kp, Ki, Kd)
			steeringPIDWeights[] = { 2.0, 0.25, 0.65 };
			// controls working parameters of speed PID controller (Kp, Ki, Kd)
			speedPIDWeights[] = { 1.0, 0.4, 0.0 };

			// remapping of maxSpeed of vehicle, for fast vehicles we want to lower the used speed
			doRemapSpeed = true;
			remapSpeedRange[] = { 10.0, 50.0 };
			remapSpeedScalar[] = { 1.0, 0.35 };

			// prediction ahead is used for both steering and analysing of shape to modify the speed
			doPredictForward = true;
			predictForwardRange[] = { 1, 20 };
			// steer ahead is a point to steer to, saturated down to given range, in meters
			steerAheadSaturation[] = { 0.06, 0.8 };

			// set method of predicting safe speed
			
			speedPredictionMethod = 2;
			// 0 - three angles method
			// 1 - wheel direction method
			// 2 - combined method
			// three coef's to determine how much given angle should influence slowing down
			wheelAngleCoef = 0.7;
			forwardAngleCoef = 0.7;
			steeringAngleCoef = 1.0;
			differenceAngleCoef = 1.0;

			// for how long we allow to be not moving, before we consider us stuck
			stuckMaxTime = 3.0;
						
			// overtaking is part of collision avoidance
			allowOvertaking = true;
			allowCollisionAvoidance = true;
			// allow using movement vector as direction
			allowDrifting = false;

			// parameters of predictionMethod = 1
			maxWheelAngleDiff = 0.2616;
			minSpeedToKeep = 0.1;

			// how strong AI will turn when commanded left/right
			commandTurnFactor = 1.0; */
		};

		/// memory points where do tracks of the wheel appear
		memoryPointTrackFLL = "stopa PLL";
		memoryPointTrackFLR = "stopa PLP";
		memoryPointTrackBLL = "stopa ZLL";
		memoryPointTrackBLR = "stopa ZLP";
		memoryPointTrackFRL = "stopa PPL";
		memoryPointTrackFRR = "stopa PPP";
		memoryPointTrackBRL = "stopa ZPL";
		memoryPointTrackBRR = "stopa ZPP";

 		//memoryPointTrackFLL = "TrackFLL";
		//memoryPointTrackFLR = "TrackFLR";
		//memoryPointTrackBLL = "TrackBLL";
		//memoryPointTrackBLR = "TrackBLR";
		//memoryPointTrackFRL = "TrackFRL";
		//memoryPointTrackFRR = "TrackFRR";
		//memoryPointTrackBRL = "TrackBRL";
		//memoryPointTrackBRR = "TrackBRR";

		class Damage
		{
			tex[]={};
			mat[]={
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_exterior.rvmat",
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_exterior_damage.rvmat",
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_exterior_destruct.rvmat",

				"z\wfar\addons\scrapyardwars\ikarus\data\bus_interior.rvmat",
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_interior_damage.rvmat",
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_interior_destruct.rvmat",

				"z\wfar\addons\scrapyardwars\ikarus\data\bus_windows.rvmat",
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_windows_damage.rvmat",
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_windows_damage.rvmat",

				"z\wfar\addons\scrapyardwars\ikarus\data\bus_windows_in.rvmat",
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_windows_in_damage.rvmat",
				"z\wfar\addons\scrapyardwars\ikarus\data\bus_windows_in_damage.rvmat"
			};
		};

		memoryPointExhaust = "vyfuk start";
		memoryPointExhaustDir = "vyfuk konec";

		class Exhausts /// specific exhaust effects for the car
		{
			class Exhaust /// the car has two exhausts - each on one side
			{
				position 	= "vyfuk start";  		/// name of initial memory point
				direction 	= "vyfuk konec";	/// name of memory point for exhaust direction
				effect 		= "ExhaustsEffect";	/// what particle effect is it going to use
			};
		};

		hiddenSelections[] =
		{
			"Camo1"
		};
		hiddenSelectionsTextures[] =
		{
			"z\wfar\addons\scrapyardwars\ikarus\data\bus_exterior_co.paa"
		};
		rarityUrban=0.9;
	};


	class WFAR_Ikarus: WFAR_Ikarus_base
	{
		side = 1;
		scope = 2;
		model="\z\wfar\addons\scrapyardwars\ikarus\WFAR_Ikarus.p3d";
		//picture="\Ca\wheeled\data\ico\bus_city_CA.paa";// TODO
		//Icon="\Ca\wheeled\data\map_ico\icomap_bus_CA.paa";// TODO
		//crew = Citizen1;
		//typicalCargo[]={Profiteer2};
		displayName="Ikarus";
		class Library {libTextDesc = "WFAR Public Transport"};

		class HitPoints: HitPoints
		{
			class HitGlass1: HitGlass1 {armor=0.25;}; /// it is pretty easy to puncture the glass but not so easy to remove it
			class HitGlass2: HitGlass2 {armor=0.25;};
			class HitGlass3: HitGlass3 {armor=0.25;};
			class HitGlass4: HitGlass4 {armor=0.25;};
			class HitGlass5: HitGlass5 {armor=0.25;};
			class HitGlass6: HitGlass6 {armor=0.25;};
		};
	};

	class WFAR_Ikarus_Armoured: WFAR_Ikarus_base
	{
		side = 1;
		scope = 2;
		model="\z\wfar\addons\scrapyardwars\ikarus\WFAR_Ikarus_Armoured.p3d";
		//picture="\Ca\wheeled\data\ico\bus_city_CA.paa";// TODO
		//Icon="\Ca\wheeled\data\map_ico\icomap_bus_CA.paa";// TODO
		//crew = Citizen1;
		//typicalCargo[]={Profiteer2};
		displayName="Armoured Bus";
		class Library {libTextDesc = "ISIS Armoured Bus"};

		fireResistance 	= 7; 	/// lesser protection against fire than tanks
		damageResistance = 0.03;
		armor 			= 160; 	/// just some protection against missiles, collisions and explosions 
		cost = 150000; /// how likely is the enemy going to target this vehicle

		class PlateInfos
		{
			// name of section where plate number should generated
			name = "spz";
			// color used for plate number in (r,g,b,a) format
			color[] = {0.00,0.30,0.30,0.6};
			plateFont		= "RobotoCondensed";
			// "#" represent number & "$" represents letter
			plateFormat		= "BATTLE BUS #$";
			// Required even if you don't use any letters in plateFormat
			plateLetters	= "ABCDEFHIKLMOPRSTVXYZ";
		};

		//	Weak spots parameters
		// 	name: selection in HitPoints LOD - create selections first!
		// 	radius: radius of weak spot spheres generated around vertices in HitPoints LOD, tweak before armor
		// 	armor: multiplier of total vehicle armor required to destroy given component, tweak after radius
		// 	explosionShielding: multiplier of damage caused by explosive rounds, tweak after armor
		//	minimalHit: minimum hit required to receive damage, tweak after explosionSielding
		// 	passThrough: how much damage is passed to total vehicle damage
		// 	visual: section in Resource LODs and CfgModels section of model.cfg
		// 	material: unneeded, leave at -1

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
			/*class HitArmourPlate
			{
				simulation = "Default";
				armorComponent = "plateArmour";
				name = "karoserie";
				armor = 1;
				minimalHit = 0.3;
				passThrough = 0;
				visual="";
				explosionShielding = 2;
				radius = 0.5;
			};  */
			class HitBody: HitBody /// all damage to the hull is aFRLied to total damage
			{
				armor = 10;
				minimalHit = 1.5;
				explosionShielding = 5;
			}; 
		};
	};	

	class WFAR_Ikarus_CIV : WFAR_Ikarus
	{
		scope = 2;
		side = 2;

		//faction = BIS_TK_CIV;
		//hiddenSelections[] ={"Camo1"};
		//hiddenSelectionsTextures[] = {"\ca\wheeled_E\ikarus\data\bus_exterior_ECIV_CO"};

		rarityUrban=0.4;

		//crew = TK_CIV_Takistani01_EP1;
		//typicalCargo[]={TK_CIV_Takistani01_EP1};
	};
};