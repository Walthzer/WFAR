#ifdef DESIGN
	#undef DESIGN
#endif
#define DESIGN Jews

class wfar_jews_mich_helmet_marpatwd_norotos: rhsusf_mich_helmet_marpatwd_norotos
{
	author="Walthzer/Shark";
	dlc="";
    scope=2;
	picture="\rhsusf\addons\rhsusf_inventoryicons\data\headgear\rhsusf_mich_helmet_marpatwd_norotos_ca.paa";
	displayName="MICH 2000 MARPAT-WD (Norotos) Jewsbury";
	model="\rhsusf\addons\rhsusf_infantry\gear\head\mich_01_nor1";
	hiddenSelectionsTextures[]=
	{
		"z\wfar\addons\retextures\data\mich_covered_norotos\jews\wood\mich_covered_norotos_wd_jews_co.paa",
		"rhsusf\addons\rhsusf_infantry\gear\head\data\mich_acc_od_co.paa"
	};
	class ItemInfo: ItemInfo
	{
		uniformModel="\rhsusf\addons\rhsusf_infantry\gear\head\mich_01_nor1";
	};
};

class wfar_jews_mich_helmet_marpatd_norotos: wfar_jews_mich_helmet_marpatwd_norotos
{
	picture="\rhsusf\addons\rhsusf_inventoryicons\data\headgear\rhsusf_mich_helmet_marpatd_norotos_ca.paa";
	displayName="MICH 2000 MARPAT-D (Norotos) Jewsbury";
	hiddenSelectionsTextures[]=
	{
		"z\wfar\addons\retextures\data\mich_covered_norotos\jews\desert\mich_covered_norotos_des_jews_co.paa",
		"rhsusf\addons\rhsusf_infantry\gear\head\data\mich_acc_od_co.paa"
	};
};

class wfar_jews_mich_helmet_marpatwd_norotos_arc: wfar_jews_mich_helmet_marpatwd_norotos
{
	picture="\rhsusf\addons\rhsusf_inventoryicons\data\headgear\rhsusf_mich_helmet_marpatwd_norotos_ca.paa";
	displayName="MICH 2000 MARPAT-WD (Norotos/ARC) Jewsbury";
	model="\rhsusf\addons\rhsusf_infantry\gear\head\mich_01_nor1_arc";
	hiddenSelectionsTextures[]=
	{
		"z\wfar\addons\retextures\data\mich_covered_norotos\jews\wood\mich_covered_norotos_arc_wd_jews_co.paa",
		"rhsusf\addons\rhsusf_infantry\gear\head\data\mich_acc_od_co.paa"
	};
	class ItemInfo: ItemInfo
	{
		uniformModel="\rhsusf\addons\rhsusf_infantry\gear\head\mich_01_nor1_arc";
	};
};

class wfar_jews_mich_helmet_marpatd_norotos_arc: wfar_jews_mich_helmet_marpatwd_norotos_arc
{
	picture="\rhsusf\addons\rhsusf_inventoryicons\data\headgear\rhsusf_mich_helmet_marpatd_norotos_ca.paa";
	displayName="MICH 2000 MARPAT-D (Norotos/ARC) Jewsbury";
	hiddenSelectionsTextures[]=
	{
		"z\wfar\addons\retextures\data\mich_covered_norotos\jews\wood\mich_covered_norotos_arc_des_jews_co.paa",
		"rhsusf\addons\rhsusf_infantry\gear\head\data\mich_acc_od_co.paa"
	};
};