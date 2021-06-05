/// @description init
view_visible[0] = true;
view_enabled = true;

var vc = view_camera[0];

//var add = abs(sin(current_time*.001))*150;
aspect = 640/360; //16 / 9 
zoom = 1;
new_zoom = 1;
zoom_lerp = .2;
width = 960;
height = width/aspect;


//surface_resize(application_surface, width, height)

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
window_set_size(width,height);
display_set_gui_size(width, height);

