// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_enemies(){

if !no_discover_effects() and !discover_queue.hide {
	exit;
}

	if !audio_is_playing(sfx_fire_grass){ 
		//audio_play_sound(sfx_fire_grass,0,1);
		
		audio_sound_gain(sfx_fire_grass,0,0);
	}


var default_fade = 100;
var maximum_sound_volume = .8;

if !m1_check {
	audio_sound_gain(sfx_fire_grass,0,default_fade);
}

//var lenx = lengthdir_x(1000,held.dir);
//var leny = lengthdir_y(1000,held.dir);

total_intent_enemy_damage = 0;
var targeting_specific_enemy = false;
var is_single_target = false;
//active_enemies = [];
//active_enemies = [new_enemy(e_enemies.fat_tony),new_enemy(e_enemies.fat_tony),new_enemy(e_enemies.fat_tony)];
hovering_over_a_target = false;
var check_if_you_are_currently_holding_a_card = false; //only for single target cards
	//DRAW ENEMIES
var len = number_of_enemies;

	for (var i = 0; i < len;i++){ 
		var enemy_ = active_enemies[@ i];
		var enemy_string = scribble("[fa_center]"+enemy_.title);
		var enemy_bbox = enemy_string.get_bbox(0,0);
		var enemy_width = 70;//;enemy_string.get_width();
		 get_enemy_damage(enemy_);
		//run step event for enemies if we specify it
		if enemy_.step_event != noone {
			enemy_.step_event();
		}
		var dis_ = 140;
		
		var total_dis = len * dis_;
		var center_ = 0;
		var diff = total_dis - center_;
		var i_add = (i *dis_) - total_dis/2;
		var targetx_ =  center_ - i_add;
	//	draw_sprite(s_char_hit_coco,0,targetx_ , 300);
		
		active_enemies[@ i].x = lerp(active_enemies[@ i].x, targetx_,.08);
		active_enemies[@ i].y = o_game.camera.height*.23;
		
		var enemyx = enemy_.x ;
		var enemyy = enemy_.y + yoffgame;
		if enemy_.enable_death { 
			enemy_.enable_death_timer--;
			if enemy_.enable_death_timer <= 0 { 		
				enemy_has_died(i);
				if number_of_enemies = 1 { 
					all_enemies_have_died();
				}
				exit;
			}
		}
		draw_status(enemyx-40,enemyy-23-yoffgame,active_enemies[@ i]);

		var potential_damage = 0;

		//show target type  
		//	draw_line(selected_card_x,selected_card_y, MX,MY);


		var _left_enemy_collision = enemyx-43;
		var _top_enemy_collision = enemy_bbox.y0+enemyy-35;
		var _right_enemy_collision = enemyx+70;
		var _bot_enemy_collision = enemy_bbox.y0+enemyy+45;
		//	draw_rectangle(_left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,1);
												
		
		var intention_offset = 30;
		
		///DRAW ENEMY INTENTION AND HANDLE COLLISION
		//draw_rectangle(_left_enemy_collision,_top_enemy_collision-intention_offset,_right_enemy_collision,_bot_enemy_collision-1,1);
		//check if our mouse is holding M1 and hovering over an enemy
		 draw_struct(enemy_, enemyx, enemyy+10);
				if hovering_over_enemy_intent > 0 { 
					enemy_.force_outline_color = false;	
				}
		if allow_player_input() and current_turn = e_current_turn.player_ and hovered_over_card = false and boon_collision(_left_enemy_collision,_top_enemy_collision-intention_offset,_right_enemy_collision,_bot_enemy_collision-1,MX,MY) { 			
				draw_enemy_intention(enemyx,enemyy,  enemy_,false);	
				hovering_over_enemy_intent = SEC*.1;
				enemy_.force_outline_color = c_white;
		}else if !hovering_over_enemy_intent {
				
				draw_enemy_intention(enemyx,enemyy,  enemy_,true);
		}

//draw_rectangle(_left_enemy_collision,_top_enemy_collision-intention_offset,_right_enemy_collision,_bot_enemy_collision-1,1);				
				
				enemy_.selected_by_card.enable = false; 
				player.selected_by_card.enable = false; //gets disabled every step 
				
//		enemy_string.draw(enemyx-5,enemyy);



	if hand_size > 0 &&  hovered_over_card and no_discover_effects(){ 
			if player.mana >= hand[| hand_hover_array].cost {			
					//We are holding a card and have to decide what target it is going ot affect
					switch get_target_type(hand[| hand_hover_array]) { 
						
						case e_target.single:		//this card is a single target card																					
											//check if our mouse is holding M1 and hovering over an enemy
											is_single_target = true;
											
											var return_ = false;
									
									
											if held.enable and held.last_dir < 180 and boon_collision_line(_left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,held.finalx0,held.finaly0, held.finalx1,held.finaly1) {   //  boon_collision(_left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,MX,MY)  {
												
												
											}
											
											
											if array_length( active_enemies ) = 1 { 
												if      held.enable and held.last_dir < 180 and held.last_dir > 0 {
													return_ = true;
												}
										}else if array_length( active_enemies ) > 1 { 
													
													var amount = 20
													
													
													//
													
													if held.enable and held.targeting_enemy_i = i { 
														
															if held.last_dir < 180 {
															return_ = true;	
														}
													}
											
										}
											
										if  return_ ||  boon_collision(_left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,MX,MY)  { 
												//we are currently selecting an enemy with a card
												
												audio_sound_gain(sfx_fire_grass,maximum_sound_volume,default_fade);
												potential_damage = get_card_damage(hand[| hand_hover_array] );
												
												
												potential_damage = check_damage(player,active_enemies[@ i], potential_damage);
												//
												//	get_card_damage(hand[| hand_hover_array]);
												
												
												if array_length(active_enemies) > 1 {
													targeting_specific_enemy = true;
												}
												
												attack_target = [i];	
												if !played_card_hover_sound and array_length(active_enemies) = 1{ 
													played_card_hover_sound = true;
													audio_play(sfx_light_card);
												}
												hovering_over_a_target = true;
												check_if_you_are_currently_holding_a_card = true;
												draw_set_color(C_LIME);
												enemy_.force_outline_color = C_LIME;
												enemy_.selected_by_card.enable = true;
											//	draw_rectangle(_left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,1);
												var col = C_LIME;
											//	nine_slice_anim(s_nine_slice_caret,  current_time*0.02,   _left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,1,col);
												draw_set_color(c_white);
											}else{		
												
												if array_length(active_enemies) = 1{ 
													played_card_hover_sound = false;
												}
												//audio_sound_gain(sfx_fire_grass,0,default_fade);
												//we are currently NOT selecting an enemy with a card
												var col = C_YELLOW;
											//	nine_slice_anim(s_nine_slice_caret,  current_time*0.02,   _left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,1,col);
												enemy_.force_outline_color = C_YELLOW;
									
												//draw_rectangle(_left_enemy_collision,_top_enemy_collision,_right_enemy_collision,_bot_enemy_collision,1);
												draw_set_color(c_white);
										}
										
										if m1_release{
											enemy_.force_outline_color = false
											if i  = number_of_enemies-1 and check_if_you_are_currently_holding_a_card = false {
													hovered_over_card = false;			
											}
										}
								break;
							case e_target.all_enemies:
							
								//we are using a card that will affect the player
										var _l = -camera.width/2;
										var _t = 5+yoffgame;
										var _r = room_width-5;
										var _b = -camera.height*0.1;
										
										if held.enable and held.last_dir < 180 and held.last_dir > 0 {
											
											if !played_card_hover_sound { 
												played_card_hover_sound = true;
												audio_play(sfx_light_card);
											}
											
											audio_sound_gain(sfx_fire_grass,maximum_sound_volume,default_fade);
											hovering_over_a_target = true;
											//the card is ready to affect the player
											draw_set_color(C_LIME);
											//draw_rectangle(_l,_t,_r,_b,1);
											draw_set_color(c_white);
											enemy_.force_outline_color = C_LIME;
											enemy_.selected_by_card.enable = true;
											enemy_.selected_by_card.color = C_YELLOW;
											
											
										}else{
											played_card_hover_sound = false;
											audio_sound_gain(sfx_fire_grass,0,default_fade);
											//the card will NOT affect the player
											draw_set_color(C_YELLOW);
										//	draw_rectangle(_l,_t,_r,_b,1);
											draw_set_color(c_white);
											enemy_.force_outline_color = C_YELLOW;
													//we have put the card down
												if m1_release { 
													hovered_over_card = false;		
												}
										}
										if m1_release { 
												enemy_.force_outline_color = false;
										}							
							
							break;
							case e_target.none:
							case e_target.player:
								
								
							
								
								//we are using a card that will affect the player
										var _l = -camera.width/2;
										var _t = 5+yoffgame;
										var _r = camera.width/2;
										var _b = -camera.height*0.1;
										
						//			draw_line(held.finalx0,held.finaly0,held.finalx1,held.finaly1);
//boon_collision(_l,_t,_r,_b,MX,MY)  || 
				
										if held.enable and held.last_dir < 180 and held.last_dir > 0 {// boon_collision_line(_l,_t,_r,_b,held.finalx0,held.finaly0, held.finalx1,held.finaly1) { 	
											
											if !played_card_hover_sound { 
												played_card_hover_sound = true;
												audio_play(sfx_light_card);
											}
											
											player.selected_by_card.enable = true;
											player.selected_by_card.color = C_LIME;
											hovering_over_a_target = true;
											//the card is ready to affect the player
											draw_set_color(C_LIME);
									//	draw_rectangle(_l,_t,_r,_b,1);
											draw_set_color(c_white);
											player.force_outline_color = C_LIME;
											audio_sound_gain(sfx_fire_grass,maximum_sound_volume,default_fade);
										}else{
											played_card_hover_sound = false;
											audio_sound_gain(sfx_fire_grass,0,default_fade);
											//the card will NOT affect the player
											draw_set_color(C_YELLOW);
									//		draw_rectangle(_l,_t,_r,_b,1);
											draw_set_color(c_white);
											player.force_outline_color = C_YELLOW;
											
													//we have put the card down
													if m1_release { 
														hovered_over_card = false;		
													}
										
										}
										if m1_release { 
												player.force_outline_color = false;
										}	
								break;				
							}
			
					}	
			}
			
		draw_health_bar(enemyx-40-xoffgame,enemyy+15-yoffgame,active_enemies[@ i], potential_damage);
}


	if  current_turn = e_current_turn.player_ and no_discover_effects()  and 
		number_of_enemies > 0 and allow_player_input() 
	{
		
		if player.buff.weak_poison.amount > 0 { 
			total_intent_enemy_damage += player.buff.weak_poison.amount;
		}
	
		total_intent_enemy_damage -= player.armor;
		total_intent_enemy_damage = max(total_intent_enemy_damage,0);
		
		if player.buff.poison.amount > 0 { 
			total_intent_enemy_damage += player.buff.poison.amount;
		}
		
	}


	if array_length(active_enemies) > 1 and is_single_target{


	 if  targeting_specific_enemy { 
		if !played_card_hover_sound { 
			played_card_hover_sound = true;
			audio_play(sfx_light_card);
		}
	 }else{
		 played_card_hover_sound = false;
	 }
		
	}
							


	if 	hovering_over_enemy_intent > 0 	hovering_over_enemy_intent--;
	
	held_card();
}

				function boon_collision_line(_l,_t,_r,_b,lx0,ly0, lx1,ly1) { 
											
						
						
						
												//creates 4 lines and checks to see if they intersect with the line
									var  return_ = lines_intersect(_l,_t,_r,_t,  lx0,ly0, lx1,ly1,1);  //top left. //top right
									
										
										if return_ != 0 return true;
								 	var  return_ = lines_intersect(_r,_t,_r,_b,  lx0,ly0, lx1,ly1,1);  //top right. //bot right
									if return_ != 0 return true;
								  	var  return_ = lines_intersect(_r,_b,_l,_b,  lx0,ly0, lx1,ly1,1);  //bot right. //bot left
									if return_ != 0 return true;
								  	var  return_ = lines_intersect(_l,_b,_l,_t,  lx0,ly0, lx1,ly1,1);  //bot left. //top left
									if return_ != 0 return true;
											
											
											
											
											return false
											
											
							
							}
							
function lines_intersect(x1,y1,x2,y2,x3,y3,x4,y4,segment){
	/// lines_intersect(x1,y1,x2,y2,x3,y3,x4,y4,segment)
	//
	//  Returns a vector multiplier (t) for an intersection on the
	//  first line. A value of (0 < t <= 1) indicates an intersection 
	//  within the line segment, a value of 0 indicates no intersection, 
	//  other values indicate an intersection beyond the endpoints.
	//
	//      x1,y1,x2,y2     1st line segment
	//      x3,y3,x4,y4     2nd line segment
	//      segment         If true, confine the test to the line segments.
	//
	//  By substituting the return value (t) into the parametric form
	//  of the first line, the point of intersection can be determined.
	//  eg. x = x1 + t * (x2 - x1)
	//      y = y1 + t * (y2 - y1)
	//
	/// GMLscripts.com/license

    var ua, ub, ud, ux, uy, vx, vy, wx, wy;
    ua = 0;
    ux = argument2 - argument0;
    uy = argument3 - argument1;
    vx = argument6 - argument4;
    vy = argument7 - argument5;
    wx = argument0 - argument4;
    wy = argument1 - argument5;
    ud = vy * ux - vx * uy;
    if (ud != 0) 
    {
        ua = (vx * wy - vy * wx) / ud;
        if (argument8) 
        {
            ub = (ux * wy - uy * wx) / ud;
            if (ua < 0 || ua > 1 || ub < 0 || ub > 1) ua = 0;
        }
    }
    return ua;
}