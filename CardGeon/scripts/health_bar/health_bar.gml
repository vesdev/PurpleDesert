// Script assets have changed for v2.3.0 see
function draw_health_bar(xx,yy,struct, potential_damage){
	if live_call(xx,yy,struct, potential_damage) return live_result;
	

sprite_set_live(images,1);
var heart_name = images;
draw_set_font(font_health_number);
xx += xoffgame;
yy += yoffgame;

var original_potential_damage = potential_damage;
	potential_damage -= struct.armor;
//	struct.armor = 10;
						
									
	var front_hp_bar_color = C_GUM;
	var front_text_color = C_DARK;
	var back_hp_bar_color = c_white;
	
	if struct.health_bar_hit_timer > 0 { 
		struct.health_bar_hit_timer--;
		var front_text_color = C_DARK;
		if struct.armor <= 0 { 
			front_hp_bar_color = c_white;
			}
		yy += 1;
	}
	if struct.hp_max = 0 { 
		show_debug_message("ERROR")
		exit;
	}
	
	var percent = struct.hp/struct.hp_max;
	percent = clamp(percent,0,1);
	var hp_string = struct.hp;

	if 	struct.delay_health_bar_timer > 0 { 
		struct.delay_health_bar_timer--;
		
	}else{ 
		struct.health_bar_lerp = lerp(struct.health_bar_lerp,percent,.2);
	}

	if potential_damage != 0 { 
		 var percent_new =  divide( (struct.hp-potential_damage) , struct.hp);

		//struct.health_bar_lerp = lerp(struct.health_bar_lerp,percent,.15);
		back_hp_bar_color = C_YELLOW;
		 struct.potential_health_lerp =  lerp(struct.potential_health_lerp, percent_new,.4);
		//if struct.hp <=  struct.hp_max*.3 struct.hp = struct.hp_max;
	}else{
		struct.potential_health_lerp = lerp(struct.potential_health_lerp, 1,.4)	
	}
	struct.potential_health_lerp = clamp(struct.potential_health_lerp,0,1);



	
var back_bar_lerp = struct.health_bar_lerp;
var front_bar_lerp = percent*struct.potential_health_lerp;

		if struct.armor > 0  || struct.armor_destroy_enable{ 
		armor_len = 2;

		}else{
		var armor_len = 1;		
		armor_ui_timer = 0;	
		}

var new_hp = struct.hp-potential_damage;
	if new_hp > 0{ 
	var output_string = string(max(0,round(struct.hp*struct.potential_health_lerp)))+"/"+string(struct.hp_max);
	}else{
	output_string = struct.death_message;	
	}
for (var i = 0; i < armor_len; i++) { 	
	var bar_height = 5;//default 17
	if i >= 1 { 
	//we are in armor territory
	var shield_x_offset = 0;
	var shield_y_offset = 10;
	
	var size = 1;
	var time = SEC*.5;
	var change = 12;
	if current_turn != e_current_turn.player_ { 
		time *= .25;	
		var change = 4;
	}
	
	var color = c_white;
	var angle = 0;

	var text_color = C_ARMOR;
	var back_text_color = c_white;
		front_hp_bar_color = C_BLUE;

		
		
if struct.armor_ui_timer <= time { 
		//angle = easings(e_ease.easeoutexpo,0,1,time,struct.armor_ui_timer);
		size = easings(e_ease.easeoutexpo,0,1,time,struct.armor_ui_timer);
		shield_y_offset = easings(e_ease.easeoutexpo,shield_y_offset+change,-change,time,struct.armor_ui_timer);


	if struct.armor_ui_timer <= SEC*.1{
			back_text_color = c_white;
			text_color = C_DARK;
			front_hp_bar_color = c_white;
	}
		
		
if current_turn != e_current_turn.player_ { 
		angle = 0;
		size = 1;
	}
		struct.armor_ui_timer++;
}
		


		var armor_x = xx-1-17-8;
		var armor_y = yy-2+shield_y_offset-3;
		
	if struct = player { 
		
		armor_x += 150;
		armor_y -= 30;
	}


	if struct.armor_destroy_enable { 
		
			struct.armor_destroy_image_index += .2;
			var sprite = s_status_armor_destroy;
			var number = 		sprite_get_number(sprite);
			draw_outline_thick(s_status_armor_destroy,struct.armor_destroy_image_index,armor_x,armor_y,size,size,angle*360,c_white,1);
			draw_outline(s_status_armor_destroy,struct.armor_destroy_image_index,armor_x,armor_y,size,size,angle*360,C_DARK,1);
			draw_sprite_ext(s_status_armor_destroy,struct.armor_destroy_image_index,armor_x,armor_y,size,size,angle*360,color,1);
			
			if ceil(struct.armor_destroy_image_index) >= number - 1 { 
				struct.armor_destroy_enable = false;
				struct.armor_destroy_image_index = 0;
			}
			back_bar_lerp = 0;
			front_bar_lerp = 0;
			percent = 0;
	}else{
		var sprite_ = s_status_armor;

		var offset = 10; //make it easier to touch the button
		var width_ = sprite_get_width(sprite_)*.5;
		var height_ = sprite_get_height(sprite_)*.5;
		
		var _l = armor_x-width_-offset ;
		var _t = armor_y-height_-offset;
		var _r = armor_x+width_+offset;
		var _b = armor_y+height_+offset;
		//view hitbox draw_rectangle(_l,_t,_r,_b,true);
		
		if struct = player and boon_collision(_l,_t,_r,_b,MX,MY){
			
			var col1 = "c_gum";
			if total_intent_enemy_damage = 0 { 
				col1 = "c_lime";
			}
			draw_status_information = "[s_status_armor][c_yellow]ARMOR[]\n"+struct.title+" IS BLOCKING [c_yellow]"+string(struct.armor)+"["+col1+"] [s_damage_icon] DAMAGE.";
			
				if player.buff.armor_keep.amount = 0 { 
				
					draw_status_information += "\n\n[c_blue]ARMOR[] IS [c_gum]DESTROYED[] ON THE START OF YOUR TURN";
				
				}
			
			draw_outline_thick(sprite_,0,armor_x,armor_y,size,size,angle*360,c_white,1);
			draw_outline(sprite_,0,armor_x,armor_y,size,size,angle*360,C_DARK,1);
			
		}
	
	
	
	var percent = struct.armor/struct.hp_max;
	var percent_potential =  divide( (struct.armor-original_potential_damage) , struct.armor);	
	percent = clamp(percent,0,1);
	percent_potential = clamp(percent_potential,0,1);

	
	if original_potential_damage != 0 { 
			var armor_string_ = string(round(struct.armor*struct.armor_bar_front_lerp));		
		back_hp_bar_color = C_YELLOW;
		 struct.armor_bar_front_lerp =		lerp(struct.armor_bar_front_lerp, percent_potential,.4);
			
		//if struct.hp <=  struct.hp_max*.3 struct.hp = struct.hp_max;
	}else{
			var armor_string_ = string(round(struct.armor));
		struct.armor_bar_front_lerp  = lerp(struct.armor_bar_front_lerp, 1,.4)	
	}	
	
	
		front_bar_lerp = struct.armor_bar_front_lerp;
		var back_bar_lerp = struct.armor_bar_back_lerp;
		var front_bar_lerp = percent*struct.armor_bar_front_lerp;
		var percent_with_potential = (struct.armor)/struct.hp_max;
		struct.armor_bar_back_lerp = lerp(struct.armor_bar_back_lerp,percent_with_potential,.2);
		back_bar_lerp = clamp(back_bar_lerp,0,1);

		
	if original_potential_damage != 0 { 
		
		draw_set_halign(fa_right);
		draw_outline_thick(sprite_,0,armor_x,armor_y,size,size,angle*360,c_yellow,1);
		draw_outline(sprite_,0,armor_x,armor_y,size,size,angle*360,C_DARK,1);
			back_text_color = C_YELLOW;
			text_color = C_DARK;
		text_outline_thick(armor_x,armor_y+shield_y_offset,armor_string_,C_DARK	);

	}
		draw_sprite_ext(sprite_,0,armor_x,armor_y,size,size,angle*360,color,1);
	



	draw_set_font(font_damage_number);

	draw_set_halign(fa_center);
		if struct.armor_ui_timer <= time*.1 {
	draw_outline(s_status_armor,0,armor_x,armor_y,size,size,angle*360,color,1);
	}
	
	//text_outline_thick(xx-1-6,yy-2+shield_y_offset,string(struct.armor),back_text_color)
	//draw_text(armor_x,yy-2+shield_y_offset,armor_string_);
///////////////////
	draw_text_outline(armor_x,armor_y+shield_y_offset,armor_string_,back_text_color)
	draw_set_color(text_color);
	draw_text(armor_x,armor_y+shield_y_offset,armor_string_);
	draw_set_font(f_vhs);
	}
	
	
	draw_set_color(c_white);
	draw_set_halign(fa_left)
	yy += 5;
	
	var percent = struct.armor/struct.hp_max;
	percent = clamp(percent,0,1);
	
	
	var percent = struct.armor/struct.hp_max;
	
	var hp_string = struct.hp;
	
//	back_bar_lerp =  1;
	//front_bar_lerp = percent;

	output_string = string(struct.armor)+"/"+string(struct.hp_max);
	bar_height = 4;
	
		if struct.health_bar_hit_timer > 0 { 
				front_hp_bar_color = c_white;
		}	
	
	}
	var size = 100;
	draw_set_halign(fa_left);

	if front_bar_lerp < .02 { 

		draw_sprite_ext(s_pixel,0,xx-1+4,yy-2+4,1*size*back_bar_lerp,bar_height,0,c_black,1);
		draw_outline(s_pixel,0,xx-1,yy-2,1*size*back_bar_lerp,bar_height,0,C_YELLOW,1);

	}else{
		nine_slice(s_nine_slice_hp,xx-1,yy-2,xx-1+1*size*back_bar_lerp,yy-2+bar_height,1,c_black)
		nine_slice(s_nine_slice_hp,xx-1+4,yy-2+4,xx-1+4+1*size*back_bar_lerp,yy-2+4+bar_height,1,c_black)
	}


//	if i = 0 draw_text_outline(xx,yy,output_string,c_white);


	if i = 0 { 
		
		
		if front_bar_lerp < .02 { 
			draw_sprite_ext(s_pixel,0,xx-1,yy-2.5,1*size*back_bar_lerp,bar_height,0,make_color_rgb( 143, 20 ,83),.15);
			draw_sprite_ext(s_pixel,0,xx-1,yy-2,1*size*front_bar_lerp,bar_height,0,make_color_rgb( 143, 20 ,83),1);
	
		}else{
			nine_slice(s_nine_slice_hp,xx-1,yy-2,xx-1+1*size,yy-2+bar_height,.15,make_color_rgb( 143, 20 ,83))
			nine_slice(s_nine_slice_hp_border,xx-1,yy-2,xx-1+1*size,yy-2+bar_height,1,make_color_rgb( 143, 20 ,83))
		}
	}
	
	if front_bar_lerp < .02 { 
		
		if front_bar_lerp > 0 { 
		draw_sprite_ext(s_pixel,0,xx-1,yy-2,1*size*back_bar_lerp,bar_height,0,back_hp_bar_color,1);
		draw_sprite_ext(s_pixel,0,xx-1,yy-2,1*size*front_bar_lerp,bar_height,0,front_hp_bar_color,1);
		}
	}else{
	

	if struct = player { 
			var size_ = .45;
			var x___ = xx-1+o_game.camera.width*.04;
			var y___ = yy-2-o_game.camera.height*.06;
	}else{
			var size_ = .25;
			x___ = xx-1+o_game.camera.width*.04;
			y___ = yy-2+o_game.camera.height*.05;
	}
	
//	var spr_width = sprite_get_width(heart_name);
//	var spr_height = sprite_get_height(heart_name);
//	
//	var xoff = sprite_get_xoffset(heart_name)*size_;
//	var yoff = sprite_get_yoffset(heart_name)*size_;
//	
//	var hp_div = abs( 1- divide(struct.hp , struct.hp_max));
//	var sprite_diff = spr_height * hp_div;

	
	//gum
//	draw_sprite_part_ext(heart_name,1,0,sprite_diff,spr_width ,spr_height, x___-xoff,y___-yoff+sprite_diff*size_,size_,size_,C_GUM,1);
//	var hp_div = abs( 1- divide(struct.hp-potential_damage , struct.hp_max));
//	var sprite_diff = spr_height * hp_div;

	
	//white
	//draw_sprite_part_ext(heart_name,1,0,sprite_diff,spr_width ,spr_height, x___-xoff,y___-yoff+sprite_diff*size_,size_,size_,c_white,1);

	//draw_outline(heart_name,0,x___,y___,size_,size_,0,c_white,1);
	//draw_sprite_ext(heart_name,0,x___,y___,size_,size_,0,c_white,1);
	nine_slice(s_nine_slice_hp,xx-1,yy-2,xx-1+1*size*back_bar_lerp,yy-2+bar_height,1,back_hp_bar_color)
	nine_slice(s_nine_slice_hp,xx-1,yy-2,xx-1+1*size*front_bar_lerp,yy-2+bar_height,1,front_hp_bar_color)
	}
	
	
	
	
	
	if struct = player { 
				

		var col_ = c_white;
		draw_set_halign(fa_center);
		draw_set_color(col_);
	
	
		var _l = -o_game.camera.width*.33;
		var _t = -o_game.camera.height*.42;
		var _r = _l+30; 
		var _b = _t+20;
		
		var _l_sprite = _l+10;
		var _t_sprite = _t+3;
		
		var x_ = _l+30;
		var y_ = _t+25;

		
		if o_game.current_turn = e_current_turn.player_ and number_of_enemies > 0{ 
			
			
		//draw_outline(s_damage_icon,0,_l_sprite,_t_sprite,1,1,0,c_black,1);
		//draw_outline(s_damage_icon,0,_l_sprite+1,_t_sprite+1,1,1,0,c_black,1);
		
		
		 if total_intent_enemy_damage <= 0 {
				 	var color_ = C_LIME;
					var ang_ = 0;
			 }else{
					var color_ = C_GUM;
					ang_ = current_time*0.05;
			 }
			 
		draw_outline(s_damage_icon,0,_l_sprite+2,_t_sprite+2,1,1,ang_,c_black,1)	 			
		draw_outline(s_damage_icon,0,_l_sprite,_t_sprite,1,1,ang_,c_black,1)	 
		draw_sprite_ext(s_damage_icon,0,_l_sprite,_t_sprite,1,1,ang_,color_,1);
		}
		//var str =  string(player.armor) +"/"+string(total_intent_enemy_damage);
				
		
		
		
		//draw_text_outline(x_,y_,str,c_black)
		draw_set_halign(fa_center);
		
		x_ -= 18;
		y_ -= 10;
		//draw_outline(s_larger_shield,0,x_-10,_t_sprite,1,1,0,c_black,1);
		//draw_sprite_ext(s_larger_shield,0,x_-12,_t_sprite,1,1,0,C_BLUE,1);
		draw_set_font(font_health_number_white);
		
		//draw_text(x_-12,y_,string(player.armor))
	
	
		
		if o_game.current_turn = e_current_turn.player_  and number_of_enemies > 0{  
			draw_text_outline(x_+1,y_+1,string(total_intent_enemy_damage), c_black)
			draw_text_outline(x_,y_,string(total_intent_enemy_damage), c_black)
			draw_text(x_,y_,string(total_intent_enemy_damage))
		}
		draw_set_font(f_vhs);
		draw_set_color(c_white);
		draw_set_halign(fa_left)
		//draw_rectangle(_l-10,_t-20,_r,_b+10,1)
		
		if boon_collision( _l-10,_t-20,_r,_b+10, MX,MY) {
			 if total_intent_enemy_damage <= 0 {
				 	var color_ = "c_lime";
			 }else{
					var color_ = "c_gum";
			 }
			
			
			
			draw_status_information = "[c_yellow] TOTAL ENEMY DAMAGE[]\nAFTER ENDING YOUR TURN\nYOU'LL TAKE ["+color_+"] "+string(total_intent_enemy_damage)+" []["+color_+"][s_damage_icon][] DAMAGE";
		
			
			
		}
		 
	}
		
	
	draw_set_color(front_text_color);
	if i = 0 {
		//draw_text(xx,yy,output_string);
	}
	draw_set_color(c_white);	
}	
var hp_y = yy - camera.height*.02;
	var output_string_scribble = string(max(0,round(struct.hp*struct.potential_health_lerp)))+"[][c_white]/"+string(struct.hp_max);



	var scribble_numb = scribble("[f_outrun][c_gum]"+output_string_scribble);
	
	
	scribble_numb.blend(c_black,1).draw(xx-1,hp_y);
	scribble_numb.draw(xx-1,hp_y);
	scribble_numb.draw(xx+1,hp_y);
	scribble_numb.draw(xx,hp_y-1);
	scribble_numb.draw(xx,hp_y+1);
	scribble_numb.draw(xx+2,hp_y+2);
	scribble_numb.draw(xx+2,hp_y+1);
	scribble_numb.blend(c_white,1).draw(xx,hp_y);
	
	
draw_set_font(font_boon);		
}

