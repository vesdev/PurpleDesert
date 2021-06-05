/// @description 



if !surface_exists(surf){
	surf = surface_create(room_width,room_height);	
}else{
	if (view_current == 0) {
		/*
		gpu_set_fog(1,c_white,0,1);
		draw_surface(surf,1,0);
		draw_surface(surf,-1,0);
		draw_surface(surf,0,1);
		draw_surface(surf,0,-1);
		gpu_set_fog(0
		,c_white,0,1);
		*/
		
		draw_surface(surf,0,0);
	}
}
with obj_mapgen{ 
	draw_player_minimap( draw_playerx, draw_playery);
}