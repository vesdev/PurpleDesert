// Script assets have changed for v2.3.0 see


function remove_token_duration(amount){ 

	/*
			NEED TO ALSO LET THE PLAYER SEE THE TOKEN CHANGE
	*/
	
		var array = player.token_array;
		var len = array_length( array );
		
		 for (var i = 0; i < len ; i++){ 
			var current_token = array[@ i];
				
				current_token.turns_to_live -= amount;
			
				
				if current_token.turns_to_live <= 0 {
					array_delete(array,i,1)	
					i--;
					len--;
				}
				
		 }		
}

function remove_all_armor(struct){
	

	
	if struct.armor < 0 armor = 0;
	if struct.armor > 0 { 
	struct.armor = 0;
	struct.armor_destroy_image_index = 0;
	struct.armor_destroy_enable = true;
	}
}

function draw_step(){

attack_target = [];
}

//standby
function upkeep_step(){



}




//play card
function end_turn(){



}


function no_discover_effects() { 
	//the player is not allwoed to choose a card
	if array_length(discover_queue.array ) = 0{
	return true;	
	}else{
	return false;	
	}
	
}

function allow_player_input() { 
	/*
	
	Does not allow player input if 
	it's not the player's turn.
	there is not a notification bein displayed,
	there are no CHOOSE 1 OF 3 card effects.
	
	*/
	var discover_ = true;
	var len = array_length(discover_queue.array );
	if len > 0 { 
	
			if discover_queue.hide = false { 

	discover_ = false;

			}
	}
	return array_length(card_array_queue.array) = 0 and
	current_turn = e_current_turn.player_ and
	wait_for_the_attack_to_play_out_timer <= 0 and
	!hand_to_discard.enable and 
	!discard_to_deck_queue.enable and
	!display_notification and discover_;
}

function armor_string(armor) { 
	var color = "[c_yellow]";
	var original_armor = armor;
	
	
	if player.buff.armor_reduction.amount > 0 { 
		armor *= o_game.buff_multipliers.armor_reduction;
	}
	armor += player.buff.endurance.amount;
	
	
	armor = round(armor);
	//check player attack 
	
	//check enemy debuffs
	
	if armor > original_armor{ 
		
		color = "[c_lime]";
		
	}else if armor < original_armor{
		
		color = "[c_gum]";
		
	}
	return color+string(armor)+"[]";	
	
}

function apply_debuff_damage(  ) { 
	
	
}


function damage_string(damage) { 
	var color = "[c_yellow]";
	var original_damage = damage;
	//check player attack
	//check enemy buffs
	var creator = player;
	var target = noone; 

	//add target
	if is_array(attack_target) and array_length(active_enemies) > 0 and array_length(attack_target) = 1 { 
			target = active_enemies[@ attack_target[0]];
	}	
	damage =  check_damage(creator, target, damage);

if damage > original_damage{ 
		color = "[c_lime]";
	}else if damage < original_damage{
		color = "[c_gum]";
	}
	return color+string(damage)+"[]";	
}


function damage_string_up(damage) { 
	var color = "[c_yellow]";
	var original_damage = damage;
	//check player attack
	//check enemy buffs
	var creator = player;
	var target = noone; 

	//add target
	if array_length(attack_target) = 1 { 
			target = active_enemies[@ attack_target[0]];
	}	
	damage =  check_damage(creator, target, damage);

if damage > original_damage || upgrade_card_select.enable{ 
		color = "[c_lime]";
	}else if damage < original_damage{
		color = "[c_gum]";
	}
	return color+string(damage)+"[]";	
}


enum e_single_target_script { 
		
	
}

function get_card_damage(card_struct) { 

	if is_array(card_struct.card_script) { 
		var amount = 0;										
				var len = array_length(card_struct.card_script)-1;
					for (var i =0; i < len; i++){ 	
						if card_struct.card_script[@ i].script_ = damage_single_unit and card_struct.card_script[@ i].amount > 0 { 		

								if is_real(card_struct.card_script[@ i].amount){
									amount = card_struct.card_script[@ i].amount;
								}else{
									amount = 	card_struct.card_script[@ i].amount();
								}
								
							
						}
					}								
			}else{
												
			//this is a damage scritps
			if card_struct.card_script.script_ = damage_single_unit and card_struct.card_script.amount > 0 { 
					
						if is_real(card_struct.card_script.amount){
									amount = card_struct.card_script.amount;
								}else{
									amount = 	card_struct.card_script.amount();
						}
			}
	}
	if check_card_keywords(card_struct,keywords.lucky ) {
		amount *= 	get_crit_damage(player);	
	}
	return amount;
}
function check_damage(creator , target,  damage ) { 
	
	
	var color = "[c_yellow]";
	var original_damage = damage;
	
	
	//check player attack 
	//check enemy debuffs
	 damage += creator.buff.attack.amount;//strength
	 damage += creator.buff.attack_lost_on_crit.amount; //temp damage lost on crit
	 
	 
	 //DEBUFFS
	if target != noone { 
		if target.buff.fragile.amount > 0 { 
				damage *= o_game.buff_multipliers.fragile;
		}
	}
	
		if creator.buff.slow_start.amount > 0 { 
				damage *= o_game.buff_multipliers.slow_start;
		}
		if creator.buff.weak.amount > 0 { 
				damage *= o_game.buff_multipliers.weak;
		}
		

		

	if damage <= 0 damage = 0;
			damage = round(damage);
	return damage;	
	
}



function get_target_struct(e_target_enum) { 
	
	
	switch e_target_enum { 
				case e_target.single:	//single enemy	
				
								if array_length(attack_target) = 0 {  //targets chosen randomly
								var enemy_position = array_length(active_enemies)-1;// attack_target[@ 0]; //figures out which enemy
								var targeted_enemy = active_enemies[@ enemy_position]; //gets the enemy data
								return targeted_enemy;		
								
								}else{
								var enemy_position = attack_target[@ 0]; //figures out which enemy
								var targeted_enemy = active_enemies[@ enemy_position]; //gets the enemy data
								return targeted_enemy;
								}
				break;
				case e_target.all_enemies:
							var new_array = [];
							var length = array_length(active_enemies);
							array_copy(new_array, 0,active_enemies,0,length);
							return new_array;
					
				break;
				case e_target.player: //skill , power etc.
								return player;
				break;
				case e_target.none :
								return noone;
				break;
		}
}
