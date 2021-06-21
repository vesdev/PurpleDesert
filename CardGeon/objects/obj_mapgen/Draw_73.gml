/// @description Insert description here

	
var scr = noone;

switch standing_on.type{ 
	case e_room_type.chest_small_room:
		//open the chest
		var scr = scribble("[fa_center]OPEN CHEST");
	break;
	case e_room_type.key_room:
		//open the chest
		var scr = scribble("[fa_center]GET KEY");
	break;
	case e_room_type.chest_golden_room:
		//open the chest
		if player.golden_keys = 0 { 
			var str = "REQUIRES [s_map_key,0,0]";
		}else{
				str = "OPEN WITH [s_map_key,0,0]";
		}
		var scr = scribble("[fa_center][fa_top]"+str);
	break;	
	case e_room_type.rest_site:
		//open the chest
		var scr = scribble("[fa_center]REST AREA");
	break;	
	case e_room_type.shop_room_cards:
		//open the chest
		var scr = scribble("[fa_center]CARD SHOP");
	break;	
	case e_room_type.shop_room_tokens:
		//open the chest
		var scr = scribble("[fa_center]TOKEN SHOP");
	break;	
	case e_room_type.shop_room_stuff:
		//open the chest
		var scr = scribble("[fa_center]STUFF SHOP");
	break;			
	case e_room_type.shop_room_potions:
		//open the chest
		var scr = scribble("[fa_center]POTION SHOP");
	break;			
	case e_room_type.shop_room_removal:
		//open the chest
	if not_enough_money_for_card_remove_timer <= 0 { 
		var scr = scribble("[fa_center]REMOVE A CARD [s_icon_gold, 1, 0] [c_yellow]-"+string(player.card_removal_price));
	}else{
		scr = scribble("[fa_center][shake][c_gum]NOT ENOUGH[] [s_icon_gold, 1, 0]");
	}
	break;		
	default:
	break;
}

	not_enough_money_for_card_remove_timer--;	
			
		if scr != noone { 	
			var w = scr.get_width();
			var xsize = w*.7;
			var ysize = 15;
			var yoffset = -70;
			var xoffset = -16;
			var y_off = 0;
			var x_off = 0;
			var xsize_mod = 1;
				
		if noti_timer <= noti_time { 
			y_off = easings(e_ease.easeoutexpo,-yoffset*.5,yoffset*.5,noti_time,noti_timer);
			xsize_mod = easings(e_ease.easeoutelastic,.5,.5,noti_time,noti_timer);
			noti_timer++;
		}
				xoffset += x_off;
				yoffset += y_off;
				xsize *= xsize_mod;
			if !enable_event {
				nine_slice(s_nine_slice_default_mapgen,standing_on.x-xsize+xoffset,standing_on.y-ysize+yoffset,standing_on.x+xsize+xoffset,standing_on.y+ysize+yoffset,1,c_white);
				draw_sprite(s_nine_slice_default_point,0,standing_on.x+xoffset,standing_on.y+ysize+yoffset-1);
				scr.draw(standing_on.x+xoffset,standing_on.y+yoffset-8);
			}
				var x1 =  standing_on.x1;
				var y1 = standing_on.y1;
				
				var w = standing_on.w;
				var h = standing_on.h;
		
				//draw_rectangle(draw_on_grid(x1),draw_on_grid(y1),draw_on_grid(x1+w),draw_on_grid(y1+h),1)
				if boon_collision(draw_on_grid(x1),draw_on_grid(y1),draw_on_grid(x1+w),draw_on_grid(y1+h),MX,MY ){ 

					if o_game.m1_pressed { 
						o_game.m1_pressed = false;
						//execute the code	
							switch standing_on.type{ 
							case e_room_type.key_room:
							
							
								player.golden_keys += 1;
								standing_on.type = e_room_type.empty_room;
								var this_room = ds_list_find_value(room_list, standing_on.i)				
								this_room.type = e_room_type.empty_room;
							break;
							case e_room_type.chest_golden_room:
							
									//open the chest
									if player.golden_keys > 0 { 
										enable_event = true;
										with o_game{ 
											var stuff_enum = get_next_stuff_gold_enum();
											other.event_struct = new overworld_chest(stuff_struct(stuff_enum), player.chest_reroll);
											
										}
								
										standing_on.type = e_room_type.empty_room;
										var this_room = ds_list_find_value(room_list, standing_on.i)				
										this_room.type = e_room_type.empty_room;
									}
							break;
							case e_room_type.chest_small_room:
									//open the chest
									enable_event = true;
									with o_game{ 
										var stuff_enum = get_next_stuff_enum();
										other.event_struct = new overworld_chest(stuff_struct(stuff_enum), player.chest_reroll);
									}
									standing_on.type = e_room_type.empty_room;
									var this_room = ds_list_find_value(room_list, standing_on.i)				
									this_room.type = e_room_type.empty_room;
							break;
							
						
							case e_room_type.rest_site:
									//open the chest
									enable_event = true;
									with o_game{ 
										other.event_struct = new overworld_rest_area();
										other.event_struct.type = e_event_type.rest_area;
									}
									selecting_card_upgrade = false;
									//standing_on.type = e_room_type.empty_room;
									//var this_room = ds_list_find_value(room_list, standing_on.i)				
									//this_room.type = e_room_type.empty_room;
							break;
							
							case e_room_type.shop_room_cards:
								audio_play(	sfx_enter_shop);
								audio_play(sfx_whoosh_2);
							
								//open the chest
									enable_event = true;
								o_game.shop_card_select.enable = false;
									other.event_struct = card_shop_struct;
									with o_game{ 
										other.event_struct.type = e_event_type.shop_card;
									}
								o_game.camera.zoom = 3;					
							break;	
							case e_room_type.shop_room_tokens:
								audio_play(	sfx_enter_shop);
								audio_play(sfx_whoosh_2);
								//open the chest
								enable_event = true;
								o_game.shop_card_select.enable = false;
									other.event_struct = card_shop_struct;
									with o_game{ 
										other.event_struct.type = e_event_type.shop_token;
									}
								o_game.shop_card_select.original_amount = noone;//sets this so the player cannot get an upgrade for free
								o_game.camera.zoom = 3;
							break;	
							case e_room_type.shop_room_stuff:
								audio_play(	sfx_enter_shop);
								//open the chest
								var scr = scribble("[fa_center]STUFF SHOP");
							break;			
							case e_room_type.shop_room_potions:
								audio_play(	sfx_enter_shop);
								//open the chest
								var scr = scribble("[fa_center]POTION SHOP");
							break;			
							case e_room_type.shop_room_removal:
								audio_play(	sfx_enter_shop);
							
							if player.gold < player.card_removal_price {
								
								not_enough_money_for_card_remove_timer = SEC*3;	
								
							}else{
								audio_play(sfx_whoosh_2);
								o_game.remove_card_select.enable = false;
							with o_game{ 
									other.event_struct = new overworld_event_parent();
									other.event_struct.type = e_event_type.shop_removal;
							}
								enable_event = true;
								o_game.camera.zoom = 3;
							}
							break;		
				}
			}
		}
	}
if o_game.game_state = e_gamestate.battle  || o_game.camera.x = 0 and o_game.camera.y = 0 exit;



if os_type == os_windows { 
	shader_set(sh_fog_heavy);
	shader_set_uniform_f(uResolution,1/room_width,1/room_height);	
	shader_set_uniform_f(uTime,current_time*.003);
	shader_set_uniform_f(uOpacity,.15);
	shader_set_uniform_f(cloudscale,5);	
	draw_sprite_ext(s_pixel,0,0, 
	0, room_width*1.5, 
	room_height*1.5, 0,c_white,1);
	shader_reset();
}