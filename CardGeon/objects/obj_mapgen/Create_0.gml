/// @description Insert description here
//show_debug_overlay(1);



synth_wave = {
	y_pos_surface : -50000,
	x_pos_surface : -50000,
	xtarget : 0,
	xscale_target : 0,
	yscale_target : 0,
	//initialis surfaces
	surf : surface_create(400, 380),
	clipping_mask : surface_create(380, 380),
	col : floor(random(16777216)),
	//ignore bm values - these were just for me messing with blend modes
	bm_1 : 0,
	bm_2 : 0,
	//number of sides the shape will have
	sides : irandom_range(4, 8),
	//for opening/closing the portal
	active : false,
	//scaling the surface
	xscale : 0,
	yscale : 0,
	xscale_target : 0,
	yscale_target : 0
	
}



uResolution = shader_get_uniform(sh_fog_heavy,"uResolution");
uTime = shader_get_uniform(sh_fog_heavy,"uTime");
uOpacity = shader_get_uniform(sh_fog_heavy,"uOpacity");
cloudscale = shader_get_uniform(sh_fog_heavy,"cloudscale");

curtain_xoffset = -300;
curtain_yoffset = 0;

next_game_state_queue = noone;

bottom_struct ={ 
	
	enable : false,
	timer : -1,
	list : ds_list_create(),
	
	
}



center_camera_on_player = SEC*.2;

curtain_time = SEC*1;
curtain_timer = curtain_time*2;

curtain_time_up = SEC*.5;
curtain_timer_up = curtain_time_up*5; 

alarm[0] = 1;

start_dungeon_timer = SEC*.2;
boon_randomize();
//random_set_seed(1682793500);
//randomize();
debug("SEED "+string(random_get_seed()));

alarm[1] = 2;

#macro NUMROOMS 62  // number of rooms
#macro PADDING 2	// padding between rooms (distance between each room)
#macro UNIT 12		// map display size 8 16 32
#macro CORRIDOR 1	// corridor width

#macro CELL_SIZE 32	
#macro MAX_REST_SITES 2
#macro MAX_SMALL_CHESTS 1

wall_tilemap = layer_tilemap_get_id(layer_get_id("WALL"));
shadow_tilemap = layer_tilemap_get_id(layer_get_id("ROCK_SHADOWS"));

#macro WALL 1
#macro FLOOR 0

globalvar room_xoffset , room_yoffset; //moves the whole dungeon to the center
room_xoffset = 0;
room_yoffset = 0;
battle_transition_timer = -1;
go_to_battle = false;				
enum e_door_type {  //not done yet
	locked,
	open,
	size_
}


#region finders //variables used to determine where to put each rom

/*
How the generator determines each room in this order:
Room index = 0 : starting room
Boss room, farthest room distance from room 0. BUT if it's connected to a room with one door entrance.
Then that room becomes the boss room.
Key room, closest single door room close to the boss area.
Chest Room, farthest room with single door to key room.
Rest Area/Pizza Room. 2nd Closest single door room to the boss Room. 
Shop Area. 3rd Closest single door room to the boss Room. 
All other single door rooms if there are any become secret rooms.
*/


enum e_event_type {
	small_treasure,
	key,
	golden_treasure,
	rest_area,
	token_upgrade_shop,
	shop_card,
	shop_removal,
	shop_token,
	shop_potion,
	shop_stuff,
	
	blackjack,
}
browsing_card_shop = false;


noti_timer = 0;
noti_time = SEC;
	
standing_on = { 
	type : noone,
	x : 0,
	y : 0,
	x1 : 0,
	y1 : 0,
	w  : 0,
	h  : 0,
	i  : 0,
	room_struct : noone,
}

old_zoom = 1;
event_easing_timer = 0;
event_easing_time = SEC;


enable_event = false;
event_struct = noone;

found_elite_while_loop = false;
boss_room_reposition = false;

boss_room_index = -1;
closest_distance_from_boss_to_key_room = -1;
key_room_index = -1; //closest to the boss room with 1 link

farthest_distance_from_key_room_to_chest_room = -1;
locked_room_index = -1; // farthest from the key index 

grid = ds_grid_create(1,1);
grid_burn = ds_grid_create(1,1);

created_shop_flag = false;
not_enough_money_for_card_remove_timer = 0;

elite_placement_dis = -1;
elite_placement_index = -1;
selecting_card_upgrade = false;
closest_distance_from_boss_rest_area = -1;
rest_area_index = -1; //closest to the boss room with 1 link	
	
closest_distance_from_boss_shop = -1;
shop_area_index = -1; //closest to the boss room with 1 link

card_shop_struct = new overworld_shop_cards();
on_sale_card_index = irandom(player.card_shop_options)

player_room_index = 0;

subtract_amount_for_while_loop = 0;
#endregion

draw_playerx = noone;
draw_playery = noone;
playerx = 0;
playery = 0;
room_wmargin = 640; //makes sure the player never sees the edge of the room
room_hmargin = 640;//to make it more mysterious
room_notification = noone;

//generate rooms
room_list = ds_list_create();
struct_mapgen_create_rooms(room_list, NUMROOMS, (NUMROOMS)/2);
mask_grid = struct_mapgen_arrange_rooms(room_list);
struct_mapgen_connect_rooms(room_list);
struct_mapgen_create_doors(room_list);
corridor_grid = struct_mapgen_create_corridors(room_list, mask_grid);
init_rooms();
dungeon_set_width_and_height();