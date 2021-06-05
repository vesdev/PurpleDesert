/// @description CIRCLE OPEN
/// @description add a surface the size of the room




if second_target != noone
{
	if instance_exists(second_target)
	{
		x = second_target.x;
		y = second_target.y;
	}
}

if (surface_exists(surf)) {
	surface_set_target(surf);
	//Set the dark overlay
	draw_set_colour(c_black);
	draw_set_alpha(1);

	draw_rectangle(0,0,room_width+4000,room_height+3000,0);	

	//Set light circles
	gpu_set_blendmode(bm_subtract);
	draw_set_colour(c_white);
	//Set light circles
	gpu_set_blendmode(bm_subtract);
	draw_set_colour(c_white);
	//1.4 becaues that's how long our alarm is
	radius = easings(e_ease.easeinquart,1, 600,SEC*1.4,timer);
	timer++;
	if instance_exists(o_player){
		//draw_circle(o_player.x + random_range(-.2,.2), o_player.y-8+ random_range(-.2,.2),radius,false);
		var c = 16
		for(i=0;i<c;i++)
		{
			draw_set_alpha(1/i);
			draw_circle(o_player.x+random_range(-.2,.2),o_player.y+random_range(-.2,.2),radius*(1+(0.008*i)),false);
		}
	}else{
		var c = 16
		for(i=0;i<c;i++)
		{
			draw_set_alpha(1/i);
			draw_circle(x+random_range(-.2,.2),y+random_range(-.2,.2),radius*(1+(0.008*i)),false);
		}
		}
	//Reset all of the set draws, or else everything else gets the overridden blend modes
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
	surface_reset_target();
}else{
	surf = surface_create(1000,1000);

	surface_set_target(surf);
	draw_clear_alpha(c_black,0,);
	draw_set_color(c_white);
	surface_reset_target();

}

