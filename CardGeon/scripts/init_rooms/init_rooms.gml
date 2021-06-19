// Script assets have changed for v2.3.0 see

function map_restart(){
	
	room_restart();
	instance_destroy();
	create(0,0,obj_mapgen);

}



function init_rooms(){
closest_distance_from_boss_to_key_room = -1;
var dis = -1; 
var boss_room = ds_list_find_value(room_list,boss_room_index);
var bx = (boss_room.x1+boss_room.x2)/2;
var by = (boss_room.y1+boss_room.y2)/2;

	for(var i=0; i<ds_list_size(room_list); i++) {
		draw_set_color(c_white);
		// link
		var links = (boss_room.links);
		var other_room_index = -1;
		for(var j=0; j<ds_map_size(links); j++) {
		
			if(other_room_index == -1) {
				other_room_index = ds_map_find_first(links);
			}else {
				other_room_index = ds_map_find_next(links, other_room_index);
			}
		
if(other_room_index > i) {
	var other_room = ds_list_find_value(room_list, other_room_index);	
			if ds_map_size(other_room.links) = 1 and boss_room_reposition = false  { 
						other_room.type = e_room_type.boss_room;
						boss_room.type = e_room_type.default_encounter;
						boss_room_index = other_room_index;
						draw_sprite(s_idle_fat_tony,0,UNIT*(other_room.x1+other_room.x2)/2, UNIT*(other_room.y1+other_room.y2)/2 );
						boss_room_reposition = true;
			}
		}		
	}
}
	
var boss_room = ds_list_find_value(room_list,boss_room_index);
var bx = (boss_room.x1+boss_room.x2)/2;
var by = (boss_room.y1+boss_room.y2)/2;
		

for(var i=0; i<ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		
		
		if i = player_room_index {
				playerx = UNIT*(this_room.x1+this_room.x2)/2+room_xoffset;
				playery = UNIT*(this_room.y1+this_room.y2)/2+room_yoffset;
					camera_set_view_pos(CAM, playerx, playery) ;
		}
		
		var link_amount = ds_map_size(this_room.links);
		
				var xx = (this_room.x1+this_room.x2)/2;
				var yy = (this_room.y1+this_room.y2)/2;
			
				var dis = point_distance(xx,yy,bx,by);
				if key_room_index != -1 { 
					var key_room = ds_list_find_value(room_list, key_room_index);
				}
					//Rooms that only link to one other rooms,
					//can't be the starting room or the boss room

					
					if link_amount =  1 and i != boss_room_index and i != 0
					//if this room is closest to the boss room
					{ 
						if key_room_index = -1  || dis <  closest_distance_from_boss_to_key_room{
								//this_room[? "bgcolor"] = c_white;
								key_room_index = i;
								closest_distance_from_boss_to_key_room = dis;
								
						}
					}
		}
		
		if key_room_index != -1 {
			
			var key_room = ds_list_find_value(room_list, key_room_index);
			
			key_room.type = e_room_type.key_room;
			//key_room[? "bgcolor"] = C_AQUA;
			
			}else{
			
			
			map_restart();
			
			exit;
		}

		farthest_distance_from_key_room_to_chest_room = -1;
		
		var dis = -1; 
		var key_room = ds_list_find_value(room_list,key_room_index);
		var kx = (key_room.x1+key_room.x2)/2;
		var ky = (key_room.y1+key_room.y2)/2;

for(var i=0; i<ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		var link_amount = ds_map_size(this_room.links);
				
			
				var xx = (this_room.x1+this_room.x2)/2;
				var yy = (this_room.y1+this_room.y2)/2;
				
				var dis = point_distance(xx,yy,kx,ky);
				var dis2 = noone;
				if locked_room_index != -1 { 
					var key_room = ds_list_find_value(room_list, locked_room_index);
						  dis2 = point_distance(bx,by, (key_room.x1+key_room.x2)/2, (key_room.y1+key_room.y2)/2   );
				}
				
					//Rooms that only link to one other rooms,
					//can't be the starting room or the boss room
					if link_amount =  1 and i != boss_room_index and i != 0
					//if this room is closest to the boss room
											
					{ 
						if locked_room_index = -1  || dis  >  farthest_distance_from_key_room_to_chest_room{
								//this_room[? "bgcolor"] = c_white;
								locked_room_index = i;
								farthest_distance_from_key_room_to_chest_room = dis;
						}
					}
		}
		
		if key_room_index = locked_room_index {
				map_restart();
				exit;
		
		}
		if farthest_distance_from_key_room_to_chest_room != -1 {
		var locked_room = ds_list_find_value(room_list, locked_room_index);
		locked_room.type = e_room_type.chest_golden_room;
		//locked_room.bgcolor = C_YELLOW;
		}		
		
		
for(var i=0; i<ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		var link_amount = ds_map_size(this_room.links);
				
			
				var xx = (this_room.x1+this_room.x2)/2;
				var yy = (this_room.y1+this_room.y2)/2;
				
				var dis = point_distance(xx,yy,kx,ky);
				var dis2 = noone;
				if locked_room_index != -1 { 
					var key_room = ds_list_find_value(room_list, locked_room_index);
						  dis2 = point_distance(bx,by, (key_room.x1+key_room.x2)/2, (key_room.y1+key_room.y2)/2   );
				}
				
					//Rooms that only link to one other rooms,
					//can't be the starting room or the boss room
					if link_amount =  1 and i != boss_room_index and i != 0
					//if this room is closest to the boss room
											
					{ 
						if locked_room_index = -1  || dis  >  farthest_distance_from_key_room_to_chest_room{
								//this_room[? "bgcolor"] = c_white;
								locked_room_index = i;
								farthest_distance_from_key_room_to_chest_room = dis;
						}
					}
		}
		
		if key_room_index = locked_room_index {
				map_restart();
				exit;
		
		}
		if farthest_distance_from_key_room_to_chest_room != -1 {
		var locked_room = ds_list_find_value(room_list, locked_room_index);
		locked_room.type = e_room_type.chest_golden_room;
		//locked_room.bgcolor = C_YELLOW;
		}			
	
	//############################
	

		var dis = -1; 
		var start_room = ds_list_find_value(room_list,0);
		var size_add = 1;
		var sx = ((start_room.x1+start_room.x2)/2)*size_add;
		var sy = ((start_room.y1+start_room.y2)/2)*size_add;
		
		var boss_room = ds_list_find_value(room_list,boss_room_index);
		var bx = ((boss_room.x1+boss_room.x2)/2)*size_add;
		var by = ((boss_room.y1+boss_room.y2)/2)*size_add;
		
		var dis = point_distance( sx,sy,bx,by);
		var dir = point_direction(sx,sy, bx,by)

		var mod_ = .65; //60^ of the way from player start position to the boss room

		var lenx = lengthdir_x(dis,dir)*mod_;
		var leny = lengthdir_y(dis,dir)*mod_;
			
		draw_sprite(s_map_rest_area, 0, sx+lenx,sy+leny); 
			
		var elite_areax = sx+lenx;
		var elite_areay = sy+leny;
			
		var not_found = 0;
		elite_placement_dis = -1;
		elite_placement_index = -1;		

	for(var i=0; i<ds_list_size(room_list); i++) {
			var this_room = ds_list_find_value(room_list, i);
					var xx = (this_room.x1+this_room.x2)/2;
					var yy = (this_room.y1+this_room.y2)/2;
					
				var dis = point_distance(xx,yy,elite_areax,elite_areay);
					if elite_placement_index = -1  || dis < elite_placement_dis { 
						elite_placement_index = i;
						elite_placement_dis = dis;
		}
}

var elite_room = ds_list_find_value(room_list, elite_placement_index);
	if elite_room.type = e_room_type.default_encounter {
			elite_room.type = e_room_type.hard_encounter;
	}
	
	
	var dis = -1; 
	var start_room = ds_list_find_value(room_list,0);
	var sx = (start_room.x1+start_room.x2)/2;
	var sy = (start_room.y1+start_room.y2)/2;

for(var i=0; i < ds_list_size(room_list); i++) {

		var this_room = ds_list_find_value(room_list, i);
		var link_amount = ds_map_size(this_room.links);
		
				var xx = (this_room.x1+this_room.x2)/2;
				var yy = (this_room.y1+this_room.y2)/2;
			
				var dis = point_distance(xx,yy,sx,sy);
				
					//Rooms that only link to one other rooms,
					//can't be the starting room or the boss room
					
				if this_room.type = e_room_type.default_encounter and link_amount =  1   { 

					//if this room is closest to the boss room
					
							if dis >  closest_distance_from_boss_rest_area{
									//this_room[? "bgcolor"] = c_white;
									rest_area_index = i;
									closest_distance_from_boss_rest_area = dis;
				}
		}
}
		
		if rest_area_index != -1 {
			var rest_area = ds_list_find_value(room_list, rest_area_index);
			rest_area.type = e_room_type.rest_site;
			//key_room[? "bgcolor"] = C_AQUA;
			
			}else{
				map_restart();
				exit;
		}	
		
		
		
//make the next closest room rooms into a shop 
for(var i=0; i < ds_list_size(room_list); i++) {

		var this_room = ds_list_find_value(room_list, i);
		var link_amount = ds_map_size(this_room.links);
		
				var xx = (this_room.x1+this_room.x2)/2;
				var yy = (this_room.y1+this_room.y2)/2;
			
				var dis = point_distance(xx,yy,sx,sy);
				
					//Rooms that only link to one other rooms,
					//can't be the starting room or the boss room
					
				if this_room.type = e_room_type.default_encounter and link_amount =  1   { 

					//if this room is closest to the boss room
					
							if dis >  closest_distance_from_boss_rest_area{
									//this_room[? "bgcolor"] = c_white;
									rest_area_index = i;
									closest_distance_from_boss_rest_area = dis;
				}
		}
}
		
		if rest_area_index != -1 {
			var rest_area = ds_list_find_value(room_list, rest_area_index);
			rest_area.type = e_room_type.rest_site;
			//key_room[? "bgcolor"] = C_AQUA;
			
			}else{
				map_restart();
				exit;
		}		
		


for(var i=0; i < ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		var link_amount = ds_map_size(this_room.links);
		
				var xx = (this_room.x1+this_room.x2)/2;
				var yy = (this_room.y1+this_room.y2)/2;
			
				var dis = point_distance(xx,yy,bx,by);
				
			//Rooms that only link to one other rooms,
			//can't be the starting room or the boss room
					
			//closest_distance_from_boss_shop = -1;
			//shop_area_index = -1; //closest to the boss room with 1 link
					
				if this_room.type = e_room_type.default_encounter and link_amount =  1   { 
					//if this room is closest to the boss 
							if shop_area_index = -1 || dis <  closest_distance_from_boss_rest_area{
									//this_room[? "bgcolor"] = c_white;
									shop_area_index = i;
									closest_distance_from_boss_rest_area = dis;
							}
			}
}
		
		if shop_area_index != -1 {
				var shop_area = ds_list_find_value(room_list, shop_area_index);
				shop_area.type = choose(e_room_type.chest_small_room, e_event_type.rest_area, e_room_type.shop_room_removal);
				//key_room[? "bgcolor"] = C_AQUA;
			}else{
				map_restart();
				exit;
	
		}		
		
//last remaining rooms with one doorway become treasure rooms or shop rooms





for(var i=0; i<ds_list_size(room_list); i++) {
		var this_room = ds_list_find_value(room_list, i);
		var link_amount = ds_map_size(this_room.links);
		
				//can't be the starting room or the boss room
				if link_amount =  1 and  this_room.type =  e_room_type.default_encounter {
//					boon_randomize();	
//					if chance(.15) { 
//						var type_ = e_room_type.rest_site;	
//					}else{
//								 type_ = e_room_type.chest_small_room;		
//					}
					 type_ = e_room_type.chest_small_room;		
					this_room.type = type_;
		}
}

	

for(var i=0; i<ds_list_size(room_list); i++) {
		boon_randomize()
		var this_room = ds_list_find_value(room_list, i);
		var link_amount = ds_map_size(this_room.links);
		var start_room = ds_list_find_value(room_list,player_room_index);
	
					//can't be the starting room or the boss room
		if this_room.type = e_room_type.default_encounter { 
			if chance(.40) { //.60
						this_room.type = e_room_type.empty_room;
						if chance(.20){ 
								//,e_room_type.shop_room_potions  ,e_room_type.shop_room_stuff 
								this_room.type = choose(e_room_type.rest_site , e_room_type.chest_small_room ,e_room_type.shop_room_removal ,e_room_type.shop_room_tokens, e_room_type.shop_room_cards);
								// e_room_type.chest_small_room;
							
							if this_room.type = e_room_type.shop_room_cards{ 
								boon_randomize()
								ds_list_shuffle(card_spoils);
								for (var f=0; f < player.card_shop_options; f++){ 
									this_room.shop_deal_index = irandom(player.card_shop_options);
									array_push(this_room.shop_array, ds_list_find_value(card_spoils,f));
								}
								
							}
							
							
							if this_room.type = e_room_type.shop_room_tokens{ 
								boon_randomize()
								ds_list_shuffle(all_token_list);
								for (var f=0; f< player.token_shop_options; f++){ 
									this_room.shop_deal_index = irandom(player.token_shop_options);
									array_push(this_room.shop_array, ds_list_find_value(all_token_list,f)	);
								}
							}
						// e_room_type.chest_small_room;
			}
		}
	}

}
	//this goes last
		var links = (start_room.links);
		var other_room_index = -1;
		for(var j=0; j<ds_map_size(links); j++) {
			if(other_room_index == -1) {
				other_room_index = ds_map_find_first(links);
			}else {
				other_room_index = ds_map_find_next(links, other_room_index);
			}
//if(other_room_index > i) {
				var other_room = ds_list_find_value(room_list, other_room_index);	
				//	other_room.type = e_room_type.default_encounter;
				//	boss_room.type = e_room_type.default_encounter;
			//	}		
		}	

}

function dungeon_set_width_and_height(){ 

var left = noone;
var right = noone;
var top = noone;
var bot = noone;

for(var i=0; i<ds_list_size(room_list); i++) {
	var this_room = ds_list_find_value(room_list, i);
	
	if this_room.x1*UNIT < left  || left = noone{ 
		left = this_room.x1*UNIT;	
	}
	if this_room.x2*UNIT > right  || right = noone{ 
		right = this_room.x2*UNIT;	
	}	
	
	if this_room.y1*UNIT < top  || top = noone{ 
		top = this_room.y1*UNIT;	
	}
	if this_room.y2*UNIT > bot  || bot = noone{ 
		bot = this_room.y2*UNIT;	
	}		
}


var left_dis = point_distance(0,0,left,0);

var up_dis = point_distance(0,0,0,top);

room_wmargin = 500; //makes sure the player never sees the edge of the room
room_hmargin = 500;//to make it more mysterious


room_xoffset = room_wmargin-left;
room_yoffset = room_hmargin-top;

//draw_rectangle(left+room_xoffset,top+room_yoffset,right+room_xoffset,bot+room_yoffset,1);


///DEBUG AND REMOVE DEFAULT FIGH 

for(var i=0; i < ds_list_size(room_list); i++) {

		var this_room = ds_list_find_value(room_list, i);
		var link_amount = ds_map_size(this_room.links);
		
				var xx = (this_room.x1+this_room.x2)/2;
				var yy = (this_room.y1+this_room.y2)/2;
		
					//Rooms that only link to one other rooms,
					//can't be the starting room or the boss room
					
				if this_room.type = e_room_type.default_encounter  { 

					this_room.type = e_room_type.empty_room;
				}
}


room_set_width(r_dungeon,right+room_wmargin);
room_set_height(r_dungeon,bot+room_hmargin);

room_goto(r_dungeon);

//	persistent = false;
}