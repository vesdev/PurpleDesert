function  add_queue(script , struct,  time ) constructor{
	
	
self.timer = 0; //timer start
	
	if fast_mode { 
		self.time = time*.05;	//fast mode
	}else{
		self.time = time; //time to perform action
	}
		self.queue_script = script; // array, first the target, then the value is the script that is used, then all sequential values are the argumnents
		self.struct = struct; //which unit
}

function can_end_the_turn() { 
	



if current_turn = e_current_turn.enemy_ {  
	



//enemy step draw code
var queue = o_game.end_turn_queue;
var time = queue[| 0].time;
var timer = queue[| 0].timer;
var current_enemy = queue[| 0].struct;
var scr = queue[| 0].queue_script;


o_game.synth_wave.xtarget = current_enemy.x;

if scr != noone{ 
	
queue[| 0].queue_script(timer,time, current_enemy);

}else{
timer = 1;
time = 0;
}


if timer > time { 
	
	
//times up to do our action go to the next one
if queue[| 0].queue_script = show_attack_animation ||   queue[| 0].queue_script = show_added_card_animation{ 
	current_enemy.finished_attacking = true;	
	
	if current_enemy.attack_array[@ current_enemy.current_attack_queue].remove_on_use {				
				array_delete(current_enemy.attack_array,current_enemy.current_attack_queue,1);
	}
	
	//move to the next attack
	var len = array_length(current_enemy.attack_array)-1;
		current_enemy.current_attack_queue++;
	
	if current_enemy.current_attack_queue > len { 
			current_enemy.current_attack_queue = 0;
	}
	
}

ds_list_delete(end_turn_queue,0);

	if ds_list_empty(end_turn_queue){
		
		
		
		
		end_enemy_turn();
		hovered_over_card = 0;
		current_turn = e_current_turn.player_;
		

		exit;
	}
queue[| 0].timer = 0;
}

end_turn_queue[| 0].timer++;

 //allow player to end their turn
}else if current_turn = e_current_turn.player_ {   
	
	


	var scribble_end_turn = scribble("[fa_center]END TURN");
	var end_turn_x_position = -camera.width*xoffgame*0.00095;
	var end_turn_y_position = -camera.height*0.17; // gui_height-30  +yoffgame;
	scribble_end_turn.get_bbox();
	var end_turn_bbox = scribble_end_turn.get_bbox(0,0);

	var woffset = 25; //makes button bigger in the x position
	var hoffset = 20;  //makes button bigger in the y position
	var _left_enemy_collision = end_turn_bbox.x0+end_turn_x_position-woffset;
	var _top_enemy_collision =end_turn_bbox.y0+end_turn_y_position-hoffset;
	var _right_enemy_collision = end_turn_bbox.x3+end_turn_x_position+woffset;
	var _bot_enemy_collision = end_turn_bbox.y3+end_turn_y_position+hoffset;
	//see collision box
	//draw_rectangle(_left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,1);
var len = array_length(discover_queue.array );

	if len = 0 and allow_player_input() {
	
		if boon_collision(_left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,MX,MY) || force_end_turn{ 
	
					
					var warning = "";
					draw_status_information = "";
					
					if total_intent_enemy_damage > 0 { 
					draw_status_information  += "[c_yellow]WARNING[] AT THE END OF THE TURN YOU WILL TAKE [c_gum]"+string(total_intent_enemy_damage)+" [s_damage_icon] [] DAMAGE\nPUT ON [c_blue][s_ui_shield] ARMOR[] TO PROTECT YOURSELF\n\n";
					}
					
					
					if player.mana >= 10 { 
					draw_status_information += "[c_yellow]WARNING[] YOU HAVE [s_font_boon_sunset]"+string(player.mana)+"/"+string(player.mana_max)+" [][c_gum]UNSPENT[] [c_yellow][s_electricity_small][] ENERGY \n (PLAY CARDS TO USE ENERGY)\n\n";
					}
					
					
					var scribble_end_turn =  scribble("[fa_center][c_yellow]END TURN");
					draw_status_information += "YOU CAN ALSO [c_yellow]END YOUR TURN[] BY [s_m2_pressed] RIGHT CLICKING [c_lime]TWICE[]";
					
					scribble_end_turn.draw(end_turn_x_position,end_turn_y_position);
					if m1_pressed || force_end_turn {
							
										
				o_audio.sketch1.SetTrackGain(e_song_sketch.midsection_strings_without_fx,0,FADE_TIME);
				o_audio.sketch1.SetTrackGain(e_song_sketch.drums_without_fx				,0,FADE_TIME);

				o_audio.sketch1.SetTrackGain(e_song_sketch.midsection_strings_with_fx	,MAX_VOLUME,FADE_TIME);
				o_audio.sketch1.SetTrackGain(e_song_sketch.drums_with_fx				,MAX_VOLUME,FADE_TIME);
				o_audio.sketch1.SetTrackGain(e_song_sketch.sub_bass						,MAX_VOLUME,FADE_TIME);
				o_audio.sketch1.SetTrackGain(e_song_sketch.pad_highlights				,MAX_VOLUME,FADE_TIME);
	

						
							
							
						audio_play(sfx_open_portal);	
						audio_play(sfx_end_turn);
						
						with o_game.synth_wave {
							
						var enemy_ = active_enemies[@ 0];
						xtarget = enemy_.x;
						x_position = enemy_.x;
						xscale_target = 2;
						yscale_target = 2;
						
						}
						force_end_turn = false;
						game.combat.turns++;
						game.run.turns++;
						//destroy evaporated cards ASAP!
						
						var len = ds_list_size(hand);
						var card_index = 0;
						
						
						
						for (var i = 0; i < len; ++i) {
							var card_ = hand[| i];
							
							if has_card_keyword(card_, keywords.evaporate ){
								//destroy the card before it gets added to our hand!!!
								//and also add some cool ass smoke!!
							
								exhaust_effect(i);
							}
						}
						
						for (var i = 0; i < len; ++i) {
							var card_ = hand[| i];
							
							if has_card_keyword(card_, keywords.evaporate ){
								//destroy the card before it gets added to our hand!!!
								//and also add some cool ass smoke!!
								
								if card_.card_type != e_card_type.status and  card_.card_type != e_card_type.curse { 
								ds_list_add(exhaust,card_);
								}
								ds_list_delete(hand,i);	
								i--;
								len--;
							}
						}
						hand_size = ds_list_size(hand);
								
						hand_to_discard.enable = true;
						hand_to_discard.amount = ds_list_size(hand);
						hand_to_discard.timer = 0;
						hand_to_discard.reposition = noone;
						
						if fast_mode{ 
							hand_to_discard.time = SEC*.1;	
						}else{
							hand_to_discard.time = SEC*.5; 	
						}
						//end the turn 
						if hand_to_discard.amount = 0  {
						hand_to_discard.enable = false;
						player_turn_has_ended();	
						}
						
					}

		}else{
					if len = 0 and allow_player_input() { 
						scribble("[fa_center]END TURN");
						scribble_end_turn.draw(end_turn_x_position,end_turn_y_position);
					}
			}
		}
	}
}

function  player_turn_has_ended() {
	
	
		if player.buff.weak_poison.amount > 0 { 
			change_health(noone,player,player.buff.weak_poison.amount,true,false);
			player.buff.weak_poison.amount = 0;
		}
		
		if player.buff.poison.amount > 0 { 
			change_health(noone,player,player.buff.poison.amount,false,false);
		}
	
	
	hovered_over_card = false;
	current_turn = e_current_turn.enemy_;

	turn_phase  =  e_turn_phase.end_phase;	

	
	remove_struct_stacks(player);

	
	var len = ds_list_size(hand);	
	for (var i= 0; i < len;++i){ 
		// if the card has evaporate then remove it from the game
		if check_card_keywords(hand[| i], keywords.evaporate){ 
		ds_list_add(exhaust,hand[| i]);	
		}else{
			if !check_card_keywords(hand[| i], keywords.retain){ 
				ds_list_add(discard, hand[| i]);
			}
		}
	}
	//ds_list_clear(hand);
	//rule all of the player positive effects should be priorized up
	//all negative effects should be de-prioritized
	//check passives treasures
	//check player status effects
	//add our tokens into the queue and have them attack first
	//add enemies into the queue and have them attack
	enque_all_enemies();
	
}

function check_card_keywords(card_struct, keyword_to_check) { 
	
	var return_value = false;
		if card_struct.keywords != noone {
			if !is_array(card_struct.keywords) {
				if card_struct.keywords == keyword_to_check { 
					return true;		
				}
			}else{
				var len = array_length(card_struct.keywords);
				for (var i =0; i <len; ++i){ 
					if card_struct.keywords[@ i] == keyword_to_check {
							return true;	
					}
				}
			}	
	}else{
		return_value = false;
	}

	return return_value;
	
}

function enque_all_enemies() { 
		var queue_ = end_turn_queue;
		/*
			enemy attacks are broken down in three steps
			
			first step = Show the Player the intent, to show who is starting an attack
			second step = Show unit attacking/showing the buff animation//can be skipped
			end_step = resolve the effect (ex. deal -5 health to player, add a curse card,  +5 Enemy Strength)
		
		*/
		for (var i = 0; i < number_of_enemies; i++){ 
				var struct = active_enemies[@ i];
				
				var override = false;
				
				//skip the enemy within conditions arise
			
			if struct.buff.asleep.amount > 0 { 
				 override = true;
			}
			
			if !override { 
				#region
				
					#region remove armor
					
							if struct.cant_lose_armor_for_x_turns <= 0 {
								
								if struct.buff.armor_keep.amount = 0 { 
									remove_all_armor(struct);
								}
								}else{
									struct.cant_lose_armor_for_x_turns--;
								}
					
					
					#endregion
				
						if struct.attack_array[@ struct.current_attack_queue].type = e_intentions.attack { 
							//is it a normal hit or a multi_hit
							var damage_ = struct.attack_array[@ struct.current_attack_queue].amount;

							if is_array(damage_) {
									struct.attacks_remaining = damage_[@ 1];
							}
						}
						ds_list_add(queue_, new add_queue( show_intent_animation ,  struct, SEC*1));
						
						switch struct.attack_array[@ struct.current_attack_queue].type{ 
							case e_intentions.add_card: 
									ds_list_add(queue_, new add_queue( show_added_card_animation ,  struct, SEC*2)); //remember to re-add animations to line 44
							break;
						default:
									ds_list_add(queue_, new add_queue( show_attack_animation ,  struct, SEC*1));
						break;
						}
						
					
															
						struct.intention_x_offset = 0;
						struct.finished_attacking = false;
				#endregion 
			}else{ 
					ds_list_add(queue_, new add_queue( noone ,  struct, 0));			
					struct.finished_attacking = false;
			}
				
				//first step show WHO is attacking, make intent clear
		}
}

function  show_intent_animation(timer, time, struct) {
	
		//show warning to player
		var xoffset = 30;
		var yoffset = 20;
		
		var index = current_time*0.03;
		var size = 1;
		var angle_add = 0;
		
		//we have 2 timers, the first one 1 SEC
		
		

		
		
		
		if timer <= time { 
			if timer = 1 { 
				//audio_play(sfx_enemy_windup);	
				
			}
				var ease_ = e_ease.easeoutexpo;
				angle_add =	 easings(ease_,0,360*1.5,time,timer);
				xoffset =		 easings(ease_,0,30,time,timer);
				yoffset =		 easings(ease_,0,20,time,timer);
		}
		
		
		
	
		for (var i= 0; i <= 3; i++){ 
				   angle_add += 90 *i;
			var xlen = lengthdir_x(xoffset,angle_add);
				var ylen = lengthdir_y(yoffset, angle_add);
				draw_sprite_ext(s_caret,index,struct.x+xlen,struct.y-struct.intention_y_offset+ylen-10,-size,size,	 angle_add,	 c_white,1);
		}

}

function  show_added_card_animation(timer, time, struct)  {
	
		//show warning to player
		var timer1 = 0;
		var time1 = time*.5;
		
		var timer1 = 0;
		var time2 = time*.5;
		
		var attack_array = struct.attack_array[@ struct.current_attack_queue];
						
		var type			 = attack_array.type;
		var card_enum		 = attack_array.card_enum;
		
		//	current_turn = e_current_turn.player_;
		var xoffset = 30;
		var yoffset = 20;
		
		var xstart_ = 0;
		var ystart_ = 0;
		
		var xchange_ = -o_game.camera.width/2*0.80;
		var ychange_ = -o_game.camera.height/2*0.70;
		
		var angle_change = 0;
		
		var time_offset = time*.5;
		
		var time_xoffset = time*.5;
		
		var scale_time = time*.15;
		var card_scale = 0;
		
		
		if timer <= time { 
			
			
			
			if timer > time_offset {
				angle_change = easings(e_ease.easeinoutexpo,0,60,time_offset*.55+time*.05,timer-time_offset-time*.05);
			}else{
				angle_change = 0;	
			}
			
			if timer <= scale_time { 
				card_scale = easings(e_ease.easeoutback,.5,.5,scale_time,timer);
			}else{
				card_scale = 1;	
			}
			
			var end_scale_time = time*.75;
			
			if timer >= end_scale_time { 
				card_scale = easings(e_ease.easeinback,1,-1,time-end_scale_time,timer-end_scale_time);
			}	
			
			
			
			if timer >= time_offset{
				xstart_ = easings(e_ease.easeinoutexpo,xstart_,xchange_,time_offset,timer-time_offset);		
				ystart_ = easings(e_ease.easeinoutexpo,ystart_,ychange_,time_offset,timer-time_offset);	
			}
			struct.xscale = easings(e_ease.easeoutelastic,.5,.5,time,timer);
			struct.yscale = struct.xscale;
			
			var xoffset = easings(e_ease.easeoutelastic,20,10,time,timer);
			var yoffset = easings(e_ease.easeoutelastic,10,10,time,timer);
		}
		var card_struct_ = card_struct(card_enum);
		
		draw_card_matrix(card_struct_,xstart_,ystart_,card_scale,card_scale,angle_change,0,0);
		
		//draw_sprite(s_char_sleepy_idle,0,xstart_,ystart_);
		var index = current_time*0.03;
		var size = 1;
		var angle_add = 0;
		
		for (var i= 0; i <= 3; i++){ 
				 angle_add += 90 *i;
				var xlen = lengthdir_x(xoffset,angle_add);
				var ylen = lengthdir_y(yoffset, angle_add);
				xlen += struct.intention_x_offset ;
			
			
			
				draw_sprite_ext(s_caret,index,struct.x+xlen,struct.y-struct.intention_y_offset+ylen-10,-size,size,	 angle_add,	 c_white,1);
				draw_sprite_ext_outline( s_caret,index,struct.x+xlen,struct.y-struct.intention_y_offset+ylen-10,-size,size,	 angle_add,	 c_white,1);
				draw_sprite_ext_outline( s_caret,index,struct.x+xlen,struct.y-struct.intention_y_offset+ylen-10,-size,size,	 angle_add,	 C_PEACH,1);
		}
			

			
		if timer = time - time*.1{ 
			var current_attack = struct.attack_array[@ struct.current_attack_queue];	
			if !struct.finished_attacking{
				deck_flash_timer = 0;
				current_attack.main_script();
				//remove it from the array if we said to
			}
		}
}



function  show_attack_animation(timer, time, struct) {
		//show warning to player	
		
		var type = struct.attack_array[@ struct.current_attack_queue].type;

		
		var xoffset = 30;
		var yoffset = 20;
		
		if timer<= time { 
			
				if timer <= SEC*.15 { 
					
					struct.force_outline_color = C_GUM;
					struct.force_flash_color = c_white;
					
				}else{
					struct.force_outline_color = false;	
					struct.force_flash_color = false;
				}
				
				
				switch (type) { 
					case e_intentions.armor: 	
					case e_intentions.buff:
					case e_intentions.buff_armor:
					
					//case e_intentions.
					struct.xscale = easings(e_ease.easeoutelastic,.5,.5,time,timer);
					var xoffset = easings(e_ease.easeoutelastic,20,10,time,timer);
					var yoffset = easings(e_ease.easeoutelastic,10,10,time,timer);
					
					//struct.intention_change_amount = struct.intention_x_offset;
					//struct.xoffset = struct.intention_x_offset;
					
					struct.yscale = struct.xscale;
				break;
				default:
				var xoffset = easings(e_ease.easeoutelastic,20,10,time,timer);
				var yoffset = easings(e_ease.easeoutelastic,10,10,time,timer);
					
				struct.intention_change_amount = struct.intention_x_offset;
				struct.xoffset = easings(e_ease.easeoutelastic,25,-25,time,timer);
				}
		}
		
		var index = current_time*0.03;
		var size = 1;
		var angle_add = 0;
		
		for (var i= 0; i <= 3; i++){ 
				 angle_add += 90 *i;
				var xlen = lengthdir_x(xoffset,angle_add);
				var ylen = lengthdir_y(yoffset, angle_add);
				xlen += struct.intention_x_offset ;
			
				draw_sprite_ext(s_caret,index,struct.x+xlen,struct.y-struct.intention_y_offset+ylen-10,-size,size,	 angle_add,	 c_white,1);
				draw_sprite_ext_outline(s_caret,index,struct.x+xlen,struct.y-struct.intention_y_offset+ylen-10,-size,size,	 angle_add,	 c_white,1);
				draw_sprite_ext_outline( s_caret,index,struct.x+xlen,struct.y-struct.intention_y_offset+ylen-10,-size,size,	 angle_add,	 C_PEACH,1);
		}
		show_enemy_outcome(timer,time,struct);
	//	struct.intention_y_offset = 25;
}



function show_enemy_outcome(timer, time, struct) {

	var script_ = struct.attack_array[@ struct.current_attack_queue].script_;
	var attack_queue = struct.attack_array[@ struct.current_attack_queue];
	var type = struct.attack_array[@ struct.current_attack_queue].type;





		switch (type) { 
			case e_intentions.attack: 			
												//is it a normal hit or a multi_hit
							var damage_ = struct.attack_array[@ struct.current_attack_queue].amount;

							if is_array(damage_) {
									damage_ = damage_[@ 0];
									if struct.attacks_remaining > 0 and timer >= time*.15 { 							
										struct.attacks_remaining--;
										enemy_damage( struct , player,damage_);
										o_game.end_turn_queue[| 0].timer = 0;
										//e = 0 ;	
									}else{
										//struct.finished_attacking = true;	
									}
								
							}else{ 
							if !struct.finished_attacking and timer = round(time * .25){
									
								
								enemy_damage( struct , player,damage_);
								//struct.attack_array[@ struct.current_attack_queue].main_script(damage_);
							}
						}
						
						
					
			break;
		 default:
	
				//we need to figure out which script we are on
				var current_attack = struct.attack_array[@ struct.current_attack_queue];
			
					if !struct.finished_attacking and timer = round(time * .25){
						current_attack.main_script();
						
								//remove it from the array if we said to
					}
		break;
		}
		//	self.current_attack_queue++; if this is at the max then set it back to 0
		//	struct.intention_y_offset = 25;
}


