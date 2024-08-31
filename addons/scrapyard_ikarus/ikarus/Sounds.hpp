
          insideSoundCoef = 0.9;
          soundGear[]={"","db-85",1};
          soundGetIn[]={"z\wfar\addons\scrapyard_ikarus\ikarus\sounds\ext-bus-getout-1","db-0",1};
          soundGetOut[]={"z\wfar\addons\scrapyard_ikarus\ikarus\sounds\int-bus-getout-1","db-0",1, 40};
          soundEngineOnInt[] = {"a3\sounds_f\vehicles\soft\truck_01\int_start", "db-5", 1.0};
          soundEngineOnExt[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_start", "db-5", 1.0, 280};
          soundEngineOffInt[] ={"a3\sounds_f\vehicles\soft\truck_01\int_stop", "db-5", 1.0};
          soundEngineOffExt[] ={"a3\sounds_f\vehicles\soft\truck_01\ext_stop", "db-5", 1.0, 280};
          
          /* ---- CRASHES START ---- */

          buildCrash0[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1", "db0",1,200};
          buildCrash1[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2", "db0",1,200};
          buildCrash2[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3", "db0",1,200};
          buildCrash3[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4", "db0",1,200};
          soundBuildingCrash[]={"buildCrash0", 0.25, "buildCrash1", 0.25, "buildCrash2", 0.25, "buildCrash3", 0.25};

          WoodCrash0[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_wood_ext_1", "db0",1,200};
          WoodCrash1[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_wood_ext_1", "db0",1,200};
          WoodCrash2[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_wood_ext_1", "db0",1,200};
          WoodCrash3[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_wood_ext_1", "db0",1,200};
          soundWoodCrash[]={"woodCrash0", 0.25, "woodCrash1", 0.25, "woodCrash2", 0.25, "woodCrash3", 0.25};

          armorCrash0[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1", "db0",1,200};
          armorCrash1[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2", "db0",1,200};
          armorCrash2[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3", "db0",1,200};
          armorCrash3[]={"a3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4", "db0",1,200};
          soundArmorCrash[]={"ArmorCrash0", 0.25, "ArmorCrash1", 0.25, "ArmorCrash2", 0.25, "ArmorCrash3", 0.25};

          /* ---- CRASHES  END ---- */

          class Sounds 
          {
               /*          hatchback external sounds without gas       */

               class Idle_ext
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_engine_00", "db-13",     1, 150};
                    frequency = QUOTE(0.9 + HZ_IDLE*0.2);
                    volume = QUOTE(engineOn*camPos*VOLUME_IDLE);
               };
               class Engine
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_engine_01",     "db-11",1, 200};
                    frequency = QUOTE(0.8 + HZ_RPM1*0.2);
                    volume = QUOTE(engineOn*camPos*VOLUME_RPM1);
               };
               class Engine1_ext
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_engine_02",     "db-9",1, 240};
                    frequency = QUOTE(0.8 + HZ_RPM2*0.2);
                    volume = QUOTE(engineOn*camPos*VOLUME_RPM2);
               };
               class Engine2_ext
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_engine_03",     "db-8",1, 280};
                    frequency = QUOTE(0.8 + HZ_RPM3*0.2);
                    volume = QUOTE(engineOn*camPos*VOLUME_RPM3);
               };
               class Engine3_ext
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_engine_04",     "db-7",1, 320};
                    frequency = QUOTE(0.8 + HZ_RPM4*0.2);
                    volume = QUOTE(engineOn*camPos*VOLUME_RPM4);
               };
               class Engine4_ext
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_engine_05",     "db-6",1, 360};
                    frequency = QUOTE(0.8 + HZ_RPM5*0.2);
                    volume = QUOTE(engineOn*camPos*VOLUME_RPM5);
               };
               class Engine5_ext
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_engine_06",     "db-5",1, 420};
                    frequency = QUOTE(0.95 + HZ_RPM6*0.15);
                    volume = QUOTE(engineOn*camPos*VOLUME_RPM6);
               };
               
                    /*   hatchback external sounds with gas  */
                    
                class IdleThrust
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_exhaust_00", "db-6",1, 200};
                    frequency = QUOTE(0.9 + HZ_IDLE*0.2);
                    volume = QUOTE(engineOn*camPos*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_IDLE);
               };
               class EngineThrust
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_exhaust_01", "db-5",1, 250};
                    frequency = QUOTE(0.8 + HZ_RPM1*0.2);
                    volume = QUOTE(engineOn*camPos*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM1);
               };
               class Engine1_Thrust_ext
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_exhaust_02", "db-4",1, 280};
                    frequency = QUOTE(0.8 + HZ_RPM2*0.2);
                    volume = QUOTE(engineOn*camPos*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM2);
               };
               class Engine2_Thrust_ext
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_exhaust_03", "db-3",1, 320};
                    frequency = QUOTE(0.8 + HZ_RPM3*0.2);
                    volume = QUOTE(engineOn*camPos*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM3);
               };
               class Engine3_Thrust_ext
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_exhaust_04", "db-2",1, 360};
                    frequency = QUOTE(0.8 + HZ_RPM4*0.2);
                    volume = QUOTE(engineOn*camPos*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM4);
               };
               class Engine4_Thrust_ext
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_exhaust_05", "db0", 1, 400};
                    frequency = QUOTE(0.8 + HZ_RPM5*0.3);
                    volume = QUOTE(engineOn*camPos*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM5);
               };
               class Engine5_Thrust_ext
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\ext_exhaust_06", "db2", 1, 450};
                    frequency = QUOTE(0.9 + HZ_RPM6*0.2);
                    volume = QUOTE(engineOn*camPos*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM6);
               };

               /*  end external sounds with gas */

               /* hatchback internal sounds without gas */

               class Idle_int
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_engine_00", "db-15",     1};
                    frequency = QUOTE(0.9 + HZ_IDLE*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*VOLUME_IDLE);
               };
               class Engine_int
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_engine_01",     "db-14",1 };
                    frequency = QUOTE(0.8 + HZ_RPM1*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*VOLUME_RPM1);
               };
               class Engine1_int
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_engine_02",     "db-12",1 };
                    frequency = QUOTE(0.8 + HZ_RPM2*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*VOLUME_RPM2);
               };
               class Engine2_int
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_engine_03",     "db-11",1 };
                    frequency = QUOTE(0.8 + HZ_RPM3*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*VOLUME_RPM3);
               };
               class Engine3_int
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_engine_04",     "db-10",1 };
                    frequency = QUOTE(0.8 + HZ_RPM4*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*VOLUME_RPM4);
               };
               class Engine4_int
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_engine_05",     "db-9",1 };
                    frequency = QUOTE(0.8 + HZ_RPM5*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*VOLUME_RPM5);
               };
               class Engine5_int
               {
                    sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_engine_06",     "db-6",1 };
                    frequency = QUOTE(0.95 + HZ_RPM6*0.15);
                    volume = QUOTE(engineOn*(1-camPos)*VOLUME_RPM6);
               };

                    /* hatchback internal sounds with gas */
                    
               class IdleThrust_int
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_exhaust_00", "db-10",1 };
                    frequency = QUOTE(0.9 + HZ_IDLE*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_IDLE);
               };
               class EngineThrust_int
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_exhaust_01", "db-9",1 };
                    frequency = QUOTE(0.8 + HZ_RPM1*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM1);
               };
               class Engine1_Thrust_int
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_exhaust_02", "db-8",1 };
                    frequency = QUOTE(0.8 + HZ_RPM2*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM2);
               };
               class Engine2_Thrust_int
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_exhaust_03", "db-7",1 };
                    frequency = QUOTE(0.8 + HZ_RPM3*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM3);
               };
               class Engine3_Thrust_int
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_exhaust_04", "db-6",1 };
                    frequency = QUOTE(0.8 + HZ_RPM4*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM4);
               };
               class Engine4_Thrust_int
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_exhaust_05", "db-5",1 };
                    frequency = QUOTE(0.8 + HZ_RPM5*0.3);
                    volume = QUOTE(engineOn*(1-camPos)*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM5);
               };
               class Engine5_Thrust_int
               {
               sound[] = {"a3\sounds_f\vehicles\soft\truck_01\int_exhaust_06", "db-4",1 };
                    frequency = QUOTE(0.9 + HZ_RPM6*0.2);
                    volume = QUOTE(engineOn*(1-camPos)*(0.4+(0.6*FACTOR(thrust,0.1,1)))*VOLUME_RPM6);
               }; 
               class Movement
               {
                    sound = "soundEnviron";
                    frequency = "1";
                    volume = "0";
               };

               /*----------------------------------*/          
               /*-----------  TIRES EXT ---------*/
               /*----------------------------------*/ 
               
               class TiresRockOut
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\ext_tires_dirt_soft_1", "db-6", 1.0, 60};
                    frequency = "1";
                    volume = "camPos*rock*(speed factor[2, 20])";
               };
               class TiresSandOut
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\ext-tires-sand1", "db-6", 1.0, 60};
                    frequency = "1";
                    volume = "camPos*sand*(speed factor[2, 20])";
               };
               class TiresGrassOut
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\ext_tires_dirt_soft_2", "db-6", 1.0, 60};
                    frequency = "1";
                    volume = "camPos*grass*(speed factor[2, 20])";
               };
               class TiresMudOut
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\ext-tires-mud2", "db-6", 1.0, 60};
                    frequency = "1";
                    volume = "camPos*mud*(speed factor[2, 20])";
               };
               class TiresGravelOut
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\ext_tires_gravel_1", "db-6", 1.0, 60};
                    frequency = "1";
                    volume = "camPos*gravel*(speed factor[2, 20])";
               };
               class TiresAsphaltOut
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\ext_tires_asfalt_2", "db-6", 1.0, 60};
                    frequency = "1";
                    volume = "camPos*asphalt*(speed factor[2, 20])";
               };
               class NoiseOut
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\noise_ext_car_3", "db-8", 1.0, 90};
                    frequency = "1";
                    volume = "camPos*(damper0 max 0.02)*(speed factor[0, 8])";
               };
                         
               /*----------------------------------*/
               /*-----------  TIRES INT ---------*/
               /*----------------------------------*/

               class TiresRockIn
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\int_tires_dirt_soft_1", "db-6", 1.0};
                    frequency = "1";
                    volume = "(1-camPos)*rock*(speed factor[2, 20])";
               };
               class TiresSandIn
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\int-tires-sand2", "db-6", 1.0};
                    frequency = "1";
                    volume = "(1-camPos)*sand*(speed factor[2, 20])";
               };
               class TiresGrassIn
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\int_tires_dirt_soft_2", "db-6", 1.0};
                    frequency = "1";
                    volume = "(1-camPos)*grass*(speed factor[2, 20])";
               };
               class TiresMudIn
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\int-tires-mud2", "db-6", 1.0};
                    frequency = "1";
                    volume = "(1-camPos)*mud*(speed factor[2, 20])";
               };
               class TiresGravelIn
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\int_tires_gravel_1", "db-6", 1.0};
                    frequency = "1";
                    volume = "(1-camPos)*gravel*(speed factor[2, 20])";
               };
               class TiresAsphaltIn
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\tires\int_tires_asfalt_2", "db-6", 1.0};
                    frequency = "1";
                    volume = "(1-camPos)*asphalt*(speed factor[2, 20])";
               };
               class NoiseIn
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\noise_int_car_3", "db-12", 1.0};
                    frequency = "1";
                    volume = "(damper0 max 0.1)*(speed factor[0, 8])*(1-camPos)"; //Definition of inside sounds
               };

               /*------------------------------------------------------------------*/     
               /*-------------- external sounds for screeching tires on the road -------------*/
               /*------------------------------------------------------------------*/     
                    
               /* sounds on the road */

               class breaking_ext_road
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_04", "db-3", 1, 80};
                    frequency = QUOTE(1);
                    volume = "(engineOn*camPos*asphalt*(LongSlipDrive Factor[-0.1, -0.4])*(Speed Factor[2, 15]))";
               };
               
               class acceleration_ext_road
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02", "db-3", 1, 80};
                    frequency = QUOTE(1);
                    volume = "(engineOn*camPos*asphalt*(LongSlipDrive Factor[0.1, 0.4])*(Speed Factor[15, 2]))";
               };
               class turn_left_ext_road
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02", "db-3", 1, 80};
                    frequency = QUOTE(1);
                    volume = "(engineOn*camPos*asphalt*(latSlipDrive Factor[0.1, 0.4])*(Speed Factor[2, 15]))";
               };

               class turn_right_ext_road
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02", "db-3", 1, 80};
                    frequency = QUOTE(1);
                    volume = "(engineOn*camPos*asphalt*(latSlipDrive Factor[-0.1, -0.4])*(Speed Factor[2, 15]))";
               };

               /*-----------------------------------------------------------------*/
               /* external sounds for screeching tires on other surfaces  */
               /*-----------------------------------------------------------------*/
                    
               class breaking_ext_dirt
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_14_dirt_breaking", "db-3", 1, 60};
                    frequency = QUOTE(1);
                    volume = "(engineOn*camPos*(1-asphalt)*(LongSlipDrive Factor[-0.1, -0.4])*(Speed Factor[1, 15]))";
               };
               class acceleration_ext_dirt
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_16_dirt_acceleration", "db-3",     1, 60};
                    frequency = QUOTE(1);
                    volume = "(engineOn*camPos*(1-asphalt)*(LongSlipDrive Factor[0.1, 0.4])*(Speed Factor[15, 1]))";
               };
               class turn_left_ext_dirt
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_18_dirt", "db-3", 1, 60};
                    frequency = QUOTE(1);
                    volume = "(engineOn*camPos*(1-asphalt)*(latSlipDrive Factor[0.1, 0.4])*(Speed Factor[1, 15]))";
               };
               class turn_right_ext_dirt
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_18_dirt", "db-3", 1, 60};
                    frequency = QUOTE(1);
                    volume = "(engineOn*camPos*(1-asphalt)*(latSlipDrive Factor[-0.1, -0.4])*(Speed Factor[1, 15]))";
               };

               
               /*---------------------------------------------------------------------------*/     
               /*-------------- internal sounds for screeching tires on the road --------------*/
               /*---------------------------------------------------------------------------*/     

               class breaking_int_road
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_04_int", "db-10", 1};
                    frequency = QUOTE(1);
                    volume = "(engineOn*asphalt*(1-camPos)*(LongSlipDrive Factor[-0.1, -0.4])*(Speed Factor[2, 15]))";
               };
               class acceleration_int_road
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int", "db-10", 1};
                    frequency = QUOTE(1);
                    volume = "(engineOn*asphalt*(1-camPos)*(LongSlipDrive Factor[0.1, 0.4])*(Speed Factor[15, 2]))";
               };
               class turn_left_int_road
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int", "db-10", 1};
                    frequency = QUOTE(1);
                    volume = "(engineOn*asphalt*(1-camPos)*(latSlipDrive Factor[0.1, 0.4])*(Speed Factor[2, 15]))";
               };
               class turn_right_int_road
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_loop_02_int", "db-10", 1};
                    frequency = QUOTE(1);
                    volume = "(engineOn*asphalt*(1-camPos)*(latSlipDrive Factor[-0.1, -0.4])*(Speed Factor[2, 15]))";
               };

               /*--------------------------------------------------------------------------------------------*/     
               /*-------------- internal sounds for screeching tires on other surfaces -------------*/
               /*--------------------------------------------------------------------------------------------*/     
               class breaking_int_dirt
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_14_dirt_breaking_int", "db-10", 1};
                    frequency = QUOTE(1);
                    volume = "(engineOn*(1-asphalt)*(1-camPos)*(LongSlipDrive Factor[-01, -0.4])*(Speed Factor[2, 15]))";
               };
               class acceleration_int_dirt
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_16_dirt_acceleration_int", "db-10", 1};
                    frequency = QUOTE(1);
                    volume = "(engineOn*(1-asphalt)*(1-camPos)*(LongSlipDrive Factor[0.1, 0.4])*(Speed Factor[15, 2]))";
               };
               class turn_left_int_dirt
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_18_dirt_int", "db-10",     1};
                    frequency = QUOTE(1);
                    volume = "(engineOn*(1-asphalt)*(1-camPos)*(latSlipDrive Factor[0.1, 0.4])*(Speed Factor[2, 15]))";
               };
               class turn_right_int_dirt
               {
                    sound[] = {"a3\Sounds_F\vehicles\soft\noises\slipping_tires_18_dirt_int", "db-10",     1};
                    frequency = QUOTE(1);
                    volume = "(engineOn*(1-asphalt)*(1-camPos)*(latSlipDrive Factor[-0.1, -0.4])*(Speed Factor[2, 15]))";
               };
          };