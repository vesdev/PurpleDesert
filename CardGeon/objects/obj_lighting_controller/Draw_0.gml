/// @description Insert description here

if o_game.game_state = e_gamestate.battle exit;

if timer > 0 { 
	timer--;
	exit;	
}
//right
draw_sprite_ext(s_pixel,0,0,-room_height,room_width,room_height,0,C_DARK,1);
//left
draw_sprite_ext(s_pixel,0,-room_width,0,room_width,room_height,0,C_DARK,1);
//right
draw_sprite_ext(s_pixel,0,room_width,0,room_width,room_height,0,C_DARK,1);
//bottom
draw_sprite_ext(s_pixel,0,0,room_height,room_width,room_height,0,C_DARK,1);

draw_sprite_ext(s_pixel,0,-room_width,-room_height,room_width*4,room_height*4,0,C_DARK,1);
visible = 1;
if o_game.game_state = e_gamestate.battle exit;



	

//
//
var lay_id = obj_mapgen.wall_layer;
var map_id = obj_mapgen.wall_tilemap;

var lay_id_burn = obj_mapgen.burn_layer;
var map_id_burn = obj_mapgen.burn_tilemap ;


var w = surface_get_width(application_surface);
var h = surface_get_height(application_surface);
var ww = window_get_width();
var hh = window_get_height();

if global.draw_wavy_walls = true{ 
layer_set_visible(lay_id,false)
layer_set_visible(lay_id_burn,false)
}else{
layer_set_visible(lay_id,true)
layer_set_visible(lay_id_burn,true);

}
draw_tilemap(map_id_burn, 0, 0);

depth = 200;

var w_ = surface_get_width(application_surface);
var h_ = surface_get_height(application_surface);
	

if !surface_exists(surf2){
	surf2 = surface_create(room_width,room_height);
}else{
if surface_get_width(surf2) != room_width and surface_get_height(surf2) != room_height{
	surface_resize(surf2, room_width,room_height);
}


surface_set_target(surf2);
gpu_set_blendmode(bm_zero);
draw_clear_alpha(c_white,0);
draw_set_color(C_DARK);
draw_tilemap(map_id, 0, 0);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal)
surface_reset_target();


if speed_mod != 1{
	speed_mod = lerp(speed_mod,1,lerp_amount);
}
if amplitude_mod != 1{
	amplitude_mod = lerp(amplitude_mod,1,lerp_amount);
}
if frequency_mod != 1{
	frequency_mod = lerp(frequency_mod,1,lerp_amount);
}
if sine_timer != 0{
	sine_timer = approach(sine_timer,0,lerp_amount);
}



if !surface_exists(surf3){
	surf3 = surface_create(room_width,room_height);
	}else{
	
		var col = C_DARK;			
		surface_resize(surf3,room_width,room_height);
		surface_set_target(surf3);
		draw_clear_alpha(c_white,0)
		shader_set(sh_sine_wave_collision);
		shader_set_uniform_f(u_speed, 0.01*speed_mod);
		amplitude_default = .0005;
		frequency_default = 2170;
		shader_set_uniform_f(u_amplitude, amplitude_default*amplitude_mod);
		shader_set_uniform_f(u_frequency, frequency_default*frequency_mod);
		shader_set_uniform_f(texel_size,tex_w,tex_h);
		shader_set_uniform_f(time,current_time + sine_timer);
		
		var col = make_color_hsv((current_time*0.001) mod 255,150,250);
		var col = C_FUCHISIA;
		
		draw_surface_ext(surf2,1,0,1,1,0,  col,1);
		draw_surface_ext(surf2,-1,0,1,1,0, col,1);
		draw_surface_ext(surf2,0,1,1,1,0,  col,1);
		draw_surface_ext(surf2,0,-1,1,1,0, col,1);
		draw_surface_ext(surf2,0,0,1,1,0,  C_DARK ,1);
		shader_reset();
		surface_reset_target();
	}
}
if surface_exists(surf3) and global.draw_wavy_walls{ 
	draw_surface(surf3,0,0);
}else{
	draw_tilemap(map_id, 0, 0);
}



/*
x_len = .1;
y_len = .1;
var TMI = sprite_get_uvs(s_lazer, 0);
uvInfo = [ TMI[0], TMI[1], TMI[2] - TMI[0], TMI[3] - TMI[1] ];
shader_set(sh_tile);
shader_set_uniform_f(u_Time, current_time * 0.0001 );
shader_set_uniform_f(u_xlen, x_len);
shader_set_uniform_f(u_ylen, y_len);		
shader_set_uniform_f_array(u_uvInfo, uvInfo);
draw_sprite_ext(s_lazer,0,MX,MY,1,1,image_angle,image_blend,1);
shader_reset();
*/


exit;
if !surface_exists(lightable_surf){
lightable_surf = surface_create(w_, h_);	
}else{
surface_resize(lightable_surf,w_,h_);
// Relationship between surface and camera
var s = _W/surface_get_width(application_surface);
// same but inverse
var invS = 1/s;


var _tex = surface_get_texture(lightable_surf);
texW = texture_get_texel_width(_tex) ;
texH = texture_get_texel_height(_tex);


var view_x = o_game.camera.x;
var view_y = o_game.camera.y;

var view_h = o_game.camera.height;
var view_w = surface_get_width(application_surface);

		surface_set_target(lightable_surf);
		camera_apply(CAM);
		draw_clear_alpha(0,0);
	
		if surface_exists(surf3){
			//draw_surface(surf3,0,0);	
			draw_surface(surf3,0,0);//default
		}else{
			draw_tilemap(map_id, 0, 0);
		}
		
		
	with(obj_mapgen){
		
			draw_player_minimap( draw_playerx, draw_playery);
	}	
		
		surface_reset_target();
	
		gpu_set_blendmode(bm_normal);
		
		
		var d = false;
		
		if d{
				var view_x = 0;
				var view_y = 0;
				var view_w = 0;
				var view_h = 0;
			if instance_exists(o_camera){
				view_x = _L;//
				view_y = _T;// 
				view_w = _W;//gets the camera's total width
				view_h = _H;//gets the cameras total height
			}	
				
			var _light_array = [];
			var i = 0; //how many light sources there are
			
			var total_lights = 5;//instance_number(o_light_parent);
			if total_lights = 0 exit; //we have no lights
			var max_lights = clamp(total_lights,0,9);//90 / 6 = 15 lights
			
			closest_inst = noone;

			with(obj_light_parent){
				var radius = 100;
			
				if (x < view_x-radius || y <  view_y-radius) || (x > _R+radius || y >  _B+radius){				
					continue;
				}
				var can_return = true;
				for (var xx = 0; xx < max_lights; xx++){
					
					var xx = MX;
					var yy = MY;
					
					var red = 255;
					var green = 255;
					var blue = 255;
				//can this object light the grass and stuff
				//this line
					//	draw_text(x,y+10,string(xx));
						_light_array[i*6]   = (x-view_x)*invS;
						_light_array[i*6+1] = (y-view_y)*invS;
						_light_array[i*6+2] = radius*invS;
						_light_array[i*6+3] = (red/invS)/255;
						_light_array[i*6+4] = (green/invS)/255;
						_light_array[i*6+5] = (blue/invS)/255;
						i++;
				}
			}
			if i > 0{
	
if instance_exists(o_camera){
	var subpixelx = _L - floor(_L);
	var subpixely = _T - floor(_T);
}else{
	var subpixelx = 0;
	var subpixely = 0;
}	
			gpu_set_blendmode(bm_normal);
			shader_set(sh_rim);
			shader_set_uniform_f_array(u1_light_array, _light_array);
			shader_set_uniform_f(u1_texel, texW, texH);
			shader_set_uniform_f(u1_texel_size,invS);
			shader_set_uniform_f(u1_sources, array_length_1d(_light_array)/6);
			draw_surface_stretched(lightable_surf, view_x, view_y  , _W,_H);
			shader_reset();
				
			//	draw_text(o_player.x,o_player.y,string((view_x))+"  "+string(subpixelx));
			}
			_light_array = undefined;
	}


		/* DRAW OVER TILES
		gpu_set_fog(true,col,0,1);//o_combo_parent.after_image_color
		draw_tilemap(map_id, 0, 0);
		gpu_set_fog(false,c_white,0,1);
		lighting_alarm = SEC*.35;
		*/
	lighting_alarm--;
		
}

//surface_free(lightable_surf);