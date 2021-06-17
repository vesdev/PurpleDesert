if live_call() return live_result;


//surface
/*
if surface_exists(meatball_str.surf) {
	surface_set_target( meatball_str.surf );
	
	if meatball_str.timer <= meatball_str.time {
		var change = 1;
		meatball_str.size_mod = easings(e_ease.easeoutback,1+change,-change,meatball_str.time,meatball_str.timer);
		meatball_str.timer++;
	}
	
	
	draw_clear_alpha(c_black,0);
	shader_set(sh_meatballs);
	shader_set_uniform_f(meatball_str.u_size,3*meatball_str.size_mod );
	shader_set_uniform_f(meatball_str.u_time,current_time*.001);
	draw_sprite_ext(s_pixel,0,0,0,meatball_str.surf_width,meatball_str.surf_height,0,c_white,1);
	shader_reset();
	surface_reset_target();
	
	
}else{
 meatball_str.surf = surface_create(meatball_str.surf_width,meatball_str.surf_height);
}

	
if surface_exists(surf_bg) {
surface_set_target(surf_bg);
var col = make_color_rgb(16, 12, 25);
		
if  meatball_str.timer <= SEC*.05{ 
	 col = C_AQUA;
}
draw_clear_alpha(col,1);
gpu_set_blendmode(bm_normal);
	if surface_exists( meatball_str.surf){
		
		var inner_outline_col = C_PINK
		draw_surface_ext(meatball_str.surf,-1,0,1,1,0,inner_outline_col,1);
		draw_surface_ext(meatball_str.surf, 1,0,1,1,0,inner_outline_col,1);
		draw_surface_ext(meatball_str.surf,0,-1,1,1,0,inner_outline_col,1);
		draw_surface_ext(meatball_str.surf,0, 1,1,1,0,inner_outline_col,1);
		var col = col;
		draw_surface_ext(meatball_str.surf,0,0,1,1,0,col,1);
	}


var yoffset = 30;
var alpha = 1;
var color = merge_color( C_PINK , C_DARK,.85);


draw_sprite_ext(s_fade,0,0,0+yoffset,surf_bg_width,.15,0,color,alpha);
draw_sprite_ext(s_pixel,0,0,96+yoffset,surf_bg_width,surf_bg_height,0,color,alpha);
gpu_set_blendmode(bm_add);
//16, 12, 25
	var alpha = .25;
	var color = C_GUM;
	var xoffset_gradiant = 480;
	var xx_ = player.x+xoffset_gradiant;
	var yy_ = 135;
	var xoffset = 1;
	var yoffset =  1;
	var xscale_ = .3;
	var yscale_ = .05;
	
	var scale_  = 5;
	draw_sprite_ext(s_gradient,0,surf_bg_width*.5,surf_bg_height*.2,xscale_*scale_,yscale_*scale_,0,c_white,alpha*.2);

	var alpha_ = .07;
	
	//player
	draw_sprite_ext(s_gradient,0,xx_,yy_,xscale_,yscale_,0,c_white,alpha_);

	for (var i =0; i <array_length(active_enemies); i++) { 
		draw_sprite_ext(s_gradient,0,active_enemies[@ i].x+xoffset_gradiant ,yy_,xscale_,yscale_,0,c_white,alpha_);
	}

	gpu_set_blendmode(bm_normal);
surface_reset_target();

	draw_surface(surf_bg,-camera.width*.5,-camera.height*.5);

	
}else{
surf_bg = surface_create(surf_bg_width,surf_bg_height);	
}
*/

starBG.Draw(camera.x-camera.width/2, camera.y-camera.height/2, camera.width, camera.height);

str_sunset.x = -camera.width*.5;
str_sunset.y = -camera.width*.3;
str_sunset.draw();

draw_synth();
road3d.Draw();


if turn_phase  =  e_turn_phase.standby_phase {  //idk do standby phase stuff here
	turn_phase  =  e_turn_phase.main_phase;	
	switch game.combat.turns {
		case 0: repeat ( check_stuff(e_stuff.mana_restoring_pie)) { 
				add_card_to(hand, e_card.coco_emergency_cake, false);	
		}	break;	
	}
}

right_click_timer--;

if allow_player_input() and current_turn = e_current_turn.player_ { 
	if m2_pressed { 
		if right_click_timer < 0 { 
			right_click_timer = SEC*.3;
		}else{
			force_end_turn = true;
		}
	}
}


//draw_curve_line()
camera.zoom = 1;

camera.x = 0;
camera.y = 0;
set_battle_camera();

move_camera_to_coco = true;
//draw_sprite_ext(s_pixel,0,-camera.width*2,-camera.height*2,camera.width*4,camera.height*4,0,C_DARK,1);

if draw_card_queue > 0 { 
	draw_card_timer--;	
if draw_card_timer <= 0 {
	draw_card_queue--;
	queue_card(1)
	draw_card_timer = draw_card_time;
	if draw_card_queue = 0 {
			if turn_phase  =  e_turn_phase.draw_phase {
				turn_phase  =  e_turn_phase.standby_phase;	
			}
	}
}

var len = draw_card_queue;
len = clamp(len,0,hand_size_max_limit);

	for (var i= 0; i < len; i++){ 
		active_cards_list[| i].disable_sectable_timer = SEC*.5;
		active_cards_list[| i].x_ = -camera.width/1.2;
		active_cards_list[| i].y_ = -camera.height/2;
	}
}

if !m1_check || !allow_player_input(){ 
	selected_card_x = noone;
	selected_card_y = noone;
}

xoffgame = -camera.width/2;
yoffgame = -camera.height/2;

number_of_enemies = array_length(active_enemies);

init_card_script_queue();

var grid = map_grid;
var width = ds_grid_width(grid);
var height = ds_grid_height(grid);

#region
if current_turn = e_current_turn.player_ { 

	target_height = lerp(target_height , 0 , .15);
	current_light_target_struct = player;
}else { 
	var sprite =s_battle_bg;
	var sprite_height_ = sprite_get_height(sprite);
	target_height = lerp(target_height , sprite_height_ , .1);
}
#endregion
//player.buff.attack.amount = 0;





draw_status_information = false;
mana_text_color = "[c_white]";
deck_size = ds_list_size(deck);
discard_size = ds_list_size(discard);
exhaust_size = ds_list_size(exhaust);
//draw deck 
//deck_flash_timer = SEC;
draw_discard_and_deck();
if pause_combat_to_show_deck and !pause_combat_to_show_discard and !pause_combat_to_show_exhaust{ 
	draw_cards_in_deck();
	exit;
}

if pause_combat_to_show_discard  and !pause_combat_to_show_deck and !pause_combat_to_show_exhaust{ 
	draw_cards_in_discard();
	exit;
}
	
if pause_combat_to_show_exhaust and !pause_combat_to_show_discard and !pause_combat_to_show_deck { 
	draw_cards_in_exhaust();
	exit;	
}

deck_color = c_white;
draw_deck();
draw_set_color(deck_color);


draw_set_color(c_white)
draw_set_halign(fa_center)


var x__ = camera.width*.91;
var y__ = camera.height*.12;
var text_yoffset = -7;
var text_xoffset = 1;
//deck
draw_outline(s_ui_deck_circle,0,x__+xoffgame,y__+yoffgame,1,1,0,c_black,1);
draw_sprite_ext(s_ui_deck_circle,0,x__+xoffgame,y__+yoffgame,1,1,0,C_LAVENDER,1);
draw_text_outline(x__+xoffgame+text_xoffset, y__+yoffgame+text_yoffset,string(deck_size),c_black)
draw_text(x__+xoffgame+text_xoffset,y__+yoffgame+text_yoffset,string(deck_size));



var x__ = camera.width*.96;


//deck
draw_outline(s_ui_deck_circle,0,x__+xoffgame,y__+yoffgame,1,1,0,c_black,1);
draw_sprite_ext(s_ui_deck_circle,0,x__+xoffgame,y__+yoffgame,1,1,0,C_LAVENDER,1);
draw_text_outline(x__+xoffgame+text_xoffset, y__+yoffgame+text_yoffset,string(discard_size),c_black)
draw_text(x__+xoffgame+text_xoffset,y__+yoffgame+text_yoffset,string(discard_size));

var y__ = camera.height*.205;
//exhaust
draw_outline(s_ui_deck_circle,0,x__+xoffgame,y__+yoffgame,1,1,0,c_black,1);
draw_sprite_ext(s_ui_deck_circle,0,x__+xoffgame,y__+yoffgame,1,1,0,C_LAVENDER,1);
draw_text_outline(x__+xoffgame+text_xoffset, y__+yoffgame+text_yoffset,ds_list_size(exhaust),c_black)
draw_text(x__+xoffgame+text_xoffset,y__+yoffgame+text_yoffset,ds_list_size(exhaust));


//var scribble_discard = scribble("[fa_right]DISCARD "+string(discard_size));


//scribble_discard.draw(camera.width-10+xoffgame,65+yoffgame);
//var scribble_exahust = scribble("[fa_right]EXILE "+string(ds_list_size(exhaust)));
//scribble_exahust.draw(camera.width-10+xoffgame,110+yoffgame);



draw_set_color(c_white)

draw_set_halign(fa_right)
//draw_text(47+xoffgame,80+yoffgame,string((player.gold )));
var wgoldwide = 35;
var hgoldwide = 30;

//draw_rectangle(xoffgame,80+yoffgame,10+xoffgame+wgoldwide,80+yoffgame+hgoldwide,1);

if boon_collision(xoffgame,80+yoffgame,10+xoffgame+wgoldwide,80+yoffgame+hgoldwide,MX,MY){

		draw_outline_thick(s_icon_gold,1,17+xoffgame,87+yoffgame,1,1,0,c_white,1)
		draw_status_information = "GOLD [s_icon_gold, 1,0]\nMAKES A GREAT BIRTHDAY GIFT IN A JIFFY"
}
//draw_outline(s_icon_gold,1,17+xoffgame,87+yoffgame,1,1,0,c_black,1)
//draw_sprite(s_icon_gold,1,17+xoffgame,87+yoffgame);
//scr_gold.draw(10+xoffgame,80+yoffgame);
draw_set_halign(fa_left)

hand_size = ds_list_size(hand);

var color = "[c_white]";

player_defaultx_position = 110;
player_defaulty_position = 100;

draw_stuff();
draw_struct(player,player_defaultx_position +xoffgame, 135+yoffgame);

/////////////////////

draw_tokens();
draw_health_bar(50,100+40,player,0);
draw_discover();
if number_of_enemies != 0 { 
	draw_mana();
	can_end_the_turn();
	draw_status(-camera.width*.45,camera.height*0.165,player);
	draw_enemies();
	////DRAW HAND
	draw_hand();
}else{
	remove_generated_cards();
	reset_combat();
	draw_spoils();
}

var x_ =  -camera.width*.3;
var y_ = -camera.height*.3;

var wsize = camera.width*.05;
var hsize = camera.height*.12;
var xoff = camera.width*.02 ;
var yoff = camera.height*.04;
//draw_rectangle( x_+20-wsize+xoff,y_-hsize+yoff,x_+20+wsize+xoff,y_+hsize+yoff,1);
draw_set_color(c_white);
draw_set_font(font_boon);

if draw_status_information != false  { 
	var x_offset = 100;
	var y_offset = 20;
	var y_ = MY;
	var x_ = MX;//camera.width*0.34+xoffgame;
	
	if status_info.desc != draw_status_information { 
		status_info.scribble_desc =  scribble((( "[fa_center]"+ draw_status_information  ))).wrap(status_info.wrap_amount);
		
		var bbox_ = status_info.scribble_desc.get_bbox(0,y_);
		status_info.x0 =  bbox_.x0;
		status_info.y0 =  bbox_.y0;
		status_info.x3 =  bbox_.x3;
		status_info.y3 =  bbox_.y3;
	
	}

	status_info.desc_lerpx0  = lerp(status_info.desc_lerpx0, status_info.x0,status_info.desc_lerp_amount);
	status_info.desc_lerpy0  = lerp(status_info.desc_lerpy0, status_info.y0,status_info.desc_lerp_amount);
	status_info.desc_lerpx3  = lerp(status_info.desc_lerpx3, status_info.x3,status_info.desc_lerp_amount);
	status_info.desc_lerpy3  = lerp(status_info.desc_lerpy3, status_info.y3,status_info.desc_lerp_amount);
	
	status_info.nine_slice_w_margin = 10;
	status_info.nine_slice_h_margin = 5;
	
	var xoff_ = 15;
	var yoff_ = 80;
	if MX > 0 {
		x_ -= status_info.scribble_desc.get_width()/2+xoff_;
	}else{
		x_ += status_info.scribble_desc.get_width()/2+xoff_;	
	}

	nine_slice(s_nine_slice_hp,x_+status_info.desc_lerpx0-status_info.nine_slice_w_margin,status_info.desc_lerpy0-status_info.nine_slice_h_margin,status_info.desc_lerpx3+status_info.nine_slice_w_margin+x_,status_info.desc_lerpy3+status_info.nine_slice_h_margin,1,C_DARK);
	nine_slice(s_nine_slice_hp_border,x_+status_info.desc_lerpx0-status_info.nine_slice_w_margin,status_info.desc_lerpy0-status_info.nine_slice_h_margin,status_info.desc_lerpx3+status_info.nine_slice_w_margin+x_,status_info.desc_lerpy3+status_info.nine_slice_h_margin,1,c_white);
	status_info.scribble_desc.draw(x_,y_);
	
}




if m1_release { 
		hovered_over_card = false;	
}
