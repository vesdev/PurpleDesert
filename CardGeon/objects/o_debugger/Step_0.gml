/// @description Insert description here
// You can write your code in this editor
if debug_mode{
x += 1;
	if x > xstart+20{
			room_goto(r_menu);
			instance_destroy();
	}
}else{
		room_goto(r_menu);
		instance_destroy();
	
}