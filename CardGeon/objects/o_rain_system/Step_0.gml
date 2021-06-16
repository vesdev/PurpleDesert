/// @description 

if live_call() return live_result;


part_system_depth(sys_rain,-9000);
part_system_depth(sys_puddle,-9000);
var alpha = .5;
part_type_alpha1(pt_rain1,alpha);
part_type_alpha1(pt_rain2,alpha);
part_type_alpha1(pt_rain3,alpha);
part_type_alpha1(pt_rain4,alpha);
part_type_alpha1(pt_puddle,alpha);

var part_life_min = SEC*.2;
var part_life_max = SEC*1;

part_type_life(pt_rain1,part_life_min,part_life_max);
part_type_life(pt_rain2,part_life_min,part_life_max);
part_type_life(pt_rain3,part_life_min,part_life_max);
part_type_life(pt_rain4,part_life_min,part_life_max);

var mod_ = 1;

part_type_speed(pt_rain1,15.5*mod_,15.5*mod_,0,0);
part_type_speed(pt_rain2,10.5*mod_,16.5*mod_,0,0);
part_type_speed(pt_rain3,10.5*mod_,14.5*mod_,0,0);
part_type_speed(pt_rain4,10.5*mod_,14.5*mod_,0,0);

part_type_color1(pt_puddle,c_white);
part_type_speed(pt_puddle,0,0,0,0);
part_type_direction(pt_puddle,0,0,0,0);

part_type_life(pt_puddle,SEC*.2,SEC*.2);

timer = 0;

part_type_sprite(pt_puddle,s_pt_rain_splatter,1,1,0);
var x_  = o_game.camera.x-o_game.camera.width*.25;
var y_  = o_game.camera.y-o_game.camera.height*.5;

var width_ = o_game.camera.width;	
boon_randomize();

debug(obj_mapgen.next_game_state_queue);
if o_game.game_state = e_gamestate.choose_path and obj_mapgen.next_game_state_queue = noone
	and !obj_mapgen.browsing_card_shop and !obj_mapgen.enable_event
{ 
	
	part_particles_create(sys_rain,
	random_range(x_-700,x_+width_+100),y_-15,pt_rain1,1);
	part_particles_create(sys_rain,
	random_range(x_-700,x_+width_+100),y_-15,pt_rain2,1);
	part_particles_create(sys_rain,
	random_range(x_-700,x_+width_+100),y_-15,pt_rain3,1);
	part_particles_create(sys_rain,
	random_range(x_-700,x_+width_+100),y_-15,pt_rain1,1);
	part_particles_create(sys_rain,
	random_range(x_-700,x_+width_+100),y_-15,pt_rain2,1);
	part_particles_create(sys_rain,
	random_range(x_-700,x_+width_+100),y_-15,pt_rain3,1);
	part_particles_create(sys_rain,
	random_range(x_-700,x_+width_+100),y_-15,pt_rain4,1);
	
	if !audio_is_playing(amb_rain){ 
	audio_play_sound(amb_rain,1,1);		
	}
	
}else{
	audio_stop_sound(amb_rain);	
}