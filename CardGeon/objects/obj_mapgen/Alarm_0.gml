/// @description init grid

width = (room_width+320) div CELL_SIZE;
height = (room_height+320) div CELL_SIZE;

ds_grid_resize(grid, width, height);
ds_grid_resize(grid_burn, width, height);

o_game.depth = DEPTH_GAME;
depth = DEPTH_MAP;

wall_layer = layer_create(-300);
wall_tilemap = layer_tilemap_create(wall_layer, 0, 0, til_dungeon_wall_32x32, room_width, room_height);


burn_layer = layer_create(-100);
burn_tilemap = layer_tilemap_create(burn_layer, 0, 0, til_grass_burned_32x32, room_width, room_height);



ds_grid_clear(grid,1);

/*
for (var  yy = 1; yy < height-1; yy++) {
	for (var xx = 1; xx < width-1; xx++){
	//scr_update_tile(grid, xx, yy, wall_tilemap, 1);
	//scr_update_tile(grid, xx, yy, burn_tilemap, 1);	
		//	build_dungeon_tiles(grid, xx, yy, , WALL);	
		//build_dungeon_tiles_double(grid, xx, yy, underwall, WALL , tilemap);
		//if layer_exists(layer_get_id("WALL_EDGES")){
		//build_dungeon_tiles(grid, xx, yy, wall_edges,FLOOR, FLOOR);	
	}
}
*/
create(0,0,obj_lighting_controller);