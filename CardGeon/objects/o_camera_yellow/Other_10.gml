/// @description init
view_visible[0] = true;
view_enabled = true;
var vc = view_camera[0];

//var add = abs(sin(current_time*.001))*150;

var aspect = 640/360;
var width = 640;
var height = width/aspect;

camera_set_view_size(view_camera[0], width, height);

var vc = view_camera[0];
var vw = camera_get_view_width(vc);
var vh = camera_get_view_height(vc);
game_width = vw;
game_height = vh;
if instance_exists(obj_mapgen){ 
	x = obj_mapgen.playerx+vw/2-50;	//+room_xoffset
	y = obj_mapgen.playery+vh+50;
	dragging_timer = -1;;
//	y = obj_mapgen.playery + vh;
}

	
// this will be target game resolution:

ax = camera_get_view_x(vc) - x;
ay = camera_get_view_y(vc) - y;
// prevent default scaling behaviour:
surface_resize(application_surface, vw, vh);
display_set_gui_size(vw, vh);

