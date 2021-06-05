// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//	draw_line(selected_card_x,selected_card_y, MX,MY);
			
 function draw_caret_surface() {
	 exit;
//	 m1_check = true;
//	 m1_release = false;
//	 m1_pressed = true;
//	 	var _dis = point_distance(selected_card_x,selected_card_y,MX,MY);
//		var _dir = point_direction(selected_card_x,selected_card_y,MX,MY);

	if !o_game.held.enable exit;
	 //draw_line(held.finalx0, held.finaly0, held.finalx1,held.finaly1) 	
	 

	 
	var _sprite = s_ball;
	//draw_line(selected_card_x,selected_card_y,MX,MY);
	var _dis = point_distance(held.finalx0,held.finaly0, held.finalx1,held.finaly1)*.01;
	var _dir = point_direction(held.finalx0,held.finaly0, held.finalx1,held.finaly1);
	
	
	var _angdiff = angle_difference(caret_angle_lerp,_dir);
	caret_angle_lerp -= _angdiff * 0.3;
	var _sprite_w = sprite_get_width(_sprite) + 8;
	var _sprite_h = sprite_get_height(_sprite)*0.8;
	var _sprites = (_dis div _sprite_w) + 1;
	var _tex = sprite_get_texture(_sprite,image_index);
	draw_primitive_begin_texture(pr_trianglelist,_tex);

	// do first loop to initialize first set of variables
	var _i = 0;
	var _whip = _angdiff * (1 - _i / _sprites);
	var _off_x_0 = _sprite_w * dcos(_dir + _whip);
	var _off_y_0 = _sprite_w * -dsin(_dir + _whip);
	var _norm_x_0 = dcos(_dir + _whip + 90);
	var _norm_y_0 = -dsin(_dir + _whip + 90);
	var _window = 1.0 - power(2*_i/_sprites - 1,2);
	
	var time_divide = 6;
	var sine_multiply = 8;
	var sine_frequency = 36;
	
	var _wave_curr = sine_multiply * _window * dsin((_i + 0) * sine_frequency + current_time / time_divide);

	// top left
	var _p00_x = held.finalx0 + (_i + 0) * _off_x_0 + (_wave_curr - _sprite_h/2) * _norm_x_0;
	var _p00_y = held.finaly0 + (_i + 0) * _off_y_0 + (_wave_curr - _sprite_h/2) * _norm_y_0;

	// bottom left
	var _p01_x = held.finalx0 + (_i + 0) * _off_x_0 + (_wave_curr + _sprite_h/2) * _norm_x_0;
	var _p01_y = held.finaly0 + (_i + 0) * _off_y_0 + (_wave_curr + _sprite_h/2) * _norm_y_0;

	for (_i = 0; _i < _sprites; _i++)
		{
		_whip = _angdiff * (1 - ((_i + 1) / _sprites));
		var _off_x_1 = _sprite_w * dcos(_dir + _whip);
		var _off_y_1 = _sprite_w * -dsin(_dir + _whip);
		var _norm_x_1 = dcos(_dir + _whip + 90);
		var _norm_y_1 = -dsin(_dir + _whip + 90);

		_window =  1.0 - power(2*(_i + 1)/_sprites - 1,6);
		var _wave_next = sine_multiply * _window * dsin((_i + 1) * sine_frequency + current_time / time_divide);

		// find vertex locations

		// top right
		var _p10_x = held.finalx0 + (_i + 1) * _off_x_1 + (_wave_next - _sprite_h/2) * _norm_x_1;
		var _p10_y = held.finaly0 + (_i + 1) * _off_y_1 + (_wave_next - _sprite_h/2) * _norm_y_1;

		// bottom right
		var _p11_x = held.finalx0 + (_i + 1) * _off_x_1 + (_wave_next + _sprite_h/2) * _norm_x_1;
		var _p11_y = held.finaly0 + (_i + 1) * _off_y_1 + (_wave_next + _sprite_h/2) * _norm_y_1;

		// top right triangle
		draw_vertex_texture_color(_p10_x,_p10_y,1,0,c_white,1.0);
		draw_vertex_texture_color(_p00_x,_p00_y,0,0,c_white,1.0);
		draw_vertex_texture_color(_p11_x,_p11_y,1,1,c_white,1.0);

		// bottom left triangle
		draw_vertex_texture_color(_p11_x,_p11_y,1,1,c_white,1.0);
		draw_vertex_texture_color(_p00_x,_p00_y,0,0,c_white,1.0);
		draw_vertex_texture_color(_p01_x,_p01_y,0,1,c_white,1.0);

		// set next variables to current variables for next iteration
		_p00_x = _p10_x;
		_p00_y = _p10_y;
		_p01_x = _p11_x;
		_p01_y = _p11_y;
		_off_x_0 = _off_x_1;
		_off_y_0 = _off_y_1;
		_norm_x_0 = _norm_x_1;
		_norm_y_0 = _norm_y_1;
		}
	draw_primitive_end();	 
	
	 
	 exit;
					var offset_dis = 0;
					var get_sprite_width = sprite_get_width(s_hold_caret)-3;
					
					var dir = point_direction( held.finalx0, held.finaly0, MX,MY);
					var dis = point_distance( held.finalx0, held.finaly0, MX,MY);
					
					var total_sprites = dis div get_sprite_width;
					var x_ = 0;
					var last_x_pos = -1;
					var last_y_pos = -1;
					
					var last_x = undefined;
					var last_y = undefined;
				
					var x_offset_all = 0;
					
					if !hovering_over_a_target { 
						
						var wave = 1000;
						var time = current_time*0.005;
						var sprite_speed =current_time*.005
						var sprite = s_ball;
						
					}else{
						var sprite = s_hold_caret;
						var time = current_time*0.009;
						var wave = 500; //500 = hex 1000 = wave
						var sprite_speed =	current_time*.02;
					}
					
					
				var get_sprite_height = sprite_get_height(sprite);
				var face_ = 0;
					switch get_target_type(hand[| hand_hover_array]) { 
						case e_target.player:
						case e_target.none:	sprite = s_ball; 
						get_sprite_height = sprite_get_height(sprite);
						if hovering_over_a_target { 
							col = C_LIME;
						}
						
						break;
						case e_target.single:	
						case e_target.all_enemies:
							face_ = 1;
							get_sprite_height = get_sprite_width;

			//	surface_set_target(caret_surface);
			//	draw_clear_alpha(c_white,0);
					for (var i = total_sprites; i = total_sprites; i++) {
					var offset = 50;
					var new_i = i+offset;
					var sin_amount = 1.5;
					//1000 or 500 work great
					var dna_dir = sin(time+(wave*(new_i)));
					var dnalength = new_i*get_sprite_width;
					
					var xlendna = (dnalength)*dcos(dna_dir)*.8;
					var ylendna = (dnalength)*dsin(dna_dir)*.8;
					
						//	var xlen = lengthdir_x(new_i*get_sprite_width,dir);
						//	var ylen = lengthdir_y(new_i*get_sprite_width,dir);
					
						var length = i*get_sprite_width;
							
						var xlen = lengthdir_x(i*get_sprite_width,dir);
						var ylen = lengthdir_y(i*get_sprite_width,dir);
						
						if face_ = 1 { 
								var x_ =  held.finalx0+xlendna;//+xlen;
								var y_ =  held.finaly0+ylendna;//+ylen;
						}else{
							var x_ =  held.finalx0    +xlen;
								var y_ =  held.finaly0+ylen;	
						}
						
				//		draw_sprite_ext(s_char_attack_coco,0,x_-290,selected_card_y,1,1,0,C_BLACK,1);
					}
		break;
	}
				//	draw_line(x_-290,MY,MX,MY);
					var offset_dis = point_distance(x_-290,MY,MX,MY);
					var offset_sprites = offset_dis div get_sprite_width;

if face_ = 0 offset_sprites = 0;
	
			//hold_target_dir = []
				for (var i = 0; i <= total_sprites+offset_sprites; i++) {
					
					if array_length(hold_target_dir)-1 < i  {
						
						hold_target_dir[@ i] = dir;
					//	hold_target_x[@ i] = selected_card_x;
					//	hold_target_y[@ i] = selected_card_y;
					}
					
					hold_target_dir[@ i] -= angle_difference(hold_target_dir[@ i],dir) * 0.87;
					dir = hold_target_dir[@ i];
					
					var offset = 50;
					var new_i = i+offset;
					var sin_amount = 1.5;
					//1000 or 500 work great
					var dna_dir = sin(time+(wave*(new_i)));
				
				
				
					var dnalength = new_i*get_sprite_width;						
					
								var xlendna = (dnalength)*dcos(dna_dir)*.8;
								var ylendna = (dnalength)*dsin(dna_dir)*.8;
								var length = i*get_sprite_width;
								var xlen = lengthdir_x(i*get_sprite_width,dir);
								var ylen = lengthdir_y(i*get_sprite_height,dir);
					if face_ = 1 { 
	
								var x_ =  held.finalx0+xlendna;//+xlen;
								var y_ =  held.finaly0+ylendna;//+ylen;
						}else{
						
						
								var x_ =  held.finalx0    +xlen;
								var y_ =  held.finaly0+ylen;	
						}
						
						var draw_carets = true;
						if last_x_pos != noone {
								var get_angle = 0;
						}else{
								get_angle = point_direction(last_x_pos,x_,last_y_pos,y_);;
						}
						last_x_pos = x_;
						last_y_pos = y_;
						
						if draw_carets { 
									var col = c_white;//make_color_hsv((current_time*0.1 + i * 500) mod 255,120,250);
								if i mod 2 = 0 { 
									var col = C_GUM;
								}
								
							if !hovering_over_a_target { 
										col = c_white;	
								
								
							}
								
						
								if i = 0 { 
										x_offset_all =	point_distance( held.finalx0,0,x_ ,0);
								}
								var lerp_ = .5;
								// hold_target_x[@ i] = lerp(hold_target_x[@ i],x_-x_offset_all,lerp_);
								//	hold_target_y[@ i] = lerp(hold_target_y[@ i],y_,lerp_);
								//draw_sprite_ext(s_char_attack_coco,0,x_-x_offset_all,selected_card_y,1,1,0,C_BLACK,1);
								var dir2 = point_direction(x_-x_offset_all, y_+ylen,MX,MY);
								draw_sprite_ext(sprite,sprite_speed,x_-x_offset_all,y_+ylen,1,1,dir2,col,1);
								
							//	var new_dir = point_direction(selected_card_x+lenx_test,selected_card_y+leny_test,MX,MY   )
							//	starting_dir -= angle_difference(starting_dir,new_dir) * 0.05 *(i +1);
							//	var lenx_test = lengthdir_x(i*get_sprite_width, starting_dir);
							//	draw_sprite(s_ball, 0,selected_card_x+lenx_test,selected_card_y+leny_test);
						}
				}	
				
				//	surface_reset_target();
	/*
					var dir_offset = point_direction(0,0,selected_card_x,selected_card_y);
					var dis_offset = point_distance(0,0,selected_card_x,selected_card_y);
				
					var xlen = lengthdir_x(dis_offset, dir_offset);
					var ylen = lengthdir_y(dis_offset, dir_offset);
				
					var _c = dcos(dir);
					var _s = dsin(dir);
					var _x = xlen;  //surface origin x
					var _y = ylen;  //surface origin y
			*/
				//	draw_surface_ext(caret_surface,selected_card_x - _c * _x - _s * _y, selected_card_y - _c * _y + _s * _x,1,1,dir,c_white,1);
					
				
		//surface

		
}