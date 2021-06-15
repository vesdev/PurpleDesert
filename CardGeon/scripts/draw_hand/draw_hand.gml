// Script assets have changed for v2.3.0 see
function draw_hand(){



/*
touch_screen_card = { 
	enable : 0,
	dis : 0,
	xdis : 0,
	ydis : 0,
	
}
*/


if current_turn = e_current_turn.enemy_ exit;


if !m1_check{
	hovered_y_offset = 0;
	un_hovered_y_offset = 0;
}

hovered_y_time = SEC;
un_hovered_y_time = SEC;

var angle = 0;
if hovered_y_timer <= hovered_y_time { 
	hovered_y_offset = easings(e_ease.easeoutexpo,0,-50,hovered_y_time,hovered_y_timer);
	hovered_y_timer++;
//	angle = easings(e_ease.easeoutexpo,45,-45,hovered_y_time*.3,hovered_y_timer);
}


if un_hovered_y_timer <= un_hovered_y_time { 
	un_hovered_y_offset = easings(e_ease.easeoutback,0,200,un_hovered_y_time,un_hovered_y_timer);
	//un_hovered_y_offset = easings(;
	un_hovered_y_timer++;
}



var len = hand_size-1;
init_card_border_step(len);

if is_undefined(hand[| 0]) exit;
	
if hand_size > 0 and number_of_enemies > 0 {  
	for (var i =0; i < hand_size; ++i){ 
	
	
	var card_ = hand[| i];
	var is_condition = card_.condition;
	
	var col =  "[c_yellow]";
	if is_condition != noone { 
	var condition = card_.condition.result();

		if condition { 
			col =  "[rainbow][wave]"
			card_.card_script = card_.card_script_condition;
		}else{
			card_.card_script = card_.card_script_original;
		}
	}

	var cost = hand[| i].cost;
		
	var total_dis = len * card_distance;
	var center_ = 0;
	var diff = total_dis - center_;
	var i_add = (i *card_distance) - total_dis/2;
	var targetx_ =  center_ + i_add;
		
	//hand_to_discard.enable = true;
	//hand_to_discard.amount = ds_list_size(hand);
	//end the turn 

var x_ = targetx_;
var y_ = camera.height/2-150;

if hand_to_discard.enable and hand_to_discard.amount > 0  and i = hand_to_discard.amount-1
{
	hand_to_discard.timer++;
	if check_card_keywords(hand[| hand_to_discard.amount-1],keywords.retain) { 
		
		hand_to_discard.reposition = true;
		hand_to_discard.amount--;
		
		
		if hand_to_discard.amount <= 0 { 
			hand_to_discard.enable = false;
			player_turn_has_ended();
		}
		exit;
	}else{
		x_ = (camera.width/2)*.85;
		y_ = -(camera.height/2)*.5;
	}
	if hand_to_discard.timer > hand_to_discard.time {
	
		
		discard_icon_size_timer = 0;
		discard_a_card_from_hand(hand_to_discard.amount-1);
		
		hand_to_discard.reposition_timer = 1;
		
		hand_to_discard.reposition = false;
		hand_to_discard.amount--;
	
		if hand_to_discard.amount <= 0 { 
			hand_to_discard.enable = false;
			player_turn_has_ended();
			exit;
		}
		hand_to_discard.timer = 0;
		exit;
	}
	hand_to_discard.timer++;
	//hand_to_discard.enable and hand_to_discard.amount > 0
	//allow_player_input()
	//hand_to_discard.enable = false;
	//player_turn_has_ended();
}

if hand_to_discard.enable and  check_card_keywords(hand[| i],keywords.retain) and hand_to_discard.reposition_timer > 0 { 
	active_cards_list[| i].x_ = targetx_;
	active_cards_list[| i].y_ = camera.height/2-150;

}

draw_card_matrix_selectable(hand[| i],x_ ,y_, 1,1,0, 0, 0 ,  i,false,angle,false,true,true);

}

	
if is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
		draw_card_matrix_selectable(is_hovering_over_card, save_hovered_x_position,camera.height/2-150, 2,1,angle, 0, 0 ,  save_hovered_i,true,0,0,true,1);
}
hand_hover_array = clamp(hand_hover_array, 0, hand_size);
//scribble((( directory[  hand[| hand_hover_array].reference , card_info.desc] ))).wrap(300).draw(300,200);
///HOVER OVER A CARD AND NOW SELECT THE CARD


if hovered_over_card and allow_player_input() and hand_size > 0 { 

			if m1_check and  selected_card_x != noone and allow_player_input() {
					if no_discover_effects(){
						
					var struct_ = hand[| hand_hover_array];

					if  card_can_be_played(struct_){ 

									if player.mana >= hand[| hand_hover_array].cost { 
											draw_caret_surface();
											potential_mana_loss =  hand[| hand_hover_array].cost;// lerp(potential_mana_loss, hand[| hand_hover_array].cost , .2);//25 * abs(sin(current_time*0.001));
											mana_text_color = "[s_caret][c_yellow]";
									}else{ 
										if m1_pressed and no_discover_effects(){ 
											mana_icon_timer = 0;
										}
								}
						}
				}	
					
			}else{
						potential_mana_loss =  lerp(potential_mana_loss, 0 , .2);
			}
			
		if player.mana >= hand[| hand_hover_array].cost and no_discover_effects(){				
					//show target type  
						if m1_release {
							change_mana(-hand[| hand_hover_array].cost,true );
							
							
						
					
							first_card_we_played = true;
							play_card(hand[| hand_hover_array] );
							
							
							
							if hand[| hand_hover_array].card_type = e_card_type.red { 
								
								if player.buff.replay_red.amount > 0 { 
									play_card(hand[| hand_hover_array]);
									buff_change( player.buff.replay_red , -1);
								}
					
								
								repeat(check_tokens(e_token.coco_red_copycat)){
									play_card(hand[| hand_hover_array]);
								}
							}
							
							//remove from game if the card is exahustable 
							var card_ = hand[| hand_hover_array];
							var card_keywords = card_.keywords;
							
							if card_keywords != noone { 

							var len = array_length(card_keywords);
							var	removed_ = false;
							for (var i = 0; i < len; ++i){ 
							
								if card_keywords[@ i] = keywords.single_use || card_keywords[@ i] = keywords.passive { 
									//remove the card from teh game	
									exahust_a_card_from_hand(hand_hover_array);
									removed_ = true;
								}
							}
								if removed_ = false{ 
									discard_a_card_from_hand(hand_hover_array);
								}
								
							}else{
							discard_a_card_from_hand(hand_hover_array);
							}
							finished_playing_a_card();
						}
				}
		}else{
			potential_mana_loss =  lerp(potential_mana_loss, 0 , .2);
		}
	if m1_pressed || m1_release {
		attack_target = [];
	}

}
	hand_to_discard.reposition_timer--;

}


function draw_discard_and_deck() {
	if live_call() return live_result;
	
	
	
deckx = o_game.camera.width*.9+xoffgame;
decky = o_game.camera.height*.1+yoffgame;

//draw_deck 
var offset = 22;
//draw_rectangle(deckx-offset,decky-offset,deckx+offset,decky+offset,false)



if !pause_combat_to_show_discard and boon_collision( deckx-offset,decky-offset,deckx+offset,decky+offset,MX,MY){



	draw_outline_thick(s_ui_deck,0,deckx,decky,1,1,0,c_white,1)
	draw_status_information = "[c_yellow]DECK[]\nIT'S SEEN BETTER DAYS YET IT'S ALWAYS RELIABLE ... LIKE ME!\n[c_lime]CLICK[] TO VIEW[]";

	if m1_pressed{

	if number_of_enemies <= 0 { 
			discover_queue.array = [];
			discover_queue.hide = false;
	}
		
	deck_flash_timer = 0;
	deck_is_not_drawn_in_order_warning = true;
	pause_combat_to_show_deck = !pause_combat_to_show_deck;
	view_deck_or_discard_card_yoffset = 0;
	
	ds_list_copy(draw_tempoary_list_deck,deck);
	ds_list_shuffle(draw_tempoary_list_deck)
	//shuffle deck super quick { 
		for (var i = 0; i <ds_list_size(active_cards_list);i++){ 
		var card_ = active_cards_list[| i];
				card_.x_ = 0;
				card_.y_ = 0;
		}
	}
}




	if pause_combat_to_show_deck and !pause_combat_to_show_discard and !pause_combat_to_show_exhaust{ 
		draw_cards_in_deck();
		exit;
	}

	if pause_combat_to_show_discard  and !pause_combat_to_show_deck and !pause_combat_to_show_exhaust{ 
		draw_cards_in_discard();
		exit;
	}
	
	if pause_combat_to_show_exhaust and !pause_combat_to_show_discard and !pause_combat_to_show_deck { 
		draw_cards_in_exhaust();
		exit;	
	}
	draw_outline(s_ui_deck,0,deckx,decky,1,1,0,c_black,1);
discard_xsize = 1;
var time = discard_to_deck_queue.time_func();
if discard_to_deck_queue.enable { 
	var timer = discard_to_deck_queue.timer;
	var time = time;
	if timer <= time{ 
		
	discard_xsize = easings(e_ease.easeoutback,0,1,time,timer);
	var xoffset =  easings(e_ease.easeoutexpo,camera.width*.5,-camera.width*1.45,time,timer);
	var index =  easings(e_ease.easeinquad,0,3,time*.45,timer);
	draw_sprite(s_ui_card_discard_to_deck,index,camera.width-40+xoffgame+xoffset,-camera.height*.45);

	discard_to_deck_queue.timer++;
	}else{
		
		
	var pos = ds_list_find_value(discard_to_deck_queue.list,0);
	ds_list_add(deck,pos);
	
	ds_list_delete(discard_to_deck_queue.list,0);
	discard_to_deck_queue.timer = 0; 
	deck_flash_timer = 0;
	if ds_list_empty(discard_to_deck_queue.list){ 
		discard_to_deck_queue.draw_amount = clamp(discard_to_deck_queue.draw_amount,0,hand_size_max_limit);	
			
			discard_to_deck_queue.draw_amount = 0;
			ds_list_shuffle(deck);	
			ds_list_add(hand,deck[| 0]);
			//ds_list_insert(hand,0,deck[| 0]);
			ds_list_delete(deck,0);			
			hand_size = ds_list_size(hand);
			var len = hand_size-1;
			active_cards_list[| len].x_ = -camera.width;
			active_cards_list[| len].y_ = -camera.height;	
			discard_to_deck_queue.enable = false;	
		}
	}
}


discard_icon_size_time = SEC*.5;

if discard_icon_size_timer <= discard_icon_size_time {
	discard_xsize = easings(e_ease.easeoutelastic,0,1,discard_icon_size_time,discard_icon_size_timer);
	discard_icon_size_timer++;
}

discardx = o_game.camera.width*.95+xoffgame;
discardy = o_game.camera.height*.1+yoffgame;

exhaustx = o_game.camera.width*.95+xoffgame;
exhausty = o_game.camera.height*.18+yoffgame;



if boon_collision( discardx-offset,discardy-offset,discardx+offset,discardy+offset,MX,MY){
	draw_outline_thick(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_white,1)
	draw_status_information = "[c_yellow]DISCARD PILE[]\nYOUR DISCARD PILE BECOMES YOUR DECK IF YOUR DECK IS EMPTY\n[c_lime]CLICK[] TO VIEW[]";

	if m1_pressed{
		
	if number_of_enemies <= 0 { 
			discover_queue.array = [];
			discover_queue.hide = false;
	}
		discard_flash_timer = 0;
		m1_pressed = false;
		pause_combat_to_show_discard = true;
		pause_combat_to_show_deck = false;
		view_deck_or_discard_card_yoffset = 0;
		//shuffle deck super quick { 
		for (var i = 0; i <ds_list_size(active_cards_list);i++){ 
		var card_ = active_cards_list[| i];
				card_.x_ = 0;
				card_.y_ = 0;
		}
	}
}

//draw_rectangle(exhaustx-offset,exhausty-offset,exhaustx+offset,exhausty+offset,1)

if boon_collision( exhaustx-offset,exhausty-offset,exhaustx+offset,exhausty+offset,MX,MY){
	draw_outline_thick(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size,0,c_white,1)
	draw_status_information = "[c_yellow]EXILE []\nREMOVED FROM COMBAT PILE\n[c_lime]CLICK[] TO VIEW[]";

	if m1_pressed{
	if number_of_enemies <= 0 { 
			discover_queue.array = [];
			discover_queue.hide = false;
	}
		exhaust_flash_timer = 0;
		m1_pressed = false;
		pause_combat_to_show_exhaust = true;
		pause_combat_to_show_discard = false;
		pause_combat_to_show_deck = false;
		view_deck_or_discard_card_yoffset = 0;
		//shuffle deck super quick { 
		for (var i = 0; i <ds_list_size(active_cards_list);i++){ 
		var card_ = active_cards_list[| i];
				card_.x_ = 0;
				card_.y_ = 0;
		}
	}
}

draw_exhast();

if discard_to_deck_queue.enable and discard_to_deck_queue.timer <= time ||  discard_icon_size_timer <= discard_icon_size_time*.2{ 

var col = c_white;
if discard_to_deck_queue.enable col = C_GUM;
	draw_outline(s_discard,0,camera.width-40+xoffgame,50+yoffgame,discard_xsize,discard_xsize,0,col,.5);
}	
draw_discard();


}

function init_card_border_step (len){

is_hovering_over_card = noone;
card_distance = 100; //140 ish
switch len { 
	case 0: card_distance = 200;break;
	case 1: card_distance = 200;break;
	case 2: card_distance = 200;break;
	case 3: card_distance = 200;break;
	case 4: card_distance = 200;break;
	case 5: card_distance = 200;break;	
	case 6: card_distance = 150;break;	
	case 7: card_distance = 140;break;		
	case 8: card_distance = 120;break;		
	case 9: card_distance = 110;break;		
	case 10: card_distance =100;break;		
	default:
		card_distance = 100;
	break;
}
card_distance *= camera.width *0.0008;
save_hovered_x_position = undefined;
save_hovered_i = noone;
	
}