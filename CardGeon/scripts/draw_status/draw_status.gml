// Script assets have changed for v2.3.0 see
function draw_status(xx , yy, struct){ 
	if live_call() return live_result;

	//active_enemies = [];
	//active_enemies  = [new_enemy(e_enemies.babydragon) , new_enemy(e_enemies.babydragon) , new_enemy(e_enemies.babydragon)];
		yy +=  camera.height*0.2+yoffgame;	
	
	if struct = player { 
		yy += 	camera.height*0.05;
	}
	
	draw_set_halign(fa_center);
			
	var buff_list = struct.buff;
	var str = "";
	var struct_variable_names = variable_struct_get_names(buff_list);
	var move_x = 0;
	var next_line = 0;
	
	var w = 0;
	rows = 4;
	var amount = 10;
	var amount_of_active_buffs = 0;
	
	
	
			
	
	for (var i = 0; i < array_length(struct_variable_names); i++;){
		var variable_name = struct_variable_names[@ i];
//		var buff_struct =  buff_list[$ variable_name];
		var buff_struct = variable_struct_get(buff_list, variable_name);	
		var amount = buff_struct.amount;
				
//	offset_y = 0;
//	offset_x = 0;
	if buff_struct.created_timer <= buff_struct.created_time { 
		var change = 5;
		buff_struct.offset_y = easings(e_ease.easeoutback,change,-change,buff_struct.created_time,buff_struct.created_timer);
		buff_struct.created_timer++;
	}
		yy += buff_struct.offset_y;
//	created_time = SEC*.2; //transition period when it gets created
		
		if  amount != 0{
		
		if amount > 0 and (i mod rows) = 0 and amount_of_active_buffs >= rows{ 

			yy += 30;	
			xx -= move_x;	
			amount_of_active_buffs++;
		}
					var w = 31;	
					var x1 = xx+move_x-5;
					var y1 = yy;
					var x2 = x1+w;
					var y2 = yy+w+2;
					var text_color = c_white;
					var y_offset = 0;
					
					var text_y = y1 + 20;
					var get_amount = buff_struct.amount;
					
					
				
				switch buff_struct.sprite { 
						case s_status_crit_chance_up:
						
						get_amount = "+"+string(round( 100*( buff_struct.amount*player.token_stats[@ e_token.coco_bee].starting_amount+player.token_stats[@ e_token.coco_bee].output1())  ))+"%";
						break;
						case s_status_crit_damage_up:
						
						get_amount = "+"+string(round( 100*(buff_struct.amount*player.token_stats[@ e_token.coco_bat].starting_amount+player.token_stats[@ e_token.coco_bat].output1())  ))+"%";
						break;
				}
					
					
					var text_offset = 8;	
				
					var text_x = x1 + 25;
				//	draw_rectangle(x1,y1,x2,y2,1);
						var text_outline = c_black;
				var text_color = c_white;
			
					var bubble_color = C_YELLOW;
			
					if allow_player_input() and hovered_over_card = false and draw_status_information = false
					and boon_collision(x1,y1,x2,y2,MX,MY) || current_turn = e_current_turn.enemy_ and 
					 hovered_over_card = false
					and boon_collision(x1,y1,x2,y2,MX,MY)
					{
					y_offset += 1;
					
					bubble_color = C_LIME;
					buff_struct.hovered_over_status = true;
					
					text_color = c_white;
					
					var col = C_GUM;
				
					if buff_struct.good_or_bad = GOOD and get_amount > 0 and struct = player  { 
						col = C_LIME;	
					}
					
					draw_outline(s_ui_deck_circle	,0,	text_x+1+1,text_y-text_offset+7+1,1,1,0,C_DARK,1)	
					draw_outline(s_ui_deck_circle	,0,	text_x+1,text_y-text_offset+7,1,1,0,C_DARK,1)
					draw_sprite_ext(s_ui_deck_circle,0,	text_x+1,text_y-text_offset+7,1,1,0,col,1);
					
					draw_set_color(c_white);
					
					draw_text(text_x+2-2,text_y-text_offset,string(get_amount));
					draw_text(text_x+2+2,text_y-text_offset,string(get_amount));
					draw_text(text_x+2,text_y-text_offset+2,string(get_amount));
					draw_text(text_x+2,text_y-text_offset-2,string(get_amount));
	
					draw_text(text_x+2-2,text_y-text_offset+1,string(get_amount));
					draw_text(text_x+2+2,text_y-text_offset-1,string(get_amount));
					draw_text(text_x+2+1,text_y-text_offset+2,string(get_amount));
					draw_text(text_x+2-1,text_y-text_offset-2,string(get_amount));				
							
					draw_outline( buff_struct.sprite,0,xx+move_x,yy+1-1,1,1,0,c_white,1);
					draw_outline( buff_struct.sprite,0,xx+move_x,yy+1+1,1,1,0,c_white,1);
					draw_outline( buff_struct.sprite,0,xx+move_x+1,yy+1,1,1,0,c_white,1);
					draw_outline( buff_struct.sprite,0,xx+move_x-1,yy+1,1,1,0,c_white,1);
					draw_outline( buff_struct.sprite,0,xx+move_x,yy+1,1,1,0,c_black,1);
					draw_sprite(  buff_struct.sprite,0,xx+move_x,yy+1);
					
							var amount =	get_status_arg(struct, buff_struct);
							
							draw_status_information = "[";
							draw_status_information += sprite_get_name(buff_struct.sprite);
							draw_status_information += "] [c_yellow]"+buff_struct.title+"[]\n";
							draw_status_information += buff_struct.desc(amount);
							
							if buff_struct.lose_per_turn { 
							draw_status_information += "\nREMOVE [c_gum]1[] STACK AT THE END OF THE TURN";
							}
					}else{
						
						var col = C_GUM;
				
						if buff_struct.good_or_bad = GOOD and get_amount > 0 and struct = player  { 
							col = C_LIME;	
						}
						
						draw_outline(s_ui_deck_circle	,0,	text_x+1+1,text_y-text_offset+7+1,1,1,0,C_DARK,1)	
						draw_outline(s_ui_deck_circle	,0,	text_x+1,text_y-text_offset+7,1,1,0,C_DARK,1)
						draw_sprite_ext(s_ui_deck_circle,0,	text_x+1,text_y-text_offset+7,1,1,0,col,1);
					
	
						draw_outline( buff_struct.sprite,0,xx+move_x,yy,1,1,0,c_black,1);
						draw_sprite(buff_struct.sprite,0,xx+move_x,yy);
													
						if buff_struct.created_timer <= buff_struct.created_time*.3 { 
								draw_outline_thick(buff_struct.sprite,0,xx+move_x,yy,1,1,0,c_white,1);
									draw_outline( buff_struct.sprite,0,xx+move_x,yy,1,1,0,C_DARK,1);
									shader_set(sh_fill_with_image_blend);
									draw_sprite_ext( buff_struct.sprite,0,xx+move_x,yy,1,1,0,c_white,1);
									shader_reset();
										var text_outline = c_white;
										var text_color = c_white;		
							}

					}		
						
					if !buff_struct.played_init_animation { 
						buff_struct.played_init_animation = true;
						audio_stop_sound(sfx_record_scratch);
						//audio_stop_sound(sfx_add_new_status_enemy);
						
						//audio_play(sfx_add_new_status_enemy );
						audio_play(	sfx_record_scratch );
						var image_speed_ = 2;
						create_animation_effect(s_summon_status,xx+move_x+5,yy+8,image_speed_,1,90-10,c_yellow,1);
						create_animation_effect(s_summon_status,xx+move_x+5,yy+8,image_speed_,1,0,c_yellow,1);
						create_animation_effect(s_hit_flash,xx+move_x+5,yy+8,image_speed_,1,0,c_yellow,1);
					}

					if buff_struct.hovered_over_status = false { 
						particle_bubble(xx+move_x+sprite_get_width(buff_struct.sprite)*.5,text_y-text_offset-5,20,bubble_color,false,false,false,random_range(15,25),random_range(-.2,-.5))
					}
					
					if struct.check_for_buff != amount_of_active_buffs { 
							struct.check_for_buff = amount_of_active_buffs
							particle_explode(xx+move_x+sprite_get_width(buff_struct.sprite)*.5,text_y-text_offset,15,c_yellow,false, SEC*.7, false);
					}
					
			
	
				
				draw_text_outline(text_x+2,text_y-text_offset,string(get_amount), text_outline)
				draw_set_color(text_color);
				draw_text(text_x+2,text_y-text_offset,string(get_amount));
				draw_set_color(c_white);
				draw_set_halign(fa_left)
				move_x += 32;
				}
		}
		if amount_of_active_buffs = 0 { 
			struct.check_for_buff = amount_of_active_buffs;
		}
}