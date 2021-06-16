/// @description Insert description here
if live_call() return live_result;



if o_game.game_state = 1 and !enable_event{ 
	scribble(
	"[fa_middle]KEY :\n[s_map_default_fight]ENEMY\n[s_map_fight_area_hard] BOSS\n[s_map_fight_area] SUPER ENEMY\n[s_map_rest_area]REST AREA"
	 ).draw(20,o_game.camera.height*.5);
	 var str = "[s_card_heart_small] "+string(player.hp)+"/"+string(player.hp_max);
	 str += "\n[s_icon_gold, 0, 0] "+string(player.gold)
	 str += "\n[s_map_key, 0, 0] "+string(player.golden_keys);
	 
	 
	 scribble("[fa_left]"+str).draw(o_game.camera.width*.02,o_game.camera.height*.04);
}

var w = gui_width;
var spr_w = sprite_get_width(s_palm_trees);


if battle_transition_timer > 0 exit;

if curtain_timer > curtain_time and curtain_timer_up > curtain_time_up exit;

	 if curtain_timer <= curtain_time { 
			curtain_xoffset = easings(e_ease.easeoutexpo,-gui_width,gui_width*1.3,curtain_time,curtain_timer);
			curtain_timer++;
	 }
	 curtain_time_up = SEC*1;
	if curtain_timer_up <= curtain_time_up and curtain_timer > curtain_time*.9 { 
	

	if next_game_state_queue != noone and curtain_timer_up >= curtain_time*.47 {  //curtain_timer_up = curtain_time*.71 switch rooms on this frame
			o_game.game_state	= next_game_state_queue;
			next_game_state_queue = noone;
			center_camera_on_player = SEC*.2;
	}
	
	var visible_ = false;
	if o_game.game_state = e_gamestate.battle { 
		visible_ = true;
	}
		curtain_yoffset = 0;
	var lay_id = layer_get_id("Battle_Background");
		layer_set_visible(lay_id,visible_);
		curtain_yoffset = easings(e_ease.easeinoutexpo,0,-sprite_get_height(s_palm_trees)*1.2,curtain_time_up,curtain_timer_up);
		curtain_timer_up++;
	}else{
		curtain_timer_up = 0;
	//	curtain_timer = 0;
	//	curtain_xoffset = 0;
	}
	var yoff = o_game.camera.height*.55+curtain_yoffset;
	var dis = 150;
	
	var front_col = c_black;
	var back_col = C_PINK;
	for (var i=0; i < 4 ; ++i){ 
		
		var amount =  ceil(sin(current_time) *5);
		amount = max(amount,1);
		draw_sprite_ext(s_palm_trees,0,curtain_xoffset+i*dis,yoff,-1,1,0,front_col,1);
	
		draw_sprite_ext(s_palm_trees,0,spr_w+w*.8-curtain_xoffset+i*dis,yoff,-1,1,0,front_col,1);
	}


	
function go_to_next_state(game_state_enum){ 
	with obj_mapgen{	
		next_game_state_queue = game_state_enum;
		curtain_xoffset = -gui_width;
		curtain_yoffset = -sprite_get_height(s_palm_trees)*.1;
		curtain_timer = 0;
		curtain_timer_up = 0;
	}
}