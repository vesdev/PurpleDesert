/// @description Insert description here

if alarm[0] = -1 { 
	wall_layer = layer_create(-300);
	wall_tilemap = layer_tilemap_create(wall_layer, 0, 0, til_dungeon_wall_32x32, room_width, room_height);
	alarm[1] = SEC*.2;//redraw dungeon
}