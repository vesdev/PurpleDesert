/// @description Insert description here
// You can write your code in this editor
if color = noone{
	if instance_exists(o_combo_parent){

	image_blend = o_combo_parent.after_image_color;
	}
	}else{
	
	image_blend = color;
	
	}
	
	x_ = return_gui_x(x);
	y_ = return_gui_y(y);

draw_sprite_ext(sprite_index,image_index,x_,y_,image_xscale,image_yscale,image_angle,image_blend,image_alpha);