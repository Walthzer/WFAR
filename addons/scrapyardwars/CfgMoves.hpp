class CfgMovesBasic
{
	class DefaultDie;
	class ManActions
	{
		Ikarus_Driver = "Ikarus_Driver";
		Ikarus_Cargo = "Ikarus_Cargo";
	};
};
class CfgMovesMaleSdr: CfgMovesBasic
{
	class States
	{
		class Crew;
		class KIA_Ikarus_Driver: DefaultDie
		{
			actions = DeadActions;
			file="z\wfar\addons\scrapyardwars\ikarus\data\anim\KIA_Ikarus_driver.rtm";
			speed = 0.5;
			looped=0;
			terminal = 1;
			soundEnabled=0;
			connectTo[] = {DeadState,0.1};
		};
		class Ikarus_Driver: Crew
		{
			file="z\wfar\addons\scrapyardwars\ikarus\data\anim\Ikarus_driver.rtm";
			interpolateTo[]={KIA_Ikarus_Driver,1};
		};
		class KIA_Ikarus_Cargo: DefaultDie
		{
			actions = DeadActions;
			file="z\wfar\addons\scrapyardwars\ikarus\data\anim\KIA_Ikarus_Cargo.rtm";
			speed = 0.5;
			looped=0;
			terminal = 1;
			soundEnabled=0;
			connectTo[] = {DeadState,0.1};
		};
		class Ikarus_Cargo: Crew
		{
			file="z\wfar\addons\scrapyardwars\ikarus\data\anim\Ikarus_Cargo.rtm";
			interpolateTo[]={KIA_Ikarus_Cargo,1};
		};
	};
};