function struct_mapgen_arrange_rooms(room_list) {
	// arrange rooms
	var collisions = 0;
	do {
		// reset collisions
		for(var i=0; i<ds_list_size(room_list); i++) {
			var this_room = ds_list_find_value(room_list, i);
			this_room.collision = false;
		}
		collisions = 0;
	
		// check collisions
		for(var i=0; i<ds_list_size(room_list); i++) {
			var room_a = ds_list_find_value(room_list, i);
	
			for(var j=i+1; j<ds_list_size(room_list); j++) {
				var room_b = ds_list_find_value(room_list, j);
				
				// check collision:
				if (room_a.x1-PADDING < room_b.x2+PADDING and room_a.x2+PADDING > room_b.x1-PADDING and room_a.y1-PADDING < room_b.y2+PADDING and room_a.y2+PADDING > room_b.y1-PADDING) {
					room_a.collision = true;
					room_b.collision = true;
					collisions += 1;
			
					// calculate shift direction
					var x_diff = (room_a.x1-PADDING)-(room_b.x2+PADDING);
					var x_diff2 = (room_a.x2+PADDING)-(room_b.x1-PADDING);
					if(abs(x_diff2) < abs(x_diff)) x_diff = x_diff2;
			
				    //var y_diff = min(room_a[? "y2"]-room_b[? "y1"]+PADDING, ;
					var y_diff = (room_a.y2+PADDING)-(room_b.y1-PADDING);
					var y_diff2 = (room_a.y1-PADDING)-(room_b.y2+PADDING);
					if(abs(y_diff2) < abs(y_diff)) y_diff = y_diff2;
			
				    // shift in the shortest directionn
				    if(abs(x_diff) <= abs(y_diff)) {
						var room_a_x_shift = -ceil(x_diff/2)
						var room_b_x_shift = x_diff - room_a_x_shift;
						room_a.x1 = room_a.x1 + sign(room_a_x_shift);
						room_a.x2 = room_a.x2 + sign(room_a_x_shift);
						room_b.x1 = room_b.x1 + sign(room_b_x_shift);
						room_b.x2 = room_b.x2 + sign(room_b_x_shift);
					}
				    else {
						var room_a_y_shift = -ceil(y_diff/2)
						var room_b_y_shift = y_diff - room_a_y_shift;
						room_a.y1 = room_a.y1 + sign(room_a_y_shift);
						room_a.y2 = room_a.y2 + sign(room_a_y_shift);
						room_b.y1 = room_b.y1 + sign(room_b_y_shift);
						room_b.y2 = room_b.y2 + sign(room_b_y_shift);
					}
				}
			}
		}
	
	} until(collisions ==0);
	
	// remove spacers and get bounds
	var min_x = 0;
	var min_y = 0;
	for(var i=ds_list_size(room_list)-1; i>=0; i--) {
		var this_room = ds_list_find_value(room_list, i);
		if(   this_room.spacer == true) {
			ds_list_delete(room_list, i);
		}
		else {
			if(this_room.x1 < min_x) min_x = this_room.x1;
			if(this_room.y1 < min_y) min_y = this_room.y1;
		}
	}

	// shift all the coordinates
	var max_x = 0;
	var max_y = 0;
	
	var farthest_room_index = 0;
	var farthest_room_amount = 0;
	
	for(var i=0; i<ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		this_room.x1 -= min_x - ceil(PADDING);
		this_room.x2 -= min_x - ceil(PADDING);
		this_room.y1 -= min_y - ceil(PADDING);
		this_room.y2 -= min_y - ceil(PADDING);
		
		
		
	
		if(this_room.x2 > max_x) max_x = this_room.x2;
		if(this_room.y2 > max_y) max_y = this_room.y2;
	
		//ds_map_add(this_room, "bgcolor", c_ltgray)	

		var first_room = ds_list_find_value(room_list, 0);
		var x1 = (first_room.x1+first_room.x2)/2;
		var y1 = (first_room.y1+first_room.y2)/2;
		var dis = point_distance( x1,y1, (this_room.x1+this_room.x2)/2,  (this_room.y1+this_room.y2)/2);

	//	show_debug_message("DIS "+string(dis)+" FARTHESET "+string(farthest_room_amount)+"INDEX "+string(i))
		if  dis > farthest_room_amount{ 
					farthest_room_amount = dis;
					farthest_room_index = i;
		}
	}
	var farthest_room = ds_list_find_value(room_list, farthest_room_index);
	farthest_room.type = e_room_type.boss_room;
	boss_room_index = farthest_room_index;
	

	max_x += ceil(PADDING);
	max_y += ceil(PADDING);


	//figure out the farthest room 
	
	// create room grid
	var mask_grid = ds_grid_create(max_x, max_y);
	for(var i=0; i<ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		ds_grid_set_region(mask_grid, this_room.x1-1, this_room.y1-1, this_room.x2, this_room.y2, 40);
		ds_grid_set_region(mask_grid, this_room.x1, this_room.y1, this_room.x2-1, this_room.y2-1, 100);
	}
	return mask_grid;
}






function scr_mapgen_arrange_rooms(argument0) {

	var room_list = argument0;

	// arrange rooms
	var collisions = 0;
	do {
		// reset collisions
		for(var i=0; i<ds_list_size(room_list); i++) {
			var this_room = ds_list_find_value(room_list, i);
			this_room[? "collision"] = false;
		}
		collisions = 0;
	
		// check collisions
		for(var i=0; i<ds_list_size(room_list); i++) {
			var room_a = ds_list_find_value(room_list, i);
	
			for(var j=i+1; j<ds_list_size(room_list); j++) {
				var room_b = ds_list_find_value(room_list, j);

				// check collision:
				if (room_a[? "x1"]-PADDING < room_b[? "x2"]+PADDING && room_a[? "x2"]+PADDING > room_b[? "x1"]-PADDING && room_a[? "y1"]-PADDING < room_b[? "y2"]+PADDING && room_a[? "y2"]+PADDING > room_b[? "y1"]-PADDING) {
					room_a[? "collision"] = true;
					room_b[? "collision"] = true;
					collisions += 1;
			
					// calculate shift direction
					var x_diff = (room_a[? "x1"]-PADDING)-(room_b[? "x2"]+PADDING);
					var x_diff2 = (room_a[? "x2"]+PADDING)-(room_b[? "x1"]-PADDING);
					if(abs(x_diff2) < abs(x_diff)) x_diff = x_diff2;
			
				    //var y_diff = min(room_a[? "y2"]-room_b[? "y1"]+PADDING, ;
					var y_diff = (room_a[? "y2"]+PADDING)-(room_b[? "y1"]-PADDING);
					var y_diff2 = (room_a[? "y1"]-PADDING)-(room_b[? "y2"]+PADDING);
					if(abs(y_diff2) < abs(y_diff)) y_diff = y_diff2;
			
				    // shift in the shortest directionn
				    if(abs(x_diff) <= abs(y_diff)) {
						var room_a_x_shift = -ceil(x_diff/2)
						var room_b_x_shift = x_diff - room_a_x_shift;
						room_a[? "x1"] = room_a[? "x1"] + sign(room_a_x_shift);
						room_a[? "x2"] = room_a[? "x2"] + sign(room_a_x_shift);
						room_b[? "x1"] = room_b[? "x1"] + sign(room_b_x_shift);
						room_b[? "x2"] = room_b[? "x2"] + sign(room_b_x_shift);
					}
				    else {
						var room_a_y_shift = -ceil(y_diff/2)
						var room_b_y_shift = y_diff - room_a_y_shift;
						room_a[? "y1"] = room_a[? "y1"] + sign(room_a_y_shift);
						room_a[? "y2"] = room_a[? "y2"] + sign(room_a_y_shift);
						room_b[? "y1"] = room_b[? "y1"] + sign(room_b_y_shift);
						room_b[? "y2"] = room_b[? "y2"] + sign(room_b_y_shift);
					}
				}
			}
		}
	
	} until(collisions ==0);





	// remove spacers and get bounds
	var min_x = 0;
	var min_y = 0;
	for(var i=ds_list_size(room_list)-1; i>=0; i--) {
		var this_room = ds_list_find_value(room_list, i);
		if(ds_map_find_value(this_room, "spacer") == true) {
			ds_list_delete(room_list, i);
		}
		else {
			if(this_room[? "x1"] < min_x) min_x = this_room[? "x1"];
			if(this_room[? "y1"] < min_y) min_y = this_room[? "y1"];
		}
	}

	// shift all the coordinates
	var max_x = 0;
	var max_y = 0;
	
	var farthest_room_index = 0;
	var farthest_room_amount = 0;
	
for(var i=0; i<ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		this_room[? "x1"] -= min_x - ceil(PADDING);
		this_room[? "x2"] -= min_x - ceil(PADDING);
		this_room[? "y1"] -= min_y - ceil(PADDING);
		this_room[? "y2"] -= min_y - ceil(PADDING);
	
		if(this_room[? "x2"] > max_x) max_x = this_room[? "x2"];
		if(this_room[? "y2"] > max_y) max_y = this_room[? "y2"];
		
		//ds_map_add(this_room, "bgcolor", c_ltgray)	

		var first_room = ds_list_find_value(room_list, 0);
		var x1 = (first_room[? "x1"]+first_room[? "x2"])/2;
		var y1 = (first_room[? "y1"]+first_room[? "y2"])/2;
		var dis = point_distance( x1,y1, (this_room[? "x1"]+this_room[? "x2"])/2,  (this_room[? "y1"]+this_room[? "y2"])/2);

		//show_debug_message("DIS "+string(dis)+" FARTHESET "+string(farthest_room_amount)+"INDEX "+string(i))
		if  dis > farthest_room_amount{ 
					farthest_room_amount = dis;
					farthest_room_index = i;
		}
	}
	var farthest_room = ds_list_find_value(room_list, farthest_room_index);
	farthest_room[? "bgcolor"] = c_red;
	boss_room_index = farthest_room_index;
	
	//ds_map_add(this_room, "bgcolor", c_lime)	

	max_x += ceil(PADDING);
	max_y += ceil(PADDING);
	
	//figure out the farthest room 
	// create room grid
	var mask_grid = ds_grid_create(max_x, max_y);
	for(var i=0; i<ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		ds_grid_set_region(mask_grid, this_room[? "x1"]-1, this_room[? "y1"]-1, this_room[? "x2"], this_room[? "y2"], 40);
		ds_grid_set_region(mask_grid, this_room[? "x1"], this_room[? "y1"], this_room[? "x2"]-1, this_room[? "y2"]-1, 100);
	}
	return mask_grid;
}