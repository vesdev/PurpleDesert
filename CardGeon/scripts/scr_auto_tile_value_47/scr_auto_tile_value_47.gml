///@descrition Returns the tile index of a value on a grid
///@param Grid_id
///@param Grid_x X axis on grid
///@param Grid_y Y axis on grid
///@param Value The value to tile
function scr_auto_tile_value_47(argument0, argument1, argument2, argument3) {

	var grid = argument0;
	var xx = argument1;
	var yy = argument2;
	var val = argument3;
	var gw = ds_grid_width(grid);
	var gh = ds_grid_height(grid);

	var tile = 0;
	var bit = 0;

	//Basically, below checks to see all cells around targeted cell.
	//Looking first if it's not 'out of bounds' then see if value matches for auto-wall.
	if(scr_on_grid(grid, xx-1, yy-1) && grid[# xx-1, yy-1] == val)//up_left
	{
		if(scr_on_grid(grid, xx-1, yy) && grid[# xx-1, yy] == val && scr_on_grid(grid, xx, yy-1) && grid[# xx, yy-1] == val)
		{
		bit = bit | 1;
		}
	}
	if(scr_on_grid(grid, xx, yy-1) && grid[# xx, yy-1] == val)//up
	{
	bit = bit | 2;
	}
	if(scr_on_grid(grid, xx+1, yy-1) && grid[# xx+1, yy-1] == val)//up_right
	{
		if(scr_on_grid(grid, xx+1, yy) && grid[# xx+1, yy] == val && scr_on_grid(grid, xx, yy-1) && grid[# xx, yy-1] == val)
		{
		bit = bit | 4;
		}
	}
	if(scr_on_grid(grid, xx-1, yy) && grid[# xx-1, yy] == val)//left
	{
	bit = bit | 8;
	}
	if(scr_on_grid(grid, xx+1, yy) && grid[# xx+1, yy] == val)//right
	{
	bit = bit | 16;
	}
	if(scr_on_grid(grid, xx-1, yy+1) && grid[# xx-1, yy+1] == val)//down_left
	{
		if(scr_on_grid(grid, xx-1, yy) && grid[# xx-1, yy] == val && scr_on_grid(grid, xx, yy+1) && grid[# xx, yy+1] == val)
		{
		bit = bit | 32;
		}
	}
	if(scr_on_grid(grid, xx, yy+1) && grid[# xx, yy+1] == val)//down
	{
	bit = bit | 64;
	}
	if(scr_on_grid(grid, xx+1, yy+1) && grid[# xx+1, yy+1] == val)//down_right
	{
		if(scr_on_grid(grid, xx+1, yy) && grid[# xx+1, yy] == val && scr_on_grid(grid, xx, yy+1) && grid[# xx, yy+1] == val)
		{
		bit = bit | 128;
		}
	}

	var hx = gw-1;
	var hy = gh-1;

	if(xx == 0)
	{
	bit = bit | 8;

		if(yy == 0)
		{
		bit = bit | 1;
		bit = bit | 2;
		
			if(grid[# xx, yy+1] == val)
			{
			bit = bit | 32;
			}
			if(grid[# xx+1, yy])
			{
			bit = bit | 4;
			}
		}
		else if(yy == hy)
		{
		bit = bit | 32;
		bit = bit | 64;
	
			if(grid[# xx, yy-1] == val)
			{
			bit = bit | 1;
			}
			if(grid[# xx+1, yy])
			{
			bit = bit | 128;
			}
		}
		else
		{
			if(grid[# xx, yy-1] == val)
			{
			bit = bit | 1;
			}
			if(grid[# xx, yy+1])
			{
			bit = bit | 32;
			}
		}
	}
	else if(xx == hx)
	{
	bit = bit | 16;

		if(yy == 0)
		{
		bit = bit | 2;
		bit = bit | 4;
	
			if(grid[# xx-1, yy] == val)
			{
			bit = bit | 1;
			}
			if(grid[# xx, yy+1])
			{
			bit = bit | 128;
			}
		}
		else if(yy == hy)
		{
		bit = bit | 64;
		bit = bit | 128;
	
			if(grid[# xx-1, yy] == val)
			{
			bit = bit | 32;
			}
			if(grid[# xx, yy-1])
			{
			bit = bit | 4;
			}
		}
		else
		{
			if(grid[# xx, yy-1] == val)
			{
			bit = bit | 4;
			}
			if(grid[# xx, yy+1])
			{
			bit = bit | 128;
			}
		}
	}
	else
	{
		if(yy == 0)
		{
		bit = bit | 2;
	
			if(grid[# xx-1, yy] == val)
			{
			bit = bit | 1;
			}
			if(grid[# xx+1, yy])
			{
			bit = bit | 4;
			}
		}
		else if(yy == hy)
		{
		bit = bit | 64;
	
			if(grid[# xx-1, yy] == val)
			{
			bit = bit | 32;
			}
			if(grid[# xx+1, yy])
			{
			bit = bit | 128;
			}
		}
	}

	switch(bit)
	{
	case 0: tile = 46; break;
	case 2: tile = 44; break;
	case 8: tile = 45; break;
	case 10: tile = 39; break;
	case 11: tile = 38; break;
	case 16: tile = 43; break;
	case 18: tile = 41; break;
	case 22: tile = 40; break;
	case 24: tile = 33; break;
	case 26: tile = 31; break;
	case 27: tile = 30; break;
	case 30: tile = 29; break;
	case 31: tile = 28; break;
	case 64: tile = 42; break;
	case 66: tile = 32; break;
	case 72: tile = 37; break;
	case 74: tile = 27; break;
	case 75: tile = 25; break;
	case 80: tile = 35; break;
	case 82: tile = 19; break;
	case 86: tile = 18; break;
	case 88: tile = 23; break;
	case 90: tile = 15; break;
	case 91: tile = 14; break;
	case 94: tile = 13; break;
	case 95: tile = 12; break;
	case 104: tile = 36; break;
	case 106: tile = 26; break;
	case 107: tile = 24; break;
	case 120: tile = 21; break;
	case 122: tile = 7; break;
	case 123: tile = 6; break;
	case 126: tile = 5; break;
	case 127: tile = 4; break;
	case 208: tile = 34; break;
	case 210: tile = 17; break;
	case 214: tile = 16; break;
	case 216: tile = 22; break;
	case 218: tile = 11; break;
	case 219: tile = 10; break;
	case 222: tile = 9; break;
	case 223: tile = 8; break;
	case 248: tile = 20; break;
	case 250: tile = 3; break;
	case 251: tile = 2; break;
	case 254: tile = 1; break;
	case 255: tile = 47; break;
	default: tile = 0; break;//That means no tile
	}

	return tile;


}
