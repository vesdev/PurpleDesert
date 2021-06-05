//PARENT

function card_script_struct(script_ , type, amount) constructor{ 
	self.script_ = script_;
	self.type = type;
	self.amount = amount;
	self.buff_type = noone;
	amount_mod = 1;//multiplies the amount
	argument_array = [];
	main_script = function(){};
	creator = noone;
	target = noone;
	token_enum = noone;
}

function card_script_empty(script_)  : card_script_struct() constructor{ 
	self.script_ = script_;	
	amount = 0;
	type = e_target.none;
}


//ATTACK TARGETED
function card_struct_reset() : card_script_struct() constructor{ 
	self.type = e_target.player;
	main_script = function() { 
				if  !creator.can_crit{
					creator.can_crit = true;
				}
	
				if creator.force_crit{ 
					creator.force_crit = false;
				}
		
		} 
}

//ATTACK TARGETED
function card_struct_attack_single( amount ) : card_script_struct() constructor{ 
	self.script_ = damage_single_unit;
	self.type = e_target.single;
	self.amount = amount;
	self.original_amount = amount;
	main_script = function() { script_(creator,target, amount) self.amount = original_amount; } 
}

//ATTACK TARGETED
function card_struct_attack_single_multiply_on_crit( amount , amount_crit) : card_struct_attack_single() constructor{ 
	self.script_ = damage_single_unit;
	self.type = e_target.single;
	self.amount = amount;
	self.amount_crit = amount_crit;
	self.original_amount = amount;
	main_script = function() {   creator.second_crit_mod =  amount_crit;                            script_(creator,target, amount) self.amount = original_amount; } 
}



function card_struct_attack_single_killed_with_crit( amount ,  killed_script, killed_with_crit_script) : card_struct_attack_single() constructor{ 
	self.script_ = damage_single_unit;
	self.type = e_target.single;
	self.amount = amount;
	self.original_amount = amount;
	self.killed_script = killed_script;
	self.killed_with_crit_script = killed_with_crit_script;
	
	main_script = function() { 
		
		creator.just_killed_an_enemy_func = killed_script;
		creator.just_killed_an_enemy_with_crit_func = killed_with_crit_script;

	    script_(creator,target, amount) self.amount = original_amount; } 
}

//ATTACK TARGETED
function card_struct_attack_single_killed( amount , killed_script) : card_struct_attack_single() constructor{
	//enemy has just died and we execute another script here
	self.script_ = damage_single_unit;
	self.type = e_target.single;
	self.amount = amount;
	self.original_amount = amount;
	self.killed_script = killed_script;
	main_script = function() { 
		creator.just_killed_an_enemy_func = killed_script;        
		script_(creator,target, amount) self.amount = original_amount; } 
}


function card_struct_condition(func_) : card_script_struct() constructor{ 
	self.type = e_target.player;
	self.main_script = func_;
}

function card_struct_armor_slam() : card_script_struct() constructor{ 
	self.script_ = damage_single_unit;
	self.type = e_target.single;
	self.amount = function(){ return player.armor};
	main_script = function() {
		var armor_amount = player.armor;
		script_(creator,target,armor_amount)}
}

//ATTACK TARGETED
function card_struct_change_mana( amount ) : card_script_struct() constructor{ 
	self.script_ = change_mana;
	self.type = e_target.player;
	self.amount = amount;
	main_script = function() { change_mana(amount,false) } 
}


//ATTACK ALL
function card_struct_attack_all( amount ) : card_script_struct() constructor{ 
	self.script_			= damage_single_unit;
	self.type				= e_target.all_enemies;
	self.amount			= amount;
	self.original_amount = amount;
	main_script = function() {
			var len = array_length(active_enemies);
				for (var i = 0; i<len; i++){
					script_(creator,active_enemies[@ i],amount )
					
					
				}
				
				self.amount = original_amount;
		} 
}

///BUFF THE PLAYER
function card_struct_buff(all_buff_enum, amount ) : card_script_struct() constructor{ 
	self.script_ = player_buff;
	self.type = e_target.player;
	self.amount = amount;
	self.buff_type = all_buff_enum;
	main_script = function() {script_(creator,buff_type,amount) } 
}



function card_struct_remove_all_tokens() : card_script_struct() constructor{ 
	self.type = e_target.player;
	main_script = function() { player.token_array = [] } 
}

function card_struct_double_armor() : card_script_struct() constructor{ 
	self.type = e_target.player;
	main_script = function() { player.armor *= 2; } 
}

//
function card_struct_buff_enemy(all_buff_enum, amount ) : card_script_struct() constructor{ 
	self.script_ = add_buff;
	self.type = e_target.single;
	self.amount = amount;
	self.buff_type = all_buff_enum;
	main_script = function() {script_(target, buff_type, amount) } 
}
//
function card_struct_armor_player(amount) : card_script_struct() constructor{ 
	self.script_ = armor_change;
	self.type = e_target.player;
	self.amount = amount;
	main_script = function() {script_(creator, amount) } 
}

function card_struck_draw_card(amount) : card_script_struct() constructor{ 
	self.type = e_target.player;
	self.amount = amount;
	main_script = function() {
		
			draw_a_card(amount);
			
		 } 
}

function card_struct_generate_specific_card(card_enum , list_location, how_many_copies) : card_script_struct() constructor{ 
	self.script_ = generate_specific_card;
	self.type = e_target.player;	
	self.list_location = list_location;
	self.how_many_copies = how_many_copies;
	self.card_generate_enum = card_enum;
	main_script = function() {script_(card_generate_enum , list_location, how_many_copies) } 
}

function card_struct_summon_token( enum_token ) : card_script_struct() constructor{ 
	self.script_ = add_token;
	self.type = e_target.player;
	self.token_enum = enum_token;
	main_script = function() {script_(token_enum) } 
}

function card_struct_reduce_cost_of(list_, amount ,true_for_multiply_false_for_additive ) : card_script_struct() constructor{ 
	self.script_ = reduce_cost_of;
	self.type = e_target.player;
	self.list_ = list_;
	self.true_for_multiply_false_for_additive = true_for_multiply_false_for_additive;
	self.amount = amount;
	main_script = function() { script_(list_, amount ,true_for_multiply_false_for_additive) } 
}

function card_struct_discover_token( enum_token_arguments ) : card_script_struct() constructor{
	self.script_ = discover_tokens;
	self.type = e_target.player;
	self.enum_token_arguments = enum_token_arguments;
	self.amount = 0;
	main_script = function() {script_( enum_token_arguments)}
}
function card_struct_discover_tokens_repeat( enum_token_arguments, repeat_ ) : card_script_struct() constructor{
	self.script_ = discover_tokens_repeat;
	self.type = e_target.player;
	self.enum_token_arguments = enum_token_arguments;
	self.amount = 0;
	self.repeat_ = repeat_;
	main_script = function() {script_( enum_token_arguments, repeat_)}
}
