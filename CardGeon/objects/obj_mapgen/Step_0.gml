
start_dungeon_timer--;

if bottom_struct.enable = true { 
	if bottom_struct.timer <= 0 { 
		//format
		var list = bottom_struct.list;
		
		for (var i = 0; i <= ds_list_size(list); ++i){ 
			var index = list[| i];
			
			if is_array(index){ 
				var xx = index[0];
				var yy = index[1];
				//ar xx = index[@ 0];
				//var yy = index[@ 1];
				update_down_tile(xx,yy);
			}
			
		}
	
			update_down_tile_full_map();

		bottom_struct.enable = false;
		ds_list_clear(bottom_struct.list);
	}
	bottom_struct.timer--;
}


if o_game.game_state = e_gamestate.battle and o_game.peek_at_map = false || enable_event exit;


if alarm[1] != -1 { 	
	//draw corridors
	for(var i=0; i<ds_grid_width(corridor_grid); i++) {
		for(var j=0; j<ds_grid_height(corridor_grid); j++) {
			var struct = ds_grid_get(corridor_grid, i, j);
			if is_struct(struct) {
				draw_set_color(c_gray);
				draw_corridor(struct , i , j)
			}
		}
	}
}


