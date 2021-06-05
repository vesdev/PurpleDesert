// Script assets have changed for v2.3.0 

function draw_enemy_intention(xx,yy, construct, sprite_only){

		//don't show the attacking sprite
		if current_turn = e_current_turn.enemy_ and construct.finished_attacking exit;
		
		var override = false;
		var override_text = "";
		var override_sprite = noone;
		if construct.buff.asleep.amount > 0  { 
			override_text = "IS ASLEEP [s_status_sleep]";
			override_sprite = s_status_sleep;
			override = true;
		}
		
		
		
		
		xx += construct.intention_x_offset;
		
		var attack_array_ = construct.attack_array;	
		var queue_pos = construct.current_attack_queue;
		var intention_struct_     = construct.attack_array[@ queue_pos];
		var desc = intention_struct_.desc();
		var type = intention_struct_.type;
				
		var scr = intention_struct_.script_;
		var sprite = intention_struct_.sprite;
	
	
		intention_struct_.target = player;
		intention_struct_.creator = construct;
	
	
	if sprite_only { 
			construct.showing_intentions = false;
			yy -= construct.intention_y_offset;
			///DRAW DAMAGE NUMBER HERE, special case for the attack
			if allow_player_input(){
			
			var len = array_length(active_enemies);
			var i = 	array_find_value(construct, active_enemies);	
				var time_ = current_time + i * SEC*5;
					yy += sin(time_*0.005)*2;
			}
			
			
		if !override{ 
			if type = e_intentions.attack || type = e_intentions.attack_armor
			|| type = e_intentions.attack_debuff
			
			{  
			//check to see if we attack 
			
				var spr_width = sprite_get_width(sprite);
				var spr_height = sprite_get_height(sprite);
				
				total_intent_enemy_damage += get_damage_intent(construct,queue_pos);
				scribble("[fa_left][fa_middle][c_gum][outline_boon]"+get_damage_string(construct,queue_pos)).draw(xx+spr_width*.5,yy+spr_height*.5);
			}
		}else{
			sprite = override_sprite;	
		}
		//	draw_outline_thick(sprite,0,xx,yy,1,1,0,c_white,1);
			draw_outline(sprite,0,xx,yy,1,1,0,C_DARK,1);
			draw_sprite_ext(sprite,0,xx,yy,1,1,0,c_white,1);
			construct.intent_timer = 0;
		}else{		
		yy -= 80;
		construct.showing_intentions = true;

		if  type = e_intentions.attack || type = e_intentions.attack_armor ||
		
			type = e_intentions.attack_debuff
		{  
				var damage =  construct.attack_array[@ queue_pos].amount; //don't touch this
				
				var desc = intention_struct_.desc(get_damage_string(construct,queue_pos));
				total_intent_enemy_damage += get_damage_intent(construct,queue_pos);
			//	var desc = attack_array_[@ queue_pos][@ 0][@ 2](get_damage_string(construct,queue_pos));			
		}
		
	if override { 
		desc = override_text;	
	}
			//+construct.title+" "+
	 var scrib = 	scribble("[fa_center]"+string(desc)).wrap(160);
		
		var time = SEC*.3;
		var timer = construct.intent_timer;
		var scale = 1;
		var offset = 5;
		var change = 15;
		var yoffset = 0;
		if  timer <= time{ 
				yoffset = easings(e_ease.easeoutexpo,-30,30,time,timer);
				offset = easings(e_ease.easeoutback,offset-change,change,time,timer);
				scale = easings(e_ease.easeoutback,0,1,time,timer);
					construct.intent_timer++;
					yy -= yoffset;
		}
		var bbox = scrib.get_bbox(xx,yy);
		var _l = bbox.x0-offset;
		var _t = bbox.y0-offset;
		var _r = bbox.x3+offset;
		var _b = bbox.y3+offset;
		//C_DARK 
		//draw_rectangle(_l,_t,_r,_b,true);
		
		
		nine_slice( s_nine_slice_default,_l,_t,_r,_b,1,C_GUM);
	
		scrib.draw(xx,yy);
		//check to see if we can attack more than once
		}
}




function get_damage_intent(struct, queue_pos){
		var damage =  struct.attack_array[@ queue_pos].amount; //don't touch this
		var target =  struct.attack_array[@ queue_pos].target;

		//multi hit
		if is_array(damage ){ 	
				var mult = struct.attack_array[@ queue_pos].amount[@ 1];
				damage = check_damage(struct,target, damage[0]);
				return 	(damage )*(mult);	

		}else{
			damage = check_damage(struct,target, damage);
			return 	(damage);	
		}	

}
function get_damage_string(struct, queue_pos){
		var damage =  struct.attack_array[@ queue_pos].amount; //don't touch this
		var target =  struct.attack_array[@ queue_pos].target;

		//multi hit
		if is_array(damage ){ 	
				var mult = struct.attack_array[@ queue_pos].amount[@ 1];
				damage = check_damage(struct,target, damage[0]);
				return 	string(damage )+"X"+string(mult);	

		}else{
			damage = check_damage(struct,target, damage);
			return 	string(damage);	
		}	
}

function get_enemy_intended_damage(amount) { 
	
	return amount;
}

