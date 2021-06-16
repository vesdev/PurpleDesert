/// @desc Audio Parser for Pitch, returns pitch from preset range (See script for a list of all ranges)
function audio_parser_pitch(input,input_id) {
	
//	live_name = "audio_parser_pitch";
//	if live_call(input,input_id) return live_result;

	// @arg index
	// This script takes the name of a sound file WITHOUT the numbered suffix.
	// Example: "sfx_footstep_wood_<number>" becomes just "sfx_footstep_wood"

	// It then returns a given pitch from a preset list of ranges.
	// This script is meant for randomization inside other audio play scripts, not for direct usage.
	// ~WangleLine

	var output;
	
	output = 1;
	switch(input)
	{
		case aud.bw_dragon_warn:
			output =  1;
		break;
		case aud.bw_antlion_warn:
			output =  1;
		break;
		
		case aud.pixel_explosion:
			output = 1;
		break;
		case aud.player_hurt:
		
				output = 1;
		break;
		case aud.enemy_death_default:
				output = random_range(.9,1.1);
		break;		
		case aud.snowball_impact:
			output = 1 + random_range(-.1,.1);
		break;			
		
		#region bosses
			case aud.punch_light_jab:
					output = 1 + random_range(-.01,.01);
			break;
			case aud.kick_heavy_impact:
				output = 1 + random_range(-.01,.01);
			break;
			case aud.enemy_boss_cloak_ball_death:
				output = 1;
			break;
			case aud.enemy_bear_death:
				output =  1;
			break; 				
			case aud.enemy_bear_warn:
				output = 1;
			break;
			case aud.weapon_init_default:
				output = 1 + random_range(-.2,.2);
			break;
			case aud.enemy_boss_foxlion_chase:
					output =  1 ;
			break;
		
		#endregion
		
#region new
			case aud.weapon_swap:
				output =  1;
			break;	
			case aud.whip:
				output =  1 ;
			break;
			case aud.enemy_vortex_death:
				output = 1 + random_range(-.1,.1);
			break;
			case aud.enemy_bee_death:
				output =  1;
			break;
			case aud.enemy_beetle_warn:
				output =  1 + random_range(-.1,.1);
			break;
			case aud.bullet_fire_deflect:
				output = 1 + random_range(-.1,.1);
			break;
	#region FOOTSTEPS
			case aud.get_xp:
				output = .9 + (.12 * (global.xp / global.max_xp));
			break;
			case aud.foot_cloud:
					output = random_range(1,1.2) + 0;
			break;
				case aud.foot_gravel:
				output = random_range(0.92,1.15);
			break;	
			case aud.foot_bush:
				output = random_range(0.92,1.15) + 0;
				break;
			case aud.foot_grass:
				output = random_range(0.92,1.15) + 0;
				break;
			case aud.foot_dirt:
				output = random_range(0.92,1.1) + 0;
				break;
			case aud.foot_wood:
				output = random_range(0.92,1.1) + 0;
				break;
			case aud.foot_sand:
				output = random_range(1,1.2) + 0;
				break;
	#endregion
			case aud.bush_cut:
			output = 1 + random_range(-.01,.01);
			break;	
			case aud.hitmarker_tap:
				output = 1 + random_range(-.01,.01);
			break;
			case aud.coin_spawn:
				output = 1 + random_range(-.01,.01);
			break;
			case aud.coin_pickup:
				output = 1 + random_range(-.01,.01);
			break;
			case aud.punch_light:
			output = 1;
			break;					
			case aud.bullet_flesh_hit:
				output = 1 + random_range(-.1,.1);
			break;
			case aud.bullet_flesh_kill:
				output = 1 + random_range(-.1,.1);
			break;
			case aud.whoosh_low:
					output = 1 + random_range(-.1,.1);
			break;
			case aud.bullet_wall_hit:
				output = random_range(.9,1.1);
			break;				
			case "sfx_enemy_porcupine_scream":
				output = 1;
			break;

			case "sfx_don_jon_speak":
					output = 1 + random_range(-.1,.1);
			break;
			case "sfx_bar_fill_up":
				output = .9 + (.5 * (pr_xp / pr_xp_max));
			break;
				case "sfx_number_goes_up":
					output = 1;
					with o_death_background{
						output = .9 + xp_output/1000;
						output = clamp(output,0,1.5);
					}
				break;
				case "sfx_death_gain_level":
					output = 1;
				break;		
				case "sfx_death_next_state":
					output = 1;
				
					with o_death_background{
						output = .9 + (xp_output_state * .05);
					}
			
				break;	
				case "sfx_death_xp_gain":
					output = .9 + (.2 * (pr_xp / pr_xp_max));
				break;
				case "sfx_crit_bullet":
					output = 1;
				break;
				case "sfx_bat_warning":
					output = 1;
				break;
				case "sfx_upgrade_spawn":
					output = 1;
				break;
				case "sfx_rock_break_low":
					output = .7;
				break;	

				case "sfx_get_heart":
					output = 1;
				break;
				case "sfx_crit":
					output = random_range(.9,1.1);
				break;
				case "sfx_bear_warn":
					output = random_range(1.2,1.3);
				break;
	
				case "sfx_dragon_warn":
					output = random_range(.6,.7);
				break;

				case "sfx_boss_bass_hitmarker":
					output = random_range(.9,1.1);
				break;
				case "sfx_apple_spawn":
					output = 1;
				break;
				case "sfx_xp_create":
					output = random_range(1.9,2.1);
				break;
				case "sfx_enemy_rip":
					output = random_range(.9,1.1);
				break;
				case "sfx_anvil":
					output = 1;
				break;
				case "sfx_explosion_dynamic":
					output = 1;
				break;
				case "sfx_ui_speak":
				output = random_range(.8,1.2);
				break;	
				case "sfx_speak":
				output = random_range(.9,1.5);
				break;
				case "sfx_stamina_appear":
				output = random_range(.9,1.1) *1.9;
				break;
				case "sfx_bomb_beep":
				output = random_range(.9,1.1) * 2.;
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
				output = 1;
				break;		
				case "sfx_rare_item":
				output = 1;
				break;	

#endregion
	

	#region gun shots
		case "sfx_shoot_ddr":
			output = random_range(.7,1.1) + 0;
		break;
	
		case "sfx_gun_sniper_fire":
			output = random_range(1,1) + 0;
			break;	
		case "sfx_gun_default_fire":
			output = random_range(1,1) + 0;
			break;
		case "sfx_lightning_short":
			output = random_range(1,1) + 0;
			break;
		case "sfx_gun_shotgun_fire":
			output = random_range(1,1) + 0;
			break;
	#endregion
		case aud.hitmarker_beer:
		
			if object_is_ancestor(object_index,o_enemy_parent){
				var mod_ =  1 - (health_/max_health_);
			
			
				output = 1;
			}else{
				output = 1;
			}
			break;
		case "sfx_orchestral_impact":
			output = 1;
			break;
		case "sfx_spider_web_rubber_band":
			output = random_range(.99,1.01);
			break;
		case "sfx_mob_bird_chirp":
			output = random_range(0.7,1) + 0;
			break;
		case "sfx_mob_bird_flap":
			output = random_range(1.05,1.55) + 0;
			break;
		case "sfx_box_destroy":
			output = random_range(0.92,1.1) + 0;
			break;
		case "sfx_bomb_explosion":
			output = random_range(0.9,1.1) + 0;
			break;
		case "sfx_bomb_thunder":
			output = random_range(0.85,1.1) + 0;
			break;
		case "sfx_bomb_fuse":
			output = random_range(0.95,1.15) + 0;
			break;
		case "sfx_bomb_fuse_loop":
			output = random_range(0.95,1.15) + 0;
			break;	
		case "sfx_bomb_tick":
			output = 0.3+input_id.sound_tick_additional_pitch;
			break;
		case "sfx_water_droplet":
			output = 1+input_id.sound_tick_additional_pitch;
			break;		
		case "sfx_fire_loop":
			output = random_range(0.9,1.2) + 0;
			break;
		case "sfx_fire_shoot":
			output = random_range(0.8,1.2) + 0;
			break;
		case "sfx_dragon_shoot":
				output = random_range(0.8,1.2) + 0;
		break;		
		case "sfx_combo":
			output = 1;
			break;
		case "sfx_sword_swing":
			output = random_range(0.85,1.05) + 0;
			break;
		case "sfx_heart_last":
			output = 1;
			break;
	
	// LEGACY, NEED REPLACEMENT
		case "sfx_bush_destroy":
			output = random_range(0.95,1.2) + 0;
			break;
	// LEGACY, NEED REPLACEMENT
		case "sfx_currency_add":
			output = 1+o_audio.coin_additional_pitch;
			break
	// LEGACY, NEED REPLACEMENT
		case "a_high_blip":
			output = random_range(0.99,1.01) + 0;
			break;	
		case "a_error":
			output = random_range(0.99,1.01) + 0;
			break;		
	
		// Throw Message, Exit Script
		default:
		{
			//output = 1;
			show_debug_message("[AUDIO PARSER PITCH] Malformed input (" + string(input) + ") in audio_parser_pitch script!");
			exit;
		}
	}

	return output;


}
