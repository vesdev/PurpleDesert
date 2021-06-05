// Script assets have changed for v2.3.0 see
function init_input() { 
	
	gp_id_default = 0; //default controller selected
	gp_id = 0;

	gamepadDetected	= false;
	gamepadID		= noone;
	gamepadType		= noone;
	thresh = .45;
	
	global.controller = false;
	
	
	global.sprite_m1 = "[s_right_trigger]";

	global.right_key = ord("D");
	global.up_key = ord("W");
	global.down_key = ord("S");
	global.left_key = ord("A");
	global.restart_key = ord("E");
	global.bomb_key = ord("F");
	global.badge_key = ord("R");

	global.action_key = ord("Z");
	global.back_key = ord("X");

	global.pause_key = vk_escape;
	global.mouse_key = mb_left;
	global.mouse_key_2 = mb_right
}



function input_step(){

	if !global.controller{
		sword_sprite = "s_m2_button";
		shoot_sprite = "s_m1_button";
	    roll_sprite =  "s_space_bar";
		pickup_sprite = "s_space_bar";
		swap_sprite = "s_q_button"
		restart_sprite = "s_select"
		choose_sprite = "s_e_button";	
		}else{
		sword_sprite = "s_right_bumber";
		shoot_sprite = "s_right_trigger";
		roll_sprite =  "s_left_trigger";
		pickup_sprite = "s_a_button";
		swap_sprite = "s_b_button";
		restart_sprite = "s_r_button";
		choose_sprite = "s_x_button";
	}


	up_check = keyboard_check(global.up_key) or keyboard_check(vk_up);
	right_check = keyboard_check(global.right_key) or keyboard_check(vk_right);
	left_check = keyboard_check(global.left_key) or keyboard_check(vk_left);
	down_check = keyboard_check(global.down_key) or keyboard_check(vk_down);


	// Menu Navigation input

	up = keyboard_check_pressed(global.up_key) or keyboard_check_pressed(vk_up);
	right= keyboard_check_pressed(global.right_key) or keyboard_check_pressed(vk_right);
	left = keyboard_check_pressed(global.left_key) or keyboard_check_pressed(vk_left);
	down = keyboard_check_pressed(global.down_key) or keyboard_check_pressed(vk_down);



	//Action and back input
	back =  keyboard_check_pressed(global.back_key);
	action = keyboard_check_pressed(global.action_key);
	extra = keyboard_check_pressed(vk_enter);
	restart_key = keyboard_check_pressed(global.restart_key);
	bomb = keyboard_check_pressed(global.bomb_key);
	badge = keyboard_check(global.badge_key);

	//Action and back pressed input
	action_check = keyboard_check(global.action_key);
	back_check = keyboard_check(global.back_key);
	extra_check = keyboard_check(vk_enter);
	bomb_check = keyboard_check(global.bomb_key);
	badge_check = keyboard_check(global.badge_key);
	
	select = noone;

	pause_pressed = keyboard_check_pressed(global.pause_key);

	m1_check = mouse_check_button(global.mouse_key);
	m2_check = mouse_check_button(global.mouse_key_2);

	m1_pressed = mouse_check_button_pressed(global.mouse_key);
	m2_pressed = mouse_check_button_pressed(global.mouse_key_2);

	m1_release = mouse_check_button_released(global.mouse_key);
	m2_release = mouse_check_button_released(global.mouse_key_2);

	weapon_swap = keyboard_check_pressed(ord("Q"));

	interact = keyboard_check_pressed(ord("E"));
	interact_check = keyboard_check(ord("E"));
	interact_release = keyboard_check_released(ord("E"));


	if gamepad_is_connected(gp_id)  and global.controller = true{
	//Movement Input
	right = gamepad_axis_value(gp_id,gp_axislh) > thresh;
	left = gamepad_axis_value(gp_id,gp_axislh) < -thresh;
	down = gamepad_axis_value(gp_id,gp_axislv) > thresh;
	up =   gamepad_axis_value(gp_id,gp_axislv) < -thresh;

	restart_key = gamepad_button_check_pressed(gp_id,gp_select);

	if gamepad_button_check(gp_id,gp_padl){
	left = true;
	}
	if gamepad_button_check(gp_id,gp_padu){
	up = true;
	}
	if gamepad_button_check(gp_id,gp_padd){
	down = true;
	}
	if gamepad_button_check(gp_id,gp_padr){
	right = true;
	}

	// Menu Navigation input

	select = gamepad_button_check_pressed(gp_id,gp_select);


	//right
	if gamepad_axis_value(gp_id,gp_axislh) > thresh or gamepad_button_check_pressed(gp_id,gp_padr) {
		if right_flag = false{
		right_flag = true;
		right_pressed = true;
		}
	}else{
		right_pressed = false;
		right_flag = false;
	}

	//left
	if gamepad_axis_value(gp_id,gp_axislh) < -thresh or  gamepad_button_check_pressed(gp_id,gp_padl){
		if left_flag = false{
		left_flag = true;
		left_pressed = true;
		}
	}else{
		left_pressed = false;
		left_flag = false;
	}

	//down
	if gamepad_axis_value(gp_id,gp_axislv) > thresh or  gamepad_button_check_pressed(gp_id,gp_padd) {
		if down_flag = false{
		down_flag = true;
		down_pressed = true;
		}
	}else{
		down_pressed = false;
		down_flag = false;
	}

	//up
	if gamepad_axis_value(gp_id,gp_axislv) < -thresh or gamepad_button_check_pressed(gp_id,gp_padu) {
		if up_flag = false{
		up_flag = true;
		up_pressed = true;
		}
	}else{
		up_pressed = false;
		up_flag = false;
	}

	//Action and back input
	back  = gamepad_button_check_pressed(gp_id,gp_shoulderrb) > thresh;
	action = gamepad_button_check_pressed(gp_id,gp_face1) or gamepad_button_check_pressed(gp_id, gp_shoulderlb)  > thresh;
	//or gamepad_button_check_pressed(gp_id,gp_face3);

	badge = gamepad_button_check_pressed(gp_id,gp_face4) ;
	badge_check = gamepad_button_check(gp_id,gp_face4);
	bomb =		 gamepad_button_check_pressed(gp_id,gp_shoulderl);
	bomb_check = gamepad_button_check(gp_id,gp_shoulderl);

	weapon_swap = gamepad_button_check_pressed(gp_id,gp_face2);

	interact = gamepad_button_check_pressed(gp_id,gp_face3);
	interact_check = gamepad_button_check(gp_id,gp_face3);
	interact_release = gamepad_button_check_released(gp_id,gp_face3);

	extra = gamepad_button_check_pressed(gp_id,gp_face1) > thresh;//a button

	//Action and back pressed input
	back_check  = gamepad_button_check(gp_id,gp_shoulderrb) > thresh;
	action_check = gamepad_button_check(gp_id,gp_face1) or gamepad_button_check_pressed(gp_id, gp_shoulderlb)  > thresh;
	extra_check = gamepad_button_check(gp_id,gp_face1) > thresh//a button


	pause_pressed = gamepad_button_check_pressed(gp_id,gp_start);
	//m1_check = gamepad_button_check(gp_id,gp_shoulderrb) > thresh;
	//m2_check = mouse_check_button(global.mouse_key_2);

	m1_pressed = gamepad_button_check_pressed(gp_id,gp_shoulderrb) > thresh;
	m2_pressed = gamepad_button_check_pressed(gp_id,gp_shoulderr) or 
	gamepad_button_check_pressed(gp_id,gp_face3);

	m1_release = gamepad_button_check_released(gp_id,gp_shoulderrb) > thresh;
	gamepad_set_button_threshold(gp_id, 0.1);    // Set the "threshold" for the triggers


	}
}