///@description returns true if value at x/y is on the boundaries of the given grid id
///@param grid_id
///@param grid_x
///@param grid_y
function scr_on_grid(argument0, argument1, argument2) {

	var grid = argument0;
	var xx = argument1;
	var yy = argument2;
	var gw = ds_grid_width(grid);
	var gh = ds_grid_height(grid);

	if(xx >= 0 && xx < gw && yy >= 0 && yy < gh)
	{
	return 1;
	}

	return 0;


}
