/// @description double_circle transitions


/// @description double_circle transitions
	timer++;

persistent = true;

if second_target = noone{
//instance_destroy();
//	exit;
}


if (surface_exists(surf)) {
	surface_set_target(surf);
	//Set the dark overlay
	
	

	draw_clear_alpha(C_DARK,1);

	//Set light circles
	gpu_set_blendmode(bm_subtract);
	draw_set_colour(c_white);
	//Set light circles
	gpu_set_blendmode(bm_subtract);
	draw_set_colour(c_white);
	//1.4 becaues that's how long our alarm is
//	if alarm[2] > -1{

	var total_change = 300;
	var difference = 30;


	
	if timer <= time {
	radius = easings(e_ease.easeoutexpo,total_change, -total_change+difference,time,timer);
	}

	
	if timer2 <= time2 and timer > time and timer > time2 + SEC*.5 {
		radius = easings(e_ease.easeinback,difference, -difference,time2,timer2);
		timer2++;
	}
	
		if instance_exists(target) {
			draw_circle(target.x + random_range(-.2,.2), target.y+ random_range(-.2,.2),radius,false);
			}else{
			draw_circle(x + random_range(-.2,.2), y+ random_range(-.2,.2),radius,false);
		}
	
		
//	}
//  Reset all of the set draws, or else everything else gets the overridden blend modes
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
	surface_reset_target();
}else{
	surf = surface_create(room_width,room_height);
	surface_set_target(surf);
	draw_clear_alpha(C_DARK,0);
	draw_set_color(c_white);
	surface_reset_target();
}

if timer2 > time2 and timer > time2 + time+  SEC*.5 {

	if next_game_state != noone{
		timer = 0;
		timer2 = 0;
		o_game.game_state = next_game_state;
		instance_destroy();
		//alarm[3] = time2;
	}
}


