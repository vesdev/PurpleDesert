
instance_destroy();
/*
var vc = view_camera[0];
var add = abs(sin(current_time*.001))*150;
var aspect = 640/360;
var width = 120+add;
var height = width/aspect;
camera_set_view_size(vc,(width),(height));
var vw = camera_get_view_width(vc);
var vh = camera_get_view_height(vc);
// this will be target game resolution:
game_width = vw;
game_height = vh;
// prevent default scaling behaviour:
/////////////
*/
// standard-issue arrow key movement:
// sloow pan
//if (keyboard_check(vk_shift)) { x += 0.1; y += 0.05; }
// all this trouble to get fractional mouse coordinates!

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _wnd_w = window_get_width();
var _wnd_h = window_get_height();
gui_scale = min(_wnd_w / _gui_w, _wnd_h / _gui_h);
var _gui_x = (_wnd_w - _gui_w * gui_scale) div 2;
var _gui_y = (_wnd_h - _gui_h * gui_scale) div 2;
gui_mouse_x = (window_mouse_get_x() - _gui_x) / gui_scale;
gui_mouse_y = (window_mouse_get_y() - _gui_y) / gui_scale;

// see https://yal.cc/gamemaker-click-n-drag-to-pan-view/
if (mouse_check_button_pressed(mb_middle)) and o_game.game_state = e_gamestate.choose_path{
	dragging = true;
	drag_x = gui_mouse_x;
	drag_y = gui_mouse_y;
}
if (dragging) {
	if (mouse_check_button(mb_middle))  and o_game.game_state = e_gamestate.choose_path{
		x -= gui_mouse_x - drag_x;
		y -= gui_mouse_y - drag_y;
		drag_x = gui_mouse_x;
		drag_y = gui_mouse_y;
		dragging_timer = SEC*3;
	} else{
		dragging = false;
		dragging_timer--;
	}
}else{
	dragging_timer--;	
}
