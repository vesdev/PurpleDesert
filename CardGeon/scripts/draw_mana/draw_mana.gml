// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_mana(){



var xx = 50  +xoffgame;
var yy = 100 +yoffgame;

if number_of_enemies = 0 exit;




draw_set_halign(fa_left);
var x_ = xx+10 ;
var y_ = yy-10 ;
var scale = .3;


//draw_sprite_ext(s_electricity_small,0,o_game.camera.width*.1,o_game.camera.height*.24,1,1,0,c_white,1);

var scale = 1;
var sprite = s_mana_icon; 
var sprite_height_ = sprite_get_height(sprite)+20;
var sprite_width_ = sprite_get_width(sprite);

var xoffset = sprite_get_xoffset(sprite);
var yoffset = sprite_get_yoffset(sprite);


var percent = divide( player.mana, player.mana_max);
percent = clamp(percent,0,1);

var change = sprite_height_ - 5;
var change_with_potential_mana_loss = change;
var bbox_yoffset = 5;
var bbox_xoffset = 5;
//draw_rectangle(x_-xoffset-bbox_xoffset,y_-yoffset-bbox_yoffset,x_-xoffset+sprite_width_+bbox_xoffset,yy-yoffset+sprite_height_*.5+bbox_yoffset,1);
xx = -o_game.camera.width*0.28;
yy = -o_game.camera.height*0.39;

var _l =  xx-20;
var _t =  yy-80;
var _r =  xx+30;
var _b =  yy+30;


//draw_rectangle(_l,_t,_r,_b, 1 );

if boon_collision( _l,_t,_r,_b,MX,MY){

	draw_status_information = "[c_yellow][s_electricity_small] ENERGY[]\nTHE RESOURCE USED TO [c_lime]PLAY CARDS.[] YOU RESTORE [c_lime]"+string(player.mana_gain)+"[] AT THE [c_yellow]START OF YOUR TURN";
	
}

//	var output_string_scribble = string(max(0,round(struct.hp*struct.potential_health_lerp)))+"[c_white][scale, .5]/"+string(struct.hp_max);


//	scribble("[s_font_health][c_gum]"+output_string_scribble).draw(xx,hp_y);
	
if potential_mana_loss > 0 
{ 



}else{
	
}
var scale = .1;


if potential_mana_loss = 0 || !m1_check { 
var scr = scribble("[fa_center][s_font_health_numbers]"+mana_text_color+string(round(player.mana-potential_mana_loss))+"[]_[s_font_boon_sunset]/"+string(player.mana_max))


draw_outline(s_electricity_large,0,xx+2,yy-20+2,scale,scale,0,c_black,1);
draw_outline(s_electricity_large,0,xx,yy-20,scale,scale,0,c_black,1);
draw_sprite_ext(s_electricity_large,0,xx,yy-20,scale,scale,0,C_YELLOW,1);
	
}else{
	
	
mana_text_color = "[c_gum]";	
	
scr = scribble("[fa_center]"+mana_text_color+"[s_font_health_numbers]"+string(round(player.mana-potential_mana_loss))+"[]_[s_font_boon_sunset]/"+string(player.mana_max))
var amount_ = .5;

var x_ = random_range(-amount_,amount_);
var y_ = random_range(-amount_,amount_);

draw_sprite_ext(s_electricity_large,0,xx+2+x_,yy-20+2+y_,scale,scale,0,C_BLUE,1);
draw_sprite_ext(s_electricity_large,0,xx+x_,yy-20+y_,scale,scale,0,C_PINK,1);
	
}

scr.blend(c_black,1).draw(xx-1,yy);
scr.draw(xx-1,yy);
scr.draw(xx+1,yy);
scr.draw(xx,yy-1);
scr.draw(xx,yy+1);
scr.draw(xx+2,yy+2);
scr.draw(xx+2,yy+1);
scr.blend(c_white,1).draw(xx,yy);
	
	
if mana_icon_timer <= mana_icon_time { 
	var yy_original = yy;
	yy += 90;
	var y_mana_offset = easings(e_ease.easeoutelastic,-10,10,mana_icon_time,mana_icon_timer);
	yy -= y_mana_offset;
	
	scribble("[fa_center][c_yellow][s_electricity_small] [c_gum][shake]NEED ENERGY [c_yellow][s_electricity_small]").draw(xx,yy-70+y_mana_offset*.2);
	var _interval = 12;
	if (mana_icon_timer % _interval) <= _interval/2 and mana_icon_timer > 0 {

		draw_outline(s_electricity_large,0,xx,yy_original-20,scale,scale,0,c_yellow,1);
	
		draw_sprite_ext(s_electricity_large,0,xx,yy_original-20,scale,scale,0,C_DARK,1);
			mana_text_color = "[c_gum][shake]";
	}
	mana_icon_timer++;
}



	

exit;
shader_set(sh_fill_with_image_blend);
draw_sprite_ext(s_mana_icon,3,x_+3,y_+3,scale,scale,0,c_black,1); //dropshadow
shader_reset();



scribble("[fa_left]"+mana_text_color+string(round(player.mana-potential_mana_loss))+"[]/"+string(player.mana_max)).draw(xx-2,yy);

if !hovered_over_card and allow_player_input() and boon_collision( x_-xoffset-bbox_xoffset,y_-yoffset-bbox_yoffset,x_-xoffset+sprite_width_+bbox_xoffset,yy-yoffset+sprite_height_*.5+bbox_yoffset ,MX,MY) {
	draw_status_information = "[c_yellow]ENERGY[]\nTHE RESOURCE NEEDED TO [c_yellow]PLAY CARDS[]. YOU GAIN [c_yellow]"+string(player.mana_gain)+"[] PER TURN.";
	draw_outline_thick(s_mana_icon,3,x_,y_,scale,scale,0,c_white,1); //white outline
	draw_outline(s_mana_icon,3,x_,y_,scale,scale,0,C_DARK,1); //white outline
}



//draw_sprite_ext(s_mana_icon,3,x_,y_,scale,scale,0,c_white,1); //white outline
//draw_sprite_ext(s_mana_icon,2,x_,y_,scale,scale,0,c_white,1); //purple bar




potential_mana_loss = clamp(potential_mana_loss,0,player.mana_max);
var percent_with_potential_mana_loss = divide( player.mana - potential_mana_loss, player.mana_max);
var change2 = change;
change *=  ( 1 - percent);
change2 *=  ( 1 - percent_with_potential_mana_loss);


if hovered_over_card and  m1_check and  selected_card_x != noone and is_struct( hand[| hand_hover_array])  and player.mana >= hand[| hand_hover_array].cost   { 
//potential_mana_los




draw_outline_thick(s_mana_icon,5,x_,y_-1,scale,scale,0,make_color_rgb(146, 161, 181),1);
draw_sprite_ext(s_mana_icon,5,x_,y_,scale,scale,0,c_white,1);

draw_sprite_ext(s_mana_icon,6,x_,y_,scale,scale,0,c_white,1); //white outline

shader_set(sh_fill_with_image_blend);
draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change2+1,scale,scale,C_DARK,1);
draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change2-1,scale,scale,C_DARK,1);
draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset+1,y_-yoffset+change2,scale,scale,C_DARK,1);
draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset-1,y_-yoffset+change2,scale,scale,C_DARK,1);

draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset+2,y_-yoffset+change2,scale,scale,C_DARK,1);
draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset-2,y_-yoffset+change2 ,scale,scale,C_DARK,1);

draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset+1,y_-yoffset+change2+3,scale,scale,C_DARK,1);
draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset-1,y_-yoffset+change2+3,scale,scale,C_DARK,1);
draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change2+3,scale,scale,C_DARK,1);
shader_reset();
//draw_sprite_part_ext(s_mana_icon,4,0,change,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change,scale,scale,c_white,1);

//draw_sprite_part_ext(s_mana_icon,1,0,change2,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change2,scale,scale,c_white,1);

draw_sprite_part_ext(s_mana_icon,0,0,change2,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change2,scale,scale,c_white,1);

}else{
if potential_mana_loss != 0 { 
	change = change2;	
}
	
//main bar
draw_sprite_ext(s_mana_icon,5,x_,y_,scale,scale,0,c_white,1);

draw_sprite_ext(s_mana_icon,3,x_,y_,scale,scale,0,c_white,1); //white outline
draw_sprite_ext(s_mana_icon,2,x_,y_,scale,scale,0,c_white,1); //white outline

if player.mana >= 1 { 

if change > 5 { 
draw_sprite_part_ext(s_mana_icon,1,0,change,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change-1,scale,scale,c_white,1);
draw_sprite_part_ext(s_mana_icon,1,0,change,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change,scale,scale,c_white,1);

}else{
//draw_sprite_part_ext(s_mana_icon,1,0,change,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change,scale,scale,c_white,1);
draw_sprite_part_ext(s_mana_icon,1,0,change-1,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change-1,scale,scale,c_white,1);
draw_sprite_part_ext(s_mana_icon,1,0,change,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change,scale,scale,c_white,1);

}
}
draw_sprite_part_ext(s_mana_icon,0,0,change,sprite_width_,sprite_height_,x_-xoffset,y_-yoffset+change,scale,scale,c_white,1);

if mana_icon_timer <= SEC*.08 { 
draw_outline_thick(s_mana_icon,5,x_,y_-1,scale,scale,0,c_white,1);
	
}
//tell the player what the mana bar is 




}
}