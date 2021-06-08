
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


