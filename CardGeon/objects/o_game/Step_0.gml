/// @description Insert description here

if keyboard_check_pressed(ord("F")){	
    if window_get_fullscreen()
        {
		var w = display_get_width();
		var h = display_get_height();
		camera.setFullscreen(0,w,h);
 }else{
		var w = display_get_width();
		var h = display_get_height();
		camera.setFullscreen(1,w,h);
        }    
}

with synth_wave { 

xscale += (mouse_wheel_up() - mouse_wheel_down())*0.1;
yscale = xscale;
bm_2 += keyboard_check(vk_up) - keyboard_check(vk_down);

if(active)
{
		xscale =  lerp(xscale ,1, 0.03);
		yscale =  lerp(yscale ,1, 0.03);
	
}
else
{
	xscale =  lerp(xscale ,0, 0.1);
	yscale =  lerp(yscale ,0, 0.1);
}

}



#region glance


#endregion

input_step();
wait_for_the_attack_to_play_out_timer--;
	if allow_player_input()  {  
			//scribble((("[fa_center]"+not_enough_mana+string( hand[| hand_hover_array].cost )+"[]/"+string(player.mana )+"\n\n"+ hand[| hand_hover_array].keywords_add_text() +   hand[| hand_hover_array].desc()	))).wrap(150).draw(gui_width*.5 +xoffgame,180 +yoffgame);
	}
	show_keyword_timer--;
	if !drawing_keywords { 
	
		keyword_easeing_x = 0;
		keyword_easeing_y = 0;
		keyword_easing_timery = 0;	
		keyword_easing_timerx = 0;	
				
		keyword_flash_timer = 1;
		show_keyword_timer = show_keyword_time;
		tip_yoffset = 50;	
	
	
	}else{ 
			tip_yoffset = lerp(tip_yoffset,0,.8);
		
	}
	drawing_keywords = false;

/*
//ik

for (var j =0; j< array_length(wire_array); j++){ 



var target_x = mouse_x;
var target_y = mouse_y;

wire_array[@ j].seg_x[wire_array[@ j].seg_amount] = target_x;
wire_array[@ j].seg_y[wire_array[@ j].seg_amount] = target_y;

for (var i = wire_array[@ j].seg_amount-1; i >= 0; i--) {
	
	var dir = point_direction(wire_array[@ j].seg_x[i],wire_array[@ j].seg_y[i],wire_array[@ j].seg_x[i+1],wire_array[@ j].seg_y[i+1]);
	
	var ldx = lengthdir_x(wire_array[@ j].seg_length, dir);
	var ldy = lengthdir_y(wire_array[@ j].seg_length, dir);
	
	wire_array[@ j].seg_x[i] = wire_array[@ j].seg_x[i+1] - ldx;
	wire_array[@ j].seg_y[i] = wire_array[@ j].seg_y[i+1] - ldy;
} 

	if (wire_array[@ j].arm_pinned) {
	
		wire_array[@ j].seg_x[0] = wire_array[@ j].startx;
		wire_array[@ j].seg_y[0] = wire_array[@ j].starty;
	
		for (var i = 1; i <= wire_array[@ j].seg_amount; i++) {
			var dir = point_direction(wire_array[@ j].seg_x[i-1], wire_array[@ j].seg_y[i-1], wire_array[@ j].seg_x[i], wire_array[@ j].seg_y[i]);
		
			var ldx = lengthdir_x(wire_array[@ j].seg_length, dir);
			var ldy = lengthdir_y(wire_array[@ j].seg_length, dir);
		
			wire_array[@ j].seg_x[i] = wire_array[@ j].seg_x[i-1] + ldx;
			wire_array[@ j].seg_y[i] = wire_array[@ j].seg_y[i-1] + ldy;
		}
	}
}
*/