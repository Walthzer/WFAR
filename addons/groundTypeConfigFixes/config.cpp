#include "script_component.hpp"

class CfgPatches
{
	class WASHM_wfar_groundTypeConfigFixes
	{
		name="WHITE FOX ASSAULT REGIMENT data";
		author="Walthzer/Shark";
		url="https://whitefoxassaultreg.wixsite.com/wfar";
		requiredVersion=1.0;
		requiredaddons[]={"A3_Data_F", "ace_trenches"};
		units[]={};
		weapons[]={};
	};
};
class CfgSurfaces
{
	class Default;
	class GdtThorn: Default
	{
		ACE_canDig = 1;
	};
};
