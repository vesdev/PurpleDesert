enum e_room_visibility_state  { 
	fogofwar_adjacent_to_player,
	fogofwar_far_from_player,
	hidden,
	visible,
	secret_undiscovered_room,
	visible_but_not_on_it,
	size_
}



function room_struct(type, x1,y1,x2,y2 ,spacer, w, h, collision, links  ) constructor{ 
	self.type = type;
	self.x1 = x1;
	self.y1 = y1;
	self.x2 = x2;
	self.y2 = y2;	
	self.spacer = spacer;
	self.w = w;
	self.h = h;
	self.collision = collision;
	self.links = links;
	set_itself_on_grid = false;
	shop_array = []; //put stuff like cards or token enums
	shop_deal_index = 0;
	
	
	set_enemies_and_spoils = function(){
				switch type  {
					case e_room_type.default_encounter:					
											with o_game{//1 fat tony
												init_battle();//e_enemies.babydragon , e_enemies.babydragon, e_enemies.babydragon
												
												var list = enemy_dungeon_list;
												var len = ds_list_size(list);
												
												var enemy_array = ds_list_find_value(list,0)
												o_game.game.run.rooms_cleared++;
												add_enemy(	enemy_array  );	
									
												
												if chance(player.find_spoils_chance) and o_game.game.run.rooms_cleared > 0 { 
													new_spoil(  [create_gold(10) ,   spoil_add_card()], stuff_struct(get_next_stuff_enum())   ) ;
													player.find_spoils_chance = player.find_spoil_chance_reset;
												}else{ 
												
													new_spoil(  [create_gold(10) ,   spoil_add_card()]) ;
													player.find_spoils_chance += player.find_spoils_chance_add;
												}
												
											
												ds_list_delete(list, 0)
												ds_list_add(list,enemy_array);
											}
					break;
					case e_room_type.hard_encounter:
								with o_game{ 
											init_battle();
											add_enemy([e_enemies.sleepy]);	
											new_spoil(  [create_gold(50) ,  stuff_struct(get_next_stuff_enum() ) , spoil_add_card()]) ;
											}
					break;
					
					case e_room_type.boss_room:
								with o_game{ 
											init_battle();
											
											var enemy = choose( 
											
											 [ e_enemies.boss_1_dragon,e_enemies.babydragon],
											 [ e_enemies.boss_1_cloak],
											 [ e_enemies.boss_1_antlion])
											 
											add_enemy(enemy);	
											new_spoil(  [create_gold(999) ,  stuff_struct(e_stuff.you_win ) , spoil_add_card()]) ;
											}
					break;					
					//type_ = e_room_type.chest_small_room;		
					//this_room.type = type_;
		}};

	sprite = get_room_sprite;
	//visibility variables
	room_visibility_state = e_room_visibility_state.hidden;
}




enum e_room_type {  //each room is given a type to determine what we will find
		start_room,
		default_encounter,
		hard_encounter,	//must be closer to the 
		boss_room,
		rest_site,				 //one per floor
		key_room,
		chest_golden_room,
		chest_small_room,
		empty_room,
		
		
		blood_bank,
		
		
		shop_room_cards,
		shop_room_tokens,
		shop_room_stuff,
		shop_room_potions,
		shop_room_removal,
		
		
		size_ 
}


function get_room_sprite (){ 
				var spr = noone;
		switch type { 
					case e_room_type.boss_room:  spr = s_map_fight_area_hard
				break;
					case e_room_type.hard_encounter:  spr = s_map_fight_area
				break;
					case e_room_type.key_room:  spr = s_map_key;
				break;		
					case e_room_type.chest_golden_room:  spr = s_map_chest_golden;
				break;
					case e_room_type.start_room:  //spr = s_char_idle_coco;
				break;		
					case e_room_type.rest_site: spr = s_map_rest_area;
				break;	
					case e_room_type.chest_small_room: spr = s_map_chest;
				break;
					case e_room_type.default_encounter: spr = s_map_default_fight;
				break;
				
					case e_room_type.shop_room_cards: spr = s_shop_cards;
				break;	
				
					case e_room_type.shop_room_tokens: spr = s_shop_token;
				break;	
				
					case e_room_type.shop_room_stuff: spr = s_potion_stuff_shop;
				break;	
				
					case e_room_type.shop_room_potions: spr = s_shop_potion;
				break;	
				
					case e_room_type.shop_room_removal: spr = s_shop_removal;
				break;	
			}
			return spr;
}

function room_links (room_a, room_b ){ 
	self.room_a = room_a;
	self.room_b = room_b;
}

function struct_mapgen_create_rooms(argument0, argument1, argument2) {
	var room_list = argument0;
	var numrooms = floor(argument1);
	var invisrooms = floor(argument2);

	var count=0;
	repeat(numrooms+invisrooms) {
	
		if(count < numrooms) {
			var spacer = false;
			var width = irandom_range(5,12);
			var height = irandom_range(5,12);
		}
		else {
			var spacer = true;
			var width = irandom_range(3,5);
			var height = irandom_range(3,5);
		}
	
		var x1 = round(-width/2) + irandom_range(-5,5);
		var y1 = round(-height/2) + irandom_range(-5,5);
		
		var links = ds_map_create();
		
		var type = e_room_type.default_encounter;
		
	
		
		
		
		
		if count = 0 {
					type = e_room_type.start_room;
					var struct = new room_struct( type,x1,y1,x1+width,y1+height,spacer,width,height,false,links);
					struct.room_visibility_state = e_room_visibility_state.visible;

		}else{
			var struct = new room_struct( type,x1,y1,x1+width,y1+height,spacer,width,height,false,links);	
		}
		ds_list_add(room_list, struct);
		count+=1;
	}
}




function scr_mapgen_create_rooms(argument0, argument1, argument2) {
	var room_list = argument0;
	var numrooms = floor(argument1);
	var invisrooms = floor(argument2);

	var count=0;
	repeat(numrooms+invisrooms) {
		var this_room = ds_map_create();
	
	
		if(count < numrooms) {
			ds_map_add(this_room, "spacer", false)
			var width = irandom_range(7,12);
			var height = irandom_range(7,12);
		}
		else {
			ds_map_add(this_room, "spacer", true)
			var width = irandom_range(3,5);
			var height = irandom_range(3,5);
		}
	
		var x1 = round(-width/2) + irandom_range(-5,5)
		var y1 = round(-height/2) + irandom_range(-5,5)
		ds_map_add(this_room, "x1", x1)
		ds_map_add(this_room, "y1", y1)
		ds_map_add(this_room, "x2", x1+width)
		ds_map_add(this_room, "y2", y1+height)
		ds_map_add(this_room, "w", width)
		ds_map_add(this_room, "h", height)
		ds_map_add(this_room, "collision", false)
		ds_map_add(this_room, "type", e_room_type.default_encounter);
		
		if count =  0{ 
				ds_map_add(this_room, "bgcolor", c_lime)	
				this_room[? "type"] = e_room_type.start_room;
		}else{
				ds_map_add(this_room, "bgcolor", c_ltgray)	
		}


		var links = ds_map_create();
		ds_map_add_map(this_room, "links", links);
	
		ds_list_add(room_list, this_room);
		ds_list_mark_as_map(room_list, ds_list_size(room_list)-1)
		count+=1;
	}



}
