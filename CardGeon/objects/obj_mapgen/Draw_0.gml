
battle_transition_timer--;

if o_game.game_state = e_gamestate.battle exit;// and !o_game.peek_at_map exit;
if alarm[0] != -1 exit;

var cam = o_game.camera;

if center_camera_on_player > 0 { 
	o_game.camera.x = playerx;
	o_game.camera.y = playery;
	center_camera_on_player--;	
}


if !obj_mapgen.enable_event {
	
//loop throught the dungeons to get the best possible map size
if o_game.move_camera_to_coco = true {
	o_game.camera.x = playerx;
	o_game.camera.y = playery;
	//
	o_game.move_camera_to_coco = false;
}else{ 
	cam.x = lerp(cam.x, playerx, .04);
	cam.y = lerp(cam.y, playery, .04);
}

	var target_zoom = 1;
		
	var this_room = ds_list_find_value(room_list, player_room_index);	
	
	var x1 = this_room.x1*UNIT+room_xoffset;
	var y1 = this_room.y1*UNIT+room_yoffset;
	var w = this_room.w*UNIT;
	var h = this_room.h*UNIT;

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
						var px1 = player_room.x1*UNIT+room_xoffset;
						var py1 = player_room.y1*UNIT+room_yoffset;
						var pw = player_room.w*UNIT;
						var ph = player_room.h*UNIT;
					
						var other_room = ds_list_find_value(room_list, other_room_index);			
					
						var x1 = other_room.x1*UNIT+room_xoffset;
						var y1 = other_room.y1*UNIT+room_yoffset;
						var w = other_room.w*UNIT;
						var h = other_room.h*UNIT;
					
						var other_room = ds_list_find_value(room_list, other_room_index);		
						
						 var otherx = x1+w*.5;
						 var othery = y1+h*.5;
						
			//			draw_line(px1+pw*.5,py1+ph*.5,otherx,othery);//px1+pw*.5,py1+ph*.5
	
				// 
			if otherx <  px1-cam.width*.5 ||	
				otherx >  px1+cam.width*.5  || 
				othery <  py1-cam.height*.4 ||
				othery >  py1+cam.height*.6
				{ 
				
					target_zoom = 2;
			}
				//debug("CAM X "+string(cam.y-cam.height*.5));
		}	
	}	
}

	cam.zoom = lerp(cam.zoom,target_zoom,.2);	
	
	if target_zoom != 1 { 
	cam.x = floor(cam.x);
	cam.y = floor(cam.y);	
	}

}



if instance_exists(o_game) and o_game.game_state != e_gamestate.choose_path {
	exit;	
}


if enable_event { 
	
update_card_text();

var cam = o_game.camera;


event_easing_timer = 0;
event_easing_time = SEC;


var offset = .15;
var _l = cam.x-cam.width*offset;
var _t = cam.y-cam.height*offset;
var _r = cam.x+cam.width*offset;
var _b = cam.y+cam.height*offset;


alarm[2] = 2;





switch event_struct.type{ 

case e_event_type.shop_removal:

		cam.zoom = lerp(cam.zoom,1,.3);
		
		with o_game{
			o_game.camera.x = 0;
			o_game.camera.y = 0;
			draw_cards_in_library_to_remove();
		}	
		center_camera_on_player = SEC*.2;

break;


case e_event_type.shop_token:
		cam.zoom = lerp(cam.zoom,1,.3);

		with o_game{
			o_game.camera.x = 0;
			o_game.camera.y = 0;
			draw_tokens_in_shop();
		}	
		center_camera_on_player = SEC*.2;
break;

case e_event_type.shop_card:
		cam.zoom = lerp(cam.zoom,1,.3);
		browsing_card_shop = true;
		with o_game{
			o_game.camera.x = 0;
			o_game.camera.y = 0;
			draw_cards_in_shop();
		}	
		center_camera_on_player = SEC*.2;
break;
case e_event_type.rest_area:

if !selecting_card_upgrade{

	var hp =	string(player.hp);
	var hp_amount = player.hp_max * player.rest_area_restore_mod;
	
	var hp_after = string(player.hp + hp_amount);
	if  hp_after > player.hp_max { 
		hp_after = string(player.hp_max);	
	}
	var text_to_add = "[c_yellow]"+hp+"[] [s_caret] [c_lime]"+hp_after;
	
	if player.hp = player.hp_max {
		text_to_add = "HP IS [c_yellow]FULL[]";	
	}
	
	var scr_eat = scribble("[fa_center]EAT [s_pizza]\nRESTORE [c_lime]+"+string(round(player.rest_area_restore_mod*100))+"%[] MAX HP\n"+text_to_add).wrap(cam.width*offset)
	var scr_or = scribble("[fa_center][c_yellow]OR[]")
	var scr_later = scribble("[fa_center][c_gum]MAP[]")
	var scr_upgrade = scribble("[fa_center][c_lime]UPGRADE[] [s_map_card]\nA CARD IN YOUR DECK").wrap(cam.width*offset)
	
	var bbox_eat = scr_eat.get_bbox(cam.x -cam.width/8,cam.y-cam.height*0.03);
	var bbox_upgrade = scr_upgrade.get_bbox(cam.x +cam.width/8,cam.y-cam.height*0.03);
	var bbox_or = scr_or.get_bbox(cam.x ,cam.y);
	var later_x = cam.x+cam.width*.2
	var later_y = cam.y+cam.height*.2
	
	var bbox_later = scr_later.get_bbox(later_x ,later_y);			
	var xmargin = 5;
	var ymargin = 4;
	var eat_color = C_GRAY;
		//choose pizza
	if boon_collision(bbox_eat.x0-xmargin,bbox_eat.y0-ymargin,bbox_eat.x3+xmargin,bbox_eat.y3+ymargin, MX,MY) {
		col = merge_color(C_DARK,c_white,.01);
		eat_color = C_LIME
		if o_game.m1_pressed { 
			hp_amount = player.hp_max * player.rest_area_restore_mod;
			restore_health(player,hp_amount);
			
				event_struct = noone;
				enable_event = false;
				standing_on.type = e_room_type.empty_room;
				var this_room = ds_list_find_value(room_list, standing_on.i)				
				this_room.type = e_room_type.empty_room;				
		}
	}
	
	nine_slice(s_nine_slice_default,bbox_eat.x0-xmargin,bbox_eat.y0-ymargin,bbox_eat.x3+xmargin,bbox_eat.y3+ymargin,1,c_white);
	nine_slice(s_nine_slice_hp_border,bbox_eat.x0-xmargin,bbox_eat.y0-ymargin,bbox_eat.x3+xmargin,bbox_eat.y3+ymargin,1,eat_color);
	nine_slice(s_nine_slice_default,bbox_or.x0-xmargin,bbox_or.y0-ymargin,bbox_or.x3+xmargin,bbox_or.y3+ymargin,1,c_white);
	nine_slice(s_nine_slice_default,bbox_later.x0-xmargin,bbox_later.y0-ymargin,bbox_later.x3+xmargin,bbox_later.y3+ymargin,1,c_white);
	
	if boon_collision(bbox_later.x0-xmargin,bbox_later.y0-ymargin,bbox_later.x3+xmargin,bbox_later.y3+ymargin, MX,MY) {
		nine_slice(s_nine_slice_hp_border,bbox_later.x0-xmargin,bbox_later.y0-ymargin,bbox_later.x3+xmargin,bbox_later.y3+ymargin,1,c_yellow);
	
		if o_game.m1_pressed { 
			o_game.upgrade_card_select.enable = false;
			
				event_struct = noone;
				enable_event = false;
		}
	}
	
	
	
//choose upgrade
var upgrade_color = C_GRAY;
	if boon_collision(bbox_upgrade.x0-xmargin,bbox_upgrade.y0-ymargin,bbox_upgrade.x3+xmargin,bbox_upgrade.y3+ymargin, MX,MY) {
		col = merge_color(C_DARK,c_white,.01);
		upgrade_color = C_LIME;
		if o_game.m1_pressed { 
			selecting_card_upgrade = true;	
			o_game.upgrade_card_select.enable = false;
			cam.zoom = 2;
				//event_struct = noone;
				//enable_event = false;
				//standing_on.type = e_room_type.empty_room;
				//var this_room = ds_list_find_value(room_list, standing_on.i)				
				//this_room.type = e_room_type.empty_room;
		}
	}
	
	nine_slice(s_nine_slice_default,bbox_upgrade.x0-xmargin,bbox_upgrade.y0-ymargin,bbox_upgrade.x3+xmargin,bbox_upgrade.y3+ymargin,1,c_white);
	nine_slice(s_nine_slice_hp_border,bbox_upgrade.x0-xmargin,bbox_upgrade.y0-ymargin,bbox_upgrade.x3+xmargin,bbox_upgrade.y3+ymargin,1,upgrade_color);
	
	scr_eat.draw(cam.x -cam.width/8,cam.y-cam.height*0.03);
	scr_or.draw(cam.x ,cam.y);
	scr_upgrade.draw(cam.x +cam.width/8,cam.y-cam.height*0.03);
	scr_later.draw(later_x ,later_y);	
	cam.zoom = lerp(cam.zoom,.5,.1);
	}else{
	if o_game.upgrade_card_select.enable = true { 
		cam.zoom = lerp(cam.zoom,1,.2);
		
	}else{
		cam.zoom = lerp(cam.zoom,1,.2);
			
	}
		
		
		with o_game{
			o_game.camera.x = 0;
			o_game.camera.y = 0;
			draw_cards_in_library();
		}	
		center_camera_on_player = SEC*.2;
	}	


break;

case e_event_type.golden_treasure:
case e_event_type.small_treasure:
	cam.zoom = lerp(cam.zoom, .5,.1);
if event_struct.stuff = noone exit;
var col = C_DARK

nine_slice(s_nine_slice_default,_l,_t,_r,_b,1,c_white);

if boon_collision(_l,_t,_r,_b, MX,MY) {
	
	//player.chest_reroll
	col = merge_color(C_DARK,c_white,.01);
	nine_slice(s_nine_slice_hp_border,_l,_t,_r,_b,1,c_lime);
	if o_game.m1_pressed { 
		
		var struct = event_struct.stuff;
			
			with o_game{ 
				if struct.init_script != noone  { 
				struct.init_script();
			}
				all_passive_treasures = array_add_return(all_passive_treasures, array_length(all_passive_treasures) , struct);
		}
			event_struct = noone;
			enable_event = false;
			exit;
	}
}



var title = event_struct.stuff.title;
var desc = event_struct.stuff.desc();
var sprite = event_struct.stuff.sprite;
var re_roll = event_struct.reroll_amount;
	scribble("[fa_center]"+title).draw(cam.x,cam.y-50);
	
	scribble("[fa_center]"+desc).wrap(cam.width*offset*1.8).draw(cam.x,cam.y+20);
	draw_outline(sprite,0,cam.x,cam.y,1,1,0,C_DARK,1);
	draw_sprite_ext(sprite,0,cam.x,cam.y,1,1,0,c_white,1);
	
offset *= .35;

var xoffset = (cam.width*offset)*4;
var yoffset = (cam.height*offset)*4;
var _l = cam.x-cam.width*offset+xoffset;
var _t = cam.y-cam.height*offset+yoffset;
var _r = cam.x+cam.width*offset+xoffset;
var _b = cam.y+cam.height*offset+yoffset;

var xoff = cam.width*0.015;
var yoff = cam.height*.02
	nine_slice(s_nine_slice_default,_l+xoff,_t+yoff,_r-xoff,_b-yoff,1,c_white);
	nine_slice(s_nine_slice_hp_border,_l+xoff,_t+yoff,_r-xoff,_b-yoff,1,C_GUM);
if boon_collision(_l+xoff,_t+yoff,_r-xoff,_b-yoff,MX,MY ){

	nine_slice(s_nine_slice_hp_border,_l+xoff,_t+yoff,_r-xoff,_b-yoff,1,C_YELLOW);
		if o_game.m1_pressed{ 
				event_struct = noone;
				enable_event = false;
		}
	}

	scribble("[fa_center]DISCARD").wrap(_r-_l).draw(_l+(_r-_l)*.5,_t+(_b-_t)*.5-10);


if re_roll > 0 { 

var xoffset = (cam.width*offset)*4;
var yoffset = (cam.height*offset)*4;
var _l = cam.x-cam.width*offset+xoffset;
var _t = cam.y-cam.height*offset+yoffset;
var _r = cam.x+cam.width*offset+xoffset;
var _b = cam.y+cam.height*offset+yoffset;

var xoff = cam.width*0.015;
var yoff = cam.height*.02;

var y_offset = -cam.height*0.42;

	nine_slice(s_nine_slice_default,_l+xoff,_t+yoff+y_offset,_r-xoff,_b-yoff+y_offset,1,c_white);

if boon_collision(_l+xoff,_t+yoff+y_offset,_r-xoff,_b-yoff+y_offset,MX,MY ){
	nine_slice(s_nine_slice_hp_border,_l+xoff,_t+yoff+y_offset,_r-xoff,_b-yoff+y_offset,1,C_YELLOW);
		if o_game.m1_pressed{ 
			var s = false;
				//reroll
			if event_struct.type = e_event_type.golden_treasure { 
					var stuff_enum = get_next_stuff_gold_enum();
			}else{
					stuff_enum = get_next_stuff_enum();
			}
		
			with o_game{ 
			
				other.event_struct = new overworld_chest(stuff_struct(stuff_enum),re_roll-1 );
			}
				//event_struct = noone;
				//enable_event = false;
		}
	}
	scribble("[fa_center]REROLL\n[s_stuff_re_roll]").wrap(_r-_l).draw(_l+(_r-_l)*.5,_t+(_b-_t)*.5-10+y_offset);
}
	break;
}
//debug(event_struct);
exit;

}else{
	o_game.view_deck_or_discard_card_yoffset = false;	
}


if go_to_battle and  o_game.game_state = e_gamestate.choose_path and battle_transition_timer <= 0{
	with o_game { 
		game.combat = new stats();
	}
	go_to_next_state(e_gamestate.battle)
	var lay = layer_get_id("blue_lights_slow_0");
	layer_set_visible(lay,false);
	var lay = layer_get_id("blue_lights_slow_1");
	layer_set_visible(lay,false);
	var lay = layer_get_id("blue_lights_slow_1");
	layer_set_visible(lay,false);	
	exit;
}

if o_game.game_state = e_gamestate.battle exit;

draw_set_alpha(1.0);
//draw lighting
//player_light.x = mouse_x;
//player_light.y = mouse_y;
with(o_game)
{
//	lighting.Draw(camera.x-camera.width/2, camera.y-camera.height/2, lights, drawLightSolids);
}


if !instance_exists(o_game) exit;



draw_rooms();



draw_synth_map();


