function end_enemy_turn(){
	
	
	
		
		//group.SetTrackGain(index,volume,time);
		o_audio.sketch1.SetTrackGain(e_song_sketch.midsection_strings_without_fx,MAX_VOLUME,FADE_TIME);
		o_audio.sketch1.SetTrackGain(e_song_sketch.midsection_strings_without_fx,MAX_VOLUME,FADE_TIME);



		o_audio.sketch1.SetTrackGain(e_song_sketch.midsection_strings_with_fx,0,FADE_TIME);
		o_audio.sketch1.SetTrackGain(e_song_sketch.drums_with_fx,0,FADE_TIME);
		o_audio.sketch1.SetTrackGain(e_song_sketch.midsection_strings_with_fx,0,FADE_TIME);
		o_audio.sketch1.SetTrackGain(e_song_sketch.drums_with_fx,0,FADE_TIME);
		o_audio.sketch1.SetTrackGain(e_song_sketch.sub_bass,0,FADE_TIME);
		o_audio.sketch1.SetTrackGain(e_song_sketch.pad_highlights,0,FADE_TIME);

	
	
	audio_play(sfx_armor_break);
	
	with o_game.synth_wave { 
		xscale_target = 0;
		yscale_target = 0;
		audio_play(sfx_close_portal);
	}
	
	turn_phase  =  e_turn_phase.draw_phase;
	dealt_a_crit_this_turn = false;
	player.this_turn_token_was_summoned = false;
	player.this_turn_token_died = false;
	//play destroy armor animation	
	change_mana(player.mana_gain,true);
	
	var stuff_array = o_game.all_passive_treasures;
	var len = array_length(stuff_array);
	if len = 0 return 0;
	var count = 0;
	for (var i = 0; i < len; i++) {		
		if stuff_array[@ i].stuff_enum = e_stuff.sunflower { 
			count++;
			stuff_array[@ i].amount++;
			if stuff_array[@ i].amount >= 3 { 
				change_mana(10,false);		
				stuff_array[@ i].amount = 0;
			}
		}
	}
	
	//=	
	draw_card_queue = player.default_draw_amount;
	card_draw_sounds.enable = true;
	card_draw_sounds.sound_queue = draw_card_queue;


	

	var len = array_length(active_enemies)-1;	
	for (var i= 0; i <= len; i++){
		var enemy_ = active_enemies[@ i];
		
		
		if active_enemies[@ i].buff.weak_poison.amount > 0 { 
			change_health(player,enemy_,active_enemies[@ i].buff.weak_poison.amount,true,false);
			active_enemies[@ i].buff.weak_poison.amount = 0;
		}
		
		if active_enemies[@ i].buff.poison.amount > 0 { 
			change_health(player,enemy_,active_enemies[@ i].buff.poison.amount,false,false);
		}
		
		//("ARMOR TURNS "+string(active_enemies[@ i].cant_lose_armor_for_x_turns));			
		remove_struct_stacks(active_enemies[@ i])
		if active_enemies[@ i].cant_lose_armor_for_x_turns = 0 {
			remove_all_armor(active_enemies[@ i]);
		}else{
			active_enemies[@ i].cant_lose_armor_for_x_turns = 0;
		}
			active_enemies[@ i].current_attack_script_queue = 0; //back to 0 you go
}
	remove_struct_stacks(player);
	
	if player.buff.armor_keep.amount = 0 { 
		remove_all_armor(player);
	}

	var len = number_of_enemies;
	//loop through enemies
	for (var i = 0; i < len; i++){ 
		var enemy_ = active_enemies[@ i];
		//check for certain status effects
		if enemy_.buff.enrage.amount > 0 { 
			if enemy_.buff.enrage.flag = true{ 
			add_buff(enemy_, all_buffs.attack,enemy_.buff.enrage.amount );
			}else{
			 enemy_.buff.enrage.flag = true;	
			}
		}
	}
	if player.buff.enrage.amount > 0 { 
		if enemy_.buff.enrage.flag = true{ 
		add_buff(player, all_buffs.attack,player.buff.enrage.amount );
			
		}else{
			enemy_.buff.enrage.flag = true;	
		}
	}
	 remove_token_duration(1);
}
function remove_struct_stacks(struct){
	
	buff_set(struct.buff.lucky, 0);
	buff_set(struct.buff.replay_red, 0);
	
	var buff_list = struct.buff;
	var struct_variable_names = variable_struct_get_names(buff_list);	
	
	//remove tempoary frm buff attack here
	if struct.buff.attack_lost_on_crit_lose_at_turns_end.amount > 0 { 
		
		buff_change(struct.buff.attack_lost_on_crit, struct.buff.attack_lost_on_crit_lose_at_turns_end.amount );
		buff_set(struct.buff.attack_lost_on_crit_lose_at_turns_end, 0);
	}
	
	
		for (var i = 0; i < array_length(struct_variable_names); i++;){
		var variable_name = struct_variable_names[@ i];
		var buff_struct = variable_struct_get(buff_list, variable_name);
				if  buff_struct.delay_status_for_a_turn = true{
					buff_struct.delay_status_for_a_turn = false;
					exit;
				}
				if buff_struct.amount > 0 and  buff_struct.lose_per_turn > 0  and buff_struct.delay_status_for_a_turn = false{
					buff_struct.created_timer = -1
					buff_struct.amount -= buff_struct.lose_per_turn;
					if buff_struct.amount <= 0 buff_struct.amount = 0;	
				}
		}
}