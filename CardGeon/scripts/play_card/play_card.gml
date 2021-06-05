// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function play_card(card_struct){

	
	if !card_can_be_played(card_struct) { 
		exit;	
	}
	if !no_discover_effects() exit;
	var card_target = noone;
	var card_script_struct_ = card_struct.card_script;
	
	//check if an enemy has the buff that gives them +attack if you play a skill card
	for (var i = 0; i < array_length(active_enemies); ++i){ 
		
		var enemy_ = active_enemies[@ i];
		if card_struct.card_type = e_card_type.strat{ 
				
				var find_weakness = enemy_.buff.find_weakness.amount;
		
				if find_weakness > 0 { 
					repeat( find_weakness ) { 
						add_buff(enemy_, all_buffs.attack, 1);
				}
			}
		}
		
		var horror_timepiece = enemy_.buff.horror_timepiece.amount;
		
			if horror_timepiece > 0 { 
				
			if horror_timepiece = 1{ 
					force_end_turn = true;
					buff_set(enemy_.buff.horror_timepiece, 10)

				exit;
			}
				buff_change(enemy_.buff.horror_timepiece, -1);
		}
}	
	


//condition






	game.combat.cards_played++;
	game.run.cards_played++;

	var cost = card_struct.cost;
	
	game.combat.mana_spent += cost;
	game.run.mana_spent    += cost;	
	
switch card_struct.card_type {
	case e_card_type.red:
					game.combat.red_cards_played++;
					game.run.red_cards_played++;
					game.combat.mana_spent_on_red += cost;
					game.run.mana_spent_on_red    += cost;
	break;
	case e_card_type.strat:
					game.combat.blue_cards_played++;
					game.run.blue_cards_played++;
					game.combat.mana_spent_on_blue += cost;
					game.run.mana_spent_on_blue    += cost;
	break;	
	case e_card_type.token:
					game.combat.green_cards_played++;
					game.run.green_cards_played++;
					game.combat.mana_spent_on_green += cost;
					game.run.mana_spent_on_green    += cost;
	break;		
	case e_card_type.passive:
					game.combat.white_cards_played++;
					game.run.white_cards_played++;
					game.combat.mana_spent_on_white += cost;
					game.run.mana_spent_on_white    += cost;
	break;	
	default:
					game.combat.gold_cards_played++;
					game.run.gold_cards_played++;
					game.combat.mana_spent_on_gold += cost;
					game.run.mana_spent_on_gold    += cost;
	break;
}
	if check_stuff(e_stuff.lucky_penny) { 
		if game.combat.red_cards_played = 1 and game.combat.turns = 0{ 
			player.force_crit = true;
		}
	}
	
	
	//var card_target = card_script_array.type;		
	//check to see if have a nested array, if so then we have to update the card's target
	
	
var is_or_condition = card_struct.or_condition;

if is_or_condition != noone { 
	var or_condition = card_struct.or_condition.result();
	if or_condition { 
		
		
		
	var first_struct =  new or_condition_discover("THIS ONE",card_struct.choose_first_string,card_struct.card_script);
	var second_struct = new or_condition_discover("THAT ONE",card_struct.choose_second_string,card_struct.card_script_or_condition);
		
		
		discover_queue.type = e_discover.or_condition_for_card;
	
		discover_struct( [first_struct,second_struct ]  );
		
		
		exit;
	}		
}
	card_script_or_array_add_to_queue(card_script_struct_, card_struct);
}


function or_condition_discover(title,desc,script_) : card() constructor{
	self.title = title;
	self.desc = desc;
	self.script_ = script_;
	self.keywords = noone;
	cost = 0;
	original_cost = 0;
}


function card_script_or_array_add_to_queue(card_script_struct_, card_struct) { 
	if is_array(card_script_struct_) { 
		//we have multiple card effects here
		var length = array_length(card_script_struct_);
			for (var i = 0; i < length; i++) {	
				push_card_script_to_queue(card_script_struct_[@ i], card_struct);
			}
		}else{ 
		push_card_script_to_queue(card_script_struct_ , card_struct);
	}
	

}


function push_card_script_to_queue(card_script_struct_ , card_struct ) { 
		//ONLY PUSH THE CARD SCRIPT STRUCT
		if card_script_struct_.main_script = noone exit;
		card_script_struct_.creator = player;
		card_script_struct_.target = get_target_struct(card_script_struct_.type) ; //gets the enemy data
		

		array_push(card_array_queue.array,  new struct_card_script_queue(card_script_struct_.main_script, card_script_struct_, card_struct ));
		card_array_queue.timer = card_array_queue.time_func();
		
		
}


function struct_card_script_queue(script_, card_script_struct_, card_struct) constructor{ 
	self.script_ = script_;
	self.card_script_struct_ = card_script_struct_;
	self.card_struct = card_struct;
}

function init_card_script_queue() { 
	
	var len = array_length(card_array_queue.array);
	if len > 0 { 
		//we need ot play our card scripts
		var pos  = card_array_queue.array[@ 0]
		var card_script_struct_ = pos.card_script_struct_;
		var card_struct = pos.card_struct;		
		var script_ = pos.script_
		
		
		if card_array_queue.timer > 0 { 
			if card_array_queue.flag_01 = false{
			card_array_queue.flag_01 = true;		
			
			disable_player_crit(card_struct);
	
			script_();
			}
			card_array_queue.timer--;	
		}else{
			if len > 0 {
				o_game.first_card_we_played = false;
				array_delete(card_array_queue.array,0,1);
				card_array_queue.timer = card_array_queue.time_func();
			}
			card_array_queue.flag_01 = false;
		}
	}
}


function execute_card_script(card_script , args , card_target )	{ 

	//	("SCRIPT "+string(card_script)+" ARRAY "+string(card_script_array)+" TARGET "+string(card_target))
	if card_target = noone { // we don't need to change the array  
			var argument_length = array_length(args)-1; 
			
			script_execute_ext(card_script,args);
		//	script_execute_ext(card_script,card_script_array,1 , argument_length); //execute that shit!!!!

	}else if is_array(card_target) { //target multiple enemies 
		
		var len = array_length(card_target); //enemy 1 and enemy 2
	
		for (var i = 0; i <len-1; i++){ 
			var temp_array = []; 
			var len = array_length(args);
			array_copy(temp_array,0,args,0,len);
		}
	}
}



function disable_player_crit(card_struct_){
	
	
	
		if player.buff.lucky.amount > 0{ 
				player.force_crit = true;	
				buff_change(player.buff.lucky, -1);
		}
	
	

	
	var array = card_struct_.keywords;
	if array != noone { 
		if is_array(array){ 
			var len = array_length(array);
			for (var i = 0; i <  len; i++){
				var current_keyword = array[@ i];
			if current_keyword = keywords.lucky and current_keyword != keywords.cant_crit{ 
				player.force_crit = true;	
			}	
				
			if current_keyword = keywords.cant_crit {
				player.can_crit = false;	
				player.force_crit = false;
			}
			
		
		}
	}else{ 
			//not an array
			current_keyword = array.keywords;
			if current_keyword = keywords.lucky and current_keyword != keywords.cant_crit{ 
				player.force_crit = true;	
			}
			
			if current_keyword = keywords.cant_crit {
				player.can_crit = false;
				player.force_crit = false;
			}
			
			
		}
	}
}