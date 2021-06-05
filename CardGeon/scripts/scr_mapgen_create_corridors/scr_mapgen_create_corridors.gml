function struct_mapgen_create_corridors(room_list, mask_grid) {

	var corridor_grid = ds_grid_create(ds_grid_width(mask_grid), ds_grid_height(mask_grid));
	// route corridors
	for(var this_room_index=0; this_room_index<ds_list_size(room_list); this_room_index++) {
		var this_room = ds_list_find_value(room_list, this_room_index);

		// link
		var this_links = (this_room.links);
		var other_room_index = -1;
		for(var j=0; j<ds_map_size(this_links); j++) {
			if(other_room_index == -1) {
				other_room_index = ds_map_find_first(this_links)	
			}
			else {
				other_room_index = ds_map_find_next(this_links, other_room_index);
			}
			if(other_room_index > this_room_index) {
				var other_room = ds_list_find_value(room_list, other_room_index);
				var other_links = (other_room.links);
					
				var this_door = ds_map_find_value(this_links, other_room_index);
				var other_door = ds_map_find_value(other_links, this_room_index);

				var this_xc = (this_door[? "x1"] + this_door[? "x2"])/2;
				var this_yc = (this_door[? "y1"] + this_door[? "y2"])/2;
				var other_xc = (other_door[? "x1"] + other_door[? "x2"])/2;
				var other_yc = (other_door[? "y1"] + other_door[? "y2"])/2;
				
				var result = scr_mapgen_pathfind(mask_grid, corridor_grid, this_xc, this_yc, other_xc, other_yc,this_room, other_room);
				
			}
		}
	}

	return corridor_grid;
}


function scr_mapgen_create_corridors(argument0, argument1) {
	var room_list = argument0;
	var mask_grid = argument1;

	var corridor_grid = ds_grid_create(ds_grid_width(mask_grid), ds_grid_height(mask_grid));
	// route corridors
	for(var this_room_index=0; this_room_index<ds_list_size(room_list); this_room_index++) {
		var this_room = ds_list_find_value(room_list, this_room_index);

		// link
		var this_links = ds_map_find_value(this_room, "links");
		var other_room_index = -1;
		for(var j=0; j<ds_map_size(this_links); j++) {
			if(other_room_index == -1) {
				other_room_index = ds_map_find_first(this_links)	
			}
			else {
				other_room_index = ds_map_find_next(this_links, other_room_index);
			}
			if(other_room_index > this_room_index) {
				var other_room = ds_list_find_value(room_list, other_room_index);
				var other_links = ds_map_find_value(other_room, "links");
					
				var this_door = ds_map_find_value(this_links, other_room_index);
				var other_door = ds_map_find_value(other_links, this_room_index);

				var this_xc = (this_door[? "x1"] + this_door[? "x2"])/2;
				var this_yc = (this_door[? "y1"] + this_door[? "y2"])/2;
				var other_xc = (other_door[? "x1"] + other_door[? "x2"])/2;
				var other_yc = (other_door[? "y1"] + other_door[? "y2"])/2;
				debug("pathfind ", this_room_index, " to ", other_room_index);
				var result = scr_mapgen_pathfind(mask_grid, corridor_grid, this_xc, this_yc, other_xc, other_yc);
				debug("result: ", result);

			}
		}
	}

	return corridor_grid;


}
