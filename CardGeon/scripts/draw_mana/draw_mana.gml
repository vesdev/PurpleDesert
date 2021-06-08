// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_mana(){
	
if live_call() return live_result;



var xx = 50  +xoffgame;
var yy = 100 +yoffgame;

if number_of_enemies = 0 exit;




draw_set_halign(fa_left);
var x_ = xx+10 ;
var y_ = yy-10 ;
var scale = .5;
draw_sprite_ext(s_mana_icon_2,0,-o_game.camera.width*.3,-o_game.camera.height*.33,scale,scale,0,c_white,1);



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
xx = -o_game.camera.width*0.29;
yy = -o_game.camera.height*0.255;



//	var output_string_scribble = string(max(0,round(struct.hp*struct.potential_health_lerp)))+"[c_white][scale, .5]/"+string(struct.hp_max);


//	scribble("[s_font_health][c_gum]"+output_string_scribble).draw(xx,hp_y);
	
if potential_mana_loss > 0 
{ 

	mana_text_color = "[C_GUM]";

}else{
	
}
	

scribble("[fa_center][s_font_health]"+mana_text_color+string(round(player.mana-potential_mana_loss))+"[]/"+string(player.mana_max)).draw(xx-2,yy);

exit;
shader_set(sh_fill_with_image_blend);
draw_sprite_ext(s_mana_icon,3,x_+3,y_+3,scale,scale,0,c_black,1); //dropshadow
shader_reset();


if mana_icon_timer <= mana_icon_time { 
	
	var y_mana_offset = easings(e_ease.easeoutelastic,-10,10,mana_icon_time,mana_icon_timer);
	y_ -= y_mana_offset;
	scribble("[fa_center][c_gum]NOT ENOUGH").draw(x_,yy-70+y_mana_offset*.2);
	var _interval = 12;
	if (mana_icon_timer % _interval) <= _interval/2 and mana_icon_timer > 0 {
		draw_outline_thick(s_mana_icon,3,x_,y_,scale,scale,0,C_GUM,1); //white outline
		draw_outline(s_mana_icon,3,x_,y_,scale,scale,0,C_DARK,1); //white outline
			mana_text_color = "[c_gum][shake]";
	}
	mana_icon_timer++;
}

scribble("[fa_left]"+mana_text_color+string(round(player.mana-potential_mana_loss))+"[]/"+string(player.mana_max)).draw(xx-2,yy);

if !hovered_over_card and allow_player_input() and boon_collision( x_-xoffset-bbox_xoffset,y_-yoffset-bbox_yoffset,x_-xoffset+sprite_width_+bbox_xoffset,yy-yoffset+sprite_height_*.5+bbox_yoffset ,MX,MY) {
	draw_status_information = "[c_yellow]MANA[]\nTHE RESOURCE NEEDED TO [c_yellow]PLAY CARDS[]. YOU GAIN [c_yellow]"+string(player.mana_gain)+"[] PER TURN.";
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