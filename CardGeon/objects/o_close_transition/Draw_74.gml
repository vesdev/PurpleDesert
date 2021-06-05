/// @description 
var w = display_get_gui_width();
var h = display_get_gui_height();
if room = next_room and second_target != noone and timer < SEC*.1{
	draw_set_color(C_DARK);
	draw_set_alpha(1);
	draw_rectangle(0,0,w,h,false);
	draw_set_color(c_white);
}