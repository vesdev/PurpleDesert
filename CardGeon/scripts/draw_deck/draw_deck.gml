// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information



function draw_cards_in_deck(){
	
	if deck_is_not_drawn_in_order_warning { 
			scribble("[fa_center][c_yellow]DECK IS NOT SHOWN IN ORDER").draw(0,-camera.height*.4);	
	}
	
	var offset = 22;
	
	init_card_border_step(0);
	var card_height_ = 210;
	var offset_add = card_height_;
	//scroll up or down 
	var arrow_offset = 80;
	//down
	
		
	if mouse_wheel_up() { 
		view_deck_or_discard_card_yoffset += offset_add;
		m1_pressed = false;
		deck_is_not_drawn_in_order_warning = false;
	}

	arrow_offset *= 2;
	//up
	
	if mouse_wheel_down() { 
		view_deck_or_discard_card_yoffset -= offset_add;
		deck_is_not_drawn_in_order_warning = false;
	}
	
	view_deck_or_discard_card_yoffset = min(view_deck_or_discard_card_yoffset,0);
	var card_width_ = 160;

	var y_ = -camera.height*.15+view_deck_or_discard_card_yoffset;
	var hovering_card = false;
	var save_x = noone;
	var save_y = noone;
	
	
	
	
	for (var i = 0; i < ds_list_size(draw_tempoary_list_deck);i++){ 
		var card_ = ds_list_find_value(draw_tempoary_list_deck,i);
			var div_amount = camera.width div card_width_ ;
			
			var i_mult = i mod div_amount;
			var x_ = -camera.width*.5+card_width_*.5+card_width_*i_mult;
			if i / div_amount = floor(i/div_amount) and i > 1{
				y_ += card_height_;
			}
			
				draw_card_matrix_selectable(card_,x_,y_,1,1,0,0,0,i,false,0,false,true,false);
				
			if hovering_card = false  and is_hovering_over_card != noone{
				save_x = x_;
				save_y = y_;
				hovering_card = true;
			}
	}


	if save_x != noone and is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
			draw_card_matrix_selectable(is_hovering_over_card, save_x,save_y-global.shop_yoffset, 2,2,0, 0, 0 ,  save_hovered_i,true,0,0,true,false);
		
	}

		
	draw_deck();	
}

function draw_cards_in_shop(){

	var can_upgrade_card = false;
	if o_game.game_state = e_gamestate.choose_path { 
		draw_sprite_ext(s_pixel,0,-camera.width*10,-camera.height*10,room_width*10,room_height*10,0,C_DARK,1);
		
		can_upgrade_card = true;
		
		var scr = scribble("[scale, 2][c_yellow]MAP");
		var x_ = -camera.width*.45;
		var y_ = -camera.height*.45;
		
		var bbox = scr.get_bbox(x_,y_);
		var xadd = 30;
		var yadd = 20;
		nine_slice(s_nine_slice_hp_border,bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,1,c_white);
		scr.draw(x_,y_);
	
		if boon_collision(bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,MX,MY) {
			nine_slice(s_nine_slice_hp_border,bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,1,C_YELLOW);
			if m1_pressed { 
				obj_mapgen.enable_event = false;
				obj_mapgen.browsing_card_shop = false;
				o_game.camera.zoom = .15;
			}
		}
	}
	

	var offset = 22;
	init_card_border_step(0);
	var card_height_ = 210;
	var offset_add = card_height_;
	//scroll up or down 
	var arrow_offset = 80;
	//down


	arrow_offset *= 2;
	//up

	view_deck_or_discard_card_yoffset = 0;
	var card_width_ = 160;

	var y_ = -camera.height*.05+view_deck_or_discard_card_yoffset+camera.y;
	var hovering_card = false;
	var save_x = noone;
	var save_y = noone;

if !shop_card_select.enable{ 
	
	var len = array_length(obj_mapgen.standing_on.room_struct.shop_array)
	for (var i = 0; i < len;i++){ 
		var card_ = card_struct(  obj_mapgen.standing_on.room_struct.shop_array[@ i] );
			if  obj_mapgen.standing_on.room_struct.shop_deal_index = i { 
				card_.on_sale = true;	
			}else{ 
				card_.on_sale = false;	
			}
			
				
			var div_amount = camera.width div card_width_ ;
			
			var i_mult = i mod div_amount;
			
		if len < 6  {
			var total_dis = len * card_width_;
			var center_ = camera.width*.2*border_scale;
			var diff = total_dis - center_;
			var i_add = (i *card_width_) - total_dis/2;
			var x_ =  center_ + i_add;
		}else{
			var x_ =  -camera.width*.5+card_width_*.5+card_width_*i_mult+camera.x;
		}
			
			if i / div_amount = floor(i/div_amount) and i > 1{
				y_ += card_height_;
			}
			
			draw_card_matrix_selectable(card_,x_,y_,1,1,0,0,0,i,false,0,false,true,false);
			
			if hovering_card = false  and is_hovering_over_card != noone{
				save_x = x_;
				save_y = y_;
				hovering_card = true;
			}
	}
	
}else{
	
	var amount_ = 1;
	var xx = 0;
	var yy = 0;
	draw_card_matrix(shop_card_select.struct, xx,yy, 1.5,1.5,0, 0, 0 ,  0,true,0,0,true,false);
	var new_struct =  card_struct(shop_card_select.struct.upgrades_to_enum);
	
	var scr_info = scribble("[fa_center][fa_middle][scale, 2]THIS LOOKS GOOD").wrap(200);

	
	if obj_mapgen.on_sale_card_index = shop_card_select.i  { 
	
		shop_card_select.struct.price = round(shop_card_select.struct.price_original*.5);
		scr_info = scribble("[fa_center][fa_middle][scale, 2]OOOHH! THIS ONE IS [c_lime]-50%[c_white] OFF").wrap(200);
	}


	var scr = scribble("[fa_center][scale, 2][c_lime]YES[\c_lime]\n[c_yellow]-"+string(shop_card_select.struct.price)+"[c_white] [s_icon_gold, 0, 0]")
	var scr_back = scribble("[fa_center][scale, 2][c_gum]NO");
	
	var scr_remove = scribble("[fa_center][scale, 2][c_yellow]BUY");


	var x_ = camera.width*.33;
	var y_ = camera.height*.23;
	var	ok_bbox = scr.get_bbox(x_,y_);
	var	no_bbox = scr_back.get_bbox(x_,-y_);
	var remove_bbox = scr_remove.get_bbox(x_,0);
	var info_bbox = scr_info.get_bbox(-x_,0);
	
	
	var xsize = 25;
	var ysize = 10;

	nine_slice(s_nine_slice_default,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,c_white);
	nine_slice(s_nine_slice_hp_border,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,C_GRAY);

	nine_slice(s_nine_slice_default,info_bbox.x0-xsize,info_bbox.y0-ysize,info_bbox.x3+xsize,info_bbox.y3+ysize,1,c_white);
	nine_slice(s_nine_slice_hp_border,info_bbox.x0-xsize,info_bbox.y0-ysize,info_bbox.x3+xsize,info_bbox.y3+ysize,1,C_GRAY);

	nine_slice(s_nine_slice_default,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,c_white);
	if boon_collision(ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,MX,MY){
	nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_RAINBOW);

	var scr = scribble("[fa_center][scale, 2][c_lime]YES[\c_lime]\n[c_yellow]-"+string(shop_card_select.struct.price)+"[c_white] [s_icon_gold, 0, 0]")
	
	if m1_pressed { 
		
		if player.gold >= shop_card_select.struct.price{ 				
					
			audio_play(sfx_draw_card_2);
			audio_play(sfx_bought_card);
					
			add_card_for_run(deck, shop_card_select.struct.enum_);
			//ds_list_delete(card_shop, shop_card_select.i);
			array_delete(obj_mapgen.standing_on.room_struct.shop_array, shop_card_select.i,1);
			
			player.gold -= shop_card_select.struct.price;
			
			o_game.camera.zoom = .1;	
			o_game.shop_card_select.enable = false;
			
			if obj_mapgen.standing_on.room_struct.shop_deal_index = shop_card_select.i {
				obj_mapgen.standing_on.room_struct.shop_deal_index = noone;
			}
			
		}
		
	}
	
	
	}else{
	nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_LIME);
	}
	nine_slice(s_nine_slice_default,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,c_white);
	
	
	if boon_collision(no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,MX,MY){
	var scr_back = scribble("[fa_center][scale, 2][c_yellow]NO");	
	if m1_pressed { 
		m1_pressed = false;
		shop_card_select.enable = false;
		camera.zoom = 0;
	
	}
	nine_slice(s_nine_slice_hp_border,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,C_YELLOW);
	}else{
	nine_slice(s_nine_slice_hp_border,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,C_GUM);
	}

	
	scr.draw(x_,y_);
	scr_back.draw(x_,-y_);
	scr_remove.draw(x_,0);	
	scr_info.draw(-x_,0);	
//	draw_card_matrix(upgrade_card_select.struct, camera.width*.25,0, 1,1,0, 0, 0 ,  0,true,0,0,true,false);
//	draw_card_matrix(upgrade_card_select.struct, 0,0, 1,1,0, 0, 0 ,  1,true,0,0,true,false);
//	draw_card_matrix(upgrade_card_select.struct, -camera.width*.25,0, 1,1,0, 0, 0 ,  2,true,0,0,true,false);			
	
}



	if save_x != noone and is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
	

			draw_card_matrix_selectable(is_hovering_over_card, save_x,save_y-global.shop_yoffset, 2,2,0, 0, 0 ,  save_hovered_i,true,0,0,true,false);
			if m1_pressed {  
			//	shop_card_select
				if  player.gold >= is_hovering_over_card.cost { 
						camera.zoom = 2;
						shop_card_select.x = save_x;
						shop_card_select.y = save_y;
						shop_card_select.i = save_hovered_i;
						shop_card_select.struct = is_hovering_over_card;
						shop_card_select.enable = true;
					
				}else{
					cannot_upgrade_card_timer = 0;
				}
			}
		}
	
	
	if cannot_upgrade_card_timer < SEC*1.5 { 
		if cannot_upgrade_card_timer div 2 { 
			
			var yy = 0 ;
			if cannot_upgrade_card_timer <= SEC*1.5 { 
				yy = easings(e_ease.easeoutexpo,50,-50,SEC*1.5,cannot_upgrade_card_timer);
			}
				scribble("[c_gum][scale, 2][fa_center][outline_boon]NOT ENOUGH [][s_icon_gold, 1 ,0]").draw(0,-camera.height*.45+yy);
	
		}
		cannot_upgrade_card_timer++;	
	}
			scribble("[s_icon_gold, 1, 0][outline_boon][scale,2] "+string(player.gold)).draw(camera.width*.38,-camera.height*.45);

//	draw_deck();	
}

function draw_tokens_in_shop(){

	
	//player.gold = 250;
	var can_upgrade_card = false;
	
	if o_game.game_state = e_gamestate.choose_path { 

		draw_sprite_ext(s_pixel,0,-camera.width*10,-camera.height*10,room_width*10,room_height*10,0,C_DARK,1);
		can_upgrade_card = true;
		var scr = scribble("[scale, 2][c_yellow]MAP");
		var x_ = -camera.width*.45;
		var y_ = -camera.height*.45;
		
		var bbox = scr.get_bbox(x_,y_);
		var xadd = 30;
		var yadd = 20;
		nine_slice(s_nine_slice_hp_border,bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,1,c_white);
		scr.draw(x_,y_);
	
		if boon_collision(bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,MX,MY) {
			nine_slice(s_nine_slice_hp_border,bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,1,C_YELLOW);
			if m1_pressed { 
				obj_mapgen.enable_event = false;
				obj_mapgen.browsing_card_shop = false;
				o_game.camera.zoom = .15;
				exit;
			}
		}
	}
	

	var offset = 22;
	init_card_border_step(0);
	var card_height_ = 210;
	var offset_add = card_height_;
	//scroll up or down 
	var arrow_offset = 80;
	//down


	arrow_offset *= 2;
	//up
	

	
	view_deck_or_discard_card_yoffset = 0;
	var card_width_ = 160;

	var y_ = -camera.height*.05+view_deck_or_discard_card_yoffset+camera.y;
	var hovering_card = false;
	var save_x = noone;
	var save_y = noone;
if !shop_card_select.enable{ 
	scribble("[fa_center][scale, 2]UPGRADES [c_lime]ALL FUTURE VERSIONS[c_white]\nOF THIS TOKEN FOR THE REST OF THE [c_yellow]RUN[]").draw(0,-o_game.camera.height*0.4);
	scribble("[fa_center][scale, 2]UPGRADING [c_gum]DESTROYS[c_white] THE SHOP").draw(0,o_game.camera.height*0.3);

	var len = array_length(obj_mapgen.standing_on.room_struct.shop_array);
	for (var i = 0; i < len;i++){ 
		var card_ = token_struct(  obj_mapgen.standing_on.room_struct.shop_array[@ i] );
		
			if  obj_mapgen.standing_on.room_struct.shop_deal_index = i { 
				card_.on_sale = true;	
			}else{ 
				card_.on_sale = false;	
			}
			
				
			var div_amount = camera.width div card_width_ ;
			
			var i_mult = i mod div_amount;
			
			var total_dis = len * card_width_;
			var center_ = 0;
			var diff = total_dis - center_;
			var i_add = (i *card_width_) - total_dis/2;
			var targetx_ =  center_ + i_add;
			
			
			if len < 8  {
				var total_dis = len * card_width_;
				var center_ = camera.width*.2*border_scale;
				var diff = total_dis - center_;
				var i_add = (i *card_width_) - total_dis/2;
				var x_ =  center_ + i_add;
			}else{
				var x_ =  -camera.width*.5+card_width_*.5+card_width_*i_mult+camera.x;
			}
			
			if i / div_amount = floor(i/div_amount) and i > 1{
				y_ += card_height_;
			}
			draw_card_matrix_selectable(card_,x_,y_,1,1,0,0,0,i,false,0,false,true,false);
			
			if hovering_card = false  and is_hovering_over_card != noone{
				save_x = x_;
				save_y = y_;
				hovering_card = true;
			}
	}
	
}else{
	var amount_ = 1;
	var xx = 0;
	var yy = 0;
	draw_card_matrix(shop_card_select.struct, xx,yy, 1.5,1.5,0, 0, 0 ,  0,true,0,0,true,false);
	

	var price_for_hp = shop_card_select.struct.cost_to_increse_life;
	var price_for_lvl_up = shop_card_select.struct.cost_to_increase_amount;
	

	var scr = scribble("[fa_center][scale, 2][c_yellow][fa_middle]YES[\c_lime]\n[c_yellow]-"+string(price_for_hp)+"[c_white] [s_icon_gold, 0, 0]")
	var scr_back = scribble("[fa_center][scale, 2][fa_middle][c_gum]NO");
	
	var scr_remove = scribble("[fa_center][scale, 2][fa_middle]+1 [s_card_heart_small]\n[]LASTS 1 MORE TURN");


	var x_ = camera.width*.33;
	var y_ = camera.height*.23;
	var	ok_bbox = scr.get_bbox(x_,y_);
	var	no_bbox = scr_back.get_bbox(x_,-y_);
	var remove_bbox = scr_remove.get_bbox(x_,0);

	
	var xsize = 25;
	var ysize = 10;

	nine_slice(s_nine_slice_default,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,c_white);
	nine_slice(s_nine_slice_hp_border,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,C_GRAY);

	nine_slice(s_nine_slice_default,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,c_white);
	
	if boon_collision(ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,MX,MY){
		nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_LIME);

	var scr = scribble("[fa_center][scale, 2][c_lime][fa_middle]YES[\c_lime]\n[c_yellow]-"+string(price_for_hp)+"[c_white] [s_icon_gold, 0, 0]")
	
	if m1_pressed { 
		//bought hp upgrade
		if player.gold >= price_for_hp{ 	
			player.gold -= price_for_hp;
			
			
			o_game.camera.zoom = .1;	
			o_game.shop_card_select.enable = false;
			
		
			var enum_ = shop_card_select.struct.enum_;
			player.token_stats[@ enum_].turns_to_live++;
			
			
			with obj_mapgen  {
				event_struct = noone;
				enable_event = false;
				standing_on.type = e_room_type.empty_room;
				var this_room = ds_list_find_value(room_list, standing_on.i)				
				this_room.type = e_room_type.empty_room;
				
			}
			
		}
	}
	
	
	}else{
	nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_YELLOW);
	}
	nine_slice(s_nine_slice_default,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,c_white);
	
	
	if boon_collision(no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,MX,MY){
	var scr_back = scribble("[fa_center][scale, 2][fa_middle][c_yellow]NO");	
	if m1_pressed { 
		m1_pressed = false;
		shop_card_select.enable = false;
		camera.zoom = 0;
	
	}
	nine_slice(s_nine_slice_hp_border,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,C_YELLOW);
	}else{
	nine_slice(s_nine_slice_hp_border,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,C_GUM);
	}

	
	scr.draw(x_,y_);
	scr_back.draw(x_,-y_);
	scr_remove.draw(x_,0);	
	
if instance_exists(o_game) and shop_card_select.struct.amount1_per_level_up > 0{ 
	
	
	var enum_ = shop_card_select.struct.enum_;
	player.token_stats[@ enum_].amount = shop_card_select.struct.original_amount;
	

	
	
	var scr = scribble("[fa_center][scale, 2][c_yellow][fa_middle]YES[\c_lime]\n[c_yellow]-"+string(price_for_lvl_up)+"[c_white] [s_icon_gold, 0, 0]")

	var scr_remove = scribble("[fa_center][scale, 2][fa_middle][wave][rainbow]LEVEL UP [s_ui_arrow]\n[]TOUCH HERE TO SEE [c_yellow]CHANGE");


	var x_ = -camera.width*.33;
	var y_ = camera.height*.23;
	var	ok_bbox = scr.get_bbox(x_,y_);
	var remove_bbox = scr_remove.get_bbox(x_,0);

	
	var xsize = 25;
	var ysize = 10;


	nine_slice(s_nine_slice_default,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,c_white);
	nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_YELLOW);

	if boon_collision(ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,MX,MY){
		nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_LIME);

	//level up yes button
	var scr = scribble("[fa_center][scale, 2][c_lime][fa_middle]YES[\c_lime]\n[c_yellow]-"+string(price_for_lvl_up)+"[c_white] [s_icon_gold, 0, 0]")
	
	if m1_pressed { 
			//bought hp upgrade
			if player.gold >= price_for_lvl_up{ 	
				player.gold -= price_for_lvl_up;
			
			
				o_game.camera.zoom = .1;	
				o_game.shop_card_select.enable = false;
		
				var enum_ = shop_card_select.struct.enum_;
				player.token_stats[@ enum_].amount++;
				
				
			upgrade_card_select.enable = false;
			
			with obj_mapgen  {
				event_struct = noone;
				enable_event = false;
				standing_on.type = e_room_type.empty_room;
				var this_room = ds_list_find_value(room_list, standing_on.i)				
				this_room.type = e_room_type.empty_room;
				
			}
			o_game.camera.zoom = .1;
				
				exit; //don't go back up 
		}
	}
}
	
	
	if boon_collision(remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,MX,MY) {
		
		var scr_remove = scribble("[fa_center][fa_middle][scale, 2][c_yellow]SNEAK PEEK");	
		var remove_bbox = scr_remove.get_bbox(x_,0);
		player.token_stats[@ enum_].amount++;
	
		nine_slice(s_nine_slice_default,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,c_white);
		nine_slice(s_nine_slice_hp_border,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,C_YELLOW);
	}else{
		nine_slice(s_nine_slice_default,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,c_white);
		nine_slice(s_nine_slice_hp_border,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,C_RAINBOW);

	}

	
	scr.draw(x_,y_);
	scr_remove.draw(x_,0);	
	
}

//	draw_card_matrix(upgrade_card_select.struct, camera.width*.25,0, 1,1,0, 0, 0 ,  0,true,0,0,true,false);
//	draw_card_matrix(upgrade_card_select.struct, 0,0, 1,1,0, 0, 0 ,  1,true,0,0,true,false);
//	draw_card_matrix(upgrade_card_select.struct, -camera.width*.25,0, 1,1,0, 0, 0 ,  2,true,0,0,true,false);			
	
}



	if save_x != noone and is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
		
			draw_card_matrix_selectable(is_hovering_over_card, save_x,save_y-global.shop_yoffset, 2,2,0, 0, 0 ,  save_hovered_i,true,0,0,true,false);
			if m1_pressed {  
			//	shop_card_select
						camera.zoom = 2;
						shop_card_select.x = save_x;
						shop_card_select.y = save_y;
						shop_card_select.i = save_hovered_i;
						shop_card_select.struct = is_hovering_over_card;
						shop_card_select.enable = true;
						var enum_ = shop_card_select.struct.enum_;
						shop_card_select.struct.original_amount = player.token_stats[@ enum_].amount;
	
		
				
			}
		}
	
	
	if cannot_upgrade_card_timer < SEC*1.5 { 
		if cannot_upgrade_card_timer div 2 { 
			
			var yy = 0 ;
			if cannot_upgrade_card_timer <= SEC*1.5 { 
				yy = easings(e_ease.easeoutexpo,50,-50,SEC*1.5,cannot_upgrade_card_timer);
			}
				scribble("[c_gum][scale, 2][fa_center][outline_boon]NOT ENOUGH [][s_icon_gold, 1 ,0]").draw(0,-camera.height*.45+yy);
	
		}
		cannot_upgrade_card_timer++;	
	}
			scribble("[s_icon_gold, 1, 0][outline_boon][scale,2] "+string(player.gold)).draw(camera.width*.38,-camera.height*.45);

//	draw_deck();	
}


function draw_cards_in_library_to_remove(){
	draw_sprite_ext(s_pixel,0,-camera.width*10,-camera.height*10,room_width*10,room_height*10,0,C_DARK,1);
	
	if o_game.game_state = e_gamestate.choose_path{
		
		var scr = scribble("[scale, 2][c_yellow]MAP");
		var x_ = -camera.width*.45;
		var y_ = -camera.height*.45;
		
		var bbox = scr.get_bbox(x_,y_);
		var xadd = 30;
		var yadd = 20;
		nine_slice(s_nine_slice_hp_border,bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,1,c_white);
		scr.draw(x_,y_);
	
		if boon_collision(bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,MX,MY) {
			nine_slice(s_nine_slice_hp_border,bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,1,C_YELLOW);
			if m1_pressed { 
			obj_mapgen.selecting_card_upgrade = false;	
					
			obj_mapgen.enable_event = false;
			obj_mapgen.browsing_card_shop = false;
			o_game.camera.zoom = 0.1;
			obj_mapgen.event_struct = noone;
			}
		}
	}
	var offset = 22;
	init_card_border_step(0);
	var card_height_ = 210;
	var offset_add = card_height_;
	//scroll up or down 
	var arrow_offset = 80;
	//down
	
	if mouse_wheel_up() { 
		view_deck_or_discard_card_yoffset += offset_add;
		m1_pressed = false;
		deck_is_not_drawn_in_order_warning = false;
	}

	arrow_offset *= 2;
	//up
	
	if mouse_wheel_down() { 
		view_deck_or_discard_card_yoffset -= offset_add;
		deck_is_not_drawn_in_order_warning = false;
	}
	
	view_deck_or_discard_card_yoffset = min(view_deck_or_discard_card_yoffset,0);
	var card_width_ = 160;

	var y_ = -camera.height*.15+view_deck_or_discard_card_yoffset+camera.y;
	var hovering_card = false;
	var save_x = noone;
	var save_y = noone;

if !remove_card_select.enable{	
	for (var i = 0; i < ds_list_size(all_added_cards);i++){ 
		var card_ =  ds_list_find_value(all_added_cards,i);
			var div_amount = camera.width div card_width_ ;
			
			var i_mult = i mod div_amount;
			var x_ = -camera.width*.5+card_width_*.5+card_width_*i_mult+camera.x;
			if i / div_amount = floor(i/div_amount) and i > 1{
				y_ += card_height_;
			}
		
			draw_card_matrix_selectable(card_,x_,y_,1,1,0,0,0,i,false,0,false,true,false);
			
			if hovering_card = false  and is_hovering_over_card != noone{
				save_x = x_;
				save_y = y_;
				hovering_card = true;
			}
	}
}else{
	
	var amount_ = 1;
	var xx = random_range(-amount_,amount_);
	var yy = random_range(-amount_,amount_);
	
	draw_card_matrix(remove_card_select.struct, xx,yy, 1.5,1.5,0, 0, 0 ,  0,true,0,0,true,false);
	var new_struct =  card_struct(remove_card_select.struct.upgrades_to_enum);
//	draw_card_matrix(new_struct, camera.width*.2,0, 1.5,1.5,0, 0, 0 ,  0,true,0,0,true,false);
//	draw_sprite_ext(s_arrow,current_time*0.01,0,0,2,2,90,C_GUM,1);

	var scr = scribble("[fa_center][scale, 2][c_lime]YES[\c_lime]\n[c_yellow]-"+string(player.card_removal_price)+"[c_white] [s_icon_gold, 0, 0]")
	var scr_back = scribble("[fa_center][scale, 2][c_gum]NO");
	
	var scr_remove = scribble("[fa_center][scale, 2][c_yellow]REMOVE");

	var scr_info = scribble("[fa_center][fa_middle][scale, 2]REMOVAL COSTS [c_yellow]+25[][scale, 2] [s_icon_gold, 0, 0] MORE NEXT TIME").wrap(200);


	var x_ = camera.width*.33;
	var y_ = camera.height*.23;
	var	ok_bbox = scr.get_bbox(x_,y_);
	var	no_bbox = scr_back.get_bbox(x_,-y_);
	var remove_bbox = scr_remove.get_bbox(x_,0);
	var info_bbox = scr_info.get_bbox(-x_,0);
	
	
	var xsize = 25;
	var ysize = 10;

	nine_slice(s_nine_slice_default,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,c_white);
	nine_slice(s_nine_slice_hp_border,remove_bbox.x0-xsize,remove_bbox.y0-ysize,remove_bbox.x3+xsize,remove_bbox.y3+ysize,1,C_GRAY);

	nine_slice(s_nine_slice_default,info_bbox.x0-xsize,info_bbox.y0-ysize,info_bbox.x3+xsize,info_bbox.y3+ysize,1,c_white);
	nine_slice(s_nine_slice_hp_border,info_bbox.x0-xsize,info_bbox.y0-ysize,info_bbox.x3+xsize,info_bbox.y3+ysize,1,C_GRAY);

	nine_slice(s_nine_slice_default,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,c_white);
	if boon_collision(ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,MX,MY){
	nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_RAINBOW);

	var scr = scribble("[fa_center][scale, 2][rainbow]YES[][scale, 2]\n[c_yellow]-"+string(player.card_removal_price)+"[c_white] [s_icon_gold, 0, 0]")
	
	if m1_pressed { 
		camera.zoom = 0;
		var find_this_enum = remove_card_select.struct.enum_
		var found_card = false;
		var found_card_i = noone;
		var found_card_list = noone;
		
		
		var list = hand;
		var len = ds_list_size(list);
		for (var i=0; i < len;i++){
			var card_ = ds_list_find_value(list, i)
			
			if found_card = false and card_.enum_ = find_this_enum{ 
				found_card = true;
				found_card_list = list;
				found_card_i = i;
			}
		}
		
		var list = deck;
		var len = ds_list_size(list);
		for (var i=0; i < len;i++){
			var card_ = ds_list_find_value(list, i)
			
			if found_card = false and card_.enum_ = find_this_enum{ 
				found_card = true;
				found_card_list = list;
				found_card_i = i;
			}
		}

		var list = discard;
		var len = ds_list_size(list);
		for (var i=0; i < len;i++){
			var card_ = ds_list_find_value(list, i)
			
			if found_card = false and card_.enum_ = find_this_enum{ 
				found_card = true;
				found_card_list = list;
				found_card_i = i;
			}
		}
		
		if found_card = false{ 
			
			debug("ERROR COULD NOT FIND THE CARD!")	
		}else{
			
			ds_list_delete(all_added_cards,remove_card_select.i);
			ds_list_delete(found_card_list,found_card_i);
			
			remove_card_select.enable = false;
			
			with obj_mapgen  {
				event_struct = noone;
				enable_event = false;
				standing_on.type = e_room_type.empty_room;
				var this_room = ds_list_find_value(room_list, standing_on.i)				
				this_room.type = e_room_type.empty_room;
				
			}
			player.card_removal_price += 25;
			o_game.camera.zoom = .1;
		}
		
		
	}
	
	
	}else{
	nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_LIME);
	}
	nine_slice(s_nine_slice_default,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,c_white);
	
	
	if boon_collision(no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,MX,MY){
	var scr_back = scribble("[fa_center][scale, 2][c_yellow]NO");	
	if m1_pressed { 
		m1_pressed = false;
		remove_card_select.enable = false;
		camera.zoom = 0;
	
	}
	nine_slice(s_nine_slice_hp_border,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,C_YELLOW);
	}else{
	nine_slice(s_nine_slice_hp_border,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,C_GUM);
	}

	
	scr.draw(x_,y_);
	scr_back.draw(x_,-y_);
	scr_remove.draw(x_,0);	
	scr_info.draw(-x_,0);	
//	draw_card_matrix(upgrade_card_select.struct, camera.width*.25,0, 1,1,0, 0, 0 ,  0,true,0,0,true,false);
//	draw_card_matrix(upgrade_card_select.struct, 0,0, 1,1,0, 0, 0 ,  1,true,0,0,true,false);
//	draw_card_matrix(upgrade_card_select.struct, -camera.width*.25,0, 1,1,0, 0, 0 ,  2,true,0,0,true,false);			
	
}


	if   save_x != noone and is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
		
			draw_card_matrix_selectable(is_hovering_over_card, save_x,save_y-global.shop_yoffset, 2,2,0, 0, 0 ,  save_hovered_i,true,0,0,true,false);
			if m1_pressed { 
					camera.zoom = 3;
					remove_card_select.x = save_x;
					remove_card_select.y = save_y;
					remove_card_select.i = save_hovered_i;
					remove_card_select.struct = is_hovering_over_card;
					remove_card_select.enable = true;
			}
	}
//	draw_deck();	
}



function draw_cards_in_library(){
	var can_upgrade_card = false;
	if o_game.game_state = e_gamestate.choose_path and obj_mapgen.selecting_card_upgrade{ 

		draw_sprite_ext(s_pixel,0,-camera.width*10,-camera.height*20,room_width*10,room_height*10,0,C_DARK,1);
		
		can_upgrade_card = true;
		
		var scr = scribble("[scale, 2][c_yellow]MAP");
		var x_ = -camera.width*.45;
		var y_ = -camera.height*.45;
		
		var bbox = scr.get_bbox(x_,y_);
		var xadd = 30;
		var yadd = 20;
		nine_slice(s_nine_slice_hp_border,bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,1,c_white);
		scr.draw(x_,y_);


	
		if boon_collision(bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,MX,MY) {
			nine_slice(s_nine_slice_hp_border,bbox.x0-xadd,bbox.y0-yadd,bbox.x3+xadd,bbox.y3+yadd,1,C_YELLOW);
			if m1_pressed { 
			camera.zoom = .1
			obj_mapgen.selecting_card_upgrade = false;	
			}
		}
	}
	var offset = 22;
	init_card_border_step(0);
	var card_height_ = 210;
	var offset_add = card_height_;
	//scroll up or down 
	var arrow_offset = 80;
	//down
	
	if mouse_wheel_up() { 
		view_deck_or_discard_card_yoffset += offset_add;
		m1_pressed = false;
		deck_is_not_drawn_in_order_warning = false;
	}

	arrow_offset *= 2;
	//up
	
	if mouse_wheel_down() { 
		view_deck_or_discard_card_yoffset -= offset_add;
		deck_is_not_drawn_in_order_warning = false;
	}
	
	view_deck_or_discard_card_yoffset = min(view_deck_or_discard_card_yoffset,0);
	var card_width_ = 160;

	var y_ = -camera.height*.15+view_deck_or_discard_card_yoffset+camera.y;
	var hovering_card = false;
	var save_x = noone;
	var save_y = noone;
	
	

if !upgrade_card_select.enable{	
	for (var i = 0; i < ds_list_size(all_added_cards);i++){ 
		var card_ = ds_list_find_value(all_added_cards,i);
			var div_amount = camera.width div card_width_ ;
			
			var i_mult = i mod div_amount;
			var x_ = -camera.width*.5+card_width_*.5+card_width_*i_mult+camera.x;
			if i / div_amount = floor(i/div_amount) and i > 1{
				y_ += card_height_;
			}
			draw_card_matrix_selectable(card_,x_,y_,1,1,0,0,0,i,false,0,false,true,false);
			
			if hovering_card = false  and is_hovering_over_card != noone{
				save_x = x_;
				save_y = y_;
				hovering_card = true;
			}
	}
}else{
	
	
			
	draw_card_matrix(upgrade_card_select.struct, -camera.width*.2  ,0, 1.5,1.5,0, 0, 0 , 0);
	var new_struct =  card_struct(upgrade_card_select.struct.upgrades_to_enum);
	draw_card_matrix(new_struct, camera.width*.2,0, 1.5,1.5,0, 0, 0 ,  0,true,0,0,true,false);
	draw_sprite_ext(s_arrow,current_time*0.01,0,0,2,2,90,C_GUM,1);

	var scr = scribble("[fa_center][scale, 2][c_lime]YES")
	var scr_back = scribble("[fa_center][scale, 2][c_gum]NO");
	var x_ = camera.width*.43;
	var y_ = camera.height*.23;
	var	ok_bbox = scr.get_bbox(x_,y_);
	var	no_bbox = scr.get_bbox(x_,-y_);
	var xsize = 25;
	var ysize = 10;
	
	nine_slice(s_nine_slice_default,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,c_white);
	if boon_collision(ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,MX,MY){
	nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_RAINBOW);
	var scr = scribble("[fa_center][scale, 2][rainbow][wave]YES")
	
	if m1_pressed { 
		
			
		var find_this_enum = upgrade_card_select.struct.enum_
		var found_card = false;
		var found_card_i = noone;
		var found_card_list = noone;
		
		
		var list = hand;
		var len = ds_list_size(list);
		for (var i=0; i < len;i++){
			var card_ = ds_list_find_value(list, i)
			
			if found_card = false and card_.enum_ = find_this_enum{ 
				found_card = true;
				found_card_list = list;
				found_card_i = i;
			}
		}
		
		var list = deck;
		var len = ds_list_size(list);
		for (var i=0; i < len;i++){
			var card_ = ds_list_find_value(list, i)
			
			if found_card = false and card_.enum_ = find_this_enum{ 
				found_card = true;
				found_card_list = list;
				found_card_i = i;
			}
		}

		var list = discard;
		var len = ds_list_size(list);
		for (var i=0; i < len;i++){
			var card_ = ds_list_find_value(list, i)
			
			if found_card = false and card_.enum_ = find_this_enum{ 
				found_card = true;
				found_card_list = list;
				found_card_i = i;
			}
		}
		
		if found_card = false{ 
			debug("ERROR COULD NOT FIND THE CARD!")	
		}else{
			
			ds_list_delete(all_added_cards,upgrade_card_select.i);
			ds_list_delete(found_card_list,found_card_i);
			add_card_for_run(found_card_list,new_struct.enum_);
			
			upgrade_card_select.enable = false;
			
			with obj_mapgen  {
				event_struct = noone;
				enable_event = false;
				standing_on.type = e_room_type.empty_room;
				var this_room = ds_list_find_value(room_list, standing_on.i)				
				this_room.type = e_room_type.empty_room;		
			}
			o_game.camera.zoom = .1;
		}
	}
	
	
	}else{
	nine_slice(s_nine_slice_hp_border,ok_bbox.x0-xsize,ok_bbox.y0-ysize,ok_bbox.x3+xsize,ok_bbox.y3+ysize,1,C_LIME);
	}
	nine_slice(s_nine_slice_default,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,c_white);
	
	
	if boon_collision(no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,MX,MY){
	var scr_back = scribble("[fa_center][scale, 2][c_yellow]NO");	
	if m1_pressed { 
		m1_pressed = false;
		upgrade_card_select.enable = false;
		o_game.camera.zoom = .1;
		
	}
	nine_slice(s_nine_slice_hp_border,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,C_YELLOW);
	}else{
	nine_slice(s_nine_slice_hp_border,no_bbox.x0-xsize,no_bbox.y0-ysize,no_bbox.x3+xsize,no_bbox.y3+ysize,1,C_GUM);
	}

	
	scr.draw(x_,y_);
	scr_back.draw(x_,-y_);
	


//	draw_card_matrix(upgrade_card_select.struct, camera.width*.25,0, 1,1,0, 0, 0 ,  0,true,0,0,true,false);
//	draw_card_matrix(upgrade_card_select.struct, 0,0, 1,1,0, 0, 0 ,  1,true,0,0,true,false);
//	draw_card_matrix(upgrade_card_select.struct, -camera.width*.25,0, 1,1,0, 0, 0 ,  2,true,0,0,true,false);
					

			
	
}
	if cannot_upgrade_card_timer < SEC { 
		if cannot_upgrade_card_timer div 2 { 
			
			var yy = 0 ;
			if cannot_upgrade_card_timer <= SEC { 
				yy = easings(e_ease.easeoutexpo,30,-30,SEC,cannot_upgrade_card_timer);
			}
			
				scribble("[c_gum][scale, 2][fa_center]CARD CANNOT BE UPGRADED").draw(0,-camera.height*.45+yy);
		}
		cannot_upgrade_card_timer++;	
	}

	if   save_x != noone and is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
		
			draw_card_matrix_selectable(is_hovering_over_card, save_x,save_y-global.shop_yoffset, 2,2,0, 0, 0 ,  save_hovered_i,true,0,0,true,false);
			if can_upgrade_card and m1_pressed { 
					o_game.camera.zoom = 3;
					if is_hovering_over_card.upgrades_to_enum != noone  { 				
						upgrade_card_select.x = save_x;
						upgrade_card_select.y = save_y;
						upgrade_card_select.i = save_hovered_i;
						upgrade_card_select.struct = is_hovering_over_card;
						upgrade_card_select.enable = true;
					}else{
						cannot_upgrade_card_timer = 0;
					}
			}
	}
//	draw_deck();	
}


function draw_deck() { 
	
	//time looks amazing at SEC*.3 or .4
	if deck_flash_timer <= deck_flash_time{ 
	var _interval = 14;
	var size = 0;
	
	size = easings(e_ease.easeoutelastic,.1,.9,deck_flash_time,deck_flash_timer);
		draw_outline(s_ui_deck,0,deckx,decky,size,size,0,C_DARK,1);
		draw_sprite_ext(s_ui_deck,0,deckx,decky,size,size,0,c_white,1);

	if deck_flash_timer > 0 and deck_flash_timer < SEC*.1  {
		draw_outline_thick(s_ui_deck,0,deckx,decky,size,size,0,c_white,1);
		
		draw_outline(s_ui_deck,0,deckx,decky,size,size,0,C_DARK,1);
		gpu_set_fog(true,c_white,1,1)
		draw_sprite_ext(s_ui_deck,0,deckx,decky,size,size,0,c_white,1);
		gpu_set_fog(false,c_white,1,1)

		//draw_text_outline(10+xoffgame,65+yoffgame,"DECK_"+string(deck_size),c_white);
		deck_color = C_DARK;
	}

	deck_flash_timer++;
	}else{
	
	draw_outline(s_ui_deck,0,deckx,decky,1,1,0,c_black,1);
	draw_sprite_ext(s_ui_deck,0,deckx,decky,1,1,0,c_white,1);
	}
	
}

function draw_cards_in_discard(){	
	var offset = 22;
	init_card_border_step(0);
	var card_height_ = 210;
	var offset_add = card_height_;
	//scroll up or down 
	var arrow_offset = 80;
	//down
	if mouse_wheel_up() { 
		view_deck_or_discard_card_yoffset += offset_add;
		m1_pressed = false;
	}

	arrow_offset *= 2;
	//up
	
	if mouse_wheel_down() { 
		view_deck_or_discard_card_yoffset -= offset_add;
	}
	var card_width_ = 160;

	var y_ = -camera.height*.15+view_deck_or_discard_card_yoffset;
	var hovering_card = false;
	var save_x = noone;
	var save_y = noone;
	
	
	
	
	for (var i = 0; i < ds_list_size(discard);i++){ 
		var card_ = ds_list_find_value(discard,i);
			var div_amount = camera.width div card_width_ ;
			
			var i_mult = i mod div_amount;
			var x_ = -camera.width*.5+card_width_*.5+card_width_*i_mult;
			if i / div_amount = floor(i/div_amount) and i > 1{
				y_ += card_height_;
			}
			
				draw_card_matrix_selectable(card_,x_,y_,1,1,0,0,0,i,false,0,false,true,false);
				
			if hovering_card = false and is_hovering_over_card != noone{
				save_x = x_;
				save_y = y_;
				hovering_card = true;
			}
	}


	if save_x != noone and is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
			draw_card_matrix_selectable(is_hovering_over_card, save_x,save_y-global.shop_yoffset, 2,2,0, 0, 0 ,  save_hovered_i,true,0,0,true,false);
		
	}
			
	/*
	if hover_over_keyword { 
		show_keyword_timer--;
	}else{
		show_keyword_timer = show_keyword_time;
	}
	*/
	
//	draw_sprite_ext(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_white,1)
	
	if boon_collision( discardx-offset,discardy-offset,discardx+offset,discardy+offset,MX,MY){
	draw_outline_thick(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_white,1);
		if m1_pressed { 
			discard_flash_timer = 0;
			m1_pressed = false;
			pause_combat_to_show_discard = false;
		for (var i = 0; i <ds_list_size(active_cards_list);i++){ 
			var card_ = active_cards_list[| i];
				card_.x_ = 0;
				card_.y_ = 0;
		}
		//	pause_combat_to_show_discard = false;		
		}	
	}
		draw_discard();	
}

function draw_discard(){ 
	
	//time looks amazing at SEC*.3 or .4
	discard_flash_time = SEC*.4;
	
	if discard_flash_timer <= discard_flash_time{ 
	
	var _interval = 14;


	discard_xsize = easings(e_ease.easeoutelastic,.1,.9,discard_flash_time,discard_flash_timer);
	draw_outline(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,C_DARK,1)
	draw_sprite_ext(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_white,1)

	if discard_flash_timer > 0 and discard_flash_time < SEC*.2 {
		draw_outline_thick(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_white,1);
		draw_outline(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,C_DARK,1);
		gpu_set_fog(true,c_white,1,1);
		draw_sprite_ext(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_white,1)
		gpu_set_fog(false,c_white,1,1);
		//draw_text_outline(10+xoffgame,65+yoffgame,"DECK_"+string(deck_size),c_white);
		deck_color = C_DARK;
	}
	discard_flash_timer++;
	}else{
	draw_outline(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_black,1);
	draw_sprite_ext(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_white,1)
	}
}
function draw_cards_in_exhaust(){

	
	var offset = 22;
	init_card_border_step(0);
	var card_height_ = 210;
	var offset_add = card_height_;
	//scroll up or down 
	var arrow_offset = 80;
	//down
	if mouse_wheel_up() { 
		view_deck_or_discard_card_yoffset += offset_add;
		m1_pressed = false;
	}

	arrow_offset *= 2;
	//up
	
	if mouse_wheel_down() { 
		view_deck_or_discard_card_yoffset -= offset_add;
	}
	var card_width_ = 160;

	var y_ = -camera.height*.15+view_deck_or_discard_card_yoffset;
	var hovering_card = false;
	var save_x = noone;
	var save_y = noone;
	
	
	
	
	for (var i = 0; i < ds_list_size(exhaust);i++){ 
		var card_ = ds_list_find_value(exhaust,i);
			var div_amount = camera.width div card_width_ ;
			
			var i_mult = i mod div_amount;
			var x_ = -camera.width*.5+card_width_*.5+card_width_*i_mult;
			if i / div_amount = floor(i/div_amount) and i > 1{
				y_ += card_height_;
			}
			
				draw_card_matrix_selectable(card_,x_,y_,1,1,0,0,0,i,false,0,false,true,false);
				
			if hovering_card = false and is_hovering_over_card != noone{
				save_x = x_;
				save_y = y_;
				hovering_card = true;
			}
	}

	
	if save_x != noone and is_hovering_over_card != noone and save_hovered_x_position != undefined and save_hovered_i != noone{ 
			draw_card_matrix_selectable(is_hovering_over_card, save_x,save_y-global.shop_yoffset, 2,2,0, 0, 0 ,  save_hovered_i,true,0,0,true,false);
		
	}
			
	/*
	if hover_over_keyword { 
		show_keyword_timer--;
	}else{
		show_keyword_timer = show_keyword_time;
	}
	*/
	
//	draw_sprite_ext(s_discard,0,discardx,discardy,discard_xsize,discard_xsize,0,c_white,1)

if boon_collision( exhaustx-offset,exhausty-offset,exhaustx+offset,exhausty+offset,MX,MY){
		draw_outline_thick(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size ,0,c_white,1);

		if m1_pressed { 
			exhaust_flash_timer = 0;
			m1_pressed = false;
			pause_combat_to_show_discard = false;
			pause_combat_to_show_exhaust = false;
		for (var i = 0; i < ds_list_size(active_cards_list)-1;i++){ 
			var card_ = active_cards_list[| i];
				card_.x_ = 0;
				card_.y_ = 0;
		
		}
			
		//	pause_combat_to_show_discard = false;
			
		}	
	}
		
		draw_exhast();	
}

function draw_exhast(){ 
	

	if exhaust_flash_timer <= exhaust_flash_timer{ 
	
	var _interval = 14;

	exhaust_size = easings(e_ease.easeoutelastic,.1,.9,exhaust_flash_time,exhaust_flash_timer);
	draw_outline(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size,0,C_DARK,1)
	draw_sprite_ext(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size,0,c_white,1)

	if exhaust_flash_timer > 0 and discard_flash_time < SEC*.2 {
		draw_outline_thick(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size,0,c_white,1);
		draw_outline(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size,0,C_DARK,1);
		gpu_set_fog(true,c_white,1,1);
		draw_sprite_ext(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size,0,c_white,1)
		gpu_set_fog(false,c_white,1,1);
		//draw_text_outline(10+xoffgame,65+yoffgame,"DECK_"+string(deck_size),c_white);
		deck_color = C_DARK;
	}
	exhaust_flash_timer++;
	}else{
	draw_outline(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size,0,c_black,1);
	draw_sprite_ext(s_exhaust,0,exhaustx,exhausty,exhaust_size,exhaust_size,0,c_white,1)
	}
}
