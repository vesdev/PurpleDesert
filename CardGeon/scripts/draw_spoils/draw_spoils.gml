// Script assets have changed for v2.3.0 see


function draw_spoils(){



if !no_discover_effects() exit;

var _x_offset = 78;
var _y_offset = 150;

var _l = camera.width*.5-_x_offset +xoffgame;
var _t = -camera.height*.4;
var _r = camera.width*.5+_x_offset +xoffgame;
var _b = -camera.height*.1;

var len = array_length(hand_over_rewards_array);
if len = 0  { 
	var str = "[fa_center][s_caret]GET THE HECK [c_lime]OUTTA OF HERE";
}else{
	var str = "[fa_center][s_caret]LEAVE [c_yellow]WITHOUT[] THE STUFF";
}

var scr = scribble(str)

var scrx = camera.width*.5-150;
var scry = 0;
var yoffset = 15;
var bbox = scr.get_bbox(scrx,scry);

draw_set_color(c_white);
if no_discover_effects() and boon_collision(bbox.x0,bbox.y0-yoffset, bbox.x3,bbox.y3+yoffset,  MX,MY){

	if m1_pressed  and obj_mapgen.next_game_state_queue = noone{ 
		audio_play(sfx_get_the_heck_outta_here);
		m1_pressed = false;
		//RETURN TO THE MAP
		hand_over_rewards_array = [];
		discover_queue.array = [];
		
		obj_mapgen.go_to_battle = false;
		go_to_next_state(e_gamestate.choose_path);
		reset_combat();		
		exit;
	}
	
	if len != 0 { 
		draw_set_color(c_yellow);
	}else{
		draw_set_color(c_lime);
	}
}

draw_rectangle(bbox.x0 ,bbox.y0-yoffset , bbox.x3,bbox.y3+yoffset ,1)
draw_set_color(c_white);
scr.draw(scrx,scry);

draw_rectangle(_l,_t,_r,_b ,1);

scribble("[rainbow][wave][fa_center]NICE JOB").draw(0 ,_t+10);
																
for (var i = 0; i < len; ++i){ 
	
	var xx = _l+ i *50 +5 ;
	var yy = _t + 50 ;
	var width  =45;
	var height  = 45;
	draw_rectangle(xx, yy, xx+width, yy+width,1)
	var struct = hand_over_rewards_array[@ i];
	
	if boon_collision( xx, yy, xx+width, yy+width, MX,MY) and no_discover_effects(){ 
	
	if m1_pressed { 
		m1_pressed = false;
		
		
		
		switch struct.type {
			case e_spoil_type.gold:	 struct.init_script(struct.amount); 
			array_delete(hand_over_rewards_array,i,1);
			audio_play(sfx_get_coin);
			break;
			case e_spoil_type.stuff:  
			audio_play(sfx_get_stuff);
			add_stuff(struct.stuff_enum);
			array_delete(hand_over_rewards_array,i,1);
			break;
			case e_spoil_type.choose_card: 
			
			audio_play(sfx_card_shuffle);
			struct.init_script();
			break;
			
		}
		
		exit;
	}
	draw_outline(struct.sprite,0,xx+width*.5,yy+height*.5,1,1,0,c_white,1 );	
	draw_status_information = "[fa_center]["+sprite_get_name(struct.sprite)+",0]";
	if struct.amount != false { 
			draw_status_information += struct.title+"\n"+struct.desc(struct.amount);
			}else{
			draw_status_information += struct.title+"\n"+struct.desc();	
		}
	}
	draw_sprite(struct.sprite,0,xx+width*.5,yy+height*.5);

}
player.current_sprite = player.sprite_victory;

if player.z = 0  and player.sprite_image_index = 3 and chance(.25){ 
		player.z_speed = -1.5;	
	}
	player.angle = lerp(player.angle, 0, .2);	
	

}


function draw_keywords(struct,xx,yy) { 

o_game.drawing_keywords = true;

	

var card_width = sprite_get_width(s_card_border)	
keyword_easing_timex = SEC*.75;
keyword_easing_timey = SEC*.75;

	
if keyword_easing_timerx <= keyword_easing_timex { 
keyword_easeing_x = easings(e_ease.easeoutelastic,0,1,keyword_easing_timex,keyword_easing_timerx);
keyword_easing_timerx++;	
	
}


if keyword_easing_timery <= keyword_easing_timey { 
keyword_easeing_y = easings(e_ease.easeoutelastic,0,1,keyword_easing_timey,keyword_easing_timery);
keyword_easing_timery++;	
}

//keyword_easeing_y = 0;
//keyword_easing_timery = 0;
	
	
	var wrap = 150*camera.width*.001;
	var title = struct.title;	
	var xmargin = -10-10*keyword_easeing_x;
	var ymargin =  9+10*keyword_easeing_y;
	
			if is_array(struct.keywords) {
			var len = array_length(struct.keywords);
			//this is in case we have more than one keyword
			var str_height = 0;
			var str_width = 0;
			var y_margin = 10;
			
			for (var i = 0; i <  len; i++){				
				var current_keyword = struct.keywords[@ i];
				
			
			
				
				/*
				
					self.card_enum = card_enum;
					self.card_struct = function(){ return card_struct(card_enum) };
					self.sprite = s_keyword_card;
					self.title = "";
					self.desc = function() { return ""};
				*/
				//figure out how many keywords this has
				var sprite_string = sprite_get_name(current_keyword.sprite );
				
				if current_keyword.card_enum != noone { 
				var card_ = current_keyword.card_struct();
				var title = card_.title;	
				var desc = card_.desc();
				
				var sub_card_keyword = card_.keywords;

				var sub_card_keyword_print = "";
				var len_ = array_length(sub_card_keyword);
				var col = "[c_yellow]";
				switch card_.card_type { 
					case e_card_type.red: col = "[c_gum]";
					break;
					case e_card_type.strat: col = "[c_blue]";
					break;
					case e_card_type.token: col = "[c_lime]";
					break;							
				}
				
				for (var i = 0; i < len_; i++) {
				
				
					sub_card_keyword_print +=  "[c_lime]"+sub_card_keyword[@ i].title+" ["+sprite_get_name(sub_card_keyword[@ i].sprite)+"][]\n"
					
					
				}
				
				//current_keyword.title = current_keyword.card_struct.title;
				//desc = "["+sprite_get_name(current_keyword.sprite)+"] [c_yellow]"+current_keyword.title+"[]\n"+"TEST";
				
				
				desc = col+"["+sprite_get_name(current_keyword.sprite)+"][c_yellow] \n"+title+"\n[]"+sub_card_keyword_print+desc+"\nCOSTS "+string(card_.cost);
				}else{
				var desc = "["+sprite_get_name(current_keyword.sprite)+"] [c_yellow]"+current_keyword.title+"[]\n"+current_keyword.desc();
				}
				
				var i_add = i*50;
				var text = scribble("[fa_center]"+desc)//
				
			
				var x_ = xx ;				
				var y_ = yy +  str_height ;
				
				text.wrap(wrap)
				
				var ww = text.get_width();
				if hand_hover_keyword_left { 
					x_ -= card_width*.25;
				}else{
					x_ += card_width + card_width*.1;
				}
				
				
				var bbox = text.wrap(wrap).get_bbox(x_,y_);
				
				
			
				draw_set_color(c_yellow);	
				//	draw_rectangle(bbox.x1+xmargin,bbox.y1-ymargin,bbox.x2-xmargin,bbox.y2+ymargin,1)
				nine_slice( s_nine_slice_elegant,bbox.x0+xmargin,bbox.y0-ymargin,bbox.x3-xmargin,bbox.y3+ymargin,1,c_white );
				draw_set_color(C_DARK);
				
				
				//draw_rectangle(bbox.x1+xmargin,bbox.y1-ymargin,bbox.x2-xmargin,bbox.y2+ymargin,0)
	
				draw_set_color(c_white);			

				
				text.draw(x_,y_);	
				
				if 	keyword_flash_timer > 0 { 
						keyword_flash_timer--;
						
				gpu_set_fog(true,C_YELLOW,1,1)
				nine_slice( s_nine_slice_elegant,bbox.x0+xmargin,bbox.y0-ymargin,bbox.x3-xmargin,bbox.y3+ymargin,1,c_white );
				gpu_set_fog(false,c_white,1,1)	
				}
				str_width += text.get_width();
				str_height += text.get_height()+y_margin+35;
			}
			}else if struct.keywords != noone{
					var current_keyword = struct.keywords;
					
					
					
				if current_keyword.card_enum != noone { 
	
				
				}
						
				//figure out how many keywords this has
				var sprite_string = sprite_get_name(current_keyword.sprite );
				var desc = "["+sprite_get_name(current_keyword.sprite)+"] [c_yellow]"+current_keyword.title+"[]\n"+current_keyword.desc();
				var i_add = 0;
				var text = scribble("[fa_center]"+desc)//
				
			
				x_ = xx ;				
				y_ = yy  ;
				text.wrap(wrap)
				var ww = text.get_width();
				if hand_hover_keyword_left { 
					x_ -= card_width*.25;
				}else{
					x_ += card_width + card_width*.1;
				}
				
				
				var bbox = text.wrap(wrap).get_bbox(x_,y_);
			
				draw_set_color(c_yellow);	
				//	draw_rectangle(bbox.x1+xmargin,bbox.y1-ymargin,bbox.x2-xmargin,bbox.y2+ymargin,1)
				nine_slice( s_nine_slice_elegant,bbox.x0+xmargin,bbox.y0-ymargin,bbox.x3-xmargin,bbox.y3+ymargin,1,c_white );
				draw_set_color(C_DARK);
				
				
				//draw_rectangle(bbox.x1+xmargin,bbox.y1-ymargin,bbox.x2-xmargin,bbox.y2+ymargin,0)
	
				draw_set_color(c_white);			

				
				text.draw(x_,y_);	
				
				if 	keyword_flash_timer > 0 { 
						keyword_flash_timer--;
						
				gpu_set_fog(true,C_YELLOW,1,1)
				nine_slice( s_nine_slice_elegant,bbox.x0+xmargin,bbox.y0-ymargin,bbox.x3-xmargin,bbox.y3+ymargin,1,c_white );
				gpu_set_fog(false,c_white,1,1)	
				}
			}
}


