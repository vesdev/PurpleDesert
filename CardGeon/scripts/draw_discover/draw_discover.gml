// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_discover(){	
	
	var selected_card_struct = noone;
	if no_discover_effects() exit;
	
	if array_length(discover_queue.array) > 0 { 
	var len = array_length(discover_queue.array[@ 0]);
	
	init_card_border_step(len);
	hovered_over_card = false
			for (var i = 0; i < len; ++i){ 
		
			var struct_ = discover_queue.array[@ 0][@ i];	
			var desc = struct_.desc();	
		
			var cost = struct_.cost;

			var w = 150;
			var spacing_ = 5;
			
			
			var total_width = (len-1) * w;
			var width_ = i*w;
			var xx =  width_ -w/2-total_width*.5 ;
			
			
			var yy = 90 +yoffgame;
			var h = 240;
			var y_bot_cutoff = -10;
			
			
			
			
		
	if !discover_queue.hide { 		
			
		//draw keywords


	var ww = sprite_get_width(s_card_border);
	
			card_distance = camera.width*.18;
			var cost = noone;
			var total_dis = len * card_distance;
			var center_ = 0;
			var diff = total_dis - center_;
			var i_add = (i *card_distance) - total_dis/2;
			var targetx_ =  center_ + i_add;

			var draw_card_matrix_struct =  draw_card_matrix_selectable(struct_, targetx_+ww*.2,0,1,1,0,0,0,i,false,0,true,true,true);
			
				if draw_card_matrix_struct != noone and draw_card_matrix_struct.struct != noone { 					
					selected_card_struct = 	draw_card_matrix_struct;	
				}
		
			if is_hovering_over_card != noone{ 
					if m1_release { 	
						boon_randomize()
						var enum_  = struct_.enum_;	
						//add it
						switch discover_queue.type { 
							case e_discover.add_for_combat: 
										
										//discover_queue.type = e_discover.add_for_run;
										audio_play(sfx_draw_card_1);
										add_card_to(discover_queue.place_to_add, enum_, false);
										ds_list_shuffle(discover_queue.place_to_add	)
										
							break;
							case e_discover.add_for_run:
								
							
										audio_play(sfx_draw_card_1);
										add_card_to(deck, enum_, true);
										ds_list_shuffle(card_spoils);
											
									if discover_queue.type = e_discover.add_for_run  {
										var len = array_length(hand_over_rewards_array);
										for (var i= 0; i< len ;i ++){ 
												var struct_ = hand_over_rewards_array[@ i];
														if struct_.type = e_spoil_type.choose_card { 
														array_delete(hand_over_rewards_array,i,1);
														i--;
														len--;
													}
														//type = e_spoil_type.gold;	
			
											}
										}
							break;				
							case e_discover.play_token:
										add_token( enum_);
										ds_list_shuffle(all_token_list)
							break;
							
							case e_discover.or_condition_for_card:
							card_script_or_array_add_to_queue(struct_.script_);
							break;
						}
						array_delete(discover_queue.array,0,1);
						m1_release = false;
						exit;
					}
				}
				draw_set_color(c_white);
		 }
				var cost_color = "[c_lime]";
				if cost > player.mana { 
					cost_color = "[c_gum]";	
				}
				//Hide Button
				
					
				var hx = camera.width*.125 +xoffgame;
				var hy = camera.height*.35-camera.height*.05*.5+4;
				var hw = 55;
				var hh = 25;
				var border_col = c_white;
				if boon_collision(hx-hw,hy-hh*.5,hx+hw,hy+hh ,MX,MY)   { 				 
					 border_col = C_LIME;
							 if m1_release { 
								 m1_release = false;
								 if discover_queue.hide { 
									 discover_queue.hide = false;
								 }else{
									  discover_queue.hide = true;
								 }
						 }
				}
		
				draw_set_color(merge_color(C_PURPLE,C_DARK,.5));
				//draw_rectangle(hx-hw,hy-hh*.5,hx+hw,hy+hh ,1 );
				nine_slice( s_nine_slice_hp, hx-hw,hy-hh*.5,hx+hw,hy+hh,1,C_DARK);
				nine_slice( s_nine_slice_hp_border, hx-hw,hy-hh*.5,hx+hw,hy+hh,1,border_col);
			
			
				var str = "HIDE";		
				if  discover_queue.hide { 
					str = "UN-HIDE";
				}
					scribble("[c_yellow][fa_center]"+str).draw(hx,hy);
			if  !discover_queue.hide { 
				
					if number_of_enemies != 0 { 
					scribble("[c_yellow][fa_center][wave]CHOOSE").draw(0,-camera.height*.4);
					}
				if discover_queue.type != e_discover.play_token{ 
			//		desc += "\n\nCOST "+cost_color+string(cost)+"[]/"+string(player.mana_max);
				}else{
			//		desc = short_token_desc(struct_);	
				}
			//	scribble("[c_yellow][fa_center]"+text+"[]\n"+desc).wrap(w*.9).draw(xx+w*.5,yy+90);	
			}
				draw_set_color(c_white);
			}



	if !discover_queue.hide and discover_queue.type = e_discover.add_for_run{ 	
				var w_ = camera.width*.1;
				
				var h_ = camera.height*.05;
				var y_ =camera.height*.35; 
				var border_col = c_white;
				
				if boon_collision( -w_,y_-h_,w_,y_+h_,MX,MY) {
					 border_col = C_LIME;
					 if m1_pressed { 
						audio_play(sfx_grab_a_card);
						discover_queue.array = [];
						
					 }
				}
				
				nine_slice( s_nine_slice_hp, -w_,y_-h_,w_,y_+h_,1,C_DARK);
				nine_slice( s_nine_slice_hp_border, -w_,y_-h_,w_,y_+h_,1,border_col);
				
				draw_set_halign(fa_center)
				draw_set_color(c_white);
				
				draw_text(0,y_-h_*.5+4,"SKIP");
				draw_set_halign(fa_left)
				draw_set_color(c_white);
	}


}

	if  is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
		draw_card_matrix_selectable(is_hovering_over_card, save_hovered_x_position,0, 2,2,0, 0, 0 ,  save_hovered_i,true,0,true,true,true);
	}

}