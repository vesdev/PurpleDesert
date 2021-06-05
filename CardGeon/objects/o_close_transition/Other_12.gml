/// @description CIRCLE CLOSE



if (surface_exists(surf)) {
	surface_set_target(surf);
	// Set the dark overlay
	draw_set_colour(C_DARK);
	draw_set_alpha(1);
	draw_rectangle(0,0,room_width,room_height,0);
	
	// Set light circles
	gpu_set_blendmode(bm_subtract);
	draw_set_colour(c_white);
	// 1.4 becaues that's how long our alarm is
	//radius = easings(e_ease.easeoutexpo,300, -300,SEC*1.4,timer);
	

	var total_change = 300;
	var difference = 30;
	time = SEC;
	
	if timer <= time {
		radius = easings(e_ease.easeoutexpo,total_change, -total_change+difference,time,timer);
		alarm[0] = SEC*.1;
	}

	
	if timer2 <= time2 and timer > time and timer > time2 + SEC*.5 {
		radius = easings(e_ease.easeinback,difference, -difference,time2,timer2);
		timer2++;
		alarm[0] = SEC*.1;
	}else {
		if timer > time and timer > time2 + SEC*.5 and next_room != noone { 
			room_goto(next_room);
			instance_destroy();
		}
	}

	timer++;
	// Blurry outside tingies
	
var s = 0;
	
	draw_circle(1+x+random_range(-s,s),y+random_range(-s,s),radius,false);
	draw_circle(-1+x+random_range(-s,s),y+random_range(-s,s),radius,false);
	draw_circle(x+random_range(-s,s),1+y+random_range(-s,s),radius,false);
	draw_circle(x+random_range(-s,s),-1+y+random_range(-s,s),radius,false);

	var c = 1
	for(i=0;i<c;i++)
	{
	//	draw_set_alpha(1/i);//*(1+(0.007*(i^1.25)))
		draw_circle(x+random_range(-s,s),y+random_range(-s,s),radius,false);
	}
	// Reset
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


//draw_text(20,20,"IdasfsdffsdfdsfsdfdsfH");
