// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function playable_entity(){ 
	title = ""; //name of it
	desc = function() { }; //card description
	cost = 0;
	self.keywords = noone;
}

enum e_struct_type  {
	card,
	token,
	size_
}

enum e_card_type { 
	
	red, //red
	strat,//blue
	token, //green
	passive, //yellow
	none,
	status, //grey
	curse, //purple
	size_
	
}


function  card(title, desc,cost, card_script , keywords, card_type, upgrades_to_enum) : playable_entity() constructor{
	self.title = title; //name of it
	self.desc = desc; //card description
	self.original_cost = cost;
	self.cost_with_discount = cost;
	self.cost = cost; //cost to play
	self.card_script = card_script; // array, first the target, then the value is the script that is used, then all sequential values are the argumnents
	self.card_script_original = card_script;// in case we need to replace it with our card
	self.keywords = keywords; //keywords the card contains  for example exhaust, if none then use noone
	self.card_type = card_type;
	self.upgrades_to_enum = upgrades_to_enum;
	price_original = 40;
	price = 40;
	on_sale = false;
	struct_type = e_struct_type.card;
	golden = false;
	func_card_sprite_index = function() { 
	original_amount = 0;
	sprite_index_ = s_white_card;
	
	switch card_type {
				case e_card_type.red :		return s_red_card; break;
				case e_card_type.strat:		return s_blue_card; break;
				case e_card_type.token:		return s_green_card; break;
				case e_card_type.passive:	return s_purple_card; break;
				case e_card_type.status:	return s_black_card; break;
				case e_card_type.curse:		return s_curse_card; break;
			}
	}
	remove_after_combat = false;//for discovered cards
	remove_on_end_turn = false;
	can_crit = true;
	
	card_script_condition = noone;
	
	condition = noone;
	or_condition = noone;
	
	choose_first_string = "";
	choose_second_string = "";
	
	
	card_script_condition = noone;
	card_script_or_condition = noone;
	self.keywords_add_text = function(){
		
		var array = self.keywords;
		var output = "";
	if array != noone { 
				var len = array_length(array);
						for (var i = 0; i <  len; i++){
							var current_keyword = array[@ i];
							if current_keyword = keywords.single_use  ||  current_keyword =	keywords.cant_crit
							{ 
								output += "["+sprite_get_name(current_keyword.sprite)+"] [c_yellow]"+current_keyword.title + "[]\n";
							}
						}
					}
	return output;	
	}
	self.token_enum_ = noone;
	self.token_struct = false;
	self.enum_ = noone;
}

function  card_condition(title, desc,cost, card_script, card_script_condition ,  keywords, condition, card_type, upgrades_to_enum) : card(title, desc,cost, card_script , keywords, card_type, upgrades_to_enum)constructor{

self.card_script_condition = card_script_condition;
self.condition = condition;

}

function  card_or_condition(title, desc, choose_first_string, choose_second_string,cost, card_script, card_script_or_condition, card_type , keywords,or_condition, upgrades_to_enum) : card( title, desc,cost, card_script ,card_type, keywords, upgrades_to_enum) constructor{
	
	self.card_type = card_type;
	self.keywords = keywords;
	self.choose_first_string = choose_first_string;
	self.choose_second_string = choose_second_string;
	self.card_script_or_condition = card_script_or_condition;
	self.or_condition = or_condition;
	
	
}




function token_str_lasts_turns(token_struct_){ 
	var col = "[c_yellow]";
	if token_struct_.turns_to_live = 1 { 
		col = "[c_gum]";	
	}
	
	return "LASTS "+col+string(token_struct_.turns_to_live)+"[] TURNS";
}

function short_token_desc(token_struct_){ 
			return token_struct_.desc()//+"\n"+token_str_lasts_turns(token_struct_);
}

function  card_summon (token_enum, cost , upgrades_to_enum) : card() constructor{
	token_struct_ = token_struct(token_enum);
	self.type = e_target.player;
	self.title = "[c_aqua]TOKEN[] "+token_struct_.title; //name of it
	token_enum_ = token_enum;
	self.desc = function() { return short_token_desc(token_struct_);} //card description
	self.cost = cost;
	self.original_cost = cost; //cost to play
	self.cost_with_discount = cost;
	self.card_script = new  card_struct_summon_token( token_enum_); // array, first the target, then the value is the script that is used, then all sequential values are the argumnents
	self.keywords = [keywords.token]; //keywords the card contains  for example exhaust, if none then use noone
	self.card_type = e_card_type.token;
	self.upgrades_to_enum = upgrades_to_enum;
}




enum e_card { 
	status_tired,
	status_hesitate,
	status_anxiety,
	status_self_doubt,
	status_burn,
	
		 // don't add this crap cards into the spoils rewards
		//this one too
		//DONT ADD ANY OF THESE SINCE THEY ARE DISCOVERABLE BUT NOT FINDABLE IN THE SPOILS
	
	coco_default_attack,				coco_up1_default_attack,			
	coco_default_armor,				coco_up1_default_armor,			
	coco_wimpy_punch,				coco_up1_wimpy_punch,			

	coco_curl_up,						   	coco_up1_curl_up,
	coco_discover_token,		   	coco_up1_discover_token,
																					
	coco_token_bee,												coco_up1_token_bee,
	coco_token_bat,													coco_up1_token_bat,
	coco_token_beetle,											coco_up1_token_beetle,
	coco_token_salmon,											coco_up1_token_salmon,
	coco_token_spider,											coco_up1_token_spider,
	coco_token_dice,												coco_up1_token_dice,
	coco_hot_sauce,													coco_up1_hot_sauce,
	coco_rocket_punch,											coco_up1_rocket_punch,
	coco_iron_punch,												coco_up1_iron_punch,
	coco_generate_wimpy_punch,						coco_up1_generate_wimpy_punch,
	coco_nut_kick,														coco_up1_nut_kick,
	coco_spin,															coco_up1_spin,
	coco_reduce_hand_cost_and_armor,			coco_up1_reduce_hand_cost_and_armor,
	coco_pebble_throw,											coco_up1_pebble_throw,
	coco_boomerang,												coco_up1_boomerang,
	coco_liquid_luck,												coco_up1_liquid_luck,
	coco_lucky_punch,												coco_up1_lucky_punch,
	coco_generate_emergency_cake,					coco_up1_generate_emergency_cake,
	coco_emergency_cake,										coco_up1_emergency_cake,
	coco_green_juice,												coco_up1_green_juice,
	coco_double_armor,											coco_up1_double_armor,
	coco_keep_armor,												coco_up1_keep_armor,
	coco_armor_slam,												coco_up1_armor_slam,
	coco_pile_on,														coco_up1_pile_on,
	coco_genereate_broken_bottle,					coco_up1_genereate_broken_bottle,
	coco_generated_broken_bottle,					coco_up1_generated_broken_bottle,
	coco_all_in,															coco_up1_all_in,
	coco_double_crit,												coco_up1_double_crit,
	
	coco_add_temp_attack,								coco_up1_add_temp_attack,
	coco_double_damage_on_crit,						coco_up1_double_damage_on_crit,
	
	coco_ultra_armor,						coco_up1_ultra_armor,
	coco_clingy_shield,						coco_up1_clingy_shield,
	

	coco_wimpy_pebble_throw ,								coco_up1_wimpy_pebble_throw,
	coco_powerup_punch ,									coco_up1_powerup_punch,
	coco_focus,												coco_up1_focus,
	coco_coupe_de_grace,									coco_up1_coupe_de_grace,
	coco_replay_red,										coco_up1_replay_red,
	coco_token_red_copycat,									coco_up1_token_red_copycat,
	coco_token_summoning,									coco_up1_token_summoning,
	coco_bubble_shield,										coco_up1_bubble_shield,
	coco_starter_kit,										coco_up1_starter_kit,
	coco_lucky_helmet,										coco_up1_lucky_helmet,
	coco_sucker_punch,		coco_up1_sucker_punch,
	
	size_
}

function card_struct(card_enum){
//makes a card struct	
var card_ = false;

switch card_enum { 
	
	////////////////////////////status
			
		case e_card.status_hesitate: 
				card_ = new card("HESITATE",
				function(){ return ""; },
				noone,
				noone, 
				[keywords.evaporate, keywords.unplayable], e_card_type.status,noone);		
		break;
		case e_card.status_anxiety: card_ = new card("ANXIETY",
		function()  {
			return ""
		},10,
		noone,
		[keywords.unplayable],  e_card_type.status,noone);		
		break;

		case e_card.status_self_doubt: card_ = new card("SELF DOUBT",
			function()  {
				return ""
			},
			10,
			new card_script_empty(function(){ }),
			[keywords.single_use] ,  e_card_type.status,noone);		
		break;

		case e_card.status_burn: card_ = new card("BURN",
			function()  {
				return "AT THE END OF YOUR TURN DO [c_gum]3[] DAMAGE TO YOURSELF"
			},
			noone,
			noone,
			[keywords.unplayable] ,  e_card_type.status,noone);		
		break;		
		
		case e_card.status_tired: card_ = new card("TIRED",
			function()  {
				return ""
			},
			noone,
			new card_script_empty(function(){ }),
			[keywords.evaporate, keywords.unplayable] , e_card_type.status,noone);		
		break;	
		
		case e_card.coco_default_attack: 
								card_ = new card("STRIKE",
											function(){ return "DO "+damage_string(20)+" DAMAGE"; },
											10,
											new card_struct_attack_single(20), //first is the script, second value is the argument for the script
											noone, e_card_type.red, e_card.coco_up1_default_attack);					
		break;
	
		case e_card.coco_up1_default_attack: 
						card_ = new card("STRIKE+",
									function(){ return "DO "+damage_string(30)+" DAMAGE"; },
									10,
									new card_struct_attack_single(30), //first is the script, second value is the argument for the script
									noone, e_card_type.red, noone);					
		break;	

		case e_card.coco_default_armor: card_ = new card("ARMOR UP",
								function()  {
									return armor_string(20)+" ARMOR"
								}	, 10,
								 new card_struct_armor_player(20) ,
								noone, e_card_type.strat,e_card.coco_up1_default_armor);				
		break;
		
		case e_card.coco_up1_default_armor: card_ = new card("ARMOR UP+",
								function(){
									return armor_string(30)+" ARMOR"
								}	, 10,
								 new card_struct_armor_player(30),
								noone, e_card_type.strat,noone);
		break;
			/////////////////
		case e_card.coco_curl_up: card_ = new card_condition("DEFENSE CURL",
			function()  {
				return armor_string(30)+" ARMOR. IF YOU HAVE [c_pink]40 ARMOR:[] CHOOSE [c_lime]1[] TOKEN."
			}	, 10,
			new card_struct_armor_player(30),
			[new card_struct_armor_player(30),
			new card_struct_discover_token(false)] //false or noone will allow you to find random tokens from the list 
			,[keywords.token, keywords.choose_], conditions.have_40_armor , e_card_type.strat, e_card.coco_up1_curl_up);				
			break;
			
		case e_card.coco_up1_curl_up: card_ = new card_condition("DEFENSE CURL+",
			function()  {
				return armor_string(30)+" ARMOR. IF YOU HAVE [c_pink]40 ARMOR:[] CHOOSE [c_lime]2[] TOKENS."
			}	, 10,
			new card_struct_armor_player(30),
			[new card_struct_armor_player(30),
			new card_struct_discover_tokens_repeat(false,2)] //false or noone will allow you to find random tokens from the list 
			,[keywords.token, keywords.choose_], conditions.have_40_armor , e_card_type.strat, noone);				
		break;
		

		case e_card.coco_bubble_shield :
		card_ = new card("BUBBLE SHIELD",
					function()  {
									return armor_string(30)+" ARMOR. "+get_string_card_amount(1);
								}	, 10,
								 [
								 new card_struct_armor_player(30),
								 new card_struck_draw_card(1),
								 ],
								noone , e_card_type.strat, e_card.coco_up1_bubble_shield);
		break;
		




		case e_card.coco_up1_bubble_shield :
		
		card_ = new card("BUBBLE SHIELD+",
					function()  {
									return armor_string(40)+" ARMOR. "+get_string_card_amount(2);
								}	, 10,
								 [
								 new card_struct_armor_player(40),
								 new card_struck_draw_card(2),
								 ],
								noone , e_card_type.strat, noone);
		break;

		case e_card.coco_lucky_helmet :
				card_ = new card_condition("LUCKY HELMET",
							function()  {
											return armor_string(40)+" ARMOR. IF YOU DEALT A [c_pink]CRIT THIS TURN[] GET [c_lime]+2[] [s_keyword_endurance] "+keywords.endurance.title;
										}	,20,
										 new card_struct_armor_player(50),
										 [ new card_struct_armor_player(50),
										   new card_struct_buff(all_buffs.endurance, 5),
										 ],
										[keywords.endurance] ,conditions.dealt_a_crit_this_turn,  e_card_type.strat, e_card.coco_up1_lucky_helmet);

				break;

		case e_card.coco_up1_lucky_helmet :
				card_ = new card_condition("LUCKY HELMET+",
							function()  {
											return armor_string(40)+" ARMOR. IF YOU DEALT A [c_pink]CRIT THIS TURN[] GET [c_lime]+5[] [s_keyword_endurance] +"+keywords.endurance.title;
										}	, 20,
										 new card_struct_armor_player(50),								 
										 [ new card_struct_armor_player(50),
										   new card_struct_buff(all_buffs.endurance, 10),
										 ],
										[keywords.endurance] ,conditions.dealt_a_crit_this_turn,  e_card_type.strat, noone);
		break;
				

		case e_card.coco_sucker_punch:
				card_ = new card_condition("SUCKER PUNCH",
							function()  {
											return "DO "+damage_string(30)+" DAMAGE.  IF YOU DEALT A [c_pink]CRIT THIS TURN[] RESTORE [c_lime]+10[] [c_yellow][s_electricity_small] ENERGY";
										}	,10,
										 new card_struct_attack_single(30),
										 [ new card_struct_attack_single(30),
										   new card_struct_change_mana(10),
										 ],
										noone ,conditions.dealt_a_crit_this_turn,  e_card_type.red, e_card.coco_up1_sucker_punch);

				break;

		case e_card.coco_up1_sucker_punch:
				card_ = new card_condition("SUCKER PUNCH+",
							function()  {
											return "DO "+damage_string(30)+" DAMAGE.  IF YOU DEALT A [c_pink]CRIT THIS TURN[] RESTORE [c_lime]+20[] [c_yellow][s_electricity_small] ENERGY";
										}	,10,
										 new card_struct_attack_single(30),
										 [ new card_struct_attack_single(30),
										   new card_struct_change_mana(20),
										 ],
										noone ,conditions.dealt_a_crit_this_turn,  e_card_type.red, noone);

				break;


		case e_card.coco_starter_kit :
		card_ = new card("STARTER KIT",
					function()  {
									return armor_string(40)+" ARMOR. ADD [c_lime]2[] [s_keyword_wimpy] [c_yellow]WIMPY PUNCHES[]";
								}	, 15,
								 [
									new card_struct_armor_player(40),
									new card_struct_generate_specific_card(e_card.coco_wimpy_punch, hand, 2)
								 ],
								[keywords.wimpy_punch] , e_card_type.strat, e_card.coco_up1_bubble_shield);
		break;


		case e_card.coco_up1_starter_kit :
		card_ = new card("STARTER KIT+",
					function()  {
									return armor_string(50)+" ARMOR. ADD [c_lime]3[] [s_keyword_wimpy] [c_yellow]WIMPY PUNCHES[]";
								}	, 15,
								 [
									new card_struct_armor_player(50),
									new card_struct_generate_specific_card(e_card.coco_wimpy_punch, hand, 3)
								 ],
								[keywords.wimpy_punch] , e_card_type.strat, noone);
		break;



		case e_card.coco_rocket_punch:
		card_ = new card("ROCKET PUNCH",
					function()  {
									return "DO "+damage_string(20)+" DAMAGE. "+get_string_card_amount(1);
								}	, 10,
								 [
								 new card_struct_attack_single(20),
								 new card_struck_draw_card(1),
								 ],
								noone , e_card_type.red, e_card.coco_up1_rocket_punch);
		break;
		


		

		case e_card.coco_up1_rocket_punch: 
		
		card_ = new card("ROCKET PUNCH+",
								function()  {
									return "DO "+damage_string(25)+" DAMAGE. "+get_string_card_amount(2);
								}	, 10,
								 [
								 new card_struct_attack_single(25),
								 new card_struck_draw_card(2),
								 ],
								noone , e_card_type.red, noone);
		break;

		case e_card.coco_spin: card_ = new card("SPIN",
			function()  {
				return "DO "+damage_string(20)+" DAMAGE. TO [c_lime]ALL[] ENEMIES";
			}	, 10,		
			new card_struct_attack_all(20),
			noone , e_card_type.red, e_card.coco_up1_spin);
		break;
		
		
		case e_card.coco_up1_spin: card_ = new card("SPIN+",
			function()  {
				return "DO "+damage_string(30)+" DAMAGE. TO [c_lime]ALL[] ENEMIES";
			}	, 10,		
			new card_struct_attack_all(30),
			noone , e_card_type.red, noone);
		break;
		

		case e_card.coco_iron_punch: card_ = new card("IRON PUNCH",
			function()  {
				return "DO "+damage_string(20)+" DAMAGE. "+armor_string(20)+" ARMOR.";
			}	, 10,
			[new card_struct_attack_single(20)  ,  new card_struct_armor_player(20)],
			noone, e_card_type.red, e_card.coco_up1_iron_punch);
		break;
		
		case e_card.coco_up1_iron_punch: card_ = new card("IRON PUNCH+",
				function()  {
					return "DO "+damage_string(25)+" DAMAGE. "+armor_string(25)+" ARMOR.";
				}	, 10,
				[new card_struct_attack_single(25)  ,  new card_struct_armor_player(25)],
				noone, e_card_type.red, noone);
		break;

		case e_card.coco_liquid_luck: card_ = new card("LIQUID LUCK",
		function()  {
			return "NEXT CARD PLAYED THIS TURN HAS ["+sprite_get_name(keywords.lucky.sprite)+"] [c_yellow]"+keywords.lucky.title;
		}	, 10,
		[ new card_struct_buff(all_buffs.lucky, 1) ] ,
		[ keywords.lucky_dont_print ] ,  e_card_type.strat,e_card.coco_up1_liquid_luck);
		break;
		
				case e_card.coco_up1_liquid_luck: card_ = new card("LIQUID LUCK+",
				function()  {
					return "NEXT 2 CARDS PLAYED THIS TURN HAVE ["+sprite_get_name(keywords.lucky.sprite)+"] [c_yellow]"+keywords.lucky.title;
				}	, 10,
				[ new card_struct_buff(all_buffs.lucky,2)  ] ,
				[ keywords.lucky ] ,  e_card_type.strat,noone);
				break;		
		
		case e_card.coco_replay_red:  card_ = new card("SECOND WIND",
		function()  {
			return "THIS TURN. YOUR NEXT [c_yellow]RED CARD[] IS PLAYED [c_lime]TWICE."
		}	, 10,
		[ new card_struct_buff(all_buffs.replay_red, 1) ] ,
		noone ,  e_card_type.strat,e_card.coco_up1_replay_red);
		break;
		
			case e_card.coco_up1_replay_red : card_ = new card("SECOND WIND+",
				function()  {
					return "THIS TURN. YOUR NEXT [c_lime]2[] RED CARD IS PLAYED [c_lime]TWICE."
				}	, 10,
				[ new card_struct_buff(all_buffs.replay_red,2)  ] ,
				noone,  e_card_type.strat,noone);
				break;		

		
		case e_card.coco_nut_kick: card_ = new card("GROIN KICK",
				function()  {
					return "DO "+damage_string(30)+" DAMAGE.\nAPPLY "+get_debuff_turns(all_buffs.fragile, 2)+" [s_status_def_down] "+string(keywords.fragile.title)+".";}, 20,
				[new card_struct_attack_single(30) , new card_struct_buff_enemy(all_buffs.fragile, 2)], 
				[keywords.fragile] , e_card_type.red, e_card.coco_up1_nut_kick
				);
		break;
				case e_card.coco_up1_nut_kick: card_ = new card("GROIN KICK+",
					function()  {
							return "DO "+damage_string(30)+" DAMAGE.\nAPPLY "+get_debuff_turns(all_buffs.fragile, 3)+" [s_status_def_down] "+string(keywords.fragile.title)+".";}, 20,
					[new card_struct_attack_single(30) , new card_struct_buff_enemy(all_buffs.fragile, 3)], 
					[keywords.fragile] , e_card_type.red, noone
					);
				break;

		case e_card.coco_boomerang: card_ = new card("BOOMERANG",
				function()  {
					return "DO "+damage_string(20)+" DAMAGE [c_lime]"+get_x_times_string(2)+"[] TIMES TO [c_lime]ALL[] FOES.";
				}	, 30,
				[new card_struct_attack_all(20), new card_struct_attack_all(20)],
				noone , e_card_type.red, e_card.coco_up1_boomerang );
		break;
		
				case e_card.coco_up1_boomerang: card_ = new card("BOOMERANG+",
						function()  {
							return "DO "+damage_string(20)+" DAMAGE [c_lime]"+get_x_times_string(2)+"[] TIMES TO [c_lime]ALL[] FOES.";
						}	, 20,
						[new card_struct_attack_all(20), new card_struct_attack_all(20)],
						noone , e_card_type.red, noone);
				break;
		
		case e_card.coco_pebble_throw: card_ = new card("PEBBLE THROW",
				function()  {
					return "DO "+damage_string(2)+" DAMAGE [c_lime] X"+get_x_times_string(5)+"[] TIMES.";
				}	, 10,[
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				],
				[keywords.single_use] , e_card_type.red, e_card.coco_up1_pebble_throw);
		break;		
		
		case e_card.coco_up1_pebble_throw: card_ = new card("PEBBLE THROW+",
				function()  {
					return "DO "+damage_string(2)+" DAMAGE [c_lime] X"+get_x_times_string(8)+"[] TIMES.";
				}	, 10,[
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 				
				],
				[keywords.single_use] , e_card_type.red, noone);
		break;					
		
		
				case e_card.coco_wimpy_pebble_throw: card_ = new card("WIMPY PEBBLE THROW",
				function()  {
					return "DO "+damage_string(2)+" DAMAGE [c_lime] X"+get_x_times_string(5)+"[] TIMES.";
				}	, 10,[
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				],
				[keywords.single_use,  keywords.cant_crit] , e_card_type.red, e_card.coco_up1_wimpy_pebble_throw);
		break;		
		
		case e_card.coco_up1_wimpy_pebble_throw: card_ = new card("WIMPY PEBBLE THROW+",
				function()  {
					return "DO "+damage_string(2)+" DAMAGE [c_lime] X"+get_x_times_string(8)+"[] TIMES.";
				}	, 10,[
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 
				new card_struct_attack_single(2), 				
				],
				[keywords.single_use,  keywords.cant_crit] , e_card_type.red, noone);
		break;	
		
		
		case e_card.coco_discover_token: card_ = new card_condition("CALL FOR HELP", 
				function()  {
					return "CHOOSE A [c_lime]TOKEN[].\nIF YOU DEALT A [c_pink]CRIT[] THIS TURN CHOOSE [c_lime]3[]";
				}	, 10,
				new  card_struct_discover_token( false ) ,//get this if we don't meet the condition
				new  card_struct_discover_tokens_repeat( false ,3) ,//get this if we meet the condition
				[ keywords.token, keywords.choose_  ] , conditions.dealt_a_crit_this_turn , e_card_type.token, e_card.coco_up1_discover_token);
		//	card_.golden = true;
		break;
		
				case e_card.coco_up1_discover_token: card_ = new card_condition("CALL FOR HELP+",
						function()  {
							return "CHOOSE A [c_lime]TOKEN[].\nIF YOU DEALT A [c_pink]CRIT[] THIS TURN CHOOSE [c_lime]3[]";
						}	, 0,
						new  card_struct_discover_token( false ) ,//get this if we don't meet the condition
						new  card_struct_discover_tokens_repeat( false ,3) ,//get this if we meet the condition
						[ keywords.token, keywords.choose_  ] , conditions.dealt_a_crit_this_turn , e_card_type.token,noone);
				break;		
	
	
	
		case e_card.coco_hot_sauce:
					card_ = new card_or_condition("HOT SAUCE",
					function()  {
						return  "[c_lime]+5[] [s_status_pow]ATTACK[] [c_gum]OR[] [c_yellow]PAY 5 TOKENS[] TO GET [c_lime]+20[]";
					},
					function()  {
						return  "[c_lime]+5[] [s_status_pow]ATTACK[]";
					},
					function()  {
						return "[c_yellow]PAY 5 TOKENS[] TO GET [c_lime]+20[]";
					},20,
					  new card_struct_buff( all_buffs.attack , 5) ,
					[
					new card_struct_remove_all_tokens(),
					  new card_struct_buff( all_buffs.attack , 20)
					  ],
					 e_card_type.passive,
					[keywords.passive], conditions.have_five_tokens,e_card.coco_up1_hot_sauce);
		break;
	
				case e_card.coco_up1_hot_sauce:
							card_ = new card_or_condition("HOT SAUCE+", 
							function()  {
								return  "[c_lime]+10[] [s_status_pow]ATTACK[] [c_gum]OR[] [c_yellow]PAY 5 TOKENS[] TO GET [c_lime]+35[]";
							},
							function()  {
								return  "[c_lime]+10[] [s_status_pow]ATTACK[]";
							},
		
							function()  {
								return "[c_yellow]PAY 10 TOKENS[] TO GET [c_lime]+35[]";
							},20,
							  new card_struct_buff( all_buffs.attack , 10) ,
		
							[ new card_struct_remove_all_tokens(),
							  new card_struct_buff( all_buffs.attack , 35)
							  ],
							 e_card_type.passive,
							[keywords.passive], conditions.have_five_tokens,noone);
				break;	
	
	
	
		case e_card.coco_green_juice:


		card_ = new card("GREEN JUICE",
				function()  {
					return "[c_lime]+5[] RESILIENCE.";
				},
				10,
				new card_struct_buff(all_buffs.endurance, 5)
				,[keywords.endurance, keywords.passive],
				e_card_type.passive,e_card.coco_up1_green_juice);
				
		break;

				case e_card.coco_up1_green_juice:

				card_ = new card("GREEN JUICE+",
						function()  {
							return "[c_lime]+10[] RESILIENCE.";
						},
						10,
						new card_struct_buff(all_buffs.endurance, 10)
						,[keywords.endurance, keywords.passive],
						e_card_type.passive,noone);
				
				break;

		
		case e_card.coco_token_bee : card_ = new card_summon(e_token.coco_bee, 10, e_card.coco_up1_token_bee );
		break;	
		
				case e_card.coco_up1_token_bee : card_ = new card_summon(e_token.coco_bee, 0,noone);
				break;	
		
		
		case e_card.coco_token_bat : card_ = new card_summon(e_token.coco_bat, 10,e_card.coco_up1_token_bat);
		break;
		
				case e_card.coco_up1_token_bat : card_ = new card_summon(e_token.coco_bat, 0,noone);
				break;	
		
		
		case e_card.coco_token_beetle : card_ = new card_summon(e_token.coco_beetle, 10,e_card.coco_up1_token_beetle);
		break;		
		
				case e_card.coco_up1_token_beetle : card_ = new card_summon(e_token.coco_beetle, 0,noone);
				break;	

		case e_card.coco_token_salmon : card_ = new card_summon(e_token.coco_salmon, 10,e_card.coco_up1_token_salmon);
		break;
		
				case e_card.coco_up1_token_salmon : card_ = new card_summon(e_token.coco_salmon, 0,noone);
				break;

		case e_card.coco_token_dice : card_ = new card_summon(e_token.coco_dice, 10,e_card.coco_up1_token_dice);
		break;	
		
				case e_card.coco_up1_token_dice : card_ = new card_summon(e_token.coco_dice, 0,noone);
				break;	

		case e_card.coco_token_spider : card_ = new card_summon(e_token.coco_spider, 10, e_card.coco_up1_token_spider);
		break;		
		
			case e_card.coco_up1_token_spider : card_ = new card_summon(e_token.coco_spider, 0,noone);
			break;	
		
			case e_card.coco_token_red_copycat : card_ = new card_summon(e_token.coco_red_copycat, 10, e_card.coco_up1_token_spider);
		break;		
		
			case e_card.coco_up1_token_red_copycat : card_ = new card_summon(e_token.coco_red_copycat , 0,noone);
			break;	
		
		
		case e_card.coco_generate_wimpy_punch: card_ = new card("PREPARE WIMPY PUNCHES",
				function()  {
					return "ADD [c_lime]3[] [s_keyword_wimpy] [c_yellow]WIMPY PUNCHES[] INTO YOUR HAND"}, 10,
				new card_struct_generate_specific_card(e_card.coco_wimpy_punch, hand, 3), 
				[keywords.wimpy_punch] , e_card_type.strat, e_card.coco_up1_generate_wimpy_punch
				);
		break;


				case e_card.coco_up1_generate_wimpy_punch: card_ = new card("PREPARE WIMPY PUNCHES+",
						function()  {
							return "ADD [c_lime]5[] [s_keyword_wimpy] [c_yellow]WIMPY PUNCHES[] INTO YOUR HAND"}, 10,
						new card_struct_generate_specific_card(e_card.coco_wimpy_punch, hand, 5), 
						[keywords.wimpy_punch] , e_card_type.strat , noone
						);
				break;

				case e_card.coco_wimpy_punch: card_ = new card("WIMPY PUNCH",
					function()  {
								return "DEAL "+damage_string(player.wimpy_punch_damage+player.wimpy_punch_add_damage)+" DAMAGE"}, 0,
								new card_struct_attack_single(player.wimpy_punch_damage+player.wimpy_punch_add_damage) , 
					[keywords.single_use , keywords.cant_crit] , e_card_type.red, noone
				);
				card_.remove_after_combat = true;
				break;			
				
		
		case e_card.coco_reduce_hand_cost_and_armor: card_ = new card("WAX SCALES",
			function()  {
			return armor_string(20)+" ARMOR\nREDUCE THE COST OF YOUR HAND BY [c_lime]25%[]"}, 10,
			[new card_struct_reduce_cost_of(hand,.75, true) , new card_struct_armor_player(20)] , 
			[keywords.single_use], e_card_type.strat , e_card.coco_up1_reduce_hand_cost_and_armor
		);
	
		break;
		
		case e_card.coco_up1_reduce_hand_cost_and_armor: card_ = new card("WAX SCALES+",
			function()  {
			return armor_string(20)+" ARMOR\nREDUCE THE COST OF YOUR HAND BY [c_lime]50%[]"}, 10,
			[new card_struct_reduce_cost_of(hand,.5, true) , new card_struct_armor_player(20)] , 
			[keywords.single_use], e_card_type.strat, noone
		);
		break;
		
		case e_card.coco_lucky_punch: card_ = new card("LUCKY PUNCH",
			function()  {
			 return "DO "+damage_string(15)+" DAMAGE"}, 10, 
			 new card_struct_attack_single(15), 
			 [keywords.lucky], e_card_type.red, e_card.coco_up1_lucky_punch
		);
		break;	


		case e_card.coco_up1_lucky_punch: card_ = new card("LUCKY PUNCH+",
			function()  {
			 return "DO "+damage_string(25)+" DAMAGE"}, 10, 
			 new card_struct_attack_single(25), 
			 [keywords.lucky], e_card_type.red, noone);
		break;	
		
		case e_card.coco_generate_emergency_cake: card_ = new card("MAKE EMERGENCY PIE",
					function()  {
					return "ADD A CARD WITH [c_yellow]RETAIN[] THAT RESTORES [c_lime]10[] MANA"}, 0,
					new card_struct_generate_specific_card(e_card.coco_emergency_cake, hand, 1), 
					[keywords.single_use, keywords.retain_dont_print], e_card_type.strat , e_card.coco_up1_generate_emergency_cake, noone);
		break;
		
		case e_card.coco_up1_generate_emergency_cake: card_ = new card("MAKE EMERGENCY PIE+",
					function()  {
					return "ADD 2 CARDS WITH [c_yellow]RETAIN[] THAT RESTORES [c_lime]10[] MANA"}, 0,
					new card_struct_generate_specific_card(e_card.coco_emergency_cake, hand, 1), 
					[keywords.single_use, keywords.retain_dont_print], e_card_type.strat , noone
				);
		break;
		
		
		case e_card.coco_emergency_cake: card_ = new card("PIE",
				function()  {
					return "RESTORES [c_lime]10[] MANA"}, 0,
					new card_struct_change_mana(10), 
						[keywords.single_use, keywords.retain], e_card_type.strat, noone);
		break;		
		
		case e_card.coco_double_armor: card_ = new card("DOUBLE TROUBLE",
				function()  {
					return "DOUBLE YOUR ARMOR"}, 20,
					new card_struct_double_armor(), 
						noone, e_card_type.strat,e_card.coco_up1_double_armor);
		break;	
		
		case e_card.coco_up1_double_armor: card_ = new card("DOUBLE TROUBLE+",
				function()  {
					return "DOUBLE YOUR ARMOR"}, 0,
					new card_struct_double_armor(), 
						noone, e_card_type.strat ,noone);
		break;	


		case e_card.coco_keep_armor: card_ = new card("TURTLE STRAT",
				function()  {
					return "YOUR ARMOR [c_lime]ISN'T[] DESTROYED AT THE END OF THE TURN."}, 30,
					new card_struct_buff(all_buffs.armor_keep,1), 
					[keywords.passive], e_card_type.passive,e_card.coco_up1_keep_armor );
		break;	
		
		case e_card.coco_up1_keep_armor: card_ = new card("TURTLE STRAT+",
				function()  {
					return "YOUR ARMOR [c_lime]ISN'T[] DESTROYED AT THE END OF THE TURN."}, 20,
					new card_struct_buff(all_buffs.armor_keep,1), 
					[keywords.passive], e_card_type.passive,noone);
		break;
		
		case e_card.coco_armor_slam: card_ = new card("RAPID SPIN",
				function()  {
				return "DEAL DAMAGE [c_yellow]EQUAL[] YOUR ARMOR."},
				10,
				new card_struct_armor_slam(0),
				noone, e_card_type.red, e_card.coco_up1_armor_slam);
		break;	

		case e_card.coco_up1_armor_slam: card_ = new card("RAPID SPIN+",
				function()  {
				return "DEAL DAMAGE [c_yellow]EQUAL[] TO YOUR ARMOR."},
				0,
				new card_struct_armor_slam(0),
				noone, e_card_type.red, noone);
		break;	

	
		case e_card.coco_genereate_broken_bottle: 
			card_ = new card("BOTTLE",
				function()  {
				return "DEAL "+damage_string(10)+" DAMAGE. ADD A BROKEN BOTTLE TO YOUR [c_lime]DECK["},
				10,
				[new card_struct_attack_single(10),
				 new card_struct_generate_specific_card(e_card.coco_generated_broken_bottle,deck,1)				
				],
				[keywords.single_use,  new keyword_card_struct(e_card.coco_generated_broken_bottle) ], e_card_type.red,e_card.coco_up1_genereate_broken_bottle);
		break;


		case e_card.coco_up1_genereate_broken_bottle: 
			card_ = new card("BOTTLE",
				function()  {
				return "DEAL "+damage_string(15)+" DAMAGE. ADD A BROKEN BOTTLE TO YOUR [c_lime]DECK["},
				10,
				[new card_struct_attack_single(15),
				 new card_struct_generate_specific_card(e_card.coco_up1_generated_broken_bottle,deck,1)				
				],
				[keywords.single_use,  new keyword_card_struct(e_card.coco_up1_generated_broken_bottle) ], e_card_type.red , noone);
		break;

		case e_card.coco_generated_broken_bottle: card_ = new card("BROKEN BOTTLE",
			function()  {
			 return "DEAL "+damage_string(20)+" DAMAGE"}, 10, 
			 new card_struct_attack_single(20), 
			 [keywords.lucky], e_card_type.red, noone);
		break;
		
		case e_card.coco_up1_generated_broken_bottle: card_ = new card("BROKEN BOTTLE",
			function()  {
			 return "DEAL "+damage_string(30)+" DAMAGE"}, 10, 
			 new card_struct_attack_single(30), 
			 [keywords.lucky], e_card_type.red, noone);
		break;
		
		case e_card.coco_all_in:
						card_ = new card("ALL IN",
									function(){ return "DEAL "+damage_string(80)+" DAMAGE.\n[c_pink]ON CRIT:[] GET [c_yellow]+30[] MANA"; },
									30,
									
									[new card_struct_attack_single(80),
									 new card_struct_condition( function(){ if player.last_attack_was_a_crit {  change_mana( 30 ) } } )
									
									
									]//first is the script, second value is the argument for the script
									,[keywords.crit_gift], e_card_type.red,e_card.coco_up1_all_in);				
		break;	
		

		case e_card.coco_up1_all_in:
						card_ = new card("ALL IN+",
									function(){ return "DEAL "+damage_string(100)+" DAMAGE.\n[c_pink]ON CRIT:[] GET [c_yellow]+30[] MANA"; },
									30,
									
									[new card_struct_attack_single(100),
									 new card_struct_condition( function(){ if player.last_attack_was_a_crit {  change_mana( 30 )  } } )
									
									
									]//first is the script, second value is the argument for the script
									,[keywords.crit_gift], e_card_type.red,noone);					
		break;	
		
		case e_card.coco_add_temp_attack: 
		
		card_ = new card_condition("WASABI", 
					function()  {
						return "[c_lime]+4[] [s_status_pow_remove_on_crit]. IF YOU HAVE AT LEAST [c_yellow]20[] [s_status_pow_remove_on_crit], GET [c_lime]+10[] INSTEAD";
					}	, 10,
					new  card_struct_buff(all_buffs.temp_attack, 4) ,//get this if we don't meet the condition
					new card_struct_buff(all_buffs.temp_attack, 10)  ,//get this if we meet the condition
				[ keywords.temp_attack] , conditions.have_20_temp_attack , e_card_type.strat, e_card.coco_up1_add_temp_attack);
		break;
	
	case e_card.coco_up1_add_temp_attack: 
		
		card_ = new card_condition("WASABI+", 
					function()  {
						return "[c_lime]+6[] [s_status_pow_remove_on_crit]. IF YOU HAVE AT LEAST [c_yellow]20[] [s_status_pow_remove_on_crit], GET [c_lime]+15[] INSTEAD";
					}	, 10,
					new  card_struct_buff(all_buffs.temp_attack, 6) ,//get this if we don't meet the condition
					new card_struct_buff( all_buffs.temp_attack, 15) ,//get this if we meet the condition
				[ keywords.temp_attack] , conditions.have_20_temp_attack  , e_card_type.strat , noone);
		break;
		
		
	case e_card.coco_double_damage_on_crit: 
				card_ = new card("BEAR PUNCH", 
							function()  {
								return "DEAL "+damage_string(30)+" DAMAGE. [c_pink]ON CRIT:[] DOUBLE ALL DAMAGE";
							}	, 20,
							new card_struct_attack_single_multiply_on_crit(30, 2),
						noone, e_card_type.red , e_card.coco_up1_double_damage_on_crit);
	break;		
		
	case e_card.coco_up1_double_damage_on_crit: 
		
		card_ = new card("BEAR PUNCH+", 
					function()  {
						return "DEAL "+damage_string(30)+" DAMAGE. [c_pink]ON CRIT:[] TRIPLE ALL DAMAGE";
					}	, 20,
					new card_struct_attack_single_multiply_on_crit(30, 3),
				noone, e_card_type.red , noone);
	break;		
	
	case e_card.coco_ultra_armor: 
			card_ = new card("ULTRA ARMOR", 
							function()  {
								return "GAIN "+armor_string(100)+" ARMOR.";
							}	, 20,
							new card_struct_armor_player(100),
						[keywords.single_use], e_card_type.strat , e_card.coco_up1_ultra_armor);
	break;		
		
	case e_card.coco_up1_ultra_armor: 
			card_ = new card("ULTRA ARMOR", 
							function()  {
								return "GAIN "+armor_string(150)+" ARMOR.";
							}	, 20,
							new card_struct_armor_player(150),
						[keywords.single_use], e_card_type.strat , noone);
	break;

	case e_card.coco_clingy_shield: 
			card_ = new card("CLINGY ARMOR", 
							function()  {
								return "GAIN "+armor_string(40)+" ARMOR.";
							}	, 10,
							new card_struct_armor_player(40),
						[keywords.evaporate], e_card_type.strat , e_card.coco_up1_clingy_shield);
	break;	
	
	
	case e_card.coco_up1_clingy_shield: 
			card_ = new card("CLINGY ARMOR+", 
						function()  {
							return "GAIN "+armor_string(50)+" ARMOR.";
						}	, 10,
						new card_struct_armor_player(50),
						[keywords.evaporate], e_card_type.strat ,noone);
	break;	


	case e_card.coco_powerup_punch: 
			card_ = new card("POWER-UP PUNCH", 
							function()  {
								return "DEAL "+damage_string(10)+" DAMAGE. GET [c_lime]+4[] [s_status_pow_remove_on_crit]";
							}	, 10,
							[new card_struct_attack_single(10),
							new card_struct_buff(all_buffs.temp_attack, 4)],
						[keywords.cant_crit, keywords.temp_attack], e_card_type.red , e_card.coco_up1_powerup_punch);
	break;	

	case e_card.coco_up1_powerup_punch: 
			card_ = new card("POWER-UP PUNCH+", 
							function()  {
								return "DEAL "+damage_string(15)+" DAMAGE. GET [c_lime]+8[] [s_status_pow_remove_on_crit]";
							}	, 10,
							[new card_struct_attack_single(15),
							new card_struct_buff(all_buffs.temp_attack, 8)],
						[keywords.cant_crit, keywords.temp_attack], e_card_type.red , noone);
	break;	
	

	
	case e_card.coco_focus: 
			card_ = new card("FOCUS", 
							function()  {
								return "[c_lime]+6[] [s_status_pow_remove_on_crit]. LOSE [c_gum]-6[] [s_status_pow_remove_on_crit] AT THE END OF YOUR TURN";
							}	, 0,
							[new card_struct_buff(all_buffs.temp_attack, 6),
							new card_struct_buff(all_buffs.temp_attack_lose_at_the_end, 6)
							],
						[keywords.temp_attack], e_card_type.strat , e_card.coco_up1_focus);
	break;	
	
	case e_card.coco_up1_focus: 
			card_ = new card("FOCUS+", 
							function()  {
								return "[c_lime]+10[] [s_status_pow_remove_on_crit]. LOSE [c_gum]-10[] [s_status_pow_remove_on_crit] AT THE END OF YOUR TURN";
							}	, 0,
							[
							new card_struct_buff(all_buffs.temp_attack, 10),
							new card_struct_buff(all_buffs.temp_attack_lose_at_the_end, 10)
							],
						[keywords.temp_attack], e_card_type.strat , noone);
	break;	
	
	
	
	case e_card.coco_coupe_de_grace: 
				card_ = new card("COUP DE GRACE", 
							function()  {
								return damage_string(30)+" DAMAGE. [c_yellow]"+keywords.execute.title+":[] [c_lime]+5[] [s_heart_no_border] MAX HP. "+keywords.execute.title+" WITH [c_pink]CRIT:[] ALSO ADD [c_lime]+10%[] CRIT DAMAGE";
							}	, 10,
							new card_struct_attack_single_killed_with_crit(30, function(){ player.hp_max += 5;  restore_health(player,5) },    function(){  add_crit_damage(.1, true )  }),
						[keywords.permanent_effect, keywords.single_use, keywords.execute], e_card_type.red , e_card.coco_up1_coupe_de_grace);
	break;	
	
	
	case e_card.coco_up1_coupe_de_grace: 
				card_ = new card("COUP DE GRACE+", 
							function()  {
								return damage_string(30)+" DAMAGE. [c_yellow]"+keywords.execute.title+":[] [c_lime]+10[] [s_heart_no_border] MAX HP. "+keywords.execute.title+" WITH [c_pink]CRIT:[] ALSO ADD [c_lime]+15%[] CRIT DAMAGE";
							}	, 10,
							new card_struct_attack_single_killed_with_crit(30, function(){ player.hp_max += 10; restore_health(player,5) },    function(){  add_crit_damage(.15, true )  }),
						[keywords.permanent_effect , keywords.single_use, keywords.execute], e_card_type.red , noone);
	break;
	
	
	case e_card.coco_token_summoning: 
				card_ = new card("CHEER SQUAD", 
							function()  {
								return "[c_lime]+10[] MANA AFTER [c_yellow]SUMMONING A TOKEN[]"
							}	, 20,
							new card_struct_buff(all_buffs.token_summoning_restores_mana, 10 ),
						[keywords.passive], e_card_type.passive , e_card.coco_up1_token_summoning);
	break;	
	
	case e_card.coco_up1_token_summoning: 
				card_ = new card("CHEER SQUAD+", 
							function()  {
								return "[c_lime]+10[] MANA AFTER [c_yellow]SUMMONING A TOKEN[]"
							}	, 10,
								new card_struct_buff(all_buffs.token_summoning_restores_mana, 10 ),
						[keywords.passive], e_card_type.passive , noone);
	break;
	
	
	
	
	
}

card_.original_cost = card_.cost;
card_.enum_ = card_enum;

return card_;

}



function add_crit_chance(amount, permanent ){

	player.crit_chance += amount;
	
	if permanent { 
	player.crit_starting_chance += amount;
	}
	player.crit_chance = clamp(player.crit_chance,0,1); 
	player.crit_starting_chance = clamp(player.crit_starting_chance,0,1); 
}
function add_crit_damage(amount, permanent ){
	//if we want to add 100% crit damage we add a 1. this will convert it correctly
	
	
	player.crit_damage += amount;
	if permanent { 
	player.crit_starting_damage += amount;
	}
}