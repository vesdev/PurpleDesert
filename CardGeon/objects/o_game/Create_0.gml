/// @description 


u_energy_sine = {
	shader : sh_sine_wave_collision,
	
	us_speed	 : 0.001,
	us_amplitude : 0.001,
	us_frequency : 359,

	u_speed		 : shader_get_uniform(sh_sine_wave_collision,"speed"),
	u_amplitude  : shader_get_uniform(sh_sine_wave_collision,"amplitude"),
	u_frequency  : shader_get_uniform(sh_sine_wave_collision,"frequency"),
	time		 : shader_get_uniform(sh_sine_wave_collision,"time"),
	texel_size	 : shader_get_uniform(sh_sine_wave_collision,"texel"),
	_tex		 : sprite_get_texture(s_dungeon_wall_export,0),
}


//audio_sync_group_debug(o_audio.sketch1.Group);
//show_debug_overlay(true);				
//create(0,0,o_rain_system);
//show_debug_overlay(true)
//audio_play_sound(sketch1_b,1,1);

boss_room = false;

enum e_resolution {	
	hd_960,
	android_1480,
	size_
}

mana_target_lerp = 0;

global.shop_yoffset = 20;

upgrade_card_select = { 
	x : 0,
	y : 0,
	i : 0,
	struct : 0,
	enable : false,
}

remove_card_select = { 
	x : 0,
	y : 0,
	i : 0,
	struct : 0,
	enable : false,
}
shop_card_select = { 
	x : 0,
	y : 0,
	i : 0,
	struct : 0,
	enable : false,
	original_amount : noone,
}

cannot_upgrade_card_timer = SEC*2;

deck_flash_timer = -1;
deck_flash_time = SEC;

card_draw_sounds = { 
	enable : false,
	sound_queue : 5,
	sound_interval : SEC*.15,	
	sound_timer : 0,
}

//aspect = 1366/768;
//w = 1366;
switch os_type { 

case os_android:

	var aspect = 37/18; //android 2.05
	var w = 1480;
	
	var aspect = 37/18; //android 2.05
	var w = 962;

break;
case os_windows:

	var aspect = 16/9; //widescreen 1.777778 1920 / 1080 
	var w = 960;

break;
}


var aspect = 16/9; //widescreen 1.777778 1920 / 1080 
var w = 960;

var h = w/aspect;

camera = o_menu.camera;

globalvar border_scale;

console = new Console();

draw_status_information = "";

enum e_turn_phase { 

	draw_phase,
	standby_phase,
	main_phase,
	end_phase,
	
}

turn_phase  =  e_turn_phase.draw_phase;


border_scale = camera.height/1300

camera.scaleWindow(1);

first_draw = false;

xoffgame = 0;
yoffgame = 0;



peek_at_map = false;

draw_set_font(font_boon);

attack_target = []; // who is being targeted



//changes how buffs work in the game
buff_multipliers = { 
		fragile : 1.5,
		weak : .75,
		slow_start : .5,
		armor_reduction : .75,
}


init_particles();

check_for_token = false;

enum e_gamestate { 
	battle,
	choose_path,
	size_
}


game_state = e_gamestate.choose_path;

global.scribble_state_line_min_height_default = 11; 
global.scribble_state_line_max_height_default = -1; 
global.get_text_height_offset = 0;
global.scribble_font_height = 15;

globalvar gui_width, gui_height, fast_mode, cam_width, cam_height;

fast_mode = false;
cam_width = 640;
cam_height = 360;

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();

armor_color = c_blue;

//refer to enemy_intentions
hovering_over_enemy_intent = false;


enum e_intentions_contents {
	sprite,
	scripts,
	desc,
	size_
}


held ={ 
	checkx : 0,
	checky : 0,
	lastheldx : 0,
	lastheldy : 0,
	lastdir : 0,
	dir : 0,
	lenx : 0,
	leny : 0,
	lastdir : 0,
	dis : 0,
	targeting_enemy_i : 0,
	last_targeted_enemy : noone,
	max_dis : 20,
	timer : 0,
	time : 0,
	enable : false,
	
	finalx0 : 0,
	finaly0 : 0,
	finalx1 : 0,
	finaly1 : 1,
}



function condition_struct( result) constructor{ 
	self.result = result;
	
	amount = 0;
	buff_type = 0;
	
	
}

globalvar intentions, keywords, conditions;

conditions ={ 
	dealt_a_crit_this_turn : new condition_struct( function(){ return o_game.dealt_a_crit_this_turn }),
	have_five_tokens : new condition_struct(function(){  var len = array_length( player.token_array); if len >= 5 { return true; }else{ return false} }),
	have_20_temp_attack : new condition_struct( function(){ return player.buff.attack_lost_on_crit.amount >= 20  }),
	have_40_armor : new condition_struct( function(){ return player.armor >= 40  }),
	

}


init_intentions();


#region keyword sturcts

function keyword_struct(print_keyword, sprite, title, desc ) constructor{ 
	self.print_keyword = print_keyword;
	self.sprite = sprite;
	self.title = title;
	self.desc = desc;
	self.card_enum = noone;
	self.card_struct = noone;
}

function keyword_card_struct(card_enum) : keyword_struct() constructor{ 
	self.print_keyword = 0;
	
	self.card_enum = card_enum;
	self.card_struct = function(){ return card_struct(card_enum) };
	self.sprite = s_keyword_card;
	self.title = "";
	self.desc = function() { return ""};
}
defeated_enemies_flag = false;
keywords ={ 
	fragile :			new keyword_struct(0, s_status_def_down, "FRAGILE", function(){ return "TARGET TAKES [c_gum]"+string(buff_multipliers.fragile*100)+"%[] DAMAGE FROM ATTACKS. REMOVE [c_gum]1[] STACK PER TURN."}),
	weak    :			new keyword_struct(0, s_status_atk_down, "WEAK",function() { return "[c_yellow]WEAK[] [s_status_atk_down]\nTARGET DEALS [c_gum]"+string(buff_multipliers.weak*100-100)+"%[] LESS DAMAGE FROM ATTACKS. REMOVE [c_gum]1[] STACK PER TURN."}),
	armor_reduction:	new keyword_struct(1, s_keyword_retain,"ARMOR REDUCTION", function() { return "GET [c_gum]-"+string(buff_multipliers.armor_reduction*100-100)+"%[] LESS ARMOR FROM ALL SOURCES. REMOVE [c_gum]1[] STACK PER TURN."}),
	token   :			new keyword_struct(0, s_status_token, "TOKEN", function() { return "THE [s_card_heart_small] REPRESENTS HOW MANY TURNS [c_yellow]IT LASTS.[]"}),
	
	choose_ :			new keyword_struct(0, s_keyword_choose, "CHOOSE", function() { return "CHOOSE 1 OUT OF 3 OPTIONS"}),
	wimpy_punch :		new keyword_struct(0, s_keyword_wimpy, "WIMPY PUNCH", function() { return "[c_lime]0[] COST.\nDEALS [c_lime]"+string(player.wimpy_punch_damage+player.wimpy_punch_add_damage)+"[] DAMAGE.\n[c_yellow]CAN'T CRIT[]"}),
	
	single_use :		new keyword_struct(1, s_keyword_single, "EXILE", function() { return "CARD IS MOVED TO EXILE PILE ON USE"}),
	passive :			new keyword_struct(0, s_keyword_passive, "PASSIVE", function() { return "LASTS ALL COMBAT. IS MOVED TO [c_yellow]EXILE[] [s_keyword_single] PILE ON USE."}),
	
	cant_crit :			new keyword_struct(1, s_keyword_cant_crit, "WIMPY", function() { return "ATTACK [c_gum]CAN'T[] CRIT"}),
	unplayable :		new keyword_struct(1, s_keyword_unplayable, "UNPLAYABLE", function() { return "[c_gum]CANNOT[] BE PLAYED FROM YOUR HAND"}),
	
	evaporate :			new keyword_struct(1, s_keyword_evaporate, "EVAPORATE", function() { return "WHILE THIS CARD IS IN YOUR HAND AT THE [c_yellow]END OF YOUR TURN[]. [c_lime]EXILE IT[]"}),


	lucky :				new keyword_struct(1, s_keyword_lucky,		"LUCKY", 	function() { return "THIS CARD [c_lime]ALWAYS[] CRITS"}),
	lucky_dont_print :	new keyword_struct(0, s_keyword_lucky,		"LUCKY", 	function() { return "THIS CARD [c_lime]ALWAYS[] CRITS"}),
	retain :			new keyword_struct(1, s_keyword_retain,"RETAIN", function() { return "DO NOT DISCARD THIS AT THE END OF YOUR TURN."}),
	retain_dont_print :	new keyword_struct(0, s_keyword_retain,"RETAIN", function() { return "DO NOT DISCARD THIS AT THE END OF YOUR TURN."}),//will not print it in the description
	endurance :			new keyword_struct(0, s_keyword_endurance,"RESILIENCE", function() { return "INCREASES [s_status_armor] ARMOR GAINED FROM CARDS."}),

	show_card :			new keyword_card_struct(),
	crit_gift :			new keyword_struct(0, s_keyword_crit_with_this,"ON CRIT", function() { return "BONUS EFFECT WHEN YOU CRIT WITH [c_yellow]THIS[] CARD."}),

	temp_attack :			new keyword_struct(0, s_status_pow_remove_on_crit,"TEMPOARY ATTACK", function() { return "INCREASES DAMAGE. BUFF IS [c_gum]REMOVED[] AFTER CRIT."}),
	permanent_effect: new keyword_struct(0, s_keyword_permanent_buffs,"PERMANENT BUFFS", function() { return "THESE BUFFS STAY WITH YOU UNTIL THE [c_lime]END OF THE RUN.[]"}),
	execute : new  keyword_struct(0, s_keyword_execute,"EXECUTE", function() { return "IF THIS CARD DEALS THE [c_lime]KILLING[] BLOW."}),
//	armor : ["ARMOR","Armor is [c_yellow]removed at the end of a turn[] unless stated otherwise."],	
//	exhaust: ["EXILE","This card is removed from the game when played"],
//	destroyed: ["DESTROYED","This card is removed from the game"],
//	defenseless: ["DEFENSELESS","RECIEVE [c_yellow]"+percent_to_string(get_defenseless_amount())+"%[] MORE DAMAGE"]
}


#endregion 
player_defaultx_position = 110;
player_defaulty_position = 100;

init_card_border_step(0);
hold_target_dir = [];
//card_fear = new card( "FEAR",  noone, "This card is EXILEED while it's in your hand and it's the end of your turn.",  noone,   add_bad_card, keywords.destroyed	);
globalvar player , active_enemies, number_of_enemies;
enum char { 
	coco,
	wolfman,
	size_
	
}

char_coco = new playable_character("COCO", 200 , s_char_idle_coco, s_char_hit_coco, s_char_uneasy_coco, s_char_victory_coco,


function(struct) { 
	return "[c_lime]COCO[]\n[c_lime]LOVES:[] ROLLING AROUND AND PIZZA\n[c_gum]HATES:[] DEBT COLLECTORS\n[c_aqua]CURRENT[] CRIT CHANCE [c_yellow]"+string(get_crit_chance(struct)*100)+"%[]\n[c_aqua]CURRENT[] CRIT DAMAGE: [c_yellow]"+string(round(get_crit_damage(struct)*100))+"%[]";	
},char.coco
);


player = char_coco;




total_buff_amount =	variable_struct_names_count(player.buff);

//,new_enemy(e_enemies.wolf), new_enemy(e_enemies.wolf)
active_enemies = [];
number_of_enemies = array_length(active_enemies);



deck_is_not_drawn_in_order_warning = false;
draw_tempoary_list_deck = ds_list_create();

pause_combat_to_show_deck = false;
pause_combat_to_show_discard = false;


move_camera_to_coco = true;
hand_over_rewards_array = [];

hand_hover_array = 0;
debug_value = 0;
tip_yoffset = 0;


enum card_name {
	strike,
	shield,
	size_
}


enum card_info { 
	title,
	desc,
	effect,
	size_
}

for (var xx= 0; xx < card_name.size_; ++xx) { 
	for (var yy = 0; yy < card_name.size_; ++yy) { 
		directory[ xx, yy ] = noone; //initialize them
	}
}



discard_to_deck_queue = { 	
	list : ds_list_create(),
	enable : false,
	array : [],
	timer : -1,
	draw_amount : 0,
	amount_launched : 0,
	time_func : function() { 
		
		
		if fast_mode { 
			return SEC*.05;	
		}else{
			return SEC*.15;
		}
	}
}


hovered_over_card = false;
hand_to_discard = {
	enable : false,
	amount : 0,
	len : 0,
	timer : 0,
	time : SEC*.15,
	reposition_timer : 0,
	reposition : noone,
}

init_cards();
init_stuff();

globalvar deck,hand,discard, card_shop,  exhaust, all_added_cards, card_spoils, all_token_list, enemy_dungeon_list, stuff_list,stuff_list_golden;

all_added_cards = ds_list_create();
card_shop = ds_list_create();
deck = ds_list_create();
hand = ds_list_create();
discard = ds_list_create();
exhaust = ds_list_create();
enemy_dungeon_list = ds_list_create()

stuff_list = ds_list_create();
stuff_list_golden = ds_list_create();
card_spoils = ds_list_create();
all_token_list = ds_list_create();

end_turn_queue = ds_list_create();

ds_list_add(stuff_list, 
	e_stuff.tokens_stay,
	e_stuff.lucky_penny,
	e_stuff.more_spoil_options,
);
/*
ds_list_add(stuff_list, 
	e_stuff.tokens_stay,
	e_stuff.lucky_penny,
	e_stuff.more_spoil_options
);
*/
reset_stuff_list_golden();
pause_combat_to_show_exhaust = false;
discard_icon_size_timer = 0;
discard_icon_size_time = SEC*.3;

exhaust_flash_timer					= 0;
//time looks amazing at SEC*.3 or .4
exhaust_flash_time = SEC*.4;

exhaustx = 0;
exhausty = 0;
exhaust_size = 1;


reset_stuff_list();

ds_list_add(enemy_dungeon_list,

[e_enemies.pear,e_enemies.pear,e_enemies.pear],
[e_enemies.snake, e_enemies.snake ],
[e_enemies.bee, e_enemies.bee, e_enemies.bee],
[e_enemies.bear],
[e_enemies.babydragon,e_enemies.babydragon,e_enemies.babydragon],
[e_enemies.fat_tony],
);

ds_list_shuffle(enemy_dungeon_list)


ds_list_insert(enemy_dungeon_list, 0 , [e_enemies.firefox]);
ds_list_insert(enemy_dungeon_list, 0 , [e_enemies.bee, e_enemies.bee]);
ds_list_insert(enemy_dungeon_list, 0 ,[e_enemies.snake]
);

wait_for_the_attack_to_play_out_time = SEC*.35;
wait_for_the_attack_to_play_out_timer = 0;

for (var i=0; i < e_token.size_; i++) {
ds_list_add(all_token_list,i);

}
ds_list_shuffle(all_token_list)

ds_list_add(card_spoils,

e_card.coco_discover_token,
e_card.coco_token_bee,
e_card.coco_token_salmon,
e_card.coco_token_spider,
e_card.coco_reduce_hand_cost_and_armor,

e_card.coco_token_bat,
e_card.coco_token_beetle,
//e_card.coco_token_dice,

e_card.coco_curl_up,
e_card.coco_hot_sauce,
e_card.coco_rocket_punch,
e_card.coco_iron_punch,
e_card.coco_generate_wimpy_punch,
e_card.coco_nut_kick,
e_card.coco_spin,
e_card.coco_boomerang,
e_card.coco_pebble_throw,
e_card.coco_generate_emergency_cake,
e_card.coco_lucky_punch,
e_card.coco_green_juice,
e_card.coco_double_armor,
e_card.coco_keep_armor,
e_card.coco_genereate_broken_bottle,
e_card.coco_liquid_luck,
e_card.coco_all_in,
e_card.coco_double_damage_on_crit,
e_card.coco_armor_slam,
e_card.coco_add_temp_attack,
e_card.coco_ultra_armor,
e_card.coco_clingy_shield,
e_card.coco_wimpy_pebble_throw,
e_card.coco_powerup_punch,
e_card.coco_focus,
e_card.coco_coupe_de_grace,
e_card.coco_replay_red,
e_card.coco_token_summoning,
e_card.coco_bubble_shield,
e_card.coco_starter_kit,
e_card.coco_lucky_helmet,
e_card.coco_sucker_punch
);

for (var i = 0; i < player.card_shop_options; i++){ 
	var card_ = ds_list_find_value(card_spoils,i);
	ds_list_add(card_shop, card_);
}


ds_list_shuffle(card_shop)
ds_list_shuffle(card_spoils)

first_card_we_played = false;
display_notification = false; 
potion_slots = [noone, noone, noone];

map_grid = ds_grid_create(12,5);

show_keyword_time = SEC*1.2;
show_keyword_timer = 0;
enable_end_turn_button = true;

enum e_current_turn { 
	player_,
	enemy_,
	size_
}
current_turn = e_current_turn.player_;

init_input();

//enable new relic 4 leaf clover
//All attacks now have 10% of attacking twice
//enable new relic: LUCKY UNDERWEAR
//Gain 1 strength every time you 
// Your left most card costs -2 energy
///
//Your next card costs (HEALTH X 2) instead of energy
//Put all enemies to SLEEP for one turn costs 3
  
//SPIT Give Enemies Defenseless for 2 turns

//Scavenger Enemy gains 2 strength
//Cornered Enemy gains +5 strength when alone
//Cloak of invisibility Enemies start Unaware for 1 turn.
hovering_over_a_target = false;

////////////////////////////////////////
selected_card_x = 0;
selected_card_y = 0;
//surface for when you point something to a card
caret_surface = surface_create(gui_width*10,gui_height*10);
potential_mana_loss = 0;
mana_icon_yoffset =0;
mana_icon_xoffset =0;
mana_icon_timer = 0;
mana_icon_time = SEC*1.75;
mana_icon_timer = mana_icon_time*2;

//window_set_size(640,360);

hover_hand_keyword_x = noone;
hover_hand_keyword_y = noone;
hand_hover_keyword_left = false;

keyword_easeing_x = 0;
keyword_easeing_y = 0;
keyword_easing_timerx = 0;
keyword_easing_timery = 0;
keyword_easing_timex = SEC*.5;
keyword_easing_timey = SEC*.5;

target_height = 0;
keyword_flash_timer = SEC*.1;
hand_size_max_limit = 10;

turns_through_combat = 0;
turns_through_run = 0;
card_distance = 140;

o_game.default_card_border_width =  sprite_get_width(s_card_border)*2; 
o_game.default_card_border_height= sprite_get_height(s_card_border)*2;

function  card_border( card_struct) constructor{
	
	force_update = false;
	
	sprite = s_card_border;
	x_ = undefined;
	y_ = undefined;

	x0 = 0;
	y0 = 0;
	x3 = 0;
	y3 = 0;
	
	w = 0;
	h = 0;

	reference_enum = noone;

	title = noone; 
	desc = noone;
	
	title_wrap = noone;
	desc_wrap = noone;
	

	disable_sectable_timer = SEC*.5;
	xangle = 0;
	yangle = 0;
	
	angle = 0;
	xscale = 1;
	xscale = 1;
	alpha = 1;
	
	outline_color = noone;
	
	cost_color = c_white;
	title_color = c_white;
}

active_cards_list = ds_list_create();
all_passive_treasures = [];

enum e_discover { 
	add_for_combat,
	add_for_run,
	add_for_turn,
	play_token,
	play_it,
	or_condition_for_card,
	size_
}

globalvar hand_size ,attack_target, spoils_card_len;//things that will never change

queue_up_card_script = [];

globalvar discover_queue , hand_size_max_limit, card_array_queue;
spoils_card_len = 3;
discover_queue = { 
	array : [],
	type : e_discover.add_for_combat,
	hide : false,
	place_to_add : hand,
	finder_script : function(){ 
			
			//where does the card get added?
			switch type { 
				case e_discover.add_for_run:  place_to_add = deck; 
				default:
				place_to_add = hand;
				break;
			}
		
			//assign the correct script to get the right struct
			switch type{ 
						case e_discover.play_token: return token_struct;
						break;
						case e_discover.or_condition_for_card: return noone;
						break;
						
						case e_discover.add_for_combat: 
						default:		
						return card_struct;
						break;
				}
		},
		
}


card_array_queue = { //when we want to play a card scripts, it gets stored into this queue system, so we don't do them at the same time
	flag_01 : false,
	array : [],
	timer : 0,
	time_func : function(){
				var time_ = SEC*.25;
				if fast_mode time_ *= .5;
				return time_;
			}
}

played_card_hover_sound = false;


status_info ={ 
	
	desc : "",
	scribble_desc : "",
	wrap_amount : 250,
	x0 : noone,
	y0 : noone,
	x3 : noone,
	y3 : noone,
	
	nine_slice_w_margin : 20,
	nine_slice_h_margin : 30,
	
	desc_lerpx0 : 0,
	desc_lerpy0 : 0,
	desc_lerpx3 : 0,
	desc_lerpy3 : 0,
	desc_lerp_amount : .4,
}


for (var i= 0; i < hand_size_max_limit; i++){ 
	
	ds_list_add( active_cards_list, new card_border( noone));
}

draw_card_queue = 0;
draw_card_time = SEC*.2;
draw_card_timer = 0;

caret_angle_lerp = 0;


/*	
	Boss Pitcher Plant, enemy spawns 5 token ants, Pitcher Plant consumes ants to gain health and strength
	Pitcher Plant Ants Gain 1 strength when pitcher plant gets attacked
*/


hovered_y_offset = 0;


hovered_y_time = SEC;
un_hovered_y_time = SEC;
un_hovered_y_offset = 0;
hovered_y_timer = SEC;
un_hovered_y_timer = SEC;

function stats() constructor{ 
	
	rooms_cleared = 0;
	
	token_array = 0;
	summoned_token = 0;
	dead_token = 0;
	
	turns = 0;
	cards_played = 0;
	damage_dealt = 0;
	damage_taken = 0;
	
	mana_spent = 0;
	
	red_cards_played = 0;
	green_cards_played = 0;
	blue_cards_played = 0;
	white_cards_played = 0;
	gold_cards_played = 0;
	
	mana_spent_on_red = 0;
	mana_spent_on_green = 0;
	mana_spent_on_blue = 0;
	mana_spent_on_white = 0;
	mana_spent_on_gold = 0;
	
	time_played = 0;
	
	enemies_faced_array = [];
	damage_taken_by_enemy = []; //first is the enemy title 2nd is the enemy damage0
}



function square_hit_effect(x, y,init_time,static_time,end_time) constructor{ 
	self.x = x;
	self.y = y;
	end_timer = 0;
	self.rotate_square_time = init_time;
	self.delay_time = static_time;
	self.end_time = end_time;
	

	rotate_square_amount = 0;
	rotate_square_size = 0;
	rotate_square_timer		= 0;

}
hit_effect_array = [];


game = { 
	combat : new stats(),
	run : new stats(),
}

wire_array = [new wire(0,0, 8)]


view_deck_or_discard_card_yoffset = 0;
drawing_keywords = false;

deck_flash_time = SEC*.3;
draw_card_time = SEC*.2;

discard_flash_timer = 0;
discard_flash_time = SEC*.4;

discard_xsize = 1;
right_click_timer = 0;

for (var i =0; i <e_token.size_;i++){ 
	var token = token_struct(i);
	player.token_stats[@ i].amount_affects_stat_by = 	token.amount1_per_level_up;
	player.token_stats[@ i].amount_affects_stat_by2 =	token.amount2_per_level_up;
	player.token_stats[@ i].amount_affects_stat_by3 =	token.amount3_per_level_up;	
}


max_number_of_enemies = 20;

init_fight = false;
init_fight_timer = SEC*.5;
synth_wave = {
	x_position : 0,
	xtarget : 0,
	xscale_target : 0,
	yscale_target : 0,
	//initialis surfaces
	surf : surface_create(400, 380),
	clipping_mask : surface_create(380, 380),
	col : floor(random(16777216)),
	//ignore bm values - these were just for me messing with blend modes
	bm_1 : 0,
	bm_2 : 0,
	//number of sides the shape will have
	sides : irandom_range(4, 8),
	//for opening/closing the portal
	active : false,
	//scaling the surface
	xscale : 0,
	yscale : 0,
	xscale_target : 0,
	yscale_target : 0
}

surf_bg_width = 1000;
surf_bg_height = 1000;
surf_bg = surface_create(surf_bg_width,surf_bg_width);


meatball_str ={ 
	
	timer : 0,
	time : SEC*.25,
	size_mod : 1,

	
	surf_width : 1000,
	surf_height : 1000,
	surf : surface_create(1000,1000),
	u_size : shader_get_uniform(sh_meatballs,"u_size_mod"),
	ball_size : 2,
	u_time : shader_get_uniform(sh_meatballs,"u_time"),
}




//new sunset
str_sunset = new sunset(-350,-250);

//3d waves
waves3d = new wave3D();
road3d = new road3D();
starBG = new starBackground();

depth = DEPTH_GAME;
reset_battle_camera();
force_end_turn = false;
total_intent_enemy_damage  = 0;
reset_combat();
is_hovering_over_card = noone;

event_user(14);	 

add_stuff(e_stuff.goggles);
room_goto(r_dungeon_init);