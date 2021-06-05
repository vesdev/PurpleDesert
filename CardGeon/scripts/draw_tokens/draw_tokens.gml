// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_tokens(){

for (var i = player.max_token_amount-1; i >= 0; i--) {
	var x_ = player_defaultx_position-56 + i * 25 +xoffgame;
	var y_ = player_defaulty_position+camera.height*0.14 +yoffgame;
	
var sprite = s_token_circle;
	
	var width = sprite_get_width(sprite);
	var height = sprite_get_height(sprite);
	var xoffset = sprite_get_xoffset(sprite);
	var yoffset = sprite_get_yoffset(sprite);
	
	var spot_col = c_white;
	if allow_player_input() and boon_collision(x_,y_-7, x_+width,y_+height , MX,MY ){
		draw_set_color(C_LIME);
		var spot_col = C_LIME;
		draw_status_information = "[c_yellow]UNOCCUPIED TOKEN SLOT[] [s_status_token]\n YOU CAN SUMMON A TOKEN HERE.";
	}
	draw_outline( s_token_circle, 0, x_, y_, 1, 1, 0, spot_col,1);
	draw_sprite_ext(s_token_circle, 0 , x_, y_ , 1, 1, 0, C_DARK,1 );
}

var len = array_length(player.token_array);

if len = 0 exit;

	for (var i = len-1; i >= 0; i--) {
		
			var token_struct = player.token_array[@ i];
			var max_len =  (player.max_token_amount-1) * 25
	
			var x_ =  player_defaultx_position-53 - i * 25 + max_len +xoffgame ;
			var y_ =  player_defaulty_position+80 +yoffgame;
	
			var sprite =  s_token_circle;
	
	
	
			var width = sprite_get_width(sprite);
			var height = sprite_get_height(sprite);
			var xoffset = sprite_get_xoffset(sprite);
			var yoffset = sprite_get_yoffset(sprite);
	
			var spot_col = c_white;
			
			var sprite = token_struct.current_sprite;
			
			if check_for_token != len { 
				check_for_token = len;
				 particle_explode( x_+6,y_+5,15,c_white,true, SEC*.7, false);
				 
				 if player.buff.token_summoning_restores_mana.amount > 0 { 
						change_mana(player.buff.token_summoning_restores_mana.amount,false);
				 }
				 
			}
			
			//draw_rectangle(x_,y_-7, x_+width,y_+height,0);
			if allow_player_input() and boon_collision(x_,y_-7, x_+width,y_+height , MX,MY ){
				draw_status_information = "[c_yellow]"+token_struct.title+"[]"+" "+"["+sprite_get_name(token_struct.sprite_idle)+"]\n"+token_struct.desc()+"\n\n"+token_struct.desc_additional();//+"\n"+token_str_lasts_turns(token_struct);
				draw_outline_thick(sprite, current_time*0.01 , x_, y_-15 , 1, 1, 0, c_white,1 );
			}
			draw_outline(sprite, current_time*0.01 , x_, y_-15 , 1, 1, 0, C_DARK,1 );
			draw_sprite_ext(sprite, current_time*0.01 , x_, y_-15 , 1, 1, 0, c_white,1 );
		
			draw_set_halign(fa_right);
			draw_set_valign(fa_top);
			
			var str = token_struct.turns_to_live;//  check_token_turns_to_live(token_struct);
			draw_set_halign(fa_right);
			draw_text_outline(x_+20, y_,str,C_DARK);
			draw_set_color(c_yellow);
			if str = 1 draw_set_color(C_GUM);
			draw_text(x_+20, y_,str);
			draw_set_halign(fa_left);
			draw_set_color(c_white);
	}

	if len = 0 { 
		check_for_token = len;
	}
}
