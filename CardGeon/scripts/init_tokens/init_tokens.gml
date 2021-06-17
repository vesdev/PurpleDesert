// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum e_token_type { 
	battlecry,
	aura,
	deathrattle,
	dontcheck,
	size_
}


/*
	Mini Me	
	Summon a token that plays COPIES of attack cards at half power.
*/


function token_script(enum_, script_) constructor{ 
	self.type = enum_;
	self.script_ = script_;
}


#macro NOCOST noone


function init_tokens( turns_to_live , cost_to_increse_life , cost_to_increase_amount , amount1_per_level_up, ability_array,sprite_idle, sprite_hit,  title, desc, desc_additional ) : playable_entity() constructor{
	self.attack = 0;
	self.func_card_sprite_index = function() {return s_green_card_no_border; }
	self.ability_array = ability_array;
	self.title = title;
	self.desc = desc;
	self.golden = false;
	self.desc_additional = desc_additional;
	self.sprite_idle = sprite_idle;
	self.sprite_hit = sprite_hit;
	current_sprite = sprite_idle;
	type = noone;
	cost = NOCOST
	
	
	struct_type = e_struct_type.token;
	self.turns_to_live = turns_to_live;	
	self.cost_to_increase_amount = cost_to_increase_amount;
	self.amount1_per_level_up = amount1_per_level_up;
	self.cost_to_increse_life = cost_to_increse_life;
	self.amount1_per_level_up = amount1_per_level_up;
	self.amount2_per_level_up = 0;
	self.amount3_per_level_up = 0;
}

function init_tokens2(turns_to_live , cost_to_increse_life, cost_to_increase_amount, amount1_per_level_up, amount2_per_level_up,  ability_array,sprite_idle, sprite_hit,  title, desc, desc_additional) : init_tokens() constructor{
	self.amount2_per_level_up = amount2_per_level_up;
}

function init_tokens3(turns_to_live , cost_to_increse_life, cost_to_increase_amount, amount1_per_level_up, amount2_per_level_up,  ability_array,sprite_idle, sprite_hit,  title, desc, desc_additional) : init_tokens2() constructor{

	self.amount2_per_level_up = amount2_per_level_up;
}

function check_stuff(stuff_enum) { 
	
	var stuff_array = o_game.all_passive_treasures;
	var len = array_length(stuff_array);
	if len = 0 return 0;
	var count = 0;
	for (var i = 0; i < len; i++) {		
		if stuff_array[@ i].stuff_enum = stuff_enum { 
			count++;
		}
	}
	return count;
}


function check_tokens(token_enum) { 
	
	var token_array = player.token_array;
	var len = array_length(player.token_array);
	
	if len = 0 return 0;
	var count = 0;
	for (var i = 0; i < len; i++) {		
		if token_array[@ i].type = token_enum { 
			count++;
		}
	}
	return count;
}


function execute_token_script(token_enum,e_token_type_ ) { 

	var token_array = player.token_array;	
	var len = array_length(player.token_array);


	if len = 0 return 0;
	var count = 0;
	for (var i = 0; i < len; i++) {
		if token_array[@ i].type = token_enum { 
			
			var abilities = token_array[@ i].ability_array;
			var len = array_length(abilities);
		
			for (var j = 0; j < len; j++){ 
			
				var script_type = abilities[@ j];
				
				if script_type = e_token_type_ || e_token_type.dontcheck { 
					
					abilities[@ j].script_();
				}
			}
		}
	}
}

function token_check_execute(token_enum,e_token_type_ ){ 
	
	repeat(check_tokens(token_enum)) { 
			execute_token_script(token_enum,e_token_type_);
	}
}
function add_token(token_enum) { 
	
	audio_stop_sound(sfx_spawn_a_new_token);
	audio_play(sfx_spawn_a_new_token);
	var returned_token = token_struct(token_enum);
	
		if returned_token != noone {
		if array_length( player.token_array ) < player.max_token_amount {
			returned_token.type = token_enum;
			//activate the token ability or something
			array_push(player.token_array, returned_token );
		}		
	}
}


function reduce_cost_of(list, amount, true_for_multiply_false_for_additive ){ 
	
	var len = ds_list_size(list);
	
	for (var i =0; i<len; i++){ 
		if true_for_multiply_false_for_additive{ 
			list[| i].cost *= amount;	
		}else{
			list[| i].cost += amount;	
		}	
		list[| i].cost = floor(list[| i].cost);
		if list[| i].cost <= 0 { 
			list[| i].cost = 0;	
		}
	}
}

function discover_tokens( token_enums_args ) { 
discover_queue.array = []; 
//discover_queue.type = e_discover.add_for_combat;
discover_queue.type = e_discover.play_token;
if !is_array(token_enums_args) { 
	token_enums_args = [];
	boon_randomize();
	ds_list_shuffle(all_token_list)
	for (var i= 0; i < 3; i++){
		array_push(	token_enums_args,all_token_list[| i]);	
	}
}

discover( token_enums_args);


}


function discover_tokens_repeat( token_enums_args, repeat_ ){ 
discover_queue.array = []; 
//discover_queue.type = e_discover.add_for_combat;
discover_queue.type = e_discover.play_token;
repeat (repeat_){ 
if !is_array(token_enums_args) { 

	token_enums_args = [];
	boon_randomize();
	ds_list_shuffle(all_token_list)
		for (var i= 0; i < 3; i++){
			array_push(	token_enums_args,all_token_list[| i]);	
		}
	}
	discover( token_enums_args);
}

}

#macro COST_LOW 20
#macro COST_MEDIUM 30
#macro COST_HIGH 40
#macro COST_HIGH2 50
#macro COST_HIGH3 100

function token_struct(token_enum){

	var returned_token = noone;//EVERY TIME A [c_gum]RED[] CARD [c_lime]DOESN'T CRIT[] GET 	
	switch token_enum { 
		case e_token.coco_bee: 
		returned_token = new init_tokens(player.token_stats[@ e_token.coco_bee].turns_to_live, COST_LOW, COST_MEDIUM, .05,
		[new  token_script( e_token_type.aura, function(enum_){ 
						
				buff_change(player.buff.crit_chance_up, 1);

			}) ] ,s_token_coco_bee, s_token_coco_bee_rip  , "BUSY BEE",
		function(){return "[c_lime]+"+string(round(  (player.token_stats[@ e_token.coco_bee].starting_amount+player.token_stats[@ e_token.coco_bee].output1() )*100 ))+"%[] CRIT [s_keyword_lucky] [c_yellow]CHANCE[] AFTER A RED CARD [c_lime]DOESN'T CRIT[]. LOSE BUFF [c_gum]AFTER CRIT[]"} , function() {return "CURRENT CRIT CHANCE [c_aqua]"+percent_to_string(get_crit_chance(player), false)+"%[]"});
		break;
		case e_token.coco_bat: 
		
		returned_token = new init_tokens(player.token_stats[@ e_token.coco_bat].turns_to_live, COST_LOW, COST_MEDIUM, .05,
		[new token_script( e_token_type.aura, function(enum_){ 
					
						buff_change(player.buff.crit_damage_up, 1);
		  }) ] , s_token_coco_bat, s_token_coco_bat_rip  , "BATTY BAT",
		function(enum_){ return "[c_lime]+"+string(round(  (player.token_stats[@ e_token.coco_bat].starting_amount+player.token_stats[@ e_token.coco_bat].output1() )*100 ))+"%[] CRIT [s_keyword_attack] [c_yellow]DAMAGE[] AFTER A RED CARD [c_lime]DOESN'T CRIT[]. LOSE BUFF [c_gum]AFTER CRIT[]"}, function() { return "CURRENT CRIT DAMAGE [c_aqua]"+string( round(  get_crit_damage(player)*100  ))+"%[]"});
		break;
		case e_token.coco_beetle: 
		
		returned_token = new init_tokens(player.token_stats[@ e_token.coco_beetle].turns_to_live,COST_MEDIUM, COST_MEDIUM, 2,
		[new token_script( e_token_type.aura, function(){ player.buff.attack.amount += 4+player.token_stats[@ e_token.coco_beetle].output1();   }) ] , s_token_coco_beetle, s_token_coco_beetle_rip  , "RED BEETLE",
		function(enum_){ return "GET [c_lime]+"+string(player.token_stats[@ e_token.coco_beetle].starting_amount+player.token_stats[@ e_token.coco_beetle].output1())+"[] [s_keyword_attack] ATTACK ON CRIT"}, function() { return "CURRENT CRIT CHANCE [c_aqua]"+percent_to_string(get_crit_chance(player), false)+"%[]"});
		break;
		case e_token.coco_spider: 
		
		returned_token = new init_tokens(player.token_stats[@ e_token.coco_spider].turns_to_live, COST_HIGH3, 0, 0,
		
		[new token_script( e_token_type.aura, function(){   }) ] , s_token_coco_spider,  s_token_coco_spider_death, 
			"CUTE SPIDER",function(){ return "RED CARDS [c_lime]ALWAYS CRIT[] BUT CRIT DAMAGE [c_gum]CANNOT EXCEED 200%[]"}, 
			function() { return "CANNOT STACK"});
			break;		
		case e_token.coco_salmon:
		
		returned_token = new init_tokens(player.token_stats[@ e_token.coco_salmon].turns_to_live, COST_MEDIUM, COST_MEDIUM, 1,
		[new token_script( e_token_type.aura, function(){ 
			
			var amount = 2+player.token_stats[@ e_token.coco_salmon].output1();
			
		repeat(check_stuff(e_stuff.trident) ){
				amount *= 2;
		}
			add_buff(player,all_buffs.temp_attack,amount) }
			)]  , s_token_coco_salmon_sally,  s_token_coco_salmon_sally,
		"SALMON SALLY",function(){ return 
			"[c_lime]+"+string(2+player.token_stats[@ e_token.coco_salmon].output1())+"[] [s_status_pow_remove_on_crit] ATTACK AFTER A RED CARD [c_lime]DOESN'T CRIT[] [c_gum]LOSE BUFF AFTER CRIT[]"}, 
			function() { return ""});
			break;		
		
		case e_token.coco_dice: returned_token = new init_tokens(player.token_stats[@ e_token.coco_dice].turns_to_live, COST_MEDIUM, 0, 0,
		[new token_script( e_token_type.aura, function(){} )]  , s_token_coco_crit_reroll,  s_token_coco_crit_reroll, 
		"FUDGE THE ROLL",function(){ return "WHEN YOU [c_gum]MISS A CRIT[], [c_lime]RE-ROLL YOUR CRIT[] AND TRY TO CRIT AGAIN."}, 
		function() { return ""});
		break;	
		
		case e_token.coco_red_copycat: returned_token = new init_tokens(player.token_stats[@ e_token.coco_red_copycat].turns_to_live, COST_HIGH3, 0, 0,
		
		[new token_script( e_token_type.aura, function(){} )]  , s_token_coco_copycat,  s_token_coco_copycat, 
		"RED COPYCAT",function(){ return "WHEN YOU PLAY A [c_gum]RED[] CARD, [c_lime]PLAY IT AGAIN[] AT [c_gum]50%[] DAMAGE[]"}, 
		function() { return ""});
		break;	
	} 
	
	if returned_token.turns_to_live = 1 { 
		returned_token.turns_to_live += check_stuff(e_stuff.more_token_turns_for_small);
	}	
	var s = returned_token;
	s.enum_ = token_enum;
	return returned_token;
}

function master_token_struct(turns_to_live , starting_amount) constructor{ 
	self.turns_to_live = turns_to_live;
	//to be safe we have 3 amounts
	self.starting_amount = starting_amount;
	
	amount = 0;
	amount2 = 0;
	amount3 = 0;
	
	amount_affects_stat_by = 0;
	amount_affects_stat_by2 = 0;
	amount_affects_stat_by3 = 0;
		
	output1 = function(){ return (self.amount*self.amount_affects_stat_by) }
	output2 = function(){ return (self.amount2*self.amount_affects_stat_by2) }
	output3 = function(){ return (self.amount3*self.amount_affects_stat_by3) }
	//add more stats if needed	
}

enum e_token { 
	coco_bee,
	coco_bat,
	coco_beetle,
	coco_salmon,
	coco_spider,
	coco_dice,
	coco_red_copycat,
	
	//coco_lv1_damage_single_enemy,
	//coco_lv1_damage_all_enemies,
	
	//coco_get_armor,
	
	size_	
}