// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_struct(struct, x , y ){


//	draw_ellipse_color(x-xoff,y-yoff,x+xoff,y+yoff,c_white,c_black,false);

	

	if struct.selected_by_card.enable = true{

		var y_light_off = 0;
			if struct != player{
				
			y_light_off = -o_game.camera.height*.48;	
			}
			draw_sprite_ext(s_light,0,struct.x,struct.y-220+y_light_off,1,1,0,struct.selected_by_card.color,1);
			draw_sprite_ext(s_light_ground,0,struct.x,struct.y+y_light_off,1,1,0,struct.selected_by_card.color,.5);
	}

	var xoffset = struct.xoffset;
	var yoffset = struct.yoffset;
	
	var z = struct.z;
	//HAS BEEN HIT
	struct.has_been_hit_time = SEC*.55;
	
	var timer = struct.has_been_hit_timer;
	var time = struct.has_been_hit_time;
	var draw_flash = false;
	
	z_control(struct);
	
	if  timer <= time { 
		var change = .35;
		struct.xscale = easings(e_ease.easeoutback , 1+change,-change,time,timer);
		struct.yscale = struct.xscale;
		struct.angle = easings(e_ease.easeoutelastic , -10*struct.xscale_facing ,10*struct.xscale_facing,time,timer);	
		
		if struct.trigger_hit_animation { 
		struct.current_sprite = struct.sprite_hit;
		}
		if timer <= 0 draw_flash = true;
	}else {
		if struct = player { 
		var time_ = SEC*.15;	
		}else{
			time_ = SEC*.45;
		}
	if 	 timer > time + time_ and struct.current_sprite = struct.sprite_hit struct.current_sprite = struct.sprite_idle;
	}
	if  timer <= time{ 
	draw_outline(struct.current_sprite,struct.sprite_image_index, x+xoffset,y+z+yoffset,struct.xscale*struct.xscale_facing,struct.yscale,struct.angle,c_white,1);
	}
	
	if struct = player { 

		var spr = player.sprite_idle;
		var xoff = sprite_get_xoffset(spr);
		var yoff = sprite_get_yoffset(spr);
		var offsetx = 10;
		var offsety = 10;
 		var xx = x+xoffset-xoff;
		var yy = y+z+yoffset-yoff;
		var w = sprite_get_width(spr);
		var h = sprite_get_height(spr);
		
		if boon_collision(xx-offsetx,yy-offsety,xx+w+offsetx,yy+h, MX,MY){ 
		
			draw_status_information = player.hover_over_desc_func(player);	
			draw_outline(struct.current_sprite,struct.sprite_image_index, x+xoffset,y+z+yoffset,struct.xscale*struct.xscale_facing,struct.yscale,struct.angle,c_white,1);

		}
	}	
	
	if struct.force_outline_color != false { 
		draw_outline(struct.current_sprite,struct.sprite_image_index, x+xoffset,y+z+yoffset,struct.xscale*struct.xscale_facing,struct.yscale,struct.angle,struct.force_outline_color,1);
	}
	struct.has_been_hit_timer++;
	draw_sprite_ext(struct.current_sprite,struct.sprite_image_index, x+xoffset,y+z+yoffset,struct.xscale*struct.xscale_facing,struct.yscale,struct.angle,c_white,1);

	if struct.force_flash_color != false {
		gpu_set_fog(true,struct.force_flash_color,1,1);
		draw_sprite_ext(struct.current_sprite,struct.sprite_image_index, x+xoffset,y+z+yoffset,struct.xscale*struct.xscale_facing,struct.yscale,struct.angle,c_white,1);
		gpu_set_fog(false,c_white,1,1);
	}

	struct.sprite_image_index += struct.sprite_image_speed;
	if struct.sprite_image_index > sprite_get_number(struct.current_sprite)-1{ 
		struct.sprite_image_index = 0;
	}

//////////////////////////////////////
#region targeting reticle


if struct.selected_by_card.enable = true{
		
		var dis_ = 0;
		var caretscale = 1;
		var xsize_target = 60;
		var ysize_target = 40;
		var xsize = xsize_target ;
		var ysize = ysize_target;	
		var ysize2 = ysize_target*1.1;
		var xsize2 = xsize_target*1.1;
		struct.selected_by_card.time = SEC*.5
		if  struct.selected_by_card.timer <= struct.selected_by_card.time { 
				  dis_	= easings(e_ease.easeoutexpo,0,45+180, struct.selected_by_card.time,struct.selected_by_card.timer );
					xsize	= easings(e_ease.easeoutback,0,xsize_target, struct.selected_by_card.time,struct.selected_by_card.timer );
					ysize = easings(e_ease.easeoutback,0,ysize_target, struct.selected_by_card.time,struct.selected_by_card.timer );
					xsize2	= easings(e_ease.easeoutexpo,0,xsize_target*1.1, struct.selected_by_card.time,struct.selected_by_card.timer );
					ysize2 = easings(e_ease.easeoutexpo,0,ysize_target*1.1, struct.selected_by_card.time,struct.selected_by_card.timer );
			
			
			struct.selected_by_card.timer++;	
		}else{
				  dis_	= 45+180;

		struct.selected_by_card.timer++;
		
		}
			dis_	+= sin((struct.selected_by_card.timer-struct.selected_by_card.time)*0.01)*100;
	

//game_mode_player_selected = clamp(game_mode_player_selected,0, e_game_mode.size_-1);

var size =6;
var middle = floor(size/4);
var ang_ =  sin(current_time*0.01); //side_box_x = 89 default;

var alpha = 0;

for (var i = 0; i < size; i++){

	var target = (360/size) * i + (360/size) ;
//lerp(angle_menu_blocks, 10,.1) ;
	var xsize_ = 0;
	var ysize_ = 0;
	
if i % 2 == 0 {
	
	xsize_ = xsize2;
	ysize_ = ysize2;
}else{
	xsize_ = xsize
	ysize_ = ysize;

}
	xsize_ = xsize2;
	ysize_ = ysize2;
		
	
	var xlen = lengthdir_x(xsize_,target+dis_);
	var ylen = lengthdir_y(ysize_,target+dis_);

	var alpha = ylen/15;
	
	//if ylen <= 0 {
var yoff_ = -5;
var xoff_ = 0;
if struct = player { 
xoff_ -= 10;
}

var scale = 1/(abs(ylen-10)/15+1);
//	draw_sprite_ext(s_light,0,w/2+xlen,h/2+ylen-50+y_offset,1,1,0,c_white,alpha);

var dir_ = point_direction(  xlen+x+xoffset+xoff_,ylen+y+z+yoffset  ,x+xoffset,y+z+yoffset+yoff_);
	draw_sprite_ext(s_caret,0,xlen+x+xoffset+xoff_,ylen+y+z+yoffset+yoff_,1,1,dir_,struct.selected_by_card.color,1);
		if struct.selected_by_card.timer < struct.selected_by_card.time*.2 {
			particle_evaporate(xlen+x+xoffset+xoff_,ylen+y+z+yoffset+yoff_,10, struct.selected_by_card.color,0,noone,SEC*.1,0,-.001);
		}
} 
}else{
 struct.selected_by_card.timer = 0;	
}
		

#endregion targeting reticle 

//////////////

	//damage numbers
	var number_struct = struct.damage_number;
	
	if number_struct.onscreen = true { 
//	var str = "["+number_struct.color+"]";
	var str = string(number_struct.amount);
	
	draw_set_halign(fa_center);
	draw_set_font(font_damage_number);
		var x_ = x+xoffset +40 *struct.xscale_facing;
		var y_ = y+z+yoffset-50;
		var critx = x_+5;
		var crity = y_;
		var text_size = 1;
		var critchange_amount = 10;

		var critchange = 0;
		
		var x_offset = 0;
		var y_offset = 0;
		var change = 8;
		
		var outline_thick = noone;
		var outline = noone;
		var front_color = noone;
		var is_a_crit = number_struct.is_a_crit;
	
		
		var rotate_square_size = 1;
		var sqare_col = c_white;
		var square_angle = 0;
		var square_front_angle = 0;
		var front_square_col = c_white;
		
		if is_a_crit { 
			front_square_col = c_white;
		}
		if number_struct.intro_timer <= number_struct.intro_time_func() { 			
			
			
			
			if number_struct.intro_timer = 1 {
				var snd_ = sfx_deal_damage;
				
				if struct = player { 
					snd_ = sfx_player_took_damage;	
				
					
				}
				
				
				
				if struct.armor > 0 { 
					snd_ = 	sfx_block_damage;
				}
				
				if is_a_crit{ 
					
					o_game.meatball_str.timer = 0;	
					snd_ = sfx_deal_damage_crit;
				}
				
				audio_play( snd_ );	
			}
			
		if number_struct.intro_timer < SEC*.2{
			outline_thick = C_GUM;
			outline = c_white;
			front_color = c_yellow;	
		}
			
		critchange = easings(e_ease.easeoutelastic,-critchange_amount,critchange_amount,number_struct.intro_time_func(),number_struct.intro_timer);			
		y_offset = easings(number_struct.intro_easesing_type,change,-change,number_struct.intro_time_func(),number_struct.intro_timer);			
		
		
		jolt_left_change = 0;
		if struct = player{
				if  struct.blocking_sprite != s_white_square  { 
				//we are blocking it with a shield		
					var jolt_left_change = 25;
				}else{
						jolt_left_change = 35;	
					}
			}
			
			x_offset =  easings(e_ease.easeoutelastic,jolt_left_change,-jolt_left_change,number_struct.intro_time_func(),number_struct.intro_timer);			


			square_front_angle	= easings(e_ease.easeoutelastic,-245,245,number_struct.intro_time_func(),number_struct.intro_timer);			
			square_angle = easings(e_ease.easeoutexpo,-350,350,number_struct.intro_time_func(),number_struct.intro_timer);			
			rotate_square_size = easings(e_ease.easeoutelastic,0,1,number_struct.intro_time_func(),number_struct.intro_timer);			
			text_size = easings(e_ease.easeoutexpo,0,1,number_struct.intro_time_func(),number_struct.intro_timer);			
			
			number_struct.intro_timer++;
		}
		
		if 	number_struct.intro_timer > number_struct.intro_time_func()
			and number_struct.stay_static_timer <= number_struct.stay_static_time_func()
		{ 
			number_struct.stay_static_timer++;
		}

		if 	number_struct.intro_timer > number_struct.intro_time_func() and  number_struct.stay_static_timer > number_struct.stay_static_time_func()	{
				if number_struct.outro_timer <= number_struct.outro_time_func() { 
					y_offset = easings(number_struct.outro_easesing_type,0,-change*5,number_struct.outro_time_func(),number_struct.outro_timer);
				
					critchange = easings(e_ease.easeinquart,0,200,number_struct.outro_time_func(),number_struct.outro_timer);			

					square_front_angle	= easings(e_ease.easeinelastic,0,145,number_struct.outro_time_func(),number_struct.outro_timer);			
					square_angle = easings(e_ease.easeinoutback,0,-145,number_struct.outro_time_func(),number_struct.outro_timer);			
					rotate_square_size = easings(e_ease.easeoutexpo,1,-1,number_struct.outro_time_func(),number_struct.outro_timer);			
					text_size = easings(e_ease.easeoutexpo,1,-1,number_struct.intro_time_func(),number_struct.intro_timer);			
				
					
					number_struct.outro_timer++;
				
	
				}else{
				
				//number_struct.outro_timer = 0;
				//number_struct.stay_static_timer = 0;
				//number_struct.intro_timer = 0;
				
				
					number_struct.onscreen = false;
					draw_set_color(c_white);
					draw_set_font(font_boon);
					exit;
				}			
		}

	if is_a_crit{
		var dir = 15;
		var dis = critchange;
		var xlen = lengthdir_x(dis,dir);
		var ylen = lengthdir_y(dis,dir);
 
		draw_sprite(s_crit,0,critx-10+xlen, crity-30+ylen);
		front_color = C_YELLOW;
		if number_struct.intro_timer < SEC*.04{
		draw_outline(s_crit,0,critx-10+xlen, crity-30+ylen,1,1,0,C_YELLOW,1);
		}
	}
		y_ += y_offset;
		x_ += x_offset;
	
	var outline_color = C_DARK;

	if number_struct.stay_static_timer > number_struct.stay_static_time_func(){ 
		 outline_color = c_white;
		
	}
	
	
	y_ += 20;
	
	if struct.blocking_sprite != s_white_square { 
	//shield
	
	var square_yoffset = 8;
	draw_outline_thick(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,rotate_square_size,-square_angle,front_square_col,1);
	draw_outline(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,rotate_square_size,-square_angle,outline_color,1);
	draw_sprite_ext(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,rotate_square_size,-square_angle,front_square_col,1);

	
	}else{
	

		var square_yoffset = 8;
		draw_outline_thick(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,rotate_square_size,-square_angle,front_square_col,1);
		draw_outline_thick(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,-rotate_square_size,square_front_angle+45,front_square_col,1);

		draw_outline(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,rotate_square_size,-square_angle,outline_color,1);
		draw_outline(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,-rotate_square_size,square_front_angle+45,outline_color,1);

		draw_sprite_ext(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,rotate_square_size,-square_angle,front_square_col,1);
		draw_sprite_ext(struct.blocking_sprite,0,x_,y_+square_yoffset,rotate_square_size,-rotate_square_size,square_front_angle+45,front_square_col,1);

	}




	if number_struct.intro_timer < 3{
			draw_sprite_ext(struct.blocking_sprite,0,x_,y_+square_yoffset,2,2,45,c_black,1);
			draw_sprite_ext(struct.blocking_sprite,0,x_,y_+square_yoffset,2,2,0,c_black,1);
	}

	if number_struct.intro_timer < 2{
		draw_sprite_ext(struct.blocking_sprite,0,x_,y_+square_yoffset,2,2,45,c_white,1);
			draw_sprite_ext(struct.blocking_sprite,0,x_,y_+square_yoffset,2,2,0,c_white,1);
	}
	

	


		if outline_thick != noone { 
			text_outline_thick_transformed(x_, y_, str , c_white,text_size,text_size,0);
		}
		
		if outline != noone { 
			gpu_set_fog(true,c_white,0,1);
			draw_text_transformed(x_-1,y_,str,text_size,text_size,0);
			draw_text_transformed(x_+1,y_,str,text_size,text_size,0);
			draw_text_transformed(x_,y_-1,str,text_size,text_size,0);
			draw_text_transformed(x_,y_+1,str,text_size,text_size,0);
			gpu_set_fog(false,c_white,0,1);
			
			if number_struct.intro_timer < SEC*.09{
			
			}
		}
		draw_set_color(C_YELLOW);
		if front_color != noone { 
			draw_set_color(front_color);	
			
			
		}
		
		if rotate_square_size > .4 { 
		draw_text_transformed(x_, y_, str,text_size,text_size,0);
		}
	}
		draw_set_color(c_white);
		draw_set_font(font_boon);
	
	struct.x = x;
	struct.y = y;
	draw_set_halign(fa_left);
}