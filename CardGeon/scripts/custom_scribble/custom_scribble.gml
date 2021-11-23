// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function scribble_add_colors(){

	//Duplicate GM's native colour constants in string form for access in scribble_draw()
var bright_yellow = make_color_rgb(253,210,97);
var dark_yellow = make_color_rgb(139,71,92);
	global.__scribble_colours[? "energy_yellow_bright"   ] = bright_yellow;
	global.__scribble_colours[? "energy_yellow_dark"  ]    = dark_yellow;


	global.__scribble_colours[? "c_aqua"   ] = C_AQUA;
	global.__scribble_colours[? "c_black"  ] = c_black;
	global.__scribble_colours[? "c_blue"   ] = C_BLUE;
	global.__scribble_colours[? "c_dkgray" ] = c_dkgray;
	global.__scribble_colours[? "c_dkgrey" ] = c_dkgray;
	global.__scribble_colours[? "c_fuchsia"] = C_FUCHISIA;
	global.__scribble_colours[? "c_gray"   ] = c_gray;
	global.__scribble_colours[? "c_green"  ] = c_green;
	global.__scribble_colours[? "c_grey"   ] = c_gray;
	global.__scribble_colours[? "c_lime"   ] = C_LIME;
	global.__scribble_colours[? "c_ltgray" ] = c_ltgray;
	global.__scribble_colours[? "c_ltgrey" ] = c_ltgray;
	global.__scribble_colours[? "c_maroon" ] = c_maroon;
	global.__scribble_colours[? "c_navy"   ] = C_NAVY;
	global.__scribble_colours[? "c_olive"  ] = c_olive;
	global.__scribble_colours[? "c_orange" ] = C_ORANGE;
	global.__scribble_colours[? "c_purple" ] = C_PURPLE;
	global.__scribble_colours[? "c_red"    ] = C_RED;
	global.__scribble_colours[? "c_lavender"] = C_LAVENDER;
	global.__scribble_colours[? "c_pink"] = C_PINK;


	global.__scribble_colours[? "c_silver" ] = c_silver;
	global.__scribble_colours[? "c_teal"   ] = c_teal;
	global.__scribble_colours[? "c_white"  ] = c_white;
	global.__scribble_colours[? "c_yellow" ] = C_YELLOW;
	global.__scribble_colours[? "c_gum"	   ] = C_GUM;
	global.__scribble_colours[? "c_wine"	] = C_WINE;
	
	global.__scribble_colours[? "c_dark"   ] = C_DARK;
}