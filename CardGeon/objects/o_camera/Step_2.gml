

var camx = camera_get_view_x(CAM);
var camy = camera_get_view_y(CAM);

var camw = camera_get_view_width(CAM);
var camh = camera_get_view_height(CAM);

smooth = true;
dragging_timer = -1;
if instance_exists(obj_mapgen) and dragging_timer <= 0 and !dragging and o_game.game_state = e_gamestate.choose_path{ 	
	var vc = view_camera[0];
	var vw = camera_get_view_width(vc);
	var vh = camera_get_view_height(vc);

	x = lerp(x,obj_mapgen.playerx-vw/2, .18);	
	y = lerp(y,obj_mapgen.playery-vh/2,  .18);	
}

var wheel = mouse_wheel_down() - mouse_wheel_up();

if (wheel != 0) and o_game.game_state = e_gamestate.choose_path { 
	wheel *= .1;
	var addw = camw * wheel;
	var addh = camh * wheel;
	camw += addw;
	//position
	x -= addw / 2;
	y -= addh / 2;
}

camh = camw/aspect;
if o_game.game_state = e_gamestate.battle { 
	camera_set_view_size(view_camera[0], width , height);
	camera_set_view_pos(view_camera[0], x , y);
}else{
	//surface_resize(application_surface, 1280, 720)
	camera_set_view_pos(view_camera[0],x , y);
	camera_set_view_size(view_camera[0], 640 , 360);
}