/// @description 

if next_room != noone { 
	room_goto(next_room);	
}


if next_game_state != noone{ 
	
	
	o_game.game_state = next_game_state;
	next_game_state = noone;
}

if (surface_exists(surf)) and persistent = false {
	surface_free(surf);
}