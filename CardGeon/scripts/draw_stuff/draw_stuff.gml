// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_stuff(){
var len = array_length(all_passive_treasures);
for (var i = 0; i < len; ++i){ 
		var struct = all_passive_treasures[@ i];
		var xx = 15 + 24 * i +xoffgame;
		var yy = 20 +yoffgame;
		var sprite = struct.sprite
		var amount = struct.amount;
		var bbox_xoffset = 10;
		var bbox_yoffset = 15;
		var spritexoff = sprite_get_xoffset(sprite);
		var spriteyoff = sprite_get_yoffset(sprite);
		var width = sprite_get_width(sprite);
		var height = sprite_get_height(sprite);
		
		var _l = xx-	bbox_xoffset;									   //xx-spritexoff-bbox_xoffset;
		var _t = yy - bbox_yoffset*2;										   //yy-spriteyoff-bbox_yoffset;
		var _r = xx + bbox_xoffset;									   // xx+width-spritexoff+bbox_xoffset;
		var _b = yy + bbox_yoffset*.4;										   // yy+height-spriteyoff+bbox_yoffset;
																			 
		//draw_rectangle(_l,_t,_r,_b,1);
		//	draw_outline(sprite, 0, xx,yy,1,1,0,c_white,1);
	
		if allow_player_input() and boon_collision(_l,_t,_r,_b ,MX,MY){ 
		draw_outline(sprite, 0, xx,yy,1,1,0,c_white,1);
			if draw_status_information != noone { 
			draw_status_information = "[c_yellow]"+struct.title+"[] ["+string(sprite_get_name(sprite))+"]\n"+struct.desc();
			}
		}
		
		
		draw_sprite(sprite, 0, xx,yy);
		if amount != noone{
		draw_set_color(c_white);
		draw_set_halign(fa_right);
		draw_text_outline(xx+width,yy,string(amount),c_black);
		draw_text(xx+width,yy,string(amount));
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		}

}

}