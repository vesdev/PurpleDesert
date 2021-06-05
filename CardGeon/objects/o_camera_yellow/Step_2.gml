smooth = true;

	dragging_timer = -1;;
if instance_exists(obj_mapgen) and dragging_timer <= 0 and !dragging{ 
	
	var vc = view_camera[0];
	var vw = camera_get_view_width(vc);
	var vh = camera_get_view_height(vc);

	x = lerp(x,obj_mapgen.playerx-vw/2, .18);	
	y = lerp(y,obj_mapgen.playery-vh/2,  .18);	
}

camera_set_view_pos(view_camera[0], floor(x), floor(y));

// toggling smooth camera:
/*
if (keyboard_check_pressed(vk_space)) {
	smooth = !smooth;
	smooth = true;
	// when enabling smooth camera, we set the view to draw to a surface
	// and disable application_surface so that the game doesn't clear it for nothing:
	application_surface_enable(!smooth);
	// in smooth camera mode, the view is made 1px wider and taller so that we can
	// comfortably move it up/left by 0..1px without any seams coming up:
	var pad = smooth ? 1 : 0;
	camera_set_view_size(view_camera[0], game_width + pad, game_height + pad);
}
*/
	smooth = true;
	application_surface_enable(!smooth);
	var pad = smooth ? 1 : 0;
	camera_set_view_size(view_camera[0], game_width + pad, game_height + pad);

// [re-]create the surface if needed
if (smooth) {
	if (!surface_exists(view_surf)) {
		view_surf = surface_create(game_width + 1, game_height + 1);
	}
	view_surface_id[0] = view_surf;
} else {
	if (surface_exists(view_surf)) {
		surface_free(view_surf);
		view_surf = -1;
	}
	view_surface_id[0] = -1;
}