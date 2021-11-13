#define true 1
#define false 0

#define VSoft 0
#define VArmor 1
#define VAir 2

// type scope
#define private 0
#define protected 1
#define public 2

#define CanSeeRadar 1
#define CanSeeEye 2
#define CanSeeOptics 4
#define CanSeeEar 8
#define CanSeeCompass 16
#define CanSeeRadarC CanSeeRadar+CanSeeCompass
#define CanSeeAll 31
#define CanSeePeripheral 32

//lock acquiring
#define manualLA      0
#define automaticLA   1

//lockable target type
#define lockGroundTT      0
#define lockAirGroundTT   1
#define lockAirTT         2
#define lockGround      0
#define lockAirGround   1
#define lockAir         2

//missile lock type
#define fireAndForgetLT   0
#define keepLockedLT      1
#define manualLT          2

#define SPEED_STATIC 1e10

#define LockNo		0
#define LockCadet	1
#define LockYes		2

//enum {StabilizedInAxesNone,StabilizedInAxisX,StabilizedInAxisY,StabilizedInAxesBoth,StabilizedInAxesXYZ};

#define StabilizedInAxesNone 0
#define StabilizedInAxisX 1
#define StabilizedInAxisY 2
#define StabilizedInAxesBoth 3
#define StabilizedInAxesXYZ 4

#define CM_none        0
#define CM_Lock_Visual 1
#define CM_Lock_IR     2
#define CM_Lock_Laser  4
#define CM_Lock_Radar  8
#define CM_Missile     16


#define CMImmunity_GOOD 0.9
#define CMImmunity_MIDDLE 0.65
#define CMImmunity_BAD    0.5

#define mag_xx(a,b) class _xx_##a {magazine = a; count = b;}
#define weap_xx(a,b) class _xx_##a {weapon = a; count = b;}
#define item_xx(a,b) class _xx_##a {name = a; count = b;}
#define bag_xx(a,b) class _xx_##a {backpack = a; count = b;}

#define DEFAULT_SLOT 0
#define MUZZLE_SLOT 101
#define OPTICS_SLOT 201
#define FLASHLIGHT_SLOT 301
#define NVG_SLOT 602
#define GOGGLE_SLOT 603
#define HEADGEAR_SLOT 605
#define UNIFORM_SLOT 801

#define HMD_SLOT       616
#define BINOCULAR_SLOT 617
#define MEDIKIT_SLOT   619
#define RADIO_SLOT    611

#define VEST_SLOT      701
#define BACKPACK_SLOT  901

#define LOAD(weight,capacity) maximumLoad = ##capacity##; \
							  mass = ##weight##;
							  
#define HeadArmourCoef 2.5
#define BodyArmourCoef 10
#define HandArmourCoef 5
#define LegArmourCoef 5

//Sounds Defines

// warp	factor
#define	FACTOR(val,from,to)	(val factor[from,to])
// RANGE(val,	begin, band, end,	band)
#define	RANGE(val,from,band0,to,band1) FACTOR2(val,from,(from+band0),to,(to+band1))
// FACTOR2(val,	0, 400,	1200,	2000)
#define	FACTOR2(val,from0,to0,from1,to1) (FACTOR(val,from0,to0)	*	FACTOR(val,to1,from1))

// redRpm
#define	MAX_RPM	6900
// scaled	rpm	to 0 - 1
#define	RPM(rpm) (rpm/MAX_RPM)

// specialized FACTOR for rpm
#define	FACTOR_RPM(from,to)	FACTOR(RPM(rpm),RPM(from),RPM(to))
// specialized peak	for	rpm
#define	FACTOR2_RPM(from0,to0,from1,to1) (FACTOR_RPM(from0,to0)	*	FACTOR_RPM(to1,from1))
// specialized peak, different definition, version for rpm
#define	RANGE_RPM(from,band0,to,band1) FACTOR2_RPM(from,(from+band0),to,(to+band1))


#define HZ_IDLE FACTOR_RPM(400,1150)
#define HZ_RPM1 FACTOR_RPM(900,2100)
#define HZ_RPM2	FACTOR_RPM(1300,3100)
#define HZ_RPM3 FACTOR_RPM(2200,4100)
#define HZ_RPM4 FACTOR_RPM(3300,4900)
#define HZ_RPM5 FACTOR_RPM(4200,6200)
#define HZ_RPM6 FACTOR_RPM(5100,6900)

#define VOLUME_IDLE FACTOR2_RPM(400,700,900,1100)
#define VOLUME_RPM1 FACTOR2_RPM(870,1100,1300,2100)
#define VOLUME_RPM2 FACTOR2_RPM(1250,2050,2300,3100)
#define VOLUME_RPM3 FACTOR2_RPM(2250,3050,3300,4100)
#define VOLUME_RPM4 FACTOR2_RPM(3250,4050,4200,4870)
#define VOLUME_RPM5 FACTOR2_RPM(4150,4800,5150,6150)
#define VOLUME_RPM6 FACTOR_RPM(5100,6100)