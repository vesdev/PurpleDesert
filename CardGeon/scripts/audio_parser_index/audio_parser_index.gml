/// @desc Audio Parser for Indexes, returns index from preset range (See script for a list of all ranges)
/// @arg index
function audio_parser_index(input) {
	
	var output;
	switch(input)
		{	
	#region//New enemy default


			case aud.bw_antlion_warn:
				output =  "sfx_black_and_white_antlion";
			break;
			case aud.bw_dragon_warn:
				output =  "sfx_black_and_white_dragon";
			break;
			case aud.pixel_explosion:
				output = "a_enemy_explosion";
			break;
			
			case aud.player_hurt:
				output = "a_wally_hurt";
			break;
		
			case aud.enemy_death_default:
				output = "sfx_gun_kickdrum"; break;
			break;
			case aud.snowball_impact:
				output = "sfx_snowball_hit_impact_hard_0" + string(irandom_range( 1,3));
			break;	
			case aud.punch_light_jab:
				output = "sfx_kick_soft_jab_impact_0" + string(irandom_range( 1,8 ));
			break;
			case aud.kick_heavy_impact:
				output = "sfx_kick_heavy_impact_0" + string(irandom_range( 1,7 ));
			break;
				case aud.enemy_boss_cloak_ball_death:
					output = "sfx_ball_death";
				break;
				case aud.enemy_bear_warn:
					output = "sfx_bear_ready";
				break;
				case aud.weapon_init_default:
					output = "sfx_bubble_pop";
				break;
				case aud.weapon_swap:
					output = "sfx_bag" + "_" + string(irandom_range(1,9));
				break;
				case aud.whip: 
					output = "sfx_bullwhip";// "sfx_whip" + "_" + string(irandom_range(1,4));
				break;
				case aud.enemy_vortex_death:
					output = "sfx_portal_death";
				break;
				case aud.enemy_boss_foxlion_chase:
					output = "sfx_antlion_move_repeat";
				break;
				case aud.enemy_beetle_warn:
					output = "sfx_beetle_chargeup";
				break;
				case aud.enemy_bear_death:
					output =  "sfx_bear_death";
				break; 
			#endregion 
				case aud.enemy_boss_cloak_deflect: 
					output = "sfx_ghost_deflect_balls";
				break;
				case aud.bullet_fire_deflect:
					output = "sfx_fire_ball_deflect" + "_" + string(irandom_range(1,2));
				break;
				case aud.get_xp: 
					output = "sfx_xp_get"; 
				break;
				case aud.enemy_bee_death:
					output = "a_bee_buzz";
				break;
				case aud.bush_cut:
					output = "sfx_grass_cut" + "_0" + string(irandom_range(1,5));
				break;
				case aud.hitmarker_beer:
					output = "sfx_hitmarker_bass";
				break;	
				case aud.hitmarker_tap:
					output = "sfx_hitmarker_low";
				break;		
				case aud.coin_spawn:
					output = "sfx_coins" + "_0" + string(irandom_range(1,5));
				break;	
				case aud.coin_pickup:
					output = "sfx_coin_and_purse" + "_0" + string(irandom_range(1,5));
				break;
				case aud.punch_light:
				output = "sfx_punch" + "_0" + string(irandom_range(1,4));
				break;		
				case aud.bullet_flesh_hit:
					output = "sfx_bullet_impact_body_thump" + "_0" + string(irandom_range(1,8));
				break;
				case aud.bullet_flesh_kill:
					output = "sfx_bullet_impact_body_flesh" + "_0" + string(irandom_range(1,8));
				break;				
				
				case aud.bullet_wall_hit:
					output = "sfx_bullet_impact_grass" + "_0" + string(irandom_range(1,8));
				break;
				case aud.whoosh_low:
					output = "sfx_whoosh_low_deep" + "_0" + string(irandom_range(1,9));
				break;
	#region FOOTSTEPS
			case aud.foot_bush:
					output =  "sfx_Fantasy_Game_Footstep_Grass_Medium" + "_" + string(irandom_range(1,11));
				break;	
			case aud.foot_grass:
					output = "sfx_footstep_grass" + "_" + string(irandom_range(1,12));
				break;
			case aud.foot_dirt:
					output = "sfx_footstep_dirt" + "_" + string(irandom_range(1,9));
				break;
			case aud.foot_wood:
					output = "sfx_footstep_wood" + "_" + string(irandom_range(1,9));
				break;
			case aud.foot_sand:
					output = "sfx_footstep_sand" + "_" + string(irandom_range(1,6));
				break;
			case aud.foot_cloud:
					output = "sfx_footstep_sand" + "_" + string(irandom_range(1,6));
			break;
			case aud.foot_gravel:
				output = "sfx_footstep_sand" + "_" + string(irandom_range(1,6));
				//output = "sfx_footstep_gravel_walk"  + "_" + string(irandom_range(1,17));
			break;
			case "sfx_orchestral_impact":
				output = "sfx_orchestral_impact";
				break;
			case "sfx_dragon_shoot":
				output = "sfx_dragon_shoot";
			break;
	#endregion					
				case "sfx_enemy_porcupine_scream":
					output = "a_porcupine_scream";
				break;
				case "sfx_don_jon_speak":
					output = "sfx_don_jon_speak";
				break;
				case "sfx_number_goes_up":
					output = "sfx_speak";
				break;
				case "sfx_death_gain_level":
					output = "a_gem_pick_up";
				break;		
				case "sfx_death_next_state":
					output = "sfx_upgrade_spawn";
				break;	
				case "sfx_death_xp_gain":
					output = "a_stamina_gain";
				break;
				case "sfx_crit_bullet": //bullet has a crit 
					output = "a_ruler";
				break;
				case "sfx_bat_warning":
					output = "a_porcupine_scream";
				break;
				case "sfx_upgrade_spawn": 
					output = "sfx_upgrade_spawn";
				break;
				case "sfx_get_heart":
					output = "sfx_get_heart";
				break;
				case "sfx_crit":
					output = "sfx_strong_crit";
				break;
				case "sfx_bear_warn":
					output = "sfx_dragon_warn";
				break;
				case "sfx_dragon_warn":
					output = "sfx_dragon_warn";
				break;
				case "sfx_boss_bass_hitmarker":
					output = "a_bass";
				break;	
				case "sfx_spawn_upgrade": 
					output = "sfx_spawn_upgrade";
					break;
				case "sfx_apple_spawn":
					output = "a_heart";
				break;
				case "sfx_enemy_rip":
					output = "sfx_enemy_rip";
				break;
				case "sfx_anvil":
					output = "sfx_anvil";
				break;
				case "sfx_xp_create":
					output = "sfx_water_droplet";
				break;
				case "sfx_explosion_dynamic":
					output = "sfx_explosion_dynamic";
				break;
				case "sfx_ui_speak":
					output = "a_stamina_gain";
				break;	
				case "sfx_speak":
					output = "sfx_speak";
				break;
				case "sfx_stamina_appear":
				
					output = "sfx_stamina_appear";
				break;
				case "sfx_bomb_beep":
					output = "sfx_water_droplet";
				break;			
				case "sfx_button_hover":
				output = "sfx_button_hover";
				break;
				case "sfx_bomb_pickup":
				output = "sfx_bomb_pickup";
				break;	
				case "sfx_button_press":
				output = "sfx_button_press";
				break;
				case "sfx_shotgun_load":
				output = "sfx_shotgun_load";
				break;	
				case "sfx_item_get":
				output = "sfx_item_get";
				break;		
				case "sfx_rock_hit":
				output = "sfx_rock_hit";
				break;				
				case "sfx_not_enough_bombs":
				output = "sfx_not_enough_bombs";
				break;		
				case "sfx_rare_item":
				output = "sfx_upgrade_spawn";
				break;				
	#endregion

	#region gun shots
		case "sfx_rock_break_low":
			output = "sfx_rock_break";
			break;	
		case "sfx_rock_break":
			output = "sfx_rock_break";
			break;
		case "sfx_shoot_ddr":
			output = "a_stamina_shoot_bass";
			break;
		case "sfx_gun_sniper_fire":
			output = "sfx_gun_sniper_fire_1";
			break;	
		case "sfx_gun_default_fire":
			if socket[slot] = ISAAC || socket[slot] = DEFAULT {
				if instance_exists(o_combo_parent) and o_combo_parent.combo >= 6{
					output = "sfx_gun_default_fire_bass_low_combo";	
					
					
				}else{
					output = "sfx_gun_default_fire_bass_low";		
				}
			}else{
				output = "sfx_gun_default_fire_bass_low";	
			}
		
			
		
			break;
		case "sfx_lightning_short":
			output = "sfx_lightning_short";
			break;
		case "sfx_gun_shotgun_fire":
			output = "sfx_gun_shotgun_fire_1";
			break;
	#endregion

		
		case "sfx_spider_web_rubber_band":
			output = "sfx_spider_web_rubber_band";
			break;
		case "sfx_mob_bird_chirp":
			output = "sfx_mob_bird_chirp" + "_" + string(irandom_range(1,12));
			break;
		case "sfx_mob_bird_flap":
			output = "sfx_mob_bird_flap" + "_" + string(irandom_range(1,12));
			break;
		case "sfx_box_destroy":
			output = "sfx_box_destroy" + "_" + string(irandom_range(1,5));
			break;
		case "sfx_bomb_explosion":
			output = "sfx_bomb_explosion" + "_" + string(irandom_range(1,2));
			break;
		case "sfx_bomb_thunder":
			output = "sfx_bomb_thunder" + "_" + string(irandom_range(1,5));
			break;
		case "sfx_bomb_fuse":
			output = "sfx_bomb_fuse" + "_" + string(irandom_range(1,3));
			break;
		case "sfx_bomb_fuse_loop":
			output = "sfx_bomb_fuse_loop";
			break;
		case "sfx_bomb_tick":
			output = "sfx_bomb_tick";
			break;
		case "sfx_water_droplet":
			output = "sfx_water_droplet";
			break;			
		case "sfx_fire_loop":
			output = "sfx_fire_loop";
			break;
		case "sfx_fire_shoot":
			output = "sfx_fire_shoot" + "_" + string(irandom_range(1,3));
			break;
		case "sfx_combo":
			output =  "sfx_combo" + "_" + string(o_combo_parent.combo_parse);//"a_bass";//
			break;
		case "sfx_sword_swing":
			output = "sfx_sword_swing" + "_" + string(irandom_range(1,4));
			break;
		case "sfx_heart_last":
			output = "sfx_heart_last";
			break;
	// LEGACY, NEED REPLACEMENT
		case "sfx_bush_destroy":
			output = "a_bush" + "_" + string(irandom_range(1,6));
			break;
	// LEGACY, NEED REPLACEMENT
		case "sfx_currency_add":
			output = "a_high_blip";
			break;
	// LEGACY, NEED REPLACEMENT
		case "a_high_blip":
			output = "a_high_blip";
			break;
		case "a_error":
			output = "a_error";
			break;		
		// Throw Message, Exit Script
		default:
		{
			//output = input;
			show_debug_message("[AUDIO PARSER INDEX] Malformed input (" + string(input) + ") in audio_parser_index script!");
			exit;
		}
	}
	// Return assed index id of the sound file
	return asset_get_index(output);


}
