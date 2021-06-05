// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function init_particles(){


		global.pt_summon_token = part_type_create();
		global.sys_summon_token = part_system_create();


		part_system_depth(global.sys_summon_token,DEPTH_AHEAD_GAME);
		part_type_color1(global.pt_summon_token,c_white);
		part_type_size(global.pt_summon_token,1,1,0,0);
		part_type_speed(global.pt_summon_token,4,3,-.3,0);
		part_type_sprite(global.pt_summon_token,s_summon_particle,true,true,0);
		part_type_life(global.pt_summon_token,SEC*.15,SEC*.01);
	
	
	
		global.pt_bubble = part_type_create();
		global.pt_bubble_outline = part_type_create();
		
		global.sys_bubble = part_system_create();
		global.sys_bubble_outline = part_system_create();


			var s_1 = SEC*.1;
			var s_2 = SEC*.15;
			//particle
			global.pt_bubble_outline  = part_type_create();
			part_type_sprite(global.pt_bubble_outline, s_bubble_outline , true, true, 0);
			part_type_scale(global.pt_bubble_outline, 1, 1);
			part_type_colour_rgb(global.pt_bubble_outline, 255, 255, 255, 255, 13,13);
			part_type_speed(global.pt_bubble_outline, 0.1, 0.4, 0, 0);
			part_type_direction(global.pt_bubble_outline, 90, 90, 0, 0);
			part_type_life(global.pt_bubble_outline,s_1,s_2);


			var s_1 = SEC*.1;
			var s_2 = SEC*.15;
			//particle
			global.pt_bubble  = part_type_create();
			part_type_sprite(global.pt_bubble, s_bubble , true, true, 0);
			part_type_scale(global.pt_bubble, 1, 1);
			part_type_colour_rgb(global.pt_bubble, 255, 255, 255, 255, 13,13);
			part_type_speed(global.pt_bubble, 0.1, 0.4, 0, 0);
			part_type_direction(global.pt_bubble, 90, 90, 0, 0);
			part_type_life(global.pt_bubble,s_1,s_2);
	
	






		global.pt_bubble_evaporate = part_type_create();
		global.pt_bubble_outline_evaporate = part_type_create();
		
		global.sys_bubble_evaporate = part_system_create();
		global.sys_bubble_outline_evaporate = part_system_create();



		part_type_sprite(global.pt_bubble_outline_evaporate, s_bubble_outline , true, true, 0);
		part_type_scale(global.pt_bubble_outline_evaporate, 1, 1);
		part_type_colour_rgb(global.pt_bubble_outline_evaporate, 255, 255, 255, 255, 13,13);
		part_type_speed(global.pt_bubble_outline_evaporate, 0.1, 0.4, 0, 0);
		part_type_direction(global.pt_bubble_outline_evaporate, 90, 90, 0, 0);
		part_type_life(global.pt_bubble_outline_evaporate,s_1,s_2);


		var s_1 = SEC*.1;
		var s_2 = SEC*.15;
		//particle
		part_type_sprite(global.pt_bubble_evaporate, s_bubble , true, true, 0);
		part_type_scale(global.pt_bubble_evaporate, 1, 1);
		part_type_colour_rgb(global.pt_bubble_evaporate, 255, 255, 255, 255, 13,13);
		part_type_speed(global.pt_bubble_evaporate, 0.1, 0.4, 0, 0);
		part_type_direction(global.pt_bubble_evaporate, 90, 90, 0, 0);
		part_type_life(global.pt_bubble_evaporate,s_1,s_2);
	
		global.pt_confetti  = part_type_create();
		// Create confetti
		global.sys_confetti = part_system_create();
	

	part_type_orientation(global.pt_confetti , 0, 0, 0, 0, 0);






}