// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function destroy_tile_single(xarg, yarg) {

	//Update floor
	var Tile_Grid = obj_mapgen.grid;
	var wall_tiles = obj_mapgen.wall_tilemap;
	var wall_ground = obj_mapgen.shadow_tilemap;
	
	
	var xx = xarg div CELL_SIZE;
	var yy = yarg div CELL_SIZE; 

	xx = clamp(xx, 0, ds_grid_width(Tile_Grid)-1);
	yy = clamp(yy, 0, ds_grid_height(Tile_Grid)-1);

	var dont_execute = true;

	var play_aud = false;
	if instance_exists(o_player) and o_player.finish = true {

	 if object_get_parent(object_index) = o_bomb or object_index = o_antlion{
		play_aud = true; 
	 }

		//only build dirt when our player has landed and stuff
		var spd = 2;

		if Tile_Grid[# xx,yy] == WALL{
		dont_execute = false;
		//create_animation_effect(s_wall_explosion,CELL_SIZE*(xx),CELL_SIZE*(yy),spd,false);
	
	//	var amount = random_range(35,45);
		//	create_debri(CELL_SIZE*(xx),CELL_SIZE*(yy),amount);
		}
	
	/*
	if dont_execute = false {
	
		with o_lighting_controller{
			event_user(0);
		}
		var a = "sfx_rock_break_low";
		if object_is_ancestor(object_index,o_bomb){ 
			var a = "sfx_rock_break"
			audio_play(a,argument0,argument1,0);
		}else if o_game.bomb_timer_sound  <= 0{
			o_game.bomb_timer_sound = SEC*.15;
			audio_play(a,argument0,argument1,0);
		}
	}
	*/
	Tile_Grid[# xx, yy] = FLOOR;
	//update the art firstwd
#region //SHADOW UPDATE


	
	var GET_REKT = tilemap_get_at_pixel(wall_ground,(CELL_SIZE*(xx)),(CELL_SIZE*yy+1));


	tile_set_empty(GET_REKT);
	//get REKT shadow mwahhahahahaha
	
	//deletes the tile
	tilemap_set_at_pixel(wall_ground,0,(CELL_SIZE*(xx)),(CELL_SIZE*(yy+1)));		
	
	var a = 1;
		//there is a wall UP TOP
		if Tile_Grid[# xx,yy-1] = WALL{
		
			var tile_type = 1;
	
			//there is a wall on the left and right
			if Tile_Grid[# xx-1,yy] = WALL and Tile_Grid[# xx+1,yy] = WALL{
				tile_type = 4;
			}
			
			
			//left only
			if Tile_Grid[# xx-1,yy] = WALL and Tile_Grid[# xx+1,yy] != WALL{
				tile_type = 3;
			}
			//right only
			if Tile_Grid[# xx-1,yy] != WALL and Tile_Grid[# xx+1,yy] = WALL{
				tile_type = 2;
				}
			tilemap_set_at_pixel(wall_ground,tile_type,(CELL_SIZE*(xx)),(CELL_SIZE*(yy)));		
		}
		
		///////UPDATE THE TOP MOST TILE
		
		var temp_y = yy-1;
		var temp_x = xx;
		
		if Tile_Grid[# temp_x,temp_y] = WALL{
		
		var tile_type = 1;
	
		//there is a wall on the left and right
		if Tile_Grid[# temp_x-1,temp_y] = WALL and Tile_Grid[# temp_x+1,temp_y] = WALL{
			tile_type = 4;
		}
			
			
		//left only
		if Tile_Grid[# temp_x-1,temp_y] = WALL and Tile_Grid[# temp_x+1,temp_y] != WALL{
			tile_type = 3;
		}
		//right only
		if Tile_Grid[# temp_x-1,temp_y] != WALL and Tile_Grid[# temp_x+1,temp_y] = WALL{
			tile_type = 2;
		}
			tilemap_set_at_pixel(wall_ground,tile_type,(CELL_SIZE*(temp_x)),(CELL_SIZE*(temp_y+1)));		
		}
		
		
		///////UPDATE THE BOTTOM TILES
		
	//	update_shadow(xx+1,yy+1);
	//	update_shadow(xx-1,yy+1);
	//	update_shadow(xx-1,yy);
	//	update_shadow(xx+1,yy);
		
	
#endregion
	build_dungeon_tiles(Tile_Grid, xx, yy, wall_tiles, WALL);
	}

}