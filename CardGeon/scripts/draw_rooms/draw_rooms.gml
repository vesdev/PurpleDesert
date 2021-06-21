// Script assets have changed for v2.3.0 see



function update_down_tile_full_map(){ 
if live_call() return live_result;



var left = (o_game.camera.x-o_game.camera.width/2) div 32;
var top = (o_game.camera.y-o_game.camera.height/2) div 32;

var width =  o_game.camera.width div 32;
var height = o_game.camera.height div 32;

var offset = 2;
var col = C_DARK;
var time = current_time*0.005;
var time_add = SEC*.3;
var intensity = 2;
var size = 32;

var tmiddle = 6;
var ttleft = 5;
var ttright = 4;

var tile_right = 3;
var tile_left = 2;

var tile_single = 1;


var total_width =  left+width;
var total_height = top+height;

	total_width = clamp(total_width, 0, ds_grid_width(obj_mapgen.grid)-1);
	total_height = clamp(total_height, 0, ds_grid_height(obj_mapgen.grid)-1);
	


//draw_rectangle(left*32,top*32,(left+width)*32,(top+height)*32,1);
for (var xx = left; xx <= total_width; xx++){ 
	for (var yy = top; yy <=total_height; yy++){ 
var tile = tmiddle;


		xx = clamp(xx, 0, ds_grid_width(obj_mapgen.grid)-1);
		yy = clamp(yy, 0, ds_grid_height(obj_mapgen.grid)-1);
		
	
		//
			var xx_div = xx;
			var yy_div = yy+1;
			
			
			//|_| and behind
			

			
		if obj_mapgen.grid[# xx,yy] == FLOOR and obj_mapgen.grid[# xx_div,yy_div] == WALL{
	
			var x_output = xx_div	 * 32;
			var y_output = (yy_div)  * 32;
	
		
		

			// |_
			if obj_mapgen.grid[# xx-1,yy] == WALL and obj_mapgen.grid[# xx+1,yy] == FLOOR {
				tile = tile_left;
			}
				if obj_mapgen.grid[# xx+1,yy] == WALL and obj_mapgen.grid[# xx-1,yy] == FLOOR {
				tile = tile_right;
			}
			
			
			
			//single down |_|
			if obj_mapgen.grid[# xx-1,yy] == WALL and obj_mapgen.grid[# xx+1,yy] == WALL {
				tile = tile_single;
			}
			tilemap_set_at_pixel(obj_mapgen.bottom_tilemap,tile,x_output,y_output);		
			//draw_sprite_ext(s_white_square_round,0,x_output,y_output,1,1,0,c_white,1);
		
		}
		
			if obj_mapgen.grid[# xx,yy] == FLOOR and
				obj_mapgen.grid[# xx,yy-1] == FLOOR and			
												
			   obj_mapgen.grid[# xx+1,yy] == WALL and 
			   obj_mapgen.grid[# xx-1,yy] == WALL 
			   
			   {
				
				tilemap_set_at_pixel(bottom_tilemap,tmiddle,xx*32,yy*32);		
			
			}
		
	}
}

	
	
}


function update_down_tile(xx ,yy){ 
var tmiddle = 6;
var ttleft = 5;
var ttright = 4;

var tile_right = 3;
var tile_left = 2;

var tile_single = 1;

var tile = tmiddle;

		xx = clamp(xx, 0, ds_grid_width(obj_mapgen.grid)-1);
		yy = clamp(yy, 0, ds_grid_height(obj_mapgen.grid)-1);
		//
			var xx_div = xx;
			var yy_div = yy+1;
			
			//|_| and behind

		
		if obj_mapgen.grid[# xx,yy] == FLOOR and obj_mapgen.grid[# xx_div,yy_div] == WALL{
		
		
			var x_output = xx_div	 * 32;
			var y_output = (yy_div)  * 32;
			// |_
			if obj_mapgen.grid[# xx-1,yy] == WALL and obj_mapgen.grid[# xx+1,yy] == FLOOR {
				tile = tile_left;
			}
			if obj_mapgen.grid[# xx+1,yy] == WALL and obj_mapgen.grid[# xx-1,yy] == FLOOR {
				tile = tile_right;
			}
			//single down |_|
			if obj_mapgen.grid[# xx-1,yy] == WALL and obj_mapgen.grid[# xx+1,yy] == WALL {
				tile = tile_single;
			}
			tilemap_set_at_pixel(obj_mapgen.bottom_tilemap,tile,x_output,y_output);		
			//draw_sprite_ext(s_white_square_round,0,x_output,y_output,1,1,0,c_white,1);
		
		}
		
			if obj_mapgen.grid[# xx,yy] == FLOOR and
				obj_mapgen.grid[# xx,yy-1] == FLOOR and			
												
			   obj_mapgen.grid[# xx+1,yy] == WALL and 
			   obj_mapgen.grid[# xx-1,yy] == WALL 
			   {
				tilemap_set_at_pixel(bottom_tilemap,tmiddle,xx*32,yy*32);	
			}
		
}

function grid_change(value,xx,yy, burn_ground){ 

	var grid = obj_mapgen.grid;
	xx = xx div 32;
	yy = yy div 32;
	
	xx = clamp(xx,0, ds_grid_width(grid)-1);
	yy = clamp(yy,0, ds_grid_height(grid)-1);
	
		
	if grid[# xx,yy] != value { 
		
		if value = FLOOR { 
			//create destructible effect
				create_animation_effect(s_wall_explosion,xx*32,yy*32,.5,1,0,c_white,1);
				
				bottom_struct.timer = 2;
				bottom_struct.enable = true;
				ds_list_add(bottom_struct.list, [xx, yy]);
		}
		
		grid[# xx, yy] = value;
		
		//scr_update_tile(grid, xx, yy, obj_mapgen.wall_tilemap, 1);
		obj_mapgen.grid_burn[# xx, yy] = 1;
		scr_update_tile(obj_mapgen.grid_burn, xx, yy, obj_mapgen.burn_tilemap, 1);	
		
			update_down_tile( xx,yy );
		
	//	if burn_ground { 
	//		obj_mapgen.grid_burn[# xx, yy] = 1;
	//		scr_update_tile(obj_mapgen.grid_burn, xx, yy, obj_mapgen.burn_tilemap, 1);	
	//	}
	}
	//xx *= 32;
	//yy *= 32;
}

function draw_corridor(struct , xx,  yy) { 
		var grid = mask_grid;
		var room1 = struct.room1.room_visibility_state;
		var room2 = struct.room2.room_visibility_state;
	if  room1 !=  e_room_visibility_state.hidden || room2 != e_room_visibility_state.hidden
	//	 and		room1 != e_room_visibility_state.fogofwar_adjacent_to_player //and   room2 != e_room_visibility_state.fogofwar_adjacent_to_player
			{
				//	nine_slice_on_grid(s_nine_slice_hp,xx*UNIT+room_xoffset, yy*UNIT+room_yoffset, xx*UNIT+room_xoffset+CELL_SIZE, yy*UNIT+room_yoffset+CELL_SIZE, 1,C_BROWN)
					
					if struct.set_to_wall_grid = false { 
						struct.set_to_wall_grid = true;
							grid_change(FLOOR, xx*UNIT+room_xoffset ,yy*UNIT+room_yoffset,false );
						
							
					}
			}
}


function draw_rooms(){
// draw rooms
room_notification = noone;
for(var i=0; i<ds_list_size(room_list); i++) {
	var this_room = ds_list_find_value(room_list, i);
	//if this_room.room_visibility_state = e_room_visibility_state.hidden exit;
	draw_set_color(c_white);
	var spr =  this_room.sprite();
	room_active_controller(this_room, spr,i);
	}
}


function room_active_controller(this_room, spr,i ) { 
		
var scale_add = 1;
	
var type = this_room.type;
var state = this_room.room_visibility_state;

var x1 = this_room.x1*UNIT+room_xoffset;
var y1 = this_room.y1*UNIT+room_yoffset;
var w = this_room.w*UNIT;
var h = this_room.h*UNIT;
	
	
var cam = o_game.camera;


var _l = cam.x-cam.width;
var _t = cam.y-cam.height;

var _r = cam.x+cam.width;
var _b = cam.y+cam.height;

//check if the room is up top
if  y1+h < _t ||//top
	x1+w < _l ||//left
	y1 > _b  || //bot
	x1 > _r  { //right
	exit;
}

// solid
var col = c_grey;
	switch this_room.type { 
			case e_room_type.start_room: col = C_LIME;
		break;
			case e_room_type.boss_room: col = C_GUM;
		break;
			case e_room_type.hard_encounter: col = C_WINE;
		break;	
			case e_room_type.chest_golden_room: col = C_YELLOW;
		break;
			case e_room_type.key_room: col = C_YELLOW;
		break;
			case e_room_type.rest_site: col = make_color_rgb( 211 ,252 ,126 );
		break;
			case e_room_type.shop_room_potions:
			case e_room_type.shop_room_stuff:
			case e_room_type.shop_room_tokens:
			case e_room_type.shop_room_cards: col = C_DARK;
		break;
	}
	//nine_slice_on_grid(s_nine_slice_room,x1, y1, x1+w, y1+h,1,col);
							

	var collide = false;
	if boon_collision_on_grid( x1, y1, x1+w, y1+h,MX,MY ){
		draw_set_color(C_LIME);
		collide = true;
	}
	var links = (this_room.links);
	var player_room =  ds_list_find_value(room_list, player_room_index);
	var player_links = player_room.links;
	
	var other_room_index = -1;
	var other_player_room_index = -1;
	for(var k=0; k<ds_map_size(player_links); k++) {

				if(other_player_room_index == -1) {
					other_player_room_index = ds_map_find_first(links);
				}else{
					other_player_room_index = ds_map_find_next(links, other_player_room_index);
				}


				for(var j=0; j<ds_map_size(links); j++) {
				if(other_room_index == -1) {
					other_room_index = ds_map_find_first(links);
					draw_set_color(C_LIME);
				}else{
					other_room_index = ds_map_find_next(links, other_room_index);
					draw_set_color(c_white);
				}
				
	
				if !is_undefined(other_room_index){
							
						var other_room = ds_list_find_value(room_list, other_room_index);			
			
	
					if other_room_index =  player_room_index{
							
					//				(other_room_index)
					//				(other_room_index)
									if other_room_index =  player_room_index{
					if other_room.room_visibility_state = e_room_visibility_state.hidden { 
						other_room.room_visibility_state = e_room_visibility_state.fogofwar_adjacent_to_player;
					}
			
					if this_room.room_visibility_state = e_room_visibility_state.hidden { 
						this_room.room_visibility_state = e_room_visibility_state.fogofwar_adjacent_to_player;
					}
				}
			}
		}
				
				
				if(other_room_index > i){
						draw_set_alpha(0.5);
					//	draw_line(CELL_SIZE*(this_room.x1+this_room.x2)/2, CELL_SIZE*(this_room.y1+this_room.y2)/2, CELL_SIZE*(other_room.x1+other_room.x2)/2, CELL_SIZE*(other_room.y1+other_room.y2)/2);
						draw_set_alpha(1);
				}
				
				
				
				
				var other_struct = ds_list_find_value(room_list, player_room_index);
				if this_room.room_visibility_state != e_room_visibility_state.hidden {
				
			if	boon_collision(draw_on_grid(x1), draw_on_grid(y1), draw_on_grid(x1+w), draw_on_grid(y1+h),MX,MY) { //other_room_index =  player_room_index and  
				
						draw_set_color(c_lime);
					//	draw_rectangle( other_struct.x1+room_xoffset,other_struct.y1+room_yoffset,other_struct.x1+other_struct.w+room_xoffset,other_struct.h+room_yoffset,true);
						if !go_to_battle and  o_game.m1_pressed and i != player_room_index and next_game_state_queue = noone {
									
									with obj_lighting_controller{ 
										event_user(0);
									}
									
									audio_play(sfx_coco_overworld_move_1,sfx_coco_overworld_move_2,sfx_coco_overworld_move_3);
									
									o_game.m1_pressed = false;
									other_struct.room_visibility_state = e_room_visibility_state.visible_but_not_on_it;
									player_room_index = i;
								var other_struct = ds_list_find_value(room_list, player_room_index);
									other_struct.room_visibility_state = e_room_visibility_state.visible;	
									
									this_room.room_visibility_state = e_room_visibility_state.visible;
									alarm[1] = 2;
									noti_timer = 0;
									standing_on.type =  other_struct.type;
									standing_on.x = (x1+x1+w)/2;
									standing_on.y = (y1+ y1+h)/2;
									
									standing_on.x1 = x1
									standing_on.y1 = y1
									
									standing_on.w = w;
									standing_on.h = h;
									standing_on.i = i;
									standing_on.room_struct = other_struct;

									
									switch other_struct.type { 
										
										case e_room_type.chest_small_room:
										
										
										break;
										
										case e_room_type.boss_room:
											o_audio.musicPlayer.Play( o_audio.riding_into_the_sun);
										case e_room_type.default_encounter:
										case e_room_type.hard_encounter:
											
										
									
											if go_to_battle = false { 
												
												
												
											//see if we are targeting the right rectangle here
											//draw_rectangle(x1, y1, x1+w, y1+h,false);
											//go_to_battle = true;
											
											
											nine_slice_on_grid(s_nine_slice_map_border,x1, y1, x1+w, y1+h,1,c_lime);
											other_struct.set_enemies_and_spoils();
											battle_transition_timer = SEC;
											go_to_next_state(e_gamestate.battle);			
											other_struct.type = e_room_type.empty_room;
									
				//	fade = create((other_struct.x1+other_struct.w)*CELL_SIZE,(other_struct.y1+other_struct.h-10)*CELL_SIZE,o_close_transition);
				//	fade.state = close.circle_close;
				//	fade.next_game_state = e_gamestate.battle;
				//	fade.next_room = 
				//	other_struct.type = e_room_type.empty_room;
										}		
										break;
									}	
						}
				}
		}		
					draw_set_color(col);
					draw_set_alpha(1);  
					switch state { 
							
							//case e_room_visibility_state.visible_but_not_on_it: 	draw_set_color(merge_color( col , C_DARK,.5));  draw_rectangle(x1, y1, x1+w, y1+h, false);
							
							case e_room_visibility_state.hidden:
							case e_room_visibility_state.fogofwar_far_from_player:	draw_set_alpha(1);  
							break;
							
							default:
							nine_slice_on_grid(s_nine_slice_map_border,x1, y1, x1+w, y1+h,1,col);
							//draw_rectangle(x1, y1, x1+w, y1+h, false)
								if !go_to_battle and boon_collision_on_grid(x1, y1, x1+w, y1+h,MX,MY ) { 
										draw_set_color(c_white);
										//draw_rectangle(x1, y1, x1+w, y1+h, 1);
										nine_slice_on_grid(s_nine_slice_map_border,x1, y1, x1+w, y1+h,1,c_white);
								}
							draw_set_color(col);
							//draw_rectangle(x1, y1, x1+w, y1+h, false);
							break;
					}
					
	//if this_room.set_itself_on_grid = false { 
	
		
	//}
	
	if  !this_room.set_itself_on_grid and this_room.room_visibility_state != e_room_visibility_state.hidden and 
			this_room.room_visibility_state != e_room_visibility_state.secret_undiscovered_room {
	
			
		var xx = x1 div CELL_SIZE;
		var yy = y1 div CELL_SIZE;
		
		for (var xx = x1 div CELL_SIZE; xx < (x1+w) div CELL_SIZE; xx++){ 
			for (var yy = y1 div CELL_SIZE; yy < (y1+h) div CELL_SIZE; yy++){ 
						grid_change(FLOOR,xx*CELL_SIZE,yy*CELL_SIZE,true);
					
						//nine_slice(s_nine_slice_default,x_,y_,x_+CELL_SIZE,y_+CELL_SIZE,1,c_white)
				}
		}	
		this_room.set_itself_on_grid = true;
}	
					draw_set_color(c_white);
		
				
		}
}
	
	//	draw_rectangle(x1, y1, x1+w, y1+h, true)
		draw_set_color(c_white);
		if i = player_room_index {
				playerx = UNIT*(this_room.x1+this_room.x2)/2+room_xoffset;
				playery = UNIT*(this_room.y1+this_room.y2)/2+room_yoffset;
				
				if draw_playerx = noone{ 
					draw_playerx = playerx;
					draw_playery = playery;
				
				}
				draw_playerx = lerp(draw_playerx , playerx , .08);
				draw_playery = lerp(draw_playery , playery , .08);
				var ang = sin(current_time*0.001)*10;
				draw_player_minimap( draw_playerx, draw_playery);
		}
		
		if spr != noone {
			if this_room.room_visibility_state != e_room_visibility_state.hidden and 
			this_room.room_visibility_state != e_room_visibility_state.secret_undiscovered_room {
				draw_sprite_ext(spr, 0, UNIT*(this_room.x1+this_room.x2)/2+room_xoffset-16, UNIT*(this_room.y1+this_room.y2)/2+room_yoffset-16,scale_add,scale_add,0,c_white,1);
			}
		}
		

	// label
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	//draw_text(x1+4, y1+4, string(state));

}
function draw_player_minimap(  xx, yy) { 

		draw_sprite_ext(s_char_idle_coco, current_time*.005, xx-8, yy-16,1,1,0,c_white,1);
		
}
			