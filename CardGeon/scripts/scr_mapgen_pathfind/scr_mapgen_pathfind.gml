function wall(exists, fogofwar, hidden , room1, room2) constructor{ 
	
	self.exists			= exists;
	self.fogofwar		= fogofwar;
	self.hidden			= hidden;
	
	self.room1			= room1;
	self.room2			= room2;
	
	set_to_wall_grid = false;
}



function scr_mapgen_pathfind(argument0, argument1, argument2, argument3, argument4, argument5,this_room,other_room) {
// based on A* pathfinding by L0v3

	var mask_grid = argument0;
	var corridor_grid = argument1;
	var x1 = floor(argument2);
	var y1 = floor(argument3);
	var x2 = floor(argument4);
	var y2 = floor(argument5);

	var hcells = ds_grid_width(mask_grid);
	var vcells = ds_grid_height(mask_grid);

	//Check if target is within grid.
	if((x1 >= hcells or x1 < 0) or (y1 >= vcells or y1 < 0)) {
	    return false;
	}

	//Check if target is same as start.
	if(x1 == x2 and y1 == y2) {
	    return false;
	}

	//Check if target is in a closed cell.
	if(ds_grid_get(mask_grid, x2, y2) == -1) {
	    return false;
	}

	//Initialize Node Containers.
	var list_closed = ds_list_create();
	var list_open = ds_priority_create();

	//Creates initial node.
	var node_start = ds_list_create();
	var parent = noone;
	var cost = 0;
	var distance = floor((point_distance(x1, y1, x2, y2)) *10);
	var value = cost + distance;
	ds_list_add(node_start, x1, y1, parent, cost, distance, value);

	//Adds initial node to open list.
	ds_priority_add(list_open, node_start, value);

	//Loops until open list is empty.
	while(not ds_priority_empty(list_open)) {
	    //Finds lowest cost open node.
	    var node = ds_priority_delete_min(list_open);

	    //Setup local variables used in loop.
	    var xx, yy;
	    var angle = 0;

	    //Enters loop to create 8 succesors.
	    for(var i=0; i<4; i++) {
	        //Gets variables from node.
	        var nx = ds_list_find_value(node, 0);
	        var ny = ds_list_find_value(node, 1);
     
	        //Calculates Coordinates.
	        xx = floor(nx + lengthdir_x(1, angle));
	        yy = floor(ny + lengthdir_y(1, angle));
	        angle += 90;    
     
	        //Validates coordinates are within grid bounds.
	        if((xx >= hcells or xx < 0) or (yy >= vcells or yy < 0)) {
	            //Enters next loop.
	            continue;
	        }
     
	        //Creates succesor.
	        var succesor = ds_list_create();
	        parent = node;
	        cost = 10 + ds_grid_get(mask_grid, xx, yy);
	        distance = floor(point_distance(xx, yy, x2, y2) * 10);
	        value = cost + distance;
	        ds_list_add(succesor, xx, yy, parent, cost, distance, value);
     
	        //Check if succesor is in a closed cell.
	        if(ds_grid_get(mask_grid, xx, yy) == -1) {
	            //Destroy the succesor.
	            ds_list_destroy(succesor);
         
	            //Enters next loop.
	            continue;
	        }    
     
	        //Check if node is the goal.
	        if(xx == x2 and yy == y2) {          
	            //Creates path list.
	            var list_path = ds_list_create();
	            var node_path = succesor;
	            var parent = ds_list_find_value(node_path, 2);
	            ds_list_add(list_path, node_path);
         
	            //Traces parents back to initial node.
	            while(node_path != node_start) {
	                parent = ds_list_find_value(node_path, 2);
	                ds_list_add(list_path, parent);
	                node_path = parent;
	            }
         
	            //Creates the path from the path list.
	            for(var j=ds_list_size(list_path)-1; j>=0; j--) {
	                var node_point = ds_list_find_value(list_path, j);
	                var xx = ceil(ds_list_find_value(node_point, 0) - CORRIDOR/2);
	                var yy = ceil(ds_list_find_value(node_point, 1) - CORRIDOR/2);
					ds_grid_set_region(mask_grid, xx-1, yy-1, xx+CORRIDOR, yy+CORRIDOR, 100)
					ds_grid_set_region(corridor_grid, xx, yy, xx+CORRIDOR-1, yy+CORRIDOR-1, new wall(0, false, false, this_room, other_room)) //new wall(1, false, false)
	            }
         
	            //Clean-Up Leaks
	            ds_list_destroy(list_path);
	            ds_list_destroy(node);
	            ds_list_destroy(succesor);
         
	            //Loops through closed list.
	            for(var j = 0; j < ds_list_size(list_closed); j++) {
	                //Cleans up leaks.
	                var obj = ds_list_find_value(list_closed, j);
	                ds_list_destroy(obj);
	            }
         
	            // cleanup
	            var size = ds_priority_size(list_open);
	            for(var j=0; j<size; j++) {
	                var obj = ds_priority_delete_min(list_open);
	                ds_list_destroy(obj);
	            }
	            ds_list_destroy(list_closed);
	            ds_priority_destroy(list_open);
         
	            return true;
	        }
     
	        //Creates a copy of open list to sweep through.
	        var list_open_copy = ds_priority_create();
	        ds_priority_copy(list_open_copy, list_open);
	        var size = ds_priority_size(list_open_copy);
     
	        //Creates a continue check boolean, for nested loops.
	        var continue_check = false;
     
	        //Check if node with same position is in the open list.
	        for(var j=0; j<size; j++) {
	            //Gets values from current index.
	            var obj = ds_priority_delete_min(list_open_copy);
	            var obj_x = ds_list_find_value(obj, 0)
	            var obj_y = ds_list_find_value(obj, 1)
	            var obj_value = ds_list_find_value(obj, 5)
         
	            //Check if same posotion.
	            if(obj_x == xx and obj_y == yy) {
	                //Check if value of obj is lower then succesor.
	                if(obj_value < value) {
	                    ds_list_destroy(succesor);
                 
	                    //Updates continue check to skip loop.
	                    continue_check = true;
	                    break;
	                }
	                else {
	                    //Update object with succesor values.
	                    ds_list_replace(succesor, 2, ds_list_find_value(obj, 2));
	                    ds_list_replace(succesor, 3, ds_list_find_value(obj, 3));
	                    ds_list_replace(succesor, 4, ds_list_find_value(obj, 4));
	                    ds_list_replace(succesor, 5, ds_list_find_value(obj, 5));
                 
	                    ds_list_destroy(succesor);
                 
	                    //Updates continue check to skip loop.
	                    continue_check = true;
	                    break;
	                }
	            }
	        }
     
	        ds_priority_destroy(list_open_copy);
     
	        if(continue_check) {
	            continue;
	        }
     
	        //Check if node with same position is in the closed list.
	        for(var j=0; j<ds_list_size(list_closed); j++) {
	            //Gets values from current index.
	            var obj = ds_list_find_value(list_closed, j);
	            var obj_x = ds_list_find_value(obj, 0)
	            var obj_y = ds_list_find_value(obj, 1)
         
	            //Check if same posotion.
	            if(obj_x == xx and obj_y == yy) {
	                ds_list_destroy(succesor);
             
	                //Updates continue check to skip loop.
	                continue_check = true;
	                break;
	            }
	        }
     
	        if(continue_check){
	            continue;
	        }
		
	        ds_priority_add(list_open, succesor, value);
	    }

	    ds_list_add(list_closed, node);
	}

	// cleanup
	for(var j=0; j<ds_list_size(list_closed); j++) {
	    var obj = ds_list_find_value(list_closed, j);
	    ds_list_destroy(obj);
	}

	ds_list_destroy(list_closed);
	ds_priority_destroy(list_open);

	return false;


}
