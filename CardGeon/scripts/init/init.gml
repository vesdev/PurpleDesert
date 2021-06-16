// Script assets have changed for v2.3.0 see
#macro DEPTH_AHEAD_GAME -550
#macro DEPTH_GAME -500
#macro DEPTH_BEHIND_GAME -450
#macro DEPTH_MAP -400

function boon_randomize() {
	//CUSTOM RANDOMIZE FUNCTION
	randomize();
	//eventually add daily runs and shit and use the same seed
}
//high ground advantage, all attacks deal +1 dama:ge
//every turn you regain mana back
//start the game with 100 max mana, every turn regain 60 mana
//cards typically cost 20 mana to play 20 mana = 1 mana
//every turn you regain 60 mana

//https://slay-the-spire.fandom.com/wiki/Buffs  great base until we get something original
//https://slay-the-spire.fandom.com/wiki/Debuff
	
function struct_buff(amount, lose_per_turn, sprite,  title, desc_func ) constructor  { 
	self.amount = amount;
	self.lose_per_turn = lose_per_turn;
	self.title = title;
	self.desc = desc_func;
	self.sprite = sprite;
	hovered_over_status = false;
	delay_status_for_a_turn = false;
	played_init_animation = false;
	flag = false; // flag in case we want to delay the effect for 1 turn 
//	self.get_desc_argument = get_desc_argument;
	sprite_x = 100;
	sprite_y = -100;
	offset_y = 0;
	offset_x = 0;
	created_timer = -1;
	created_time = SEC*.35; //transition period when it gets created
}




function entity_parent() constructor { 
	
	hp = 0;
	hp_max = 0;
	attack = 0;
	defence = 0;
	armor = 0;	
	active_buffs = [];
	


	second_crit_mod = 1;
	
	damage_mod_from_copycat = 1;
	
	#region tempoary variables get run in the step event and reset back to 0
	
	tempoary_crit_chance = 0;// resets back to 0 in the step event
	tempoary_crit_damage = 0;//
	blocking_sprite = s_white_square;
	
	check_for_buff = false;
	#endregion
	can_crit = true;
	force_crit = false;
	summon_ability = [];
	passive_ability = [];
	death_ability = [];
	alive_for_this_amount_of_turns = noone;
	
	just_killed_an_enemy_func = noone;
	just_killed_an_enemy_with_crit_func = noone;
	
	
	death_message = get_death_message();
	has_been_targeted = false;
	force_flash_color = false;
	force_outline_color = false;
//HEALTH BAR
	potential_health_lerp = 1;
	health_bar_hit_timer = 0;
	delay_health_bar_timer = -1;
	health_bar_timer = 0;
	health_bar_x_offset = 0;
	health_bar_y_offset = 0;
	health_bar_lerp = 0;
	armor_bar_lerp = 0;
	
	armor_ui_timer = 0;
	armor_bar_front_lerp = 0;
	armor_bar_back_lerp = 0;
	
	armor_destroy_image_index = 0;
	armor_destroy_enable = 0;
	
	#region relics
	crit_chance = 0;
	crit_damage = 1;
	
	wimpy_punch_damage = 10;
	wimpy_punch_add_damage = 0;
	#endregion
	
	draw_starting_amount = 5;
	
	intent_timer = 0;
	
	showing_intentions = false;
	
	last_attack_was_a_crit = false;
	
	
	selected_by_card  = { 
	enable : false,
	timer : 0,
	time : SEC,
	color : C_YELLOW,
	}
	
	///SPRITE
	sprite_idle		=  noone;
	sprite_hit		=  noone;
	sprite_low_hp = noone;
	sprite_victory = noone;
	current_sprite = sprite_idle;
	sprite_image_index = 0;
	
	//HAS BEEN HIT
	has_been_hit_timer = -1;
	has_been_hit_time = SEC;
	trigger_hit_animation = false;

//TRANSFORM
	xoffset = 0;
	yoffset = 0;
	self.x = -50000;
	self.y = -50000;
	self.z = 0;
	self.sprite_image_index = 0;
	sprite_image_speed = .05;
	self.xscale = 1;
	self.yscale = 1;
	angle = 0;
	self.xscale_facing = 1;
	z_speed = 0;
	bounce_amount = .55;
	gravity_ = .2;
	
	
	
//DEATH
	enable_death = 0;
	enable_death_timer = 0;
	enable_death_time = SEC*.5;
	
damage_number = { 
	
	onscreen : false,
	intro_easesing_type : e_ease.easeoutexpo,
	outro_easesing_type : e_ease.easeinexpo,
	is_a_crit : false,
	text_color : c_white,
	amount : 0,
	intro_timer : 0,
	
	stay_static_timer : 0,
	stay_static_time_func : function() {
								var mod_ = 2;
								if fast_mode { 
									mod_ = .75;
								}
										return SEC*mod_;
								},
	
	outro_timer : 0,
	
	
	intro_time_func : function() {
					var mod_ = 1;
					if fast_mode { 
						mod_ = .75;
					}
					return SEC*1*mod_;
				},
	outro_time_func : function() {
					var mod_ = 1;
					if fast_mode { 
						mod_ = .25;
					}
					return SEC*.5*mod_;
				}
}
	
#macro ALL noone
buff = { 
	//if we choose to it reduce 1 stack per turn then it will then say:  REMOVE [c_gum]1[] STACK PER TURN.
		attack:				 new struct_buff(0,0,s_status_pow, "ATTACK",  function(amount) { if amount > 0 {  return "INCREASE DAMAGE BY [c_lime]"+string(amount)+"[]"}else{return "DECREASE DAMAGE BY [c_lime]"+string(amount)+"[]"}}) ,
		fragile:			 new struct_buff(0,1, s_status_def_down ,"FRAGILE" , function(amount) { return "TAKES [c_gum]"+string(amount)+"%[] DAMAGE FROM ATTACKS."}),
		attack_lost_on_crit: new struct_buff(0,0, s_status_pow_remove_on_crit, "TEMPOARY ATTACK", function(amount) {  return "INCREASE DAMAGE BY [c_lime]"+string(amount)+"[]\n[c_gum]BUFF IS REMOVED AFTER CRIT[]"}) ,
		attack_lost_on_crit_lose_at_turns_end : new struct_buff(0,0, s_status_pow_remove_on_crit_lose, "LOSE TEMP ATTACK", function(amount) {  return "LOSE [c_gum]"+string(amount)+"[] TEMP ATTACK AT THE END OF YOUR TURN"}) ,
		enrage:				 new struct_buff(0,0, s_status_enrage, "ENRAGE", function(amount) {  return "[c_yellow]+"+string(amount)+"[] ATTACK AT THE END OF ITS TURN"}) ,
		cornered_rat:		 new struct_buff(0,0, s_status_fight_or_flight, "CORNERED RAT", function(amount) {  return "GET [c_yellow]+"+string(amount)+"[] [s_status_pow] ATTACK AND [c_yellow]+"+string(amount*2)+"[] [s_status_armor] ARMOR  WHEN IT'S THE [c_gum]LAST ENEMY[]"}) ,
		asleep:				 new struct_buff(0,1, s_status_sleep, "SLEEP", function(amount) {  return "TARGET WAKES UP WHEN HIT"}) ,
		slow_start :		 new struct_buff(0,1, s_status_slow, "SLOW START", function(amount) { return "TARGET DEALS [c_gum]-50%[] DAMAGE."}),
		find_weakness :		 new struct_buff(0,0, s_status_find_weakness, "ATTACK ONLY", function(amount) { return "GAINS [c_gum]+"+string(amount)+"[] ATTACK WHEN "+player.title+" PLAYS A [c_blue]BLUE[] CARD"}),
		weak:				 new struct_buff(0,1, s_status_atk_down ,"WEAK" , function(amount) { return "[c_gum]-"+string(amount)+"%[] DAMAGE FROM ATTACKS."}),
		armor_reduction:	 new struct_buff(0,1, s_status_armor_reduction ,"ARMOR REDUCTION" , function(amount) { return "GET [c_gum]-"+string(amount)+"%[] LESS ARMOR FROM [c_yellow]ALL[] SOURCES."}),
		pollen:				 new struct_buff(0,0, s_status_pollen,"STICKY POLLEN", function(amount) { return "WHEN HIT, REDUCE "+player.title+"'S DAMAGE BY [c_gum]25%[] FOR 1 TURN. (DOESN'T STACK)"}),
		weak_poison:		 new struct_buff(0,-1, s_status_weak_poison,"WEAK POISON", function(amount) { return "AT THE END OF THE TURN TAKE [c_yellow]"+string(amount)+"[] DAMAGE. DAMAGE CAN BE BLOCKED BY [s_status_armor] [c_yellow]ARMOR. REMOVE [c_status_weak_poison] WEAK POISON AT THE START OF YOUR TURN."}),
		poison:				 new struct_buff(0,1, s_status_poison,"POISON", function(amount) { return "AT THE END OF THE TURN TAKE [c_yellow]"+string(amount)+"[] [c_gum]UNBLOCKABLE[] DAMAGE."}),
		endurance:			 new struct_buff(0,0, s_keyword_endurance,"RESILIENCE", function(amount) { return"GET [c_yellow]"+string(amount)+"[] ARMOR FROM [c_blue]BLUE[] CARDS."}),
		armor_keep:			 new struct_buff(0,0, s_keyword_armor_keep,"ARMOR KEEP", function(amount) { return"ARMOR [c_lime]ISN'T[] DESTROYED AT THE START OF YOUR TURN."}),
		lucky:				 new struct_buff(0,0, s_status_lucky,"LUCKY", function() { return"THIS TURN YOUR NEXT CARD [c_lime]ALWAYS[] CRITS."}),
		replay_red:	 new struct_buff(0,0, s_status_replay_red,"REPLAY RED", function(amount) { return"YOUR NEXT [c_yellow]"+string(amount)+" RED CARD(S)[] IS PLAYED [c_lime]AGAIN."}),
		token_summoning_restores_mana :	 new struct_buff(0,0, s_status_cheer_squad,"CHEER SQUAD", function(amount) { return"RESTORE [c_lime]"+string(amount)+"[] MANA WHEN YOU SUMMON A TOKEN."}),
		crit_chance_up :  new struct_buff(0,0, s_status_crit_chance_up,"HONEYCOMB", function(amount) { return"[c_lime]+"+string(round( 100*amount*(player.token_stats[@ e_token.coco_bee].starting_amount+player.token_stats[@ e_token.coco_bee].output1()  )))+"%[] [s_keyword_lucky] CRIT CHANCE [c_gum]BUFF IS LOST ON CRIT.[]\n[c_aqua]TOTAL CRIT CHANCE: "+string( round( get_crit_chance(player)*100))+"%"     }),
		crit_damage_up :  new struct_buff(0,0, s_status_crit_damage_up,"BATWING", function(amount) { return"[c_lime]+"+string(round( 100*amount*(player.token_stats[@ e_token.coco_bat].starting_amount+player.token_stats[@ e_token.coco_bat].output1())  ))+"%[] [s_keyword_attack] CRIT DAMAGE [c_gum]BUFF IS LOST ON CRIT.[]\n[c_aqua]TOTAL CRIT DAMAGE:  "+string( round( get_crit_damage(player)*100))+"%"		}),



		//special enemy buffs
		horror_timepiece:  new struct_buff(0,0, s_status_horror_timepiece,"HORROR TIMEPIECE", function(amount) { return"AFTER PLAYING [c_gum]"+string(amount)+"[] CARDS, [c_gum]NEGATE[] THAT CARD AND [c_gum]END[] YOUR TURN."}),
//		defense :						[ 0, "RESILIENCE", function(amount) { return "INCREASE ARMOR BY [c_lime]"+string(amount)+"[]"}],
//		magic_armor  :			[ 0, "MAGIC ARMOR", function(amount) { return "NEGATE  [c_lime]"+string(amount)+"[] DEBUFFS"}],
//		roll_dodge :					[ 0, "ROLL DODGE" ,function(amount) { return "PREVENT THE NEXT "+string(amount)+"[] TIME YOU LOSE HEALTH"}],
//		flying			 :				[ 0, "FLYING" ,function(amount) { return "PREVENT THE NEXT TIME YOU LOSE HEALTH, LASTS [c_lime]"+string(amount)+"[] TURNS"}],
//		living_armor :				[ 0, "LIVING ARMOR" ,function(amount) { return "AT THE END OF YOUR TURN GAIN  [c_lime]"+string(amount)+"[] ARMOR"}],
//
//		counter :						[ 0, "COUNTER" ,function(amount) { return "WHEN HIT DEAL  [c_lime]"+string(amount)+"[] BACK"}],
//		power_creep :		    	[ 0, "POWER CREEP" ,function(amount) { return "GAIN  [c_lime]"+string(amount)+"[] STRENGTH PER TURN."}],
//		metal_man :			    	[ 0, "TURTLE STRAT" ,function(amount) { return "ARMOR IS [c_lime]NOT REMOVED[] AT THE END OF YOUR TURN."}],
//		fragmented_armor:		[ 0, "FRAGMANTED ARMOR",  function(amount) { return "AT THE END OF YOUR TURN GAIN "+string(amount)+". LOWER THIS BY [c_yellow]1[] FOR EVERY UNBLOCKED DAMAGE" }],
//		double_damage:			[ 0, "DOUBLE DAMAGE", function(amount) { return "AT THE END OF YOUR TURN GAIN "+string(amount)+". LOWER THIS BY [c_yellow]1[] FOR EVERY UNBLOCKED DAMAGE" }],
//		regeneration:				[ 0, "REGENERATION",  function(amount) { return "AT THE END OF YOUR TURN HEAL "+string(amount)+" HP AND REDUCE [c_lime]REGEN[] BY 1." }],
//
//		burned_out:					[ 0,"BURNED OUT" , function(amount) { return "LOSE  [c_gum]"+string(amount)+"[] STRENGTH AT THE END OF YOUR TURN."}],
//		no_draw:						[ 0,"NO DRAW" , function(amount) { return "YOU CAN'T DRAW ANY MORE CARDS THIS TURN."}],
//		weak:							[ 0,"WEAK" , function(amount) { return "TARGET DEALS [c_gum]"+string(amount)+"[] LESS ATTACK DAMAGE"}],
//		rusty:							[ 0,"RUSTY" , function(amount) { return "DECREASE ARMOR GAINED BY [c_gum]"+string(amount)+"[]"}],
//		poison:							[ 0,"POISON" , function(amount) { return "AT THE BEGGINING OF THEIR TURN, TARGET LOSES [c_gum]"+string(amount)+"[] HP AND 1 STACK OF POISON."}],
//		draw_reduction:			[ 0,"DRAW REDUCTION" , function(amount) { return "AT THE BEGGINING OF YOUR TURN DRAW [c_gum]"+string(amount)+"[] LESS CARD."}],
//		fires_stack:					[ 0,"FIRE STACKS" , function(amount) { return "AT THE END OF YOUR TURN DEAL [c_gum]"+string(amount)+"[] DAMAGE."}],
//	
//		roll_dodge :					[ 0, "ROLL DODGE" ,function(amount) { return "PREVENT THE NEXT "+string(amount)+"[] TIME YOU LOSE HEALTH"}],
//		flying			 :				[ 0, "FLYING" ,function(amount) { return "PREVENT THE NEXT TIME YOU LOSE HEALTH, LASTS [c_lime]"+string(amount)+"[] TURNS"}],
//		living_armor :				[ 0, "LIVING ARMOR" ,function(amount) { return "AT THE END OF YOUR TURN GAIN  [c_lime]"+string(amount)+"[] ARMOR"}],
//		counter :						[ 0, "COUNTER" ,function(amount) { return "WHEN HIT DEAL  [c_lime]"+string(amount)+"[] BACK"}],
//		power_creep :		    	[ 0, "POWER CREEP" ,function(amount) { return "GAIN  [c_lime]"+string(amount)+"[] STRENGTH PER TURN."}],
//		metal_man :				 	[ 0, "TURTLE STRAT" ,function(amount) { return "ARMOR IS [c_lime]NOT REMOVED[] AT THE END OF YOUR TURN."}],
//		fragmented_armor:		[ 0, "FRAGMANTED ARMOR",  function(amount) { return "AT THE END OF YOUR TURN GAIN "+string(amount)+". LOWER THIS BY [c_yellow]1[] FOR EVERY UNBLOCKED DAMAGE" }],
//		double_damage:			[ 0, "DOUBLE DAMAGE", function(amount) { return "AT THE END OF YOUR TURN GAIN "+string(amount)+". LOWER THIS BY [c_yellow]1[] FOR EVERY UNBLOCKED DAMAGE" }],
//		regeneration:				[ 0, "REGENERATION",  function(amount) { return "AT THE END OF YOUR TURN HEAL "+string(amount)+" HP AND REDUCE [c_lime]REGEN[] BY 1." }],
}
}

init_tokens();

function  playable_character(title, hp, spr_idle, spr_hit, spr_low_hp, spr_victory, hover_over_desc_func,char_enum) : entity_parent() constructor{

	self.title = title;
	self.hp = hp;
	self.hp_max = hp;
	self.mana = 30; //amount of your current mana
	self.mana_gain = 30; //amount of mana you gain per round
	self.mana_max = 30; //maximum mana capacity

	self.char_enum = char_enum;
	self.golden_keys = 0;
	
	card_removal_price = 10;
	
	rest_area_restore_mod = .3;
	card_shop_options = 3;//keep this
	token_shop_options = 2;
	
	crit_starting_chance = 0;
	crit_starting_damage = 0;
	chest_reroll = 0;


	find_spoil_chance_init = .4;//starts_with this
	find_spoil_chance_reset = .1;//when we find a spoil reset it to this
	find_spoils_chance = .1;//resets to
	find_spoils_chance_add = .1;//

	token_stats = [];
	
	
	for (var i =0; i < e_token.size_; i++){ 
	
	var turn = 5;
	var starting_amount_ = 0;
	var amount1 = 1;
	var amount2 = 0;
	var amount3 = 0;
	switch i { 
		case e_token.coco_bat: starting_amount_ = .2;
		break;
		
		case e_token.coco_bee: starting_amount_ = .15;
		break;
		
		case e_token.coco_spider:
		case e_token.coco_red_copycat: turn = 1;
		break;
		
		case e_token.coco_salmon:
		case e_token.coco_beetle: turn = 5; starting_amount_ = 5;
		break;
	}
	array_push(token_stats, new master_token_struct(turn , starting_amount_));
	}
	
	
	self.default_draw_amount = 5;
	self.hover_over_desc_func = hover_over_desc_func;

	self.sprite_idle			= s_char_idle_coco;
	self.sprite_hit				= s_char_hit_coco;
	self.sprite_low_hp			= s_char_uneasy_coco;
	self.sprite_victory			= s_char_victory_coco;
	current_sprite				= sprite_idle;
	
	self.this_turn_token_was_summoned = false;
	self.this_turn_token_died = false;
	
	max_token_amount = 5;
	token_array = [];
	gold = 0;	
}

function  enemy( hp , attack_array,randomize_queue , sprite_idle, sprite_hit, title) : entity_parent()constructor{

	self.hp = hp;
	self.hp_max = hp;
	self.attack_array = attack_array;
	self.current_attack_queue = 0; //starts the attack queue
	self.current_attack_script_queue = 0; //if we have multiple attacks per turn then have on which attack are we on?
	
	flag_01 = false;//false for misc use
	step_event = noone; //if not noone will run the function here
	
	
	self.randomize_queue = randomize_queue;

	self.sprite_idle		=  sprite_idle;
	self.sprite_hit		=  sprite_hit;
	current_sprite = sprite_idle;
	
	self.xscale_facing = -1;
	self.title = title;
	self.attacks_remaining = -1;
	
	self.cant_lose_armor_for_x_turns = 0;

	self.x_offset = 0;
	self.intention_x_offset_default = 0;
	self.intention_y_offset_default = 25;
	
	self.intention_x_offset = 0;
	self.intention_y_offset = 25 +30;
	self.intention_change_amount = 0;
	self.x = 900;
	self.y = 0;
	self.sprite_index = 0;
	self.finished_attacking = false;
	self.current_target = player;
}

enum e_enemies  { 
	fat_tony,
	babydragon,
	firefox,
	pear,
	sleepy,
	bear,
	bee,
	snake,
	boss_1_cloak,
	boss_1_dragon,
	boss_1_antlion,
	size_
}

enum e_script_enemy_target { 
	self_,
	size_
}


function new_enemy(enemy_enum) {
			var returned_enemy = noone;
			
			
			switch enemy_enum {
				case e_enemies.fat_tony: returned_enemy = new enemy( 300, 
										[
										new intent_attack([10,2]), //8 DAMAGE , 2 TIMES
										new intent_buff(all_buffs.attack, 10),
										new intent_attack(20),
										]
										,true , s_idle_fat_tony,s_hit_fat_tony,"FAT TONY") //, [intentions.attack , 10] 
				break;	
				
				case e_enemies.babydragon:					
				
		
					
				returned_enemy = (new enemy( 150, 
								[
								new intent_debuff(all_buffs.weak,1),
								new intent_attack([4,2]),// 4 DAMAGE 2 TIMES
								new intent_armor(15)
								]
								,true , s_idle_babydragon,s_hit_babydragon,"BABY DRAGON")); //, [intentions.attack , 10] 
								buff_set(returned_enemy.buff.cornered_rat, 15);
								
			break;	
					
				case e_enemies.firefox:				
				
				var intent_struct_ = new intent_buff(all_buffs.enrage, 5);
					intent_struct_.remove_on_use = true;
						
					returned_enemy =
								new enemy( 250, 
								[intent_struct_,
								new intent_attack(15),
								]
								,false ,  s_idle_fox,s_hit_fox,"GIANT TOOL"); //, [intentions.attack , 10] 
				break;	
				
				case e_enemies.sleepy:	
					returned_enemy = new enemy(500, 
								[
													
								new intent_attack(20),
								new intent_buff(all_buffs.attack,10),								
								]
								,true ,s_char_sleepy_idle ,  s_char_sleepy_hit , "SLEEPY"); //, [intentions.attack , 10] 
							
							
							buff_set(returned_enemy.buff.asleep, 3);
							returned_enemy.step_event = method(returned_enemy, 
							
							function() {
								if !flag_01 and hp != hp_max || !flag_01 and hp = hp_max and self.buff.asleep.amount = 0{ 
									flag_01 = 1;
									//ok we took damage and we woke up, now we give ourselves the 
									//negative debuff SLOW START
									self.buff.asleep.amount = 0;
									add_buff(self, all_buffs.slow_start, 3);
									return true;
								}
							}
							);
							
				break;					
			
			
				case e_enemies.pear: returned_enemy = new enemy( 100, 
										[
										new intent_add_card(deck, e_card.status_tired, 1), //8 DAMAGE , 2 TIMES
										new intent_attack(20),
										/*new intent_buff_armor(all_buffs.attack, 3, 15),
										,*/
										]
										,true , s_char_pear_idle,s_char_pear_hit,"PURPLE PEAR") //, [intentions.attack , 10] 
				break;	
			

				case e_enemies.bear: 
				
				var intent_struct_ = new intent_buff(all_buffs.find_weakness, 2);
				intent_struct_.remove_on_use = true;
				
				returned_enemy = new enemy( 300, 
				
										[
										intent_struct_, //8 DAMAGE , 2 TIMES
										new intent_attack(17)
										/*new intent_buff_armor(all_buffs.attack, 3, 15),
										,*/
										]
										,false , s_idle_bear,s_hit_bear,"AVERAGE BEAR") //, [intentions.attack , 10] 
				break;

				case e_enemies.bee: returned_enemy = new enemy( 50, 
										[
										new intent_buff(all_buffs.attack, 10), //8 DAMAGE , 2 TIMES
										new intent_attack(10)
										/*new intent_buff_armor(all_buffs.attack, 3, 15),
										,*/
										]
										,true , s_idle_bumblebee,s_hit_bumblebee,"BIG BEE") //, [intentions.attack , 10] 
						buff_set(returned_enemy.buff.pollen , 1);
					break;
					
					
				case e_enemies.snake: returned_enemy = new enemy( 80, 
				
										[
										new intent_attack(20), //deal damage and apply a debuff
										new intent_debuff(all_buffs.armor_reduction,1),
										new intent_attack_debuff(all_buffs.weak_poison, 20, 10),
										new intent_debuff(all_buffs.weak,1)
										
										/*new intent_buff_armor(all_buffs.attack, 3, 15),
										,*/
										]
										,true , s_idle_snake,s_hit_snake,"SNEAKY SNAKE") //, [intentions.attack , 10] 
				break;					
		
		
		
				case e_enemies.boss_1_antlion: 
				
						var intent_struct_ = new intent_buff(all_buffs.find_weakness, 1);
				intent_struct_.remove_on_use = true;
				
				returned_enemy = new enemy(1000, 
										[
										new intent_buff(all_buffs.find_weakness, 1),
										new intent_attack(15),
										new intent_debuff(all_buffs.weak, 3),
										new intent_attack(20),
										new intent_add_card(deck,e_card.status_self_doubt,3),
										new intent_attack([5,5]), //8 DAMAGE , 2 TIMES
										new intent_debuff(all_buffs.armor_reduction, 4),
										new intent_attack(20)
										
										]
										,false , s_idle_antlion,s_hit_antlion,"FOX-LION") //, [intentions.attack , 10] 
				break;	
				
				case e_enemies.boss_1_dragon: 
				
				var intent_struct_ = new intent_buff(all_buffs.enrage, 1);
				
					intent_struct_.remove_on_use = true;
				
				returned_enemy = new enemy(1000, 
										[
										intent_struct_,
										new intent_attack(10),
										new intent_debuff(all_buffs.armor_reduction, 2),
										new intent_attack(20),
										new intent_add_card(deck,e_card.status_self_doubt,2),
										new intent_attack(20),
										new intent_attack([1,10]), //8 DAMAGE , 2 TIMES
										]
										,false , s_idle_dragon,s_hit_dragon,"ADULT DRAGON") //, [intentions.attack , 10] 								
										
										buff_set(returned_enemy.buff.cornered_rat , 5);
			break;	

			case e_enemies.boss_1_cloak: 
				
			
					returned_enemy = new enemy(1000, 
										[
										new intent_attack(20),
										new intent_debuff(all_buffs.endurance, -3),
										new intent_attack(40),
										new intent_add_card(deck,e_card.status_self_doubt,2),
										new intent_attack(45),
										new intent_debuff(all_buffs.attack, -3),
										new intent_attack([5,10]), //8 DAMAGE , 2 TIMES
										]
										,false , s_idle_cloak,s_hit_cloak,"THE THING") //, [intentions.attack , 10] 								
										
										buff_set(returned_enemy.buff.horror_timepiece , 10);
				break;	

			}
	
	
				
	
			if returned_enemy = noone { 
				show_debug_message("ERROR")	
				return;
			}


			//randomize attacks
			if returned_enemy.randomize_queue {
				boon_randomize();
				var len = array_length(returned_enemy.attack_array) - 1;//returns 4 but arrays start with 0
						  returned_enemy.current_attack_queue = irandom(len);
		    
			}else{
				show_debug_message("NO RANDOM");
			}
			return returned_enemy;
}







function ds_list_move(move_from_ds,move_from_pos,move_to_ds) { 
		if ds_list_size(move_from_ds) <= 0 { 
			return;	
		}
		var card_to_move = move_from_ds[| move_from_pos];
	
		ds_list_delete(move_from_ds,move_from_pos);
		ds_list_add(move_to_ds,card_to_move);	
}


 #region helpers
function create(_x, _y, inst) {

	var instance = instance_create_layer(_x,_y,"Instances",inst);
	return instance;
}
#region vector
Vector2 = function(_x, _y) constructor
    {
    x = _x;
    y = _y;
    static Add = function( _other )
        {
        x += _other.x;
        y += _other.y;
        }	
    }
v1 = new Vector2(10,10);
#endregion

#endregion

enum e_target { 
	single,
	all_enemies,
	player,
	none,
	size_
}




function get_target_type(struct) constructor{ 
	//gets the target type of a card, prioritizes single target
	var length = array_length(struct.card_script);
	



	if is_array(struct.card_script) { 


		var target_type = noone;
		for (var i= 0; i < length; i++){ 
			
			if  target_type != e_target.single{ 
				target_type = struct.card_script[@ i].type;
				
			}
			
		}
		return target_type;
	}else{
			return struct.card_script.type;
	}
}


function  discover_default_token(creator) {//player discovers it 
	
	
}

function  damage_single_unit(creator, target ,   damage) {
	
			sleep(20);
			var total_damage = check_damage(creator, target,  damage);
			total_damage = change_health(creator, target, total_damage,true,true);
			return total_damage;
}


function generate_specific_card(card_enum, list_location, how_many_copies) { 

	repeat(how_many_copies) {
		var card_ = card_struct(card_enum);
		card_.remove_after_combat = true;
		if list_location != hand { 
		
			ds_list_add(list_location, 	card_);
		}else{
			if hand_size < hand_size_max_limit {  //make sure we don't have more cards than our hand allows it
					ds_list_add(list_location, 	card_);
			}
		}
	}
}




//enemy attacks player
function enemy_damage(creator,target,damage){ 
	
			sleep(30);
			var total_damage = check_damage(creator,target,damage);
			total_damage = change_health(creator, target, total_damage,true,true);
			
	
			
			return total_damage;
	
}

function enemy_buff(creator,self_buff_type,buff_amount) { 
	
	add_buff( creator, self_buff_type, buff_amount);
	
}

function player_buff(creator, self_buff_type,buff_amount) { 
	
	add_buff( creator, self_buff_type, buff_amount);
	
}



function chance_crit(creator, amount) {
	boon_randomize();
	
	var repeat_ = 0;
	var output = 0;


	
	var _percent = amount;
	output = random(1) < _percent;

	if creator = player { 
		
	var re_roll = check_tokens(e_token.coco_dice);
		
	if re_roll > 0 { 
	
		repeat (re_roll){ 
			if output = 0 { 
				var _percent = amount;
				output = random(1) < _percent;
				}
			}
		}
	}

	
	return output;
}

function restore_health(target,amount ) { 
	
	
	target.hp += amount;
	if target.hp > target.hp_max {
		target.hp = target.hp_max;	
	}
}


function change_health(creator,target,damage, check_armor, crittable) { 
 
//creator can also be noone! be careful!
	if creator = player and o_game.first_card_we_played = false and check_tokens(e_token.coco_red_copycat) and array_length(card_array_queue.array) > 0{
		//copycat
		damage *= .5;
	}


	var crit = false;
	target.blocking_sprite = s_white_square;
	var damage_number = false;
		if crittable and creator != noone{
			if chance_crit(creator,  get_crit_chance(creator) ){
				damage *=  (get_crit_damage(creator));
				damage = round(damage);
				landed_a_crit(creator,target,damage);
				damage_number = true;
				crit = true;
				creator.last_attack_was_a_crit = true;
			}else{
				creator.last_attack_was_a_crit = false;
				failed_to_land_a_crit(creator);
			}
		}

if check_armor { 
	if target.armor > 0 { 
		var changed_damage = target.armor - damage;
		target.armor -= damage;
		target.armor = max(target.armor,0);
		if changed_damage > 0 { 
			//we blocked it	
			damage = 0;
			target.armor_ui_timer = 0;
			has_been_hit(target , false)
			target.blocking_sprite = s_large_shield;
		}else{
			
			
				has_been_hit(target , true)
			//we lost our armor
			damage = abs(changed_damage);
			target.armor_destroy_image_index = 0;
			target.armor_destroy_enable = true;
			
			if damage <= 0 { 
				target.blocking_sprite = s_large_shield;	
			}
		}
	}else{
			has_been_hit(target , true)	
	}
}else{
		has_been_hit(target , true)	;
}
	

	damage = round(damage);

	target.hp -= damage;
	
	#region enemy has died here are the scripts that we execute
	
	if is_struct(creator){ 
		if target.hp <= 0 { 
					if creator.just_killed_an_enemy_func != noone { 
						creator.just_killed_an_enemy_func();
					}		
					if crit and  creator.just_killed_an_enemy_with_crit_func != noone { 
						creator.just_killed_an_enemy_with_crit_func();
					}
			}
		creator.just_killed_an_enemy_with_crit_func = noone;
		creator.just_killed_an_enemy_func = noone;
	}
	#endregion
	
	
	
	if target = player { 
		if damage > 0 { 
			
					if damage >= 20 { 
						screenshake(20, SEC*.5,180,e_ease.easeoutelastic );	
					}else{
						screenshake(10, SEC*.5,180,e_ease.easeoutelastic );	
					}
					
			}else{ 
					screenshake(3, SEC*.5,180,e_ease.easeoutelastic );		
		}
	}else if creator = player { 
					var dir = 90;
		
		if damage > 0 { 
			var amount = 3;
					if o_game.selected_card_x != noone and o_game.selected_card_y != noone {
						dir = point_direction(o_game.selected_card_x,o_game.selected_card_y,target.x,target.y);
					}
					
					if crit { 
						amount += 20;	
					}
			
					screenshake(amount, SEC*.5,dir,e_ease.easeoutelastic );	
				}else{ 
					screenshake(3, SEC*.5,dir,e_ease.easeoutelastic );		
		}
		
	}
	
	if damage >= 15 { 
	  
	  particle_explode(target.x,target.y,15,c_yellow,false, SEC*.25, false);	
	}


if creator!= noone {
	if target.buff.pollen.amount > 0 { 
		buff_change( target.buff.pollen, -1);
	   if creator.buff.weak.amount != 1 { 
		  
		    buff_set( creator.buff.weak , 1);	
		  
	   }
	}
}

	if !damage_number {
		set_damage_number(target, damage,false,c_white,false,false );
	}
	
	var mod_ = 1;
	if fast_mode { 
		mod_ = .15;	
	}	
	
	target.delay_health_bar_timer = SEC*.60*mod_;
	if target.hp <= 0 { 
			target.delay_health_bar_timer = SEC*1.4*mod_;
			unit_has_died(target); //e_stuff.royal_jelly
			
			
	}
	
	if damage > 0 { 
		target.health_bar_hit_timer = 6;
	}else{
		target.health_bar_hit_timer = 2;
	}	
}

function unit_has_died(struct) { 
	struct.enable_death = 1;
	struct.enable_death_timer = struct.enable_death_time;
}

function  damage_all_units(creator, target , damage) {
	//		var total_damage = check_damage(damage);
	//		target.hp -= total_damage;
	//	return total_damage;
}



function set_damage_number(struct, amount,is_a_crit ,color,intro_ease,outro_ease ) { 


	var struct_ = struct.damage_number;
	struct_.onscreen = true;
	
	struct_.is_a_crit = is_a_crit;
	if intro_ease = false || intro_ease = noone { 
	//set the default 	
		struct_.intro_easesing_type = e_ease.easeoutexpo;	
		}else{
		struct_.intro_easesing_type = intro_ease;
	}
	
	if outro_ease = false || outro_ease = noone { 
	//set the default 	
		struct_.intro_easesing_type = e_ease.easeoutexpo;	
		}else{
		struct_.intro_easesing_type = outro_ease;
	}	

	struct_.text_color = c_white;
	struct_.amount = amount;
	struct_.intro_timer = 0;
	struct_.outro_timer = 0;
	struct_.stay_static_timer = 0;	
}

function add_buff(target, type, amount ) { 

enum all_buffs { 
	attack,
	fragile,
	weak,
	armor_reduction,
	temp_attack,
	temp_attack_lose_at_the_end,
	enrage,
	cornered_rat,
	asleep,
	slow_start,
	find_weakness,
	pollen,
	weak_poison,
	poison,
	endurance,
	armor_keep,
	lucky,
	replay_red,
	token_summoning_restores_mana,
	crit_chance_add,
	crit_damage_add,
	
	
	horror_timepiece,
	size_
}

 var buff = noone;
	
	switch type { 
	
	case all_buffs.attack: buff = target.buff.attack break;
	case all_buffs.fragile: buff = target.buff.fragile break;
	case all_buffs.weak: buff = target.buff.weak break;
	case all_buffs.temp_attack: buff = target.buff.attack_lost_on_crit break;
	case all_buffs.enrage: buff = target.buff.enrage break;
	case all_buffs.cornered_rat: buff = target.buff.cornered_rat break;
	case all_buffs.asleep: buff = target.buff.asleep break;
	case all_buffs.slow_start: buff = target.buff.slow_start break;
	case all_buffs.find_weakness: buff = target.buff.find_weakness break;
	case all_buffs.pollen: buff = target.buff.pollen break;
	case all_buffs.weak_poison: buff = target.buff.weak_poison break;
	case all_buffs.poison: buff = target.buff.poison break;
	case all_buffs.armor_reduction: buff = target.buff.armor_reduction break;
	case all_buffs.endurance: target.buff.endurance.amount += amount;   target.buff.endurance.created_timer = -1; target.buff.endurance.hovered_over_status = false;return target.buff.endurance break;
	case all_buffs.armor_keep:buff = target.buff.armor_keep break;
	case all_buffs.horror_timepiece: buff = target.buff.horror_timepiece break;
	case all_buffs.lucky: buff = target.buff.lucky break;
	case all_buffs.temp_attack_lose_at_the_end: buff = target.buff.attack_lost_on_crit_lose_at_turns_end;break;
	case all_buffs.replay_red: buff = target.buff.replay_red;  break;
	case all_buffs.token_summoning_restores_mana: buff = target.buff.token_summoning_restores_mana;  break;
	case all_buffs.crit_chance_add: buff = target.buff.crit_chance_up;  break;
	case all_buffs.crit_damage_add: buff = target.buff.crit_damage_up;  break;

	}
	if buff = noone { 
	show_debug_message("ERROR NO BUFF FOUND")
	}else{
	update_card_text();
		
	buff.amount += amount;  
	buff.created_timer = -1; 
	buff.hovered_over_status = false; 
	return buff;
	}
}
function buff_change(buff, amount_add){ 
	buff.amount += amount_add;
	update_card_text();
	


}

function buff_set(buff, amount){ 
	buff.amount = amount;
	update_card_text();

}


function armor_change(target, armor_amount) { 
		//add or remove armor buffs/debuff
		
		
	target.armor_ui_timer = 0;
	
	
	armor_amount += target.buff.endurance.amount;
	
	if target.buff.armor_reduction.amount > 0 { 
		armor_amount *= o_game.buff_multipliers.armor_reduction;
	}
	

	armor_amount = round(armor_amount);
	if armor_amount > 0 { 
		audio_play(sfx_gain_armor);	
	}
	
	target.armor += armor_amount; //in case there are modifiers
	return armor_amount; //return total armor
}


function  enemy_armor_change(target, armor_amount) : armor_change(target, armor_amount) constructor{

		target.cant_lose_armor_for_x_turns = 1;
	
}
function change_mana(amount, clamp_) {

		
		if amount > 0 { 
			repeat(	check_stuff(e_stuff.pink_bow) ){
				amount *= 1.5; //1.5 
			}
		}
		potential_mana_loss =  0;
		player.mana += amount;
		if clamp_ player.mana = clamp(	player.mana,0, player.mana_max);
		player.mana = max(	player.mana,0 );
		

}
	
function add_card_to(list, enum_, permanently){
		if list = hand and ds_list_size(hand) > hand_size_max_limit exit;
		
		var new_card = card_struct(	enum_ );
		if !permanently { 
			new_card.remove_after_combat = true;
		}else{
			ds_list_add(all_added_cards, new_card);
		}
		ds_list_add(list, new_card);
}

function draw_a_card(amount) { 
	o_game.draw_card_queue = amount;



	if o_game.turn_phase !=  e_turn_phase.draw_phase{ 
		audio_play( choose( sfx_draw_card_1), 0 );	
		repeat(check_stuff(e_stuff.locust_crown)) {
				add_token(e_token.coco_salmon);
		}
	}
	
}

function queue_card(amount) {


	if ds_list_empty(deck) and ds_list_empty(discard) exit;
	
	if ds_list_size(hand) >= hand_size_max_limit exit;

	repeat(amount) { 	

	if ds_list_size(hand) >= hand_size_max_limit exit;
	if ds_list_empty(deck)  and !ds_list_empty(discard){ 
		
		var len = ds_list_size(discard);
		
			audio_play(sfx_card_shuffle);
		
		for (var i = 0; i < len;++i ) {
			
				discard_to_deck_queue.draw_amount += 1;
				discard_to_deck_queue.enable = true;
				discard_to_deck_queue.timer = 0;
				discard_to_deck_queue.time_func = function(){
					
					if !fast_mode { 
						var time = SEC*.25;
						}else{
							time = SEC*.25;
					}
						return  divide( time, ds_list_size( discard ) ); ;
				}
				ds_list_add(discard_to_deck_queue.list, discard[| i]);
				//ds_list_delete(discard, i);
		}  
		ds_list_clear(discard);
		//draw discard into deck shuffle here
	}else{
		boon_randomize();
		ds_list_shuffle(deck);	
		ds_list_move(deck,0,hand);
		hand_size = ds_list_size(hand);
		o_game.deck_flash_timer = 0;
		var len = hand_size-1;
		//active_cards_list[| len].x_ = -camera.width;
		//active_cards_list[| len].y_ = -camera.height;	
		}
	}
}
	

//status effects getters
function get_debuff_turns(enum_, turns) { 
	//add turns to any passive item
	//applies any debuffs or buffs
	
return "[c_yellow]"+string(turns)+"[]";	
}

function get_defenseless_amount() { 
	
	var total = .50;
	
	return total;
}


function get_string_card_amount(amount) { 
	
	
	//make this green if we have a card buff effect that lets us draw more cards
	
	if amount = 1 { 
		return "DRAW [c_yellow]"+string(amount)+"[] CARD.";
	
	}else{
		return "DRAW [c_yellow]"+string(amount)+"[] CARDS.";
	}
}




function get_card_draw_amount(amount) { 
	return amount;	
}

function get_x_times_string(amount) {
	return string(amount);
}

function get_x_times(amount) {
	return amount;
}

function finished_playing_a_card(){ 
		hovered_over_card = false;
		hand_hover_array  =  false;	
}

function has_been_hit(struct, enable_animation) { 
	
	struct.trigger_hit_animation = enable_animation;
	struct.has_been_hit_timer = 0;
	//trigger scripts and stuff
	//eventually make bigger hits much flashier and stuff
}
function exahust_a_card_from_hand(which_card_index){ 

	ds_list_add(exhaust, hand[| which_card_index]);
	ds_list_delete(hand,which_card_index);
	hand_size = ds_list_size(hand);
//	hand[| hand_hover_array]
}


function discard_a_card_from_hand(which_card_index){ 

	ds_list_add(discard, hand[| which_card_index]);
	ds_list_delete(hand,which_card_index);
	hand_size = ds_list_size(hand);
//	hand[| hand_hover_array]
}





function get_death_message() { 

	return "LATER GATER";
	return choose(  
	"REKT",
	"RIP",
	"OUTTA HERE",
	"LATER GATER",
	"BYE DUDE",
	"GET DECIMATED",
	"NOICE",
	"REST IN PEPPERONIS",
	"RIP",
	"WP",
	"THATS ALL FOLKS",
	"KOBE",
	"GET MATH'D",
	"EZ",
	"BETTER LUCK NEXT TIME",
	"GG CLOSE",
	"GOTCHA",
	"GOTTIM",
	"ADIOS"
	
	);
	
}



function spoils_struct(title, desc, cost, card_script , keywords) constructor{
	self.title = title; //name of it
	self.desc = desc; //card description
	self.cost = cost; //cost to play
	self.card_script = card_script; // array, first the target, then the value is the script that is used, then all sequential values are the argumnents
	self.keywords = keywords; //keywords the card contains  for example exhaust, if none then use noone
}

function landed_a_crit(creator,target,damage){ 
	
if creator = player  {

	o_game.dealt_a_crit_this_turn = true;
	token_check_execute(e_token.coco_beetle, e_token_type.aura);

	buff_set( player.buff.attack_lost_on_crit , 0);
}
	
	
buff_set(creator.buff.crit_chance_up, 0);
buff_set(creator.buff.crit_damage_up, 0);	
//add stuff here
creator.non_crits_grant_tempoary_damage_amount = 0;

var xoff = 30 * target.xscale_facing;
set_damage_number(target, damage,true,c_white,false,false );

/*
	var crit_string = "CRIT";
	var crit_width = string_width(crit_string);
	var ss = create_sine_text(target.x-3+xoff,target.y-30,SEC*3,"CRIT",C_YELLOW, target , 1);
	ss.alarm[0] = SEC*2;

	var damage_str = string(round(damage));
	var width = string_width(damage_str);
	var nn =	create_sine_text(target.x+xoff,target.y-20,SEC*3,string(damage_str),C_GUM, target , 0);
	nn.alarm[0] = SEC*2.2;
	nn.font = font_damage_number;
*/

var dir = 15;
var dirx = lengthdir_x(150,dir);
var diry = lengthdir_y(150,dir); 


var amount = 5;
var xx = random_range(-amount,amount);
var yy = random_range(-amount,amount);


var dir = point_direction( target.x-dirx,target.y-diry+30 ,target.x+xx,target.y+30+yy);

var dirx = lengthdir_x(750,dir);
var diry = lengthdir_y(750,dir); 

sleep(100);
var s = create(target.x-dirx,target.y-diry-20,o_slice);
	s.direction = dir;
	s.image_angle = dir;
	s.color =  choose(C_YELLOW);
	s.speed = random_range(55 , 150);	
	
}

function failed_to_land_a_crit(creator) { 

	if creator = player {
		
		
		
		var purple_scale = check_stuff(e_stuff.purple_scale);
		
		if purple_scale > 0{ 
			repeat(purple_scale) { 
				add_buff(player,all_buffs.temp_attack,1);
			}
		}

		repeat(check_tokens(e_token.coco_salmon)){
			execute_token_script(e_token.coco_salmon, e_token_type.dontcheck);	
		}

		repeat(check_tokens(e_token.coco_bee)){
			execute_token_script(e_token.coco_bee, e_token_type.dontcheck);	
		}
	
		repeat(check_tokens(e_token.coco_bat)){
		
			execute_token_script(e_token.coco_bat, e_token_type.dontcheck);
		}
	}
}
function get_crit_chance(struct) { 
	var amount = 0;	
	

	
	if  !struct.can_crit{
		struct.can_crit = true;
		struct.force_crit = false;
		return 0;	
	}
	
	if struct.force_crit{ 
		struct.force_crit = false;
		return 1;
	}

	
	if struct = player { 
		
		amount += player.buff.crit_chance_up.amount*(player.token_stats[@ e_token.coco_bee].starting_amount+player.token_stats[@ e_token.coco_bee].output1());
	}



	amount += struct.tempoary_crit_chance;
	amount += struct.crit_chance;
	
	
	
	if check_tokens(e_token.coco_spider) > 0 and struct = player{
		amount = 1;//always crit
	}
	
	if amount > 1 amount = 1;
	return amount;
}

function get_crit_damage(struct) { 
	
	var amount = 0;

	amount += struct.tempoary_crit_damage;
	amount += struct.crit_damage;
		
	if struct = player { 
		amount += player.buff.crit_damage_up.amount*(player.token_stats[@ e_token.coco_bat].starting_amount+player.token_stats[@ e_token.coco_bat].output1());
	}




	amount *= struct.second_crit_mod; //doubles the amount of crit damage a card can have
	struct.second_crit_mod = 1;//always resets when it's done
	
	
	if check_tokens(e_token.coco_spider) > 0 { //clampers
		amount = clamp(amount,0,2);
	}
	
	return amount;
	
}

function restart_dungeon(){ 
	
	instance_destroy(obj_mapgen);
	room_goto(r_dungeon_init);
}


function default_screenshake() { 
	
	screenshake(10, SEC*.1,noone,SHAKE_LERP)
}

function discover(enum_) { 

	//discover_queue.array = [];// REMEMBER TO TMPTY
	var array = [];
	var script_ = discover_queue.finder_script();
	
	if number_of_enemies > 0 || number_of_enemies <= 0 and o_game.has_pressed_card_spoils = false { 
	default_screenshake();
	confetti(500, 0,0);
		if  number_of_enemies <= 0 and 	o_game.has_pressed_card_spoils = false{ 
			o_game.has_pressed_card_spoils = true;	
		}
	
	}
	
	with o_game{ 
		if is_array(enum_) { 
			var i = 0;
			var len = array_length(enum_);
			for (var i = 0; i < len; i++) { 
					array_push( array, script_( enum_[@ i]  )	);
			}
		
		
		}else{
				for(var i=0; i<argument_count; i++) {
					array_push(array, script_(argument[i])	);
				}
		}
	array_push(discover_queue.array, array);
	}
}


function discover_struct(struct) { 



	//discover_queue.array = [];// REMEMBER TO TMPTY
	var array = [];
	var script_ = discover_queue.finder_script();
	
	with o_game{ 
		if !is_array(struct) { 
		
				array_push(array,struct);
		}else{		
				var len = array_length(struct);
			
				for(var i=0; i<len; i++) {
					array_push(array, struct[i]	);
				}
		}
		array_push(discover_queue.array, array);
	}
}


function add_enemy(enemy_array) { 
	var len = array_length(enemy_array);
	for (var i= 0; i < len; i++) {
		array_push(active_enemies,   new_enemy(enemy_array[@ i]) );
	}
  number_of_enemies = array_length(active_enemies)
 
}

function init_battle() { 
	with o_game{ 
			if !first_draw{  //	
				first_draw = true;

				
				
				draw_card_queue = player.default_draw_amount;
			}else{
				
				hand_size = ds_list_size(hand);	
				
				var draw_amount = abs(hand_size - player.default_draw_amount);
				
				draw_card_queue = draw_amount;
			
		}
	}
}




function remove_generated_cards() { 
	
	var len = ds_list_size(hand);
	var list = hand;
	for (var i = 0; i < len; i++) {
		var get_card = list[| i];
		if is_struct(get_card) and get_card.remove_after_combat { 
			ds_list_delete(list, i);
		}
	}
	var list = deck;
	var len = ds_list_size(list);
	
	for (var i = 0; i < len; i++) {
		var get_card = list[| i];
		if is_struct(get_card) and get_card.remove_after_combat { 
			ds_list_delete(list, i);
		}
	}
	var list = discard;
	var len = ds_list_size(list);
	for (var i = 0; i < len; i++) {
		var get_card = list[| i];
		if is_struct(get_card) and get_card.remove_after_combat { 
			ds_list_delete(list, i);
		}
	}	
	var list = exhaust;
	var len = ds_list_size(list);
	for (var i = 0; i < len; i++) {
		var get_card = list[| i];
		if is_struct(get_card) and get_card.remove_after_combat { 
			ds_list_delete(list, i);
		}
	}
	
	
	if len > 0 { 
	//copy exhaust to deck
		for (var i = 0; i < len; i++) {
		var get_card = list[| i];
		if is_struct(get_card) { 
			ds_list_add(deck, get_card);
			ds_list_delete(exhaust,i);
			i--;
			len--;
		}
	}
	}
}

function card_can_be_played(card_stuct) {
	var return_value = true;
	
	if card_stuct.struct_type = e_struct_type.token {
		return true;	
	}
	
	if card_stuct.original_cost = noone { 
		return_value = false;	
	}
					
	if card_stuct.card_script = noone { 
		return false;//stop
	}
	
		if card_stuct.keywords != noone {
			
			if !is_array(card_stuct.keywords) {
				
				if card_stuct.keywords == keywords.unplayable { 
					return_value = false;		
				}
			}else{
				var len = array_length(card_stuct.keywords);
				for (var i =0; i <len; ++i){ 
					if card_stuct.keywords[@ i] == keywords.unplayable {
							return_value = false;	
					}
				}
			}	
		}
	
	return return_value;
}



function returned_draw_matrix_struct(struct, xx, yy,w,h,x3,y3) constructor {
	self.struct = struct;
	self.x0 = xx;
	self.y0 = yy;
	self.w = w;
	self.h = h;
	self.x3 = x3;
	self.y3 = y3;
}


function draw_card_matrix_selectable(struct, xx, yy, xscale, yscale, angle, xrot, yrot, i, draw_selected_card, hovered_card_angle,is_discover,selectable,playable) { 
		var return_value = noone;
		
		var y_offset = 0;
		if selected_card_x = xx and m1_check{
				angle = hovered_card_angle;
				yy += hovered_y_offset;
		}else{
			if m1_check and allow_player_input() { 
			//	yy += un_hovered_y_offset;	
			}
			if hovered_over_card { 
			//	yy += 120;	
			}
		}
		if !no_discover_effects() and !is_discover{
			yy += camera.height*2;
		}
		//xx = MX;
		//yy = MY;
	
	

		var ww = sprite_get_width(s_card_border)*border_scale;
		var hh = sprite_get_height(s_card_border)*border_scale;		
		
		var x0 = xx-ww/2;
		var y0 = yy-hh/2;
		
		var x1 = xx+ww/2;
		var y1 = yy-hh/2;	
		
		var x2 = xx-ww/2;
		var y2 = yy+hh/2;
		
		var x3 = xx+ww/2;
		var y3 = yy+hh/2;	
	
	
		var returned_struct = new returned_draw_matrix_struct(noone, x0, y0,ww,hh,x3,y3);

		//	if boon_collision_polygon(x0,y0,x1,y1,x2,y2,x3,y3,MX,MY){ 
		//		draw_set_color(C_LIME)
		//	}
		////top
		//draw_line(x0,y0,x1,y1)
		////right
		//draw_line(x1,y1,x3,y3)
		////bot
		//draw_line(x2,y2,x3,y3)
		////left
		//draw_line(x0,y0,x2,y2)
	
	if is_undefined(active_cards_list[| i]){ 
	active_cards_list[| i] =  new card_border( noone);
	}
	
		
		if selectable and !is_discover and active_cards_list[| i].disable_sectable_timer > 0{
			selectable = false;
			active_cards_list[| i].disable_sectable_timer--;
		}
	
		if selectable{ 
			
			if allow_player_input() and boon_collision_polygon(x0,y0,x1,y1,x2,y2,x3,y3,MX,MY) and hovered_over_card = false ||
			   !no_discover_effects() and boon_collision_polygon(x0,y0,x1,y1,x2,y2,x3,y3,MX,MY) and hovered_over_card = false
			   {
				returned_struct.struct = struct;
				if  is_hovering_over_card = noone{ 
					save_hovered_i = i;
					save_hovered_x_position = xx;
					is_hovering_over_card = struct;
					return returned_struct;
					exit;
				}else{
				draw_set_color(C_LIME);				
				if !draw_selected_card{
					
				}else{
					
				if !m1_check { 
					hand_hover_array = save_hovered_i;
				}
					selected_card_x = xx;
					selected_card_y = yy;
				
				if hovered_over_card = false  and m1_pressed and card_can_be_played(struct) and playable  { 
					
					
					hovered_over_card = true;
					
				if player.mana >= struct.cost  { 
						hovered_y_timer = 0;
						un_hovered_y_timer = 0;
					}
				}
					xscale = 2;
					yscale = xscale;
				
					
					yy -= o_game.camera.height*.01;
				
					//check to see if we are on the edge of the camera scrxeen
					var www = sprite_get_width(s_card_border)*border_scale*xscale;
					var hhh = sprite_get_height(s_card_border)*border_scale*xscale;		
		
					var x0 = xx-www/2;
					var y0 = yy-hhh/2;
					
					var x3 = xx+www/2;
				//	draw_line(x3,y0,MX,MY);
				//	draw_line(x0,y0,MX,MY);
						
					var dis1 = point_distance(x0,0,-camera.width/2,0);
					var dis2 = point_distance(x3,0,camera.width/2,0);
					
					hand_hover_keyword_left = false;
				
			if dis1 > dis2 { 
				hover_hand_keyword_x = x0;
				hand_hover_keyword_left = true;
			}
					
				

			if x0 <= -camera.width/2{ 
				xx = -camera.width/2+ww;
			}
						
			if x3 >= camera.width/2{ 
				xx = camera.width/2-ww;	
			}
	
			
			var y0 = yy-hhh/2;
			var y3 = yy+hhh/2;

			if y0 <= -camera.height/2{ 
				yy = -camera.height/2*.1;
			}
						
			if y3 >= camera.height/2{ 
				yy = 0;	
			}	
			
				hover_hand_keyword_x = xx-www/2;
				hover_hand_keyword_y = yy-hhh/2;
	
		}
	}
}
		}

	
		
		draw_set_color(c_white);


		var card_border_sturct = active_cards_list[| i];
		
		
			card_border_sturct.x0 = x0;
			card_border_sturct.y0 = y0;
			card_border_sturct.x3 = x3;
			card_border_sturct.y3 = y3;
			card_border_sturct.w = ww;
			card_border_sturct.h = hh;
		
	if selected_card_x != noone and i = save_hovered_i{ 
		draw_keywords(struct, hover_hand_keyword_x,yy-sprite_get_width(s_card_border)*.35);
	}

		
		if 	card_border_sturct.x_ = undefined || card_border_sturct.y_ = undefined{
			card_border_sturct.x_ = xx;
			card_border_sturct.y_ = yy;
		}	
		
		var dir = point_direction(card_border_sturct.x_,card_border_sturct.y_ ,xx,yy );
		var dis = point_distance(card_border_sturct.x_,card_border_sturct.y_ ,xx,yy );
		var up = 1;
		
		if dir > 180 up = -1;
		
		var xlen = lengthdir_x(dis,dir)*.1;
		var ylen = lengthdir_y(dis,dir)*.1;
		
		card_border_sturct.xangle += ylen;
		card_border_sturct.yangle += xlen;
		
		var lerp_x = .6;
		var lerp_y = .6;
		card_border_sturct.xangle = lerp(card_border_sturct.xangle,360,lerp_x);
		card_border_sturct.yangle = lerp(card_border_sturct.yangle,360,lerp_y);
		var clamp_amount = 50;
		card_border_sturct.xangle = clamp(card_border_sturct.xangle,360-clamp_amount,360+clamp_amount);
		card_border_sturct.yangle = clamp(card_border_sturct.yangle,360-clamp_amount,360+clamp_amount);
	
		if card_border_sturct.x_ = undefined { 
			card_border_sturct.x_ = xx;
			card_border_sturct.y_ = yy;
		}else{
			card_border_sturct.x_ = lerp(card_border_sturct.x_,xx,.15);
			card_border_sturct.y_ = lerp(card_border_sturct.y_,yy,.15);
		}
		
		
		var yy_ = card_border_sturct.y_+y_offset;
		var xx_ = card_border_sturct.x_;
		
		
		if !no_discover_effects() and is_discover { 
			yy_ = 0;	
			xx_ = xx;
		}	
		var _vm = matrix_get(matrix_world);
		var _new_matrix = matrix_build(0,0,0, 0,0,0, xscale,yscale,0);
		_new_matrix = matrix_multiply(_new_matrix, matrix_build(xx_,yy_, 0, card_border_sturct.xangle , card_border_sturct.yangle, angle, 1,1,0));//xrot and yrot should be this way
		matrix_set(matrix_world, matrix_multiply(_new_matrix, _vm));
		draw_card_matrix_contents(struct, card_border_sturct);
		draw_set_font(font_boon);
		draw_set_color(c_white); 
		//xscale yscale and angle
		matrix_set(matrix_world, _vm);
		draw_set_halign(fa_left);
		return returned_struct;
}


function draw_card_matrix(struct, xx, yy, xscale, yscale, angle, xrot, yrot, card_border_struct){ 
	
		card_border_struct = o_game.active_cards_list[| 0];
		var _vm = matrix_get(matrix_world);
		var _new_matrix = matrix_build(0,0,0, 0,0,0, xscale,yscale,0);
		_new_matrix = matrix_multiply(_new_matrix, matrix_build(xx,yy, 0, xrot , yrot, angle, xscale,yscale,0));//xrot and yrot should be this way
		matrix_set(matrix_world, matrix_multiply(_new_matrix, _vm));
		draw_card_matrix_contents(struct , card_border_struct);
		draw_set_font(font_boon);
		draw_set_color(c_white); 
		//xscale yscale and angle
		matrix_set(matrix_world, _vm);
		draw_set_halign(fa_left);
}


function draw_card_matrix_contents(struct, card_border_struct ) {

		if card_border_struct == noone || !card_border_struct  {
			exit;
		}
			
			
		var return_value = noone
			var	image_index_ = 0;
			
		//check if our title has been initialized
		/*
			Our goal is to contain the scribble text here and then don't regenerate every frame since that if fucking terrible.
		*/
		
		if 	struct.struct_type = e_struct_type.token || struct.struct_type = e_struct_type.card and struct.token_enum_ != noone and !is_array(struct.token_enum_){  
			image_index_ = 0;
		}else{
			image_index_ = struct.golden;
		}
		//s_card_border_outline=
		var title_color = c_white;
		if o_game.game_state = e_gamestate.battle and number_of_enemies > 0 and no_discover_effects() and player.mana >= struct.cost { 
			var col = C_LIME;
			
		var is_condition = struct.condition;
	
		
		if is_condition != noone { 
			var condition = struct.condition.result();

			if condition { 
				 col = C_YELLOW;
				title_color = col;
			}		
		}
		
		
		var is_or_condition = struct.or_condition;
		
		
		if is_or_condition != noone { 
			
			var or_condition = struct.or_condition.result();
		
				
			if or_condition { 
				col = C_RAINBOW;
				title_color = col;
			}		
		}
		
			if !o_game.pause_combat_to_show_deck and !check_card_keywords(  struct , keywords.unplayable)	{
				draw_outline_thick(s_white_card_fill,image_index_,0,0,border_scale,border_scale,0,col,1);
				draw_outline_thick(s_white_card_fill,image_index_,0,0,border_scale,border_scale,0,col,1);
				}
			
		}
		draw_sprite_ext(struct.func_card_sprite_index(),image_index_,0,0,border_scale,border_scale,0,c_white,1);
		
		var scale = (1/border_scale)*border_scale;
		var scaletitle = scale;

		var keywords_ = "";		
		if struct.keywords != noone {
			if !is_array(struct.keywords) and struct.keywords.print_keyword {
				keywords_ = "["+sprite_get_name(struct.keywords.sprite)+"] [c_yellow]"+struct.keywords.title+"[]\n";
			}else{
				var len = array_length(struct.keywords);
				for ( var ii = 0; ii< len; ii++){ 
					if struct.keywords[@ ii].print_keyword {
					keywords_ += "["+sprite_get_name(struct.keywords[@ ii].sprite)+"] [c_yellow]"+struct.keywords[@ ii].title+"[]\n";
					}
				}	
			}
		}
		

	if card_border_struct.title = noone || card_border_struct.reference_enum  != struct.enum_ || card_border_struct.force_update = true{ 		
			card_border_struct.reference_enum = struct.enum_;
			card_border_struct.title = scribble("[fa_center]"+struct.title);
			card_border_struct.desc = scribble("[fa_center][fa_top]"+keywords_+struct.desc() ).wrap(	300*border_scale).blend(c_white, 1);	
			card_border_struct.force_update = false;
	}
	
	var title = card_border_struct.title; 
	var desc = card_border_struct.desc;
	
	//	card_border_struct.title = scribble("[fa_center]"+struct.title);
	//	card_border_struct.desc = scribble("[fa_center][fa_top]"+keywords_+struct.desc() ).wrap(	300*border_scale).blend(c_black, 1);
					
	var titlex = border_scale;
	var titley = -19*border_scale;
	var text_box_width  = 120;
	var card_xorigin = sprite_get_xoffset(s_card_border);
	var card_yorigin = sprite_get_yoffset(s_card_border);

	var text_box_xoffset = (120-card_xorigin)*border_scale;
	var text_box_yoffset = (430-card_yorigin)*border_scale;

	var text_box_height = 140;

	var desc_left = (-text_box_width)  *border_scale;
	var desc_top = (text_box_yoffset) *border_scale;
	var desc_right = (text_box_width)  *border_scale;
	var desc_bot = (text_box_yoffset-20+text_box_height)*border_scale;
	var desc_box_width = desc_right - desc_left;
	var desc_box_height =  desc_bot - desc_top;
		
	//	draw_rectangle(desc_left,desc_top,desc_right,desc_bot	,false);
	
		var descx = 0;
		var descy = desc_box_height-30;
		draw_set_color(c_white);

	desc.blend(c_black,1).draw(descx-1*scale,descy);
	desc.draw(descx-1*scale,descy);
	desc.draw(descx+1*scale,descy);
	desc.draw(descx,descy-1*scale);
	desc.draw(descx,descy+1*scale);
	desc.draw(descx+2*scale,descy+2*scale);
	desc.draw(descx+2*scale,descy+1*scale);
		
		
	title.blend(c_black, 1).draw(titlex-1*scaletitle,titley);
	title.draw(titlex+1*scaletitle,titley);
	title.draw(titlex,titley-1*scaletitle);
	title.draw(titlex,titley+1*scaletitle);
	title.draw(titlex+2*scaletitle,titley+2*scaletitle);
	title.draw(titlex+2*scaletitle,titley+1*scaletitle);

	title.blend(c_black, 1).blend(title_color, 1).draw(titlex,titley);
	desc.wrap(300*border_scale).blend(c_white, 1).draw(descx,descy);
	title.draw(titlex,titley);
	desc.draw(descx,descy);
		
		
		if obj_mapgen.browsing_card_shop and !shop_card_select.enable and struct.struct_type = e_struct_type.card{
			
			var price_amount = struct.price;
			
			if struct.on_sale = false{ 
				var price = scribble("[fa_center][s_icon_gold, 1,0] "+string(price_amount));
			}else{
				struct.price = round(struct.price_original*.5);
				
				price = scribble("[fa_center][rainbow]-50%[] [s_icon_gold, 1,0] [c_lime]"+string(struct.price));
			}
			price.draw(descx,titley+border_scale-camera.height*0.205);
			
		}
		
		if struct.cost = NOCOST { 
			cost = "";	
		}else{
		var cost = string(struct.cost);
		}
		
		draw_set_halign(fa_right);
		draw_set_font(font_damage_number);

		//text_outline_thick(titlex-62,titley-120,cost,c_white);

		draw_text_outline(titlex-112*border_scale,titley-220*border_scale,cost,make_color_rgb(40,40,40));
		draw_text(titlex-112*border_scale,titley-220*border_scale,cost);
		
		if 	struct.struct_type = e_struct_type.token || struct.struct_type = e_struct_type.card and struct.token_enum_ != noone and !is_array(struct.token_enum_){  
			
			
			if struct.struct_type = e_struct_type.token {
				
				var turns_to_live = string(check_token_turns_to_live(struct));
			
			}else{
				
				var token_struct_ =  token_struct(struct.token_enum_);
				
				var turns_to_live = get_token_turns(check_token_turns_to_live(token_struct_) );
			}
			
			var turns_to_live_x = 165;
			draw_outline(s_card_heart_large,0,titlex+92*border_scale,titley-250*border_scale ,1,1,0,C_DARK,1);
			draw_sprite(s_card_heart_large,0,titlex+92*border_scale,titley-250*border_scale );
			draw_text_outline(titlex+turns_to_live_x*border_scale,titley-220*border_scale,turns_to_live,make_color_rgb(40,40,40));
			draw_text(titlex+turns_to_live_x*border_scale,titley-220*border_scale,turns_to_live);
		}

}

function check_token_turns_to_live(struct){ 
	
	var enum_ = struct.enum_;
	
	var turns_to_live = player.token_stats[@ enum_].turns_to_live;
	
	
		
	return turns_to_live
}


function update_card_text() {
	
	for (var i= 0; i < ds_list_size(o_game.active_cards_list); i++){ 
	
		o_game.active_cards_list[| i].force_update = true;
	
	}
	
}

function has_card_keyword(card_struct_ , keyword_to_check) { 

	if !is_struct(card_struct_) || card_struct_.struct_type != e_struct_type.card{ 
		show_debug_message("ERROR has_card_keyword HAS NO CARD STRUCT");
		return false;
	}

	if card_struct_.keywords != noone {
		if !is_array(card_struct_.keywords) and  card_struct_.keywords = keyword_to_check{
				return true;
		}else{
			var len = array_length(card_struct_.keywords);
			for ( var i = 0; i< len; i++){ 
				if card_struct_.keywords[@ i] = keyword_to_check {
					return true;
				}
			}	
		}
	}

	return false;
}

function get_token_turns(number){ 
	
	var col = "[c_yellow]";
	if number = 1 { 
		col = "[c_gum]";	
	}
	
	return col+string(number);

}

function exhaust_effect(active_card_index) { 
//	for (var i = 0; i< len; ++i){
//	}

		var x0 = active_cards_list[| active_card_index].x0;
		var y0 = active_cards_list[| active_card_index].y0;
		var x3 = active_cards_list[| active_card_index].x3;
		var y3 = active_cards_list[| active_card_index].y3;
		var w = active_cards_list[| active_card_index].w;
		var h = active_cards_list[| active_card_index].h;
		
		var xwidth = 17;
		var yheight = 30;
	
		for (var xx = 0; xx < xwidth; xx++) { 
			for (var yy = 0; yy < yheight; yy++) { 
				particle_evaporate(x0+xx*7+25,y0+yy*7+30 ,1,c_white,.5,0,random_range(SEC*.3, SEC*1.9),0,-.001);
		}
	}
}


function overworld_event_parent() constructor{
	sprite = s_nine_slice_hp;	
	array_container = [];
	type = e_event_type.small_treasure;
	stuff = noone;
}

function overworld_rest_area() : overworld_event_parent() constructor{
	boon_randomize();
	type = e_event_type.rest_area;
}


function overworld_chest(struct, re_roll_amount) : overworld_event_parent() constructor{
	boon_randomize();
	stuff = struct;
	type = e_event_type.small_treasure;
	self.reroll_amount = re_roll_amount
}

enum e_shop_type { 
	card,
	token,
	card_removal,
	potion,
	size_
}


	//shop_card,
	//shop_removal,
	//shop_token,
	//shop_potion,
	//shop_stuff,

function overworld_shop_cards(re_roll_amount) : overworld_event_parent() constructor{
	
	boon_randomize();
	
	type = e_event_type.shop_card;
	self.reroll_amount = re_roll_amount;
}

function go_to_next_state(game_state_enum){ 
	with obj_mapgen{	
		next_game_state_queue = game_state_enum;
		curtain_xoffset = -gui_width;
		curtain_yoffset = 0;
		curtain_timer = 0;
		curtain_timer_up = 0;
	}
	
	if game_state_enum = e_gamestate.battle { 
		with o_game { 
			game.combat = new stats();
		}
	}
}



function reset_battle_camera() {
	shake ={
			timer : 0,
			time : SEC*.5,
			ease : noone,
			dir : 0,
			dis : 0,
			amount : 0,
			amount_init : 0,
			amount_change : 0,
			lenx : 0,
			leny : 0,
	}
}


function screenshake(amount, time, dir, ease) { 
	
with o_game{ 
	shake.amount = amount;

	if time = noone || time = 0 { 
	shake.time = SEC*.55; //default
	}else{
	shake.time = time;
	}

	shake.dir = dir;
	shake.timer = 0;
	//don't reset these
	shake.amount_init = shake.amount;
	shake.amount_change = -shake.amount;
	shake.ease = ease;
}
	
}

function set_battle_camera() { 

#macro SHAKE_DEFAULT noone
#macro SHAKE_LERP -1

var x_ = 0;
var y_ = 0;


switch shake.ease { 
	case SHAKE_DEFAULT: 
						if shake.timer > shake.time { 
							 shake.amount = 0;
						 }
						 x_ = random_range(-shake.amount, shake.amount);
						 y_ = random_range(-shake.amount, shake.amount);
						 shake.timer++;
						 
	break;
	
	case SHAKE_LERP:
			if shake.timer <= shake.time { 
			shake.amount =	easings(e_ease.easeinsine,shake.amount_init,-shake.amount_init,shake.time,shake.timer);	
			shake.timer++;
			
			}else{ 
			shake.amount =  0;//shake.amount_init
			}
		
			x_ = random_range(-shake.amount, shake.amount);
			y_ = random_range(-shake.amount, shake.amount);
	break;
	default: 
	
			//useing easing to move the camera	
			if shake.timer <= shake.time { 
				shake.amount =	easings( shake.ease ,shake.amount_init,shake.amount_change,shake.time,shake.timer);	
				shake.timer++;
			}
					
			x_ = lengthdir_x(shake.amount ,shake.dir);
			y_ = lengthdir_y(shake.amount ,shake.dir);
	
	
	break;

}
camera.x += x_;
camera.y += y_;
}

function confetti(amount_, xx,yy){
	part_type_direction(global.pt_confetti , 0, 360, 0, 0);
	part_system_depth(global.sys_confetti,DEPTH_BEHIND_GAME)
	
	
	part_type_gravity(global.pt_confetti, 0.25, 270);
	part_type_direction(global.pt_confetti , 0, 360, 0, 20);
	part_type_speed(global.pt_confetti , 4, 27, -0.4, 0);
	part_type_size(global.pt_confetti , 1, 1, 0, 0);
	part_type_life(global.pt_confetti , SEC*.1, SEC*2.1);

	
		part_type_sprite(global.pt_confetti , s_particle_fancy, true, true, 0); 
	

	//var col = choose(C_GUM, C_BLUE,make_color_rgb(255,50,197),  C_YELLOW,make_color_rgb(45 ,255,63))
	
	part_type_color1(global.pt_confetti,C_YELLOW)
	part_particles_create(global.sys_confetti, xx, yy, global.pt_confetti , amount_);
	part_type_color1(global.pt_confetti,C_BLUE)
	part_particles_create(global.sys_confetti, xx, yy, global.pt_confetti , amount_);

	part_type_color1(global.pt_confetti,C_GUM)
	part_particles_create(global.sys_confetti, xx, yy, global.pt_confetti , amount_);
	part_type_color1(global.pt_confetti,make_color_rgb(255,50,197))
	part_particles_create(global.sys_confetti, xx, yy, global.pt_confetti , amount_);
	part_type_color1(global.pt_confetti,make_color_rgb(45 ,255,63))
	part_particles_create(global.sys_confetti, xx, yy, global.pt_confetti , amount_);

	
}


function wire(startx,starty, seg_amount) constructor{ 
	
	self.startx = startx;
	self.starty = starty;
	// Arm properties
	arm_length = o_game.camera.height/5;
	arm_pinned = true;

	// Segment properties
	self.seg_amount = seg_amount; //default 8
	seg_length = arm_length/seg_amount;

	seg_x = [];
	seg_y = [];

	for(var i = 0; i < seg_amount; i++) {
	seg_x[i] = startx + i*seg_length;
	seg_y[i] = starty;
	}
	
}

function add_card_for_run(main_list , card_enum) { 
	
	ds_list_add(all_added_cards, card_struct( card_enum));
	ds_list_add(main_list , card_struct( card_enum));
}

function held_card(){ 
held.time = SEC*.5;

held.max_dis = 40;
if m1_pressed { 
	held.checkx = MX;
	held.checky = MY;	
}
if !m1_check { 
held.checkx = 0;
held.checky = 0;
held.targeting_enemy_i = noone;
held.enable = false;

}else{
	
	
held.dis = point_distance(held.checkx,held.checky,MX,MY);
held.dir = point_direction(held.checkx,held.checky,MX,MY);




/*
if held.checky != MY || held.checkx != MX{ 
	held.dir = point_direction(held.checkx,held.checky,MX,MY);
	held.checky = MY;
	held.checkx = MX;
}
*/




//var dis = 9999;

if held.lastheldx != MX and held.lastheldy != MY{

held.last_dir = point_direction(held.lastheldx,held.lastheldy,MX,MY);

if held.last_dir > 180 { 
//reste


held.targeting_enemy_i = noone;
held.enable = false;
	
}

}
held.lastheldx = MX;
held.lastheldy = MY;

if held.dis > held.max_dis { 
held.enable = true;




held.lenx = lengthdir_x((held.dis) *.12 ,held.dir);
held.leny = lengthdir_y((held.dis) *.12,held.dir);

held.checkx = held.checkx+held.lenx ;
held.checky = held.checky+held.leny ;





held.finalx0 = held.checkx;
held.finaly0 = held.checky;

}
//find the enemy with the closest distance to our dir



//if held.targeting_enemy_i = noone { 
var target_dir = 900;
var target_i = noone;


	var dir_ = point_direction( held.checkx,held.checky,MX,MY ) ;
	var xlen = lengthdir_x(99999,dir_)
	var ylen = lengthdir_y(99999,dir_)



	for (var i = 0; i < array_length(active_enemies) ;i++){ 
		var enemy_ = active_enemies[@ i]; 
		 
		 var direnemy_ = point_direction( held.checkx,  held.checky , enemy_.x,enemy_.y);
		var diff = angle_difference( dir_ , direnemy_);
		  
	//	debug("I IS " ,i ," DIFF IS ", diff, " ___ " , enemy_.title);
		if   abs( diff )  < target_dir {  //set it
			target_dir = abs(diff);
			target_i = i;
		}
		
		if target_i != noone { 
			held.targeting_enemy_i = target_i;
		}
	}


	#macro ANGLE_THRESH_FOR_TARGETING_ENEMIES 25

	held.finalx1 = held.checkx+xlen;
	held.finaly1 = held.checky+ylen;
	//draw_line(held.finalx0, held.finaly0, held.finalx1,held.finaly1) 	
	}
}


#region ///card structs



#endregion