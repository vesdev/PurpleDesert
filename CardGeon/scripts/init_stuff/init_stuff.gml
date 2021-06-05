// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information



function new_spoil(spoils) { 
	boon_randomize();
	with o_game{
		hand_over_rewards_array = [];

		if is_array(spoils) {
	
				var len = array_length(spoils);
				for(var i=0; i< len; i++) {
					array_push(   o_game.hand_over_rewards_array,spoils[@ i]);
				}
	
			}else{
				for(var i=0; i<argument_count; i++) {
					array_push(  o_game.hand_over_rewards_array,argument[i]);
				}
			}
		}
}

enum e_spoil_type { 
	gold,
	choose_card,
	stuff,
	potion,
	size_
}

function spoil_parent() constructor{ 
	self.sprite = noone;
	self.title = ""; //name of it
	self.desc = function() { return ""}; // array, first the target, then the value is the script that is used, then all sequential values are the argumnents

	self.keywords = noone;
	self.amount = noone;
}

function  init_gold( amount) : spoil_parent() constructor{
	self.sprite = s_icon_gold;
	self.title = "GOLD"; //name of it
	self.desc = function(amount_){ return "[c_yellow]+"+string(amount_)+"[]"};  // array, first the target, then the value is the script that is used, then all sequential values are the argumnents
	self.init_script = function(gold_amount) { player.gold += gold_amount   }; 
	self.keywords = noone; //keywords the card contains  for example exhaust, if none then use noone
	self.amount = amount;
	type = e_spoil_type.gold;
}


function init_spoil_add_card(card_enum_array) : spoil_parent()constructor{ 
	type = e_spoil_type.choose_card;
	self.sprite = s_keyword_choose;
	self.title = "CARD"; //name of it
	self.added_cards = card_enum_array;
	self.desc = function() { return "ADD A [c_lime]CARD[] TO YOUR DECK"}; // array, first the target, then the value is the script that is used, then all sequential values are the argumnents
	self.init_script = function() { 
		
		
		
		discover_queue.type = e_discover.add_for_run;
		discover( added_cards );
		}; 
	self.keywords = noone;
}

function spoil_add_card() { 
	boon_randomize();
	ds_list_shuffle(card_spoils);
	var array = [];
	for (var i = 0; i < spoils_card_len; i++){ 
			array_push(array, card_spoils[| i]);
	}
	

	return new init_spoil_add_card(array);
}


function add_card_to_deck( card_enums_args ) { 
discover_queue.array = []; 
//discover_queue.type = e_discover.add_for_combat;
discover_queue.type = e_discover.add_for_run;
discover( card_enums_args);

}

function  create_gold( amount) constructor{
	return new init_gold(amount);
}

function  create_stuff( sprite, title,  desc  ,init_script , keywords, amount, rarity) constructor{
	self.sprite = sprite;
	self.title = title; //name of it
	self.desc = desc; // array, first the target, then the value is the script that is used, then all sequential values are the argumnents
	self.init_script = init_script; 	
	self.keywords = keywords; //keywords the card contains  for example EXILE, if none then use noone
	self.amount = amount;
	self.rarity = rarity;
	type = e_spoil_type.stuff;
	stuff_enum = noone;
}

function get_next_stuff_enum() {
	boon_randomize();

	ds_list_shuffle(stuff_list);
	
var enum_ = ds_list_find_value(stuff_list,0);
													
	ds_list_delete(stuff_list,0);
													
	if ds_list_empty(stuff_list){
		reset_stuff_list();
	}

	return enum_;
}


function add_stuff(enum_) { 
	with o_game{ 
		var struct = stuff_struct(enum_);
		if struct.init_script != noone  { 
		struct.init_script();
		}
		all_passive_treasures = array_add_return(all_passive_treasures, array_length(all_passive_treasures) , struct);
	}
}

function get_next_stuff_gold_enum() {
	boon_randomize();

	ds_list_shuffle(stuff_list_golden);
	
var enum_ = ds_list_find_value(stuff_list_golden,0);
													
	ds_list_delete(stuff_list_golden,0);

	if ds_list_empty(stuff_list_golden){
		reset_stuff_list_golden();
	}

	return enum_;
}

function init_stuff(){
	
enum e_rarity {
	
	common,
	uncommon,
	rare,
	epic,
	legendary,
	
	
	starting,
	forbidden,
	boss,
	curse,
	
	size_
	
}


enum e_stuff { 
	
	
	purple_scale,
	molding_clay,
	
	
	max_hp,
	lucky_penny,
	more_max_mana,
	tokens_stay,
	more_token_turns_for_small,
	increase_crit_damage,
	more_spoil_options,
	pink_bow,
	size_common,
	reroll_rock,
	mana_restoring_pie,
	gold_small,
	gold_big,
	
	royal_jelly,
	you_win,
	goggles, //non findable 
	
	cafe_salmonella, ///COCO ONLY
	trident,   //
	sunflower, //coco only top
	
	locust_crown, 
	size_
}



function reset_stuff_list() { 
	
ds_list_add(stuff_list, 

e_stuff.purple_scale,
e_stuff.molding_clay,
e_stuff.more_max_mana,
e_stuff.increase_crit_damage,
e_stuff.reroll_rock,
e_stuff.gold_small,
e_stuff.royal_jelly,
e_stuff.sunflower,

);
ds_list_shuffle(stuff_list);
}


function reset_stuff_list_golden() { 
	
	ds_list_add(stuff_list_golden,
	e_stuff.pink_bow,
	e_stuff.more_token_turns_for_small,
	e_stuff.trident,
	e_stuff.locust_crown,
	e_stuff.cafe_salmonella,
	e_stuff.gold_big
	);

}
//	e_stuff.cafe_salmonella ///SHOP ONLY SHOULD HAVE FOUNDATIONAL TOKENS
// locust_crown
//fishbowl



function stuff_struct(stuff_enum) {
	
	with o_game{ 
			var returned_stuff = noone;
			switch stuff_enum {
				
				case e_stuff.you_win:
				
				returned_stuff = new create_stuff(s_passive_boss_saphire, "YOU WIN",function()  {
														return "CONGRATS YOU DID IT! +10 MANA, +10 MANA REGEN, PLEASE SEND [c_lime]YOUR FEEDBACK[]! SO THIS GAME CAN GET BETTER!";
													},
													function()  { with o_game{ player.mana_gain += 10; player.mana_max += 10;  } }, 0,
													noone, e_rarity.boss);				
				break;


		
				case e_stuff.goggles:	returned_stuff = new create_stuff( s_passive_tight_goggles, "TIGHT GOGGLES",function()  {
														return "[c_gum]RED[] CARDS HAVE A [c_lime]+10%[] CHANCE TO DEAL [c_lime]200%[] DAMAGE";
													},
													function()  { with o_game{ 
														
														add_crit_chance(.1, true);
														add_crit_damage(2,true);
														
														} }  , 0,
													noone,e_rarity.starting);
				break;
				
				
				case e_stuff.increase_crit_damage: returned_stuff = new create_stuff( s_passive_axe , "RUSTY AXE",
														function()  {
															return "ADD [c_lime]50%[] TO YOUR CRIT DAMAGE";
														},
														function()  { 
															add_crit_damage(.5,true);
															}, 0,noone, e_rarity.uncommon);
				break;

				case e_stuff.sunflower:	returned_stuff = new create_stuff( s_stuff_sunflower, "SUNFLOWER",function()  {
														return "EVERY [c_yellow]3[] TURNS GAIN [c_lime]+10[] MANA";
													},
													noone,0,
													0, e_rarity.rare);
				break;


				case e_stuff.mana_restoring_pie:	returned_stuff = new create_stuff( s_stuff_pie, "MANA INFUSED PIE",function()  {
														return "AT THE START OF COMBAT, ADD A PIE TO YOUR HAND THAT RESTORES [c_lime]10 MANA[].";
													},
													noone,0,
													noone, e_rarity.rare);
				break;

				

	
				case e_stuff.max_hp:	returned_stuff = new create_stuff( s_stuff_jelly, "BIBIMBAP",function()  {
														return "[c_lime]+20[] MAX HP and Heal [c_lime]20[] HP";
													},
														function()  { with o_game{ player.hp_max += 20; restore_health(20)} }  , 0,
													noone, e_rarity.common);
				break;
				
				case e_stuff.royal_jelly:	returned_stuff = new create_stuff( s_stuff_jelly, "ROYAL JELLY",function()  {
														return "HEAL [c_lime]7[] HEALTH AFTER DEFEATING A ROOM";
													},
													noone , 0,
													noone, e_rarity.rare);
				break;


				case e_stuff.cafe_salmonella:	returned_stuff = new create_stuff( s_stuff_salmon_on_crit, "CAFE SALMONELLA",function()  {
														return "ON CRIT SUMMON [s_token_coco_salmon_sally] SALMON SALLY.";
													},
													noone , 0,
													noone, e_rarity.epic);
				break;	

				case e_stuff.trident:	returned_stuff = new create_stuff( s_stuff_trident, "ANCIENT TRIDENT",function()  {
														return "[c_lime]DOUBLE[] THE DAMAGE GIVEN FROM [s_token_coco_salmon_sally] SALMON SALLY.";
													},
													noone , 0,
													noone, e_rarity.legendary);
				break;	

				case e_stuff.locust_crown:	returned_stuff = new create_stuff( s_stuff_locust_crown, "LOCUST CROWN",function()  {
														return "SUMMON [s_token_coco_salmon_sally] SALMON SALLY WHEN YOU [c_lime]DRAW A CARD[] ([c_gum]EXCLUDING[] DRAW PHASE).";
													},
													noone , 0,
													noone, e_rarity.legendary);
				break;	
	
					case e_stuff.gold_small:	returned_stuff = new create_stuff( s_stuff_small_nugget, "NUGGET",function()  {
														return "+100 [s_gold]";
													},
													function()  { with o_game{ player.gold += 100;  } } , 0,
													noone, e_rarity.common);
				break;	
				
				case e_stuff.gold_big:	returned_stuff = new create_stuff( s_gold_bar, "GOLD BAR",function()  {
														return "+200 [s_gold]";
													},
													function()  { with o_game{ player.gold += 200;  } } , 0,
													noone, e_rarity.uncommon);
				break;				
	
				case e_stuff.more_max_mana:	returned_stuff = new create_stuff( s_passive_more_max_mana, "CARNE ASADA",function()  {
														return "INCREASE YOUR MAX MANA BY [c_lime]10[].\n[c_gum]YOU STILL GAIN +"+string(player.mana_gain)+" PER TURN.[]";
													},
													function()  { with o_game{ player.mana_max += 10;  } } , 0,
													noone, e_rarity.uncommon);
				break;		
				case e_stuff.reroll_rock:	returned_stuff = new create_stuff( s_stuff_re_roll, "MOSS-FREE ROCK",function()  {
														return "GET [c_lime]+1[] RE-ROLL WHEN YOU OPEN A CHEST.";
													},
													function(){ with o_game{ player.chest_reroll += 1 }  } , 0,
													noone, e_rarity.uncommon);
				break;		
				case e_stuff.more_token_turns_for_small: returned_stuff = new create_stuff( s_passive_token_more_turn, "SUSPICIOUSLY SHAPED BANANA",function()  {
														return "WHEN SUMMONING A TOKEN WITH [c_yellow]1 HEALTH[] GIVE IT [c_lime]+1[] MORE HEALTH.[]";
													},
													noone, 0,
													noone, e_rarity.epic);
				break;
				
				case e_stuff.purple_scale:	returned_stuff = new create_stuff( s_stuff_purple_scale , "PURPLE SCALE",
														function()  {
															return "EVERY TIME A [c_gum]RED[] CARD [c_lime]DOESN'T CRIT[] GET [c_lime]+1[] ATTACK [c_gum]LOSE BUFF AFTER CRITTING[]";
														},
														noone, 0,noone, e_rarity.uncommon);
				break;		
				case e_stuff.molding_clay:	returned_stuff = new create_stuff( s_passive_molding_clay , "MOLDING CLAY",
														function()  {
															return "GAIN [c_yellow]+2[] RE AT THE START OF A FIGHT";
														},
														noone, 0,noone, e_rarity.common);
				break;
				case e_stuff.lucky_penny:	returned_stuff = new create_stuff( s_stuff_lucky_penny , "LUCKY PENNY",
														function()  {
															return "ON YOUR [c_yellow]FIRST[] TURN THE [c_yellow]FIRST[] RED CARD YOU PLAY [c_lime]ALWAYS CRITS[]";
														},
														noone, 0,noone, e_rarity.common);
				break;
				case e_stuff.tokens_stay:	returned_stuff = new create_stuff( s_passive_tokens_stay , "CHARISMA",
														function()  {
															return "TOKENS [c_lime]STAY[] WITH YOU IN BETWEEN FIGHTS";
														},
														noone, 0,noone, e_rarity.uncommon);
				break;
				
				
				case e_stuff.more_spoil_options:	returned_stuff = new create_stuff( s_passive_one_more , "CHOICES",
													function()  {
															return "[c_lime]+1[] CHOICE WHEN YOU ADD A CARD TO YOUR DECK";
													},
													function()  { spoils_card_len++}, 0,noone, e_rarity.uncommon);
				break;
				
				case e_stuff.pink_bow:	returned_stuff = new create_stuff( s_passive_pink_bow , "PINK BOW",
													function()  {
															return "RECOVER [c_lime]+100%[] MORE MANA FROM CARD EFFECTS";
													},
													noone, 0,noone, e_rarity.epic);
				break;
				
				
			}
			
			
			returned_stuff.stuff_enum = stuff_enum;
			return returned_stuff;
 
		}
	}
}