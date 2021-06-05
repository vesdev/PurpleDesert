///@description Updates a 3x3 tile centered on xx,yy on a given grid
///@param grid_id
///@param grid_x
///@param grid_y
///@param Tilemap
///@param Value
function scr_update_tile(argument0, argument1, argument2, argument3, argument4) {

	var grid = argument0;
	var gx1 = argument1; //Center cell
	var gy1 = argument2;//Center cell
	var tm = argument3;//Tile Map
	var tv = argument4;//Target value to auto-tile

	var gx2;
	var gy2;

	var gv;//Current grid value

	var tile_index = 0;

	var xx, yy;

	for(yy=-1; yy<2; yy++)
	{
		for(xx=-1; xx<2; xx++)
		{
		gx2 = gx1+xx;
		gy2 = gy1+yy;
	
			if(scr_on_grid(grid, gx2, gy2))
			{
			gv = grid[# gx2, gy2];
		
				if(gv == tv)
				{
				tile_index = scr_auto_tile_value_47(grid, gx2, gy2, tv);
				tilemap_set_at_pixel(tm, tile_index, gx2*32, gy2*32);
				}
				else
				{
				tilemap_set_at_pixel(tm, 0, gx2*32, gy2*32);
				}
			}
		}
	}




}
