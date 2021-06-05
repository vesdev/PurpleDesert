function struct_mapgen_create_doors(room_list) {

	for(var this_room_index=0; this_room_index<ds_list_size(room_list); this_room_index++) {
		var this_room = ds_list_find_value(room_list, this_room_index);

		// link
		var this_links = this_room.links;
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
					
				var x_overlap = min(this_room.x2, other_room.x2) - max(this_room.x1, other_room.x1);
				var y_overlap = min(this_room.y2, other_room.y2) - max(this_room.y1, other_room.y1);

				var this_door = ds_map_find_value(this_links, other_room_index);
				var other_door = ds_map_find_value(other_links, this_room_index);
				var this_x1;
				var this_y1;
				var this_x2;
				var this_y2;
				var other_x1;
				var other_y1;
				var other_x2;
				var other_y2;
				if(x_overlap < CORRIDOR and y_overlap >= CORRIDOR) { // need x connector
					var width = -x_overlap;
					var height = CORRIDOR;
					this_y1 = max(this_room.y1, other_room.y1) + ceil((y_overlap - CORRIDOR)/2);
					this_y2 = this_y1+height;
					other_y1 = this_y1;
					other_y2 = this_y2;
						
					if(this_room.x2 < other_room.x2) {
						this_x1 = this_room.x2;
						other_x1 = other_room.x1-1;
					}
					else {
						this_x1 = this_room.x1-1;
						other_x1 = other_room.x2;
					}
					this_x2 = this_x1 + 1;
					other_x2 = other_x1 + 1;
				}
				else if(y_overlap < CORRIDOR and x_overlap >= CORRIDOR) { // need y connector
					var width = CORRIDOR
					var height = -y_overlap;
	
					this_x1 = max(this_room.x1, other_room.x1) + ceil((x_overlap - CORRIDOR)/2);
					this_x2 = this_x1+width;
					other_x1 = this_x1;
					other_x2 = this_x2;
						
					if(this_room.y2 < other_room.y2) {
						this_y1 = this_room.y2;
						other_y1 = other_room.y1-1;
					}
					else {
						this_y1 = this_room.y1-1;
						other_y1 = other_room.y2;	
					}
					this_y2 = this_y1 + 1;
					other_y2 = other_y1 + 1;
				}
				else { // L-connector
					// find closest pair
					var this_x1_try;
					var this_y1_try;
					var this_x2_try;
					var this_y2_try;
					var other_x1_try;
					var other_y1_try;
					var other_x2_try;
					var other_y2_try;
					var best_dist = undefined;
						
					for(var u=0; u<3; u++) {
						switch(u) { // select this_room center coords
							case 0:
								this_x1_try = this_room.x1-1;
								this_y1_try = floor((this_room.y1 + this_room.y2 - CORRIDOR)/2);
								this_x2_try = this_x1_try + 1;
								this_y2_try = this_y1_try + CORRIDOR;
								break;
							case 1:
								this_x1_try = this_room.x2;
								this_y1_try = floor((this_room.y1 + this_room.y2 - CORRIDOR)/2)
								this_x2_try = this_x1_try + 1;
								this_y2_try = this_y1_try + CORRIDOR;
								break;
							case 2:
								this_x1_try = floor((this_room.x1 + this_room.x2 - CORRIDOR)/2)
								this_y1_try = this_room.y1-1
								this_x2_try = this_x1_try + CORRIDOR;
								this_y2_try = this_y1_try + 1;
								break;
							case 3:
								this_x1_try = floor((this_room.x1 + this_room.x2 - CORRIDOR)/2)
								this_y1_try = this_room.y2;
								this_x2_try = this_x1_try + CORRIDOR;
								this_y2_try = this_y1_try + 1;
								break;
						}
						for(var v=0; v<3; v++) {
							switch(v) { // select other_room center coords
								case 0:
									other_x1_try = other_room.x1-1;
									other_y1_try = floor((other_room.y1 + other_room.y2 - CORRIDOR)/2);
									other_x2_try = other_x1_try + 1;
									other_y2_try = other_y1_try + CORRIDOR;
									break;
								case 1:
									other_x1_try = other_room.x2;
									other_y1_try = floor((other_room.y1 + other_room.y2 - CORRIDOR)/2)
									other_x2_try = other_x1_try + 1;
									other_y2_try = other_y1_try + CORRIDOR;
									break;
								case 2:
									other_x1_try = floor((other_room.x1 + other_room.x2 - CORRIDOR)/2)
									other_y1_try = other_room.y1-1
									other_x2_try = other_x1_try + CORRIDOR;
									other_y2_try = other_y1_try + 1;
									break;
								case 3:
									other_x1_try = floor((other_room.x1 + other_room.x2 - CORRIDOR)/2)
									other_y1_try = other_room.y2;
									other_x2_try = other_x1_try + CORRIDOR;
									other_y2_try = other_y1_try + 1;
									break;
							}
							var dist = point_distance((this_x1_try+this_x2_try)/2, (this_y1_try+this_x2_try)/2, (other_x1_try+other_x2_try)/2, (other_y1_try+other_x2_try)/2);
							if(is_undefined(best_dist) or (dist == best_dist and choose(0, 1)) or dist < best_dist) {
								this_x1 = this_x1_try;
								this_y1 = this_y1_try;
								this_x2 = this_x2_try;
								this_y2 = this_y2_try;
								other_x1 = other_x1_try;
								other_y1 = other_y1_try;
								other_x2 = other_x2_try;
								other_y2 = other_y2_try;
								best_dist = dist;
							}
						}
					}
				}
				ds_map_add(this_door, "x1", this_x1);
				ds_map_add(this_door, "x2", this_x2);
				ds_map_add(this_door, "y1", this_y1);
				ds_map_add(this_door, "y2", this_y2);
				ds_map_add(other_door, "x1", other_x1);
				ds_map_add(other_door, "x2", other_x2);
				ds_map_add(other_door, "y1", other_y1);
				ds_map_add(other_door, "y2", other_y2);
			}
		}
	}
}

function scr_mapgen_create_doors(argument0) {
	var room_list = argument0;

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
					
				var x_overlap = min(this_room[? "x2"], other_room[? "x2"]) - max(this_room[? "x1"], other_room[? "x1"]);
				var y_overlap = min(this_room[? "y2"], other_room[? "y2"]) - max(this_room[? "y1"], other_room[? "y1"]);

				var this_door = ds_map_find_value(this_links, other_room_index);
				var other_door = ds_map_find_value(other_links, this_room_index);
				    
				var this_x1;
				var this_y1;
				var this_x2;
				var this_y2;
				var other_x1;
				var other_y1;
				var other_x2;
				var other_y2;
						
				if(x_overlap < CORRIDOR and y_overlap >= CORRIDOR) { // need x connector
					var width = -x_overlap;
					var height = CORRIDOR;
						
					this_y1 = max(this_room[? "y1"], other_room[? "y1"]) + ceil((y_overlap - CORRIDOR)/2);
					this_y2 = this_y1+height;
					other_y1 = this_y1;
					other_y2 = this_y2;
						
					if(this_room[? "x2"] < other_room[? "x2"]) {
						this_x1 = this_room[? "x2"];
						other_x1 = other_room[? "x1"]-1;
					}
					else {
						this_x1 = this_room[? "x1"]-1;
						other_x1 = other_room[? "x2"];
					}
					this_x2 = this_x1 + 1;
					other_x2 = other_x1 + 1;
				}
				else if(y_overlap < CORRIDOR and x_overlap >= CORRIDOR) { // need y connector
					var width = CORRIDOR
					var height = -y_overlap;
	
					this_x1 = max(this_room[? "x1"], other_room[? "x1"]) + ceil((x_overlap - CORRIDOR)/2);
					this_x2 = this_x1+width;
					other_x1 = this_x1;
					other_x2 = this_x2;
						
					if(this_room[? "y2"] < other_room[? "y2"]) {
						this_y1 = this_room[? "y2"];
						other_y1 = other_room[? "y1"]-1;
					}
					else {
						this_y1 = this_room[? "y1"]-1;
						other_y1 = other_room[? "y2"];	
					}
					this_y2 = this_y1 + 1;
					other_y2 = other_y1 + 1;
				}
				else { // L-connector
					// find closest pair
					var this_x1_try;
					var this_y1_try;
					var this_x2_try;
					var this_y2_try;
					var other_x1_try;
					var other_y1_try;
					var other_x2_try;
					var other_y2_try;
					var best_dist = undefined;
						
					for(var u=0; u<3; u++) {
						switch(u) { // select this_room center coords
							case 0:
								this_x1_try = this_room[? "x1"]-1;
								this_y1_try = floor((this_room[? "y1"] + this_room[? "y2"] - CORRIDOR)/2);
								this_x2_try = this_x1_try + 1;
								this_y2_try = this_y1_try + CORRIDOR;
								break;
							case 1:
								this_x1_try = this_room[? "x2"];
								this_y1_try = floor((this_room[? "y1"] + this_room[? "y2"] - CORRIDOR)/2)
								this_x2_try = this_x1_try + 1;
								this_y2_try = this_y1_try + CORRIDOR;
								break;
							case 2:
								this_x1_try = floor((this_room[? "x1"] + this_room[? "x2"] - CORRIDOR)/2)
								this_y1_try = this_room[? "y1"]-1
								this_x2_try = this_x1_try + CORRIDOR;
								this_y2_try = this_y1_try + 1;
								break;
							case 3:
								this_x1_try = floor((this_room[? "x1"] + this_room[? "x2"] - CORRIDOR)/2)
								this_y1_try = this_room[? "y2"];
								this_x2_try = this_x1_try + CORRIDOR;
								this_y2_try = this_y1_try + 1;
								break;
						}
						for(var v=0; v<3; v++) {
							switch(v) { // select other_room center coords
								case 0:
									other_x1_try = other_room[? "x1"]-1;
									other_y1_try = floor((other_room[? "y1"] + other_room[? "y2"] - CORRIDOR)/2);
									other_x2_try = other_x1_try + 1;
									other_y2_try = other_y1_try + CORRIDOR;
									break;
								case 1:
									other_x1_try = other_room[? "x2"];
									other_y1_try = floor((other_room[? "y1"] + other_room[? "y2"] - CORRIDOR)/2)
									other_x2_try = other_x1_try + 1;
									other_y2_try = other_y1_try + CORRIDOR;
									break;
								case 2:
									other_x1_try = floor((other_room[? "x1"] + other_room[? "x2"] - CORRIDOR)/2)
									other_y1_try = other_room[? "y1"]-1
									other_x2_try = other_x1_try + CORRIDOR;
									other_y2_try = other_y1_try + 1;
									break;
								case 3:
									other_x1_try = floor((other_room[? "x1"] + other_room[? "x2"] - CORRIDOR)/2)
									other_y1_try = other_room[? "y2"];
									other_x2_try = other_x1_try + CORRIDOR;
									other_y2_try = other_y1_try + 1;
									break;
							}
								
							var dist = point_distance((this_x1_try+this_x2_try)/2, (this_y1_try+this_x2_try)/2, (other_x1_try+other_x2_try)/2, (other_y1_try+other_x2_try)/2);
							if(is_undefined(best_dist) or (dist == best_dist and choose(0, 1)) or dist < best_dist) {
								this_x1 = this_x1_try;
								this_y1 = this_y1_try;
								this_x2 = this_x2_try;
								this_y2 = this_y2_try;
								other_x1 = other_x1_try;
								other_y1 = other_y1_try;
								other_x2 = other_x2_try;
								other_y2 = other_y2_try;
								best_dist = dist;
							}
						}
					}
				}
					
				ds_map_add(this_door, "x1", this_x1);
				ds_map_add(this_door, "x2", this_x2);
				ds_map_add(this_door, "y1", this_y1);
				ds_map_add(this_door, "y2", this_y2);
				ds_map_add(other_door, "x1", other_x1);
				ds_map_add(other_door, "x2", other_x2);
				ds_map_add(other_door, "y1", other_y1);
				ds_map_add(other_door, "y2", other_y2);
			}
		}
	}


}
