// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function reset_combat(){
	update_card_text()
	with o_game{ 
	

	
		turn_phase  =  e_turn_phase.draw_phase;
		player.armor = 0;
		if player.char_enum = char.coco  {
		player.crit_chance = player.crit_starting_chance;
		player.crit_damage = player.crit_starting_damage;
		}
		
		player.tempoary_crit_damage = 0;
		player.tempoary_crit_chance = 0;
		

			
		
		has_pressed_card_spoils = false;
	
		player.mana = player.mana_max;
		player.current_sprite = player.sprite_idle;
		turns_through_combat = 0;
		//reset tokens unless a relic says otherwise
		
		if !check_stuff(e_stuff.tokens_stay){
			player.token_array = [];
		}
		dealt_a_crit_this_turn = false;
		//reset stats
	
		var buff_list = player.buff;
		var struct_variable_names = variable_struct_get_names(buff_list);
		var amount_of_active_buffs = 0;
		for (var i = 0; i < array_length(struct_variable_names); i++;){

		
		var variable_name = struct_variable_names[@ i];


//		var buff_struct =  buff_list[$ variable_name];
		var buff_struct = variable_struct_get(buff_list, variable_name);		
	
			buff_struct.amount = 0;
			buff_struct.hovered_over_status = false;
			buff_struct.delay_status_for_a_turn = false;
			buff_struct.played_init_animation = false;
		
		}
	
	
		repeat( check_stuff(e_stuff.molding_clay)){ 
				add_buff(player, all_buffs.endurance, 2);
		}	
	
		var list_ = deck;
		var len = ds_list_size(list_);
		for (var i = 0; i < len;++i ) {
			var card_ = list_[| i];
				card_.cost = card_.original_cost;
		}  
		
		var list_ = hand;
		var len = ds_list_size(list_);
		for (var i = 0; i < len;++i ) {
			var card_ = list_[| i];
				card_.cost = card_.original_cost;
		} 
		
		var list_ = discard;
		var len = ds_list_size(list_);
		for (var i = 0; i < len;++i ) {
			var card_ = list_[| i];
				card_.cost = card_.original_cost;
		} 		
	}
}
