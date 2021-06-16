///@desc audio_play_footstep();
function audio_play_footstep() {
	
	
	// This script plays a global footstep sound based on the object or tile the player is currently standing on.
	// The priority and or overlapping of sounds is dictated by their place/order in this script
	if instance_exists(o_player) == false
	{
		exit;
	}

	var xx = o_player.x;
	var yy = o_player.y;


	if global.pillow_shoes = true
	{
		audio_play(aud.foot_cloud,xx,yy,0);
		exit;
	}


	if  instance_position(x,y,o_grass)
	{
		audio_play(aud.foot_bush,xx,yy,0);
		exit;
	}

	if instance_place(x,y,o_stair_parent)
	{
		audio_play(aud.foot_wood,xx,yy,0);
		exit;
	}

	if instance_place(x,y,o_switch)
	{
		audio_play("sfx_footstep_concrete",o_player.x,0,0);	
		exit;
	}

#region // hub
		if room = r_hub
		{
			var map_id = layer_tilemap_get_id(layer_get_id("Bridge"));
			var data = tilemap_get(map_id,tilemap_get_cell_x_at_pixel(map_id,x,y),tilemap_get_cell_y_at_pixel(map_id,x,y));
			var ind = tile_get_index(data);
	
			// bridge wood
			if ind == 231
			|| ind == 232
			|| ind == 233
			|| ind == 248
			|| ind == 249
			|| ind == 250
			{
				audio_play(aud.foot_wood,xx,yy,0);
				exit;
			}
	
			// burned ground
			var map_id = layer_tilemap_get_id(layer_get_id("burned_ground"));
			var data = tilemap_get(map_id,tilemap_get_cell_x_at_pixel(map_id,x,y),tilemap_get_cell_y_at_pixel(map_id,x,y));
			var ind = tile_get_index(data);
			if ind != 0
			{
				audio_play(aud.foot_dirt,xx,yy,0);
				exit;
			}
	
			// sand
			var map_id = layer_tilemap_get_id(layer_get_id("sand"));
			var data = tilemap_get(map_id,tilemap_get_cell_x_at_pixel(map_id,x,y),tilemap_get_cell_y_at_pixel(map_id,x,y));
			var ind = tile_get_index(data);
			if ind = 1
			{
				audio_play(aud.foot_sand,xx,yy,0);
				exit;
			}
	
			// grass
			var map_id = layer_tilemap_get_id(layer_get_id("regular_grass"));
			var data = tilemap_get(map_id,tilemap_get_cell_x_at_pixel(map_id,x,y),tilemap_get_cell_y_at_pixel(map_id,x,y));
			var ind = tile_get_index(data);
			if ind = 1
			{
				audio_play(aud.foot_grass,xx,yy,0);
				exit;
			}
		}
#endregion
	// DUNGEONS

#region//1 (Dragon)
	if room = r_ran or room = r_ran_bonus_floor {


		var lay_id = layer_get_id("UNDERWALL");
		var map_id = layer_tilemap_get_id(lay_id);
		var mx = tilemap_get_cell_x_at_pixel(map_id, x, y);
		var my = tilemap_get_cell_y_at_pixel(map_id, x, y);
		var data = tilemap_get(map_id, mx, my);
		var ind = tile_get_index(data);
		//ind 1 means that it's completly full
		if ind != 0
		{
			//we are on stone
			audio_play(aud.foot_gravel,xx,yy,0);
			//LEGACY CHANGE TO audio_play("sfx_footstep_gravel",xx,yy,0);
			//audio_play("sfx_footstep_gravel",xx,yy,0);
		
			exit;
		}
		else
		{
			
			//burned ground
			
		var map_id = global.Tilemap_Wall;
		var mx = tilemap_get_cell_x_at_pixel(map_id, x, y);
		var my = tilemap_get_cell_y_at_pixel(map_id, x, y);
		var data = tilemap_get(map_id, mx, my);
		var ind = tile_get_index(data);
		if ind != 0
		{
			audio_play(aud.foot_dirt,xx,yy,0);
			//audio_foot(a_dirt_dungeon,vol_low,vol_high,p_1,p_2);
		}
		else
		{
			//default grass
			audio_play(aud.foot_grass,xx,yy,0);
		}
			exit;
		}
	}

#endregion


#region//2 (Cloak)
	if room = r_ran_cloak
	{

		var lay_id = layer_get_id("UNDERWALL");
		var map_id = layer_tilemap_get_id(lay_id);
		var mx = tilemap_get_cell_x_at_pixel(map_id, x, y);
		var my = tilemap_get_cell_y_at_pixel(map_id, x, y);
		var data = tilemap_get(map_id, mx, my);
		var ind = tile_get_index(data);
		//ind 1 means that it's completly full
		if ind != 0
		{
			//we are on stone
		audio_play(aud.foot_sand,xx,yy,0);
			// GRAVEL HERE
			exit;
		}
		else
		{
			
			//burned ground
			
		var map_id = global.Tilemap_Wall;
		var mx = tilemap_get_cell_x_at_pixel(map_id, x, y);
		var my = tilemap_get_cell_y_at_pixel(map_id, x, y);
		var data = tilemap_get(map_id, mx, my);
		var ind = tile_get_index(data);
	
		if ind != 0{
			audio_play(aud.foot_dirt,xx,yy,0);
			//audio_foot(choose(a_dirt_dungeon),vol_low,vol_high,p_1,p_2);
				}else{
			//default grass
			audio_play(aud.foot_grass,xx,yy,0);
			}
			exit;
		}
	}
#endregion
#region//3 (Clouds)
	if room = r_ran_three
	{	
		audio_play(aud.foot_cloud,xx,yy,0);
	}
#endregion


}
