/// @description 

u_xlen = shader_get_uniform(sh_wave, "u_xamount");
u_ylen = shader_get_uniform(sh_wave, "u_yamount");
u_Time = shader_get_uniform(sh_wave, "u_Time");
u_uvInfo = shader_get_uniform(sh_wave, "u_uvInfo");


timer = 2;


_L = o_game.camera.x;
_T = o_game.camera.y;
_R = o_game.camera.x+o_game.camera.width;	
_B = o_game.camera.y+o_game.camera.height;	
_W = o_game.camera.width;
_H = o_game.camera.height;

global.ambient_light = true;
global.draw_wavy_walls = false;
gpu_set_zwriteenable(true)
depth = -2001;

wall_shader = sh_sine_wave_collision;

lighting_alarm = -1;


frequency_default = 1470.0;
amplitude_default = .001;
		
		
//if room = r_ran_halloween{
//	frequency_default = 3170.0;
//	amplitude_default = .0004;

//}



speed_mod = 1;
amplitude_mod = 1;
frequency_mod = 1;

lerp_amount = .1;

//layer_set_visible(layer_get_id("Collision"),0);
us_speed    = 0.001;
us_amplitude = 0.001;
us_frequency = 359.;


u_speed		= shader_get_uniform(sh_sine_wave_collision,"speed");
u_amplitude = shader_get_uniform(sh_sine_wave_collision,"amplitude");
u_frequency = shader_get_uniform(sh_sine_wave_collision,"frequency");


time		 = shader_get_uniform(sh_sine_wave_collision,"time");
texel_size	 = shader_get_uniform(sh_sine_wave_collision,"texel");
var _tex	 = sprite_get_texture(s_dungeon_wall_export,0);

tex_w = texture_get_texel_width(_tex);
tex_h = texture_get_texel_height(_tex);
sine_timer = 0;
surf2 = surface_create(room_width,room_height);//collision sine wave surface
surf3 = surface_create(room_width,room_height);

lightable_surf	= surface_create(_W,_H);
var _tex		= surface_get_texture(lightable_surf);
texW			= texture_get_texel_width(_tex);
texH			= texture_get_texel_height(_tex);
lightable_surf  = -1;
u1_texel_size	= shader_get_uniform(sh_rim,"rimSize");
u1_light_array	= shader_get_uniform(sh_rim,"lightData");
u1_texel		= shader_get_uniform(sh_rim,"texel");
u1_sources		= shader_get_uniform(sh_rim,"lightCount");
