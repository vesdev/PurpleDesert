/// @desc Audio Parser for Volume, returns volume from preset range (See script for a list of all ranges)
function audio_parser_volume(input, input_id) {

	// @arg index
	// This script takes the name of a sound file WITHOUT the numbered suffix.
	// Example: "sfx_footstep_wood_<number>" becomes just "sfx_footstep_wood"
	// It then returns a given volume from a preset list of ranges.
	// This script is meant for randomization inside other audio play scripts, not for direct usage.
	// ~WangleLine
	var output;
	output = 1;
	switch(input)
	{
		case aud.bw_dragon_warn:
			output =  .5;
		break;
		case aud.bw_antlion_warn:
			output =  .5;
		break;	
		case aud.pixel_explosion:
			output = .3;
		break;
		case aud.player_hurt:
				output = .2;
		break;
		case aud.enemy_death_default:
				output = random_range(.4,.6);
		break;			
		case aud.snowball_impact:
			output = 1 + random_range(-.2,.2);
		break;		
		case aud.punch_light_jab:
				output = .3 + random_range(-.01,.01);
		break;		
		case aud.kick_heavy_impact:
			output = .2;// + random_range(-.01,.01);
		break;
		case aud.enemy_boss_cloak_ball_death:
			output = 1;
		break;	
		case aud.enemy_bear_death:
			output =  1;
		break; 		
		case aud.enemy_bear_warn:
			output = .6;
		break;
		case aud.weapon_init_default:
			output = .25 + random_range(-.02,.02);
		break;
		case aud.weapon_swap:
			output =  1 + random_range(-.1,.1);
		break;		
		case aud.whip:
			output =  0.35;
		break;
		case aud.enemy_vortex_death:
				output = 1;
		break;
		case aud.enemy_boss_foxlion_chase:
				output =  .3;
		break;
		case aud.enemy_beetle_warn:
			output = 1 + random_range(-.1,.1);
		break;
		case aud.bullet_fire_deflect:
			output = .8 + random_range(-.1,.1);
		break;	
		case aud.get_xp:
			output = .15 + random_range(-.01,.01);
		break;
		case aud.enemy_bee_death:
			output = 1;
		break;	
		case aud.punch_light:
		output = 1;
		break;		
		
		case aud.bullet_flesh_hit:
		output = 0.1  + random_range(-.01,.01);
		break;	
		case aud.bullet_flesh_kill:
		output = 1  + random_range(-.01,.01);
		break;			
		case aud.bush_cut:
		output = 0.4 + random_range(-.01,.01);
		break;			
	#region //new sounds
		case aud.hitmarker_beer:
			output = random_range(0.3,.4);
			break;	
			case aud.hitmarker_tap:
			output = .3 + random_range(-.1,.1);
			break;	
			case aud.coin_spawn:
			output = .05 ;
			break;	
			case aud.coin_pickup:
			output = .2;
			break;
			case aud.bullet_wall_hit:
			output = random_range(.4,.5);
			break;	
			case aud.whoosh_low:
				if instance_exists(o_player){
					output = .5 + random_range(-.01,.01);	
				}else{
					output = 1 + random_range(-.01,.01);
				}
			break;
			
			case "sfx_enemy_porcupine_scream":
				output = 1;
			break;	
	
			case "sfx_don_jon_speak":
					output = 1;
			break;	
		case "sfx_bar_fill_up":	
			output = random_range(.7,.9);
			break;
		case "sfx_number_goes_up":
			output = random_range(.4,.5);
		break;	
		case "sfx_death_gain_level":
			output = 1;
		break;		
		case "sfx_death_next_state":
			output = 1;
		break;
		case "sfx_death_xp_gain":
		output = random_range(.4,.5);
		break;	
		case "sfx_crit_bullet":
			output = 1;
		break;	
		case "sfx_bat_warning":
			output = 1;
		break;	
		case "sfx_get_heart":
			output = 1;
		break;	
		case "sfx_crit":
			output = random_range(.152,.15);
		break;
		case "sfx_bear_warn":
			output = random_range(4,4);
		break;
		case "sfx_dragon_warn":
			output = 3;
		break;
		case "sfx_boss_bass_hitmarker":
			output = random_range(.1,.2);
		break;
		case "sfx_upgrade_spawn":
			output = 1;
		break;
		case "sfx_apple_spawn":
			output = .4;
		break;		
		case "sfx_xp_create":
			output = random_range(.3,.4);
		break;	
		case "sfx_enemy_rip":
			output = random_range(.4,.4);
		break;	
		case "sfx_anvil":
			output = .2;
		break;	
		case "sfx_explosion_dynamic":
			output = 0.08;
		break;
	
		case "sfx_ui_speak":
		output = random_range(1.8,2.2);
		break;	
		case "sfx_speak":
		output = random_range(.9,1.1);
		break;
		case "sfx_stamina_appear":
				output = random_range(.1,.2);
		break;	
		case "sfx_bomb_beep":
			output = random_range(0.1,0.2);
		break;		
		case "sfx_button_hover":
				output = 1;
				break;
				case "sfx_bomb_pickup":
				output = 1;
				break;	
				case "sfx_button_press":
				output = 1;
				break;
				case "sfx_shotgun_load":
				output = 1;
				break;	
				case "sfx_rock_break_low":
					output = 0.15;
				break;				
				case "sfx_rock_break":
				output = 1;
				break;
				case "sfx_item_get":
				output = 1;
				break;		
				case "sfx_rock_hit":
				output = 1;
				break;				
				case "sfx_not_enough_bombs":
				output = .4;
				break;		
				case "sfx_rare_item":
				output = 1;
				break;	
			#endregion
	
	#region FOOTSTEPS
			case aud.foot_gravel:
					output = random_range(0.005, 0.1);
			break;		
			case aud.foot_bush:
					output = 0.3;
			break;	
			case aud.foot_grass:
				output = 0.04;
				break;			
			case aud.foot_dirt:
				output = 0.05 + random_range(-.01,.01);
				break;
			case aud.foot_wood:
				output = 0.22;
				break;
			case aud.foot_sand:
				output = 0.04;
				break;
				
			case aud.foot_cloud:
						output = 0.04;
			break;
	#endregion
	#region gun shots		
		case "sfx_shoot_ddr":
			output = random_range(.2,.3);
		break;	
		case "sfx_gun_sniper_fire":
			output = random_range(.2,.3);
			break;	
		case "sfx_gun_default_fire":
		
			output = 0;
			if socket[slot] = ISAAC || socket[slot] = DEFAULT {
				if instance_exists(o_combo_parent) and o_combo_parent.combo >= 6{
					output = .2;//random_range(.05,.09);
				}else{
					output = random_range(1.1,1.3);	
				}
			}else{
					output = random_range(1.2,1.3);
			}
		
			break;
		case "sfx_lightning_short":
			output = random_range(.8,1);
			break;
		case "sfx_gun_shotgun_fire":
			output = random_range(.6,.7);
			break;
	#endregion	
		case "sfx_orchestral_impact":
			output = 1;
			break;	
	
		case "sfx_spider_web_rubber_band":
			output = 1.0;
			break;
		case "sfx_mob_bird_chirp":
			output = 0.05;
			break;
		case "sfx_mob_bird_flap":
			output = 0.095;
		#region if made from bullets
			if object_index = o_stamina_meter{
				output = 0.35;
			}

		#endregion
			break;
		case "sfx_box_destroy":
			output = .15;
			break;
		case "sfx_bomb_explosion":
			output = .5;
			break;
		case "sfx_bomb_thunder":
			output = 1;
			break;
		case "sfx_bomb_fuse":
			output = 0.35;
			break;
		case "sfx_bomb_fuse_loop":
			output = 0.05;
			break;
		case "sfx_bomb_tick":
			output = 0.3*input_id.sound_tick_multiplier_volume;
			break;
		case "sfx_water_droplet":
			output = 0.1+input_id.sound_tick_multiplier_volume;
			break;			
		case "sfx_fire_loop":
			output = 0.6;
			break;
		case "sfx_fire_shoot":
			output = 0.65;
			break;
		case "sfx_dragon_shoot":
				output = 0.6;
		break;			
		case "sfx_combo":
			output = 0.15;
			break;
		case "sfx_sword_swing":
			output = 0.32;
			break;
		case "sfx_heart_last":
			output = 0.85;
			break;
		
	
		
	// LEGACY LEGACY
		case "sfx_bush_destroy":
			output = 0.25;
			break;
	// LEGACY LEGACY
		case "sfx_currency_add":
			output = 0.5;
			break;
	// LEGACY LEGACY
		case "a_high_blip":
			output = 0.6;
			break;
		case "a_error":
			output = 1;
			break;		
		// Throw Message, Exit Script
		default:
		{
			//output = 1;
			show_debug_message("[AUDIO PARSER VOLUME] Malformed input (" + string(input) + ") in audio_parser_volume script!");
			exit;
		}
	}

	return output;


}
