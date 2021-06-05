/// @description 
draw_set_halign(fa_left);
if font != noone {
draw_set_font(font);	
}
var text_width = string_width(text);
timer += timer_amount;
if wobble_timer <= wobble_time{
	wobble_intensity = easings(e_ease.easeinquad,0,1,wobble_time,wobble_timer);
	wobble_timer++;
	timer_amount = easings(e_ease.easeoutexpo,0,1,wobble_time,wobble_timer);
}

if alarm[0] < SEC*.5{
wobble_intensity = lerp(wobble_intensity,0 , 0.2 );	
}


if is_struct(struct){	


var x_ = return_gui_x(struct.x-text_width/2);
var y_ = return_gui_y(struct.y+y_amount);
}else{

var x_ = return_gui_x(x-text_width/2);
var y_ = return_gui_y(y+y_amount);	
}



var wavytext_ang = current_time*1;

var String = text;
var TextSize = size;
var XPos = x_;
var YPos = y_;

//var tf = undefined;

    var strlen = string_length(String);
    var i = 0;
    var length = 0;
    var lengthy = 0;
    var dark = C_BLACK;
	
    while(i < strlen){
    
        if(string_char_at(String,i+1) == "&"){
			
            lengthy += string_height(string_char_at(String,i+1));
            length = string_width("  ");
        } else {
			
			var len = length;
			len = clamp(len,0,8);
			
			
			var wobble = sin(((length+2)*.001-(timer+SEC*.35)*.001)*51.01)*3*wobble_intensity;
			var wobblec = 0;//cos((length*.001-(timer+SEC*.35)*.001)*51.01)*3*wobble_intensity*.25;
			
			if outline != false { 
				
				draw_set_color(outline);
				    draw_text_ext_transformed(
						2+XPos + length+wobblec ,
						YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);
	
				    draw_text_ext_transformed(
						-2+XPos + length+wobblec ,
						YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);

				    draw_text_ext_transformed(
						XPos + length+wobblec ,
						2+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);
	
				    draw_text_ext_transformed(
						XPos + length+wobblec ,
						-2+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);

////////
				    draw_text_ext_transformed(
						2+XPos + length+wobblec ,
						-1+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);
	
				    draw_text_ext_transformed(
						-2+XPos + length+wobblec ,
						1+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);

				    draw_text_ext_transformed(
						1+XPos + length+wobblec ,
						2+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);
	
				    draw_text_ext_transformed(
						-1+XPos + length+wobblec ,
						-2+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);




				    draw_text_ext_transformed(
						2+XPos + length+wobblec ,
						1+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);
	
				    draw_text_ext_transformed(
						-2+XPos + length+wobblec ,
						-1+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);

				    draw_text_ext_transformed(
						-1+XPos + length+wobblec ,
						2+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);
	
				    draw_text_ext_transformed(
						1+XPos + length+wobblec ,
						-2+YPos + lengthy+wobble,string_char_at(String,i+1),10,300,TextSize,TextSize,0);

////

			}
	  
	
			 draw_set_color(dark);	
            draw_text_ext_transformed(
			1+XPos + length+wobblec ,
			YPos + lengthy+wobble,
			string_char_at(String,i+1),
			10,
			300,
			TextSize,
			TextSize,
			0);
			
			 draw_text_ext_transformed(
			-1+XPos + length+wobblec ,
			YPos + lengthy+wobble,
			string_char_at(String,i+1),
			10,
			300,
			TextSize,
			TextSize,
			0);
			
			 draw_text_ext_transformed(
			XPos + length+wobblec ,
			1+YPos + lengthy+wobble,
			string_char_at(String,i+1),
			10,
			300,
			TextSize,
			TextSize,
			0);
			
			draw_text_ext_transformed(
			XPos + length+wobblec ,
			-1+YPos + lengthy+wobble,
			string_char_at(String,i+1),
			10,
			300,
			TextSize,
			TextSize,
			0);
			
			draw_text_ext_transformed(
			1+XPos + length+wobblec ,
			1+YPos + lengthy+wobble,
			string_char_at(String,i+1),
			10,
			300,
			TextSize,
			TextSize,
			0);
			
			draw_set_color(color);
			draw_text_ext_transformed(
			XPos + length+wobblec,
			YPos + lengthy+wobble,
			string_char_at(String,i+1),
			10,
			300,
			TextSize,
			TextSize,
			0);
			
			
            length += string_width(string_char_at(String,i+1))*1.3;
        }
        if(string_char_at(String,i+1) == "#"){
            lengthy += string_height(string_char_at(String,i+1));
            length = 0;
        }
        wavytext_ang -= 1;
        i++;
    }









if sprite != noone and is_struct(struct) {

	draw_sprite_ext(sprite,0,struct.x,struct.y,size,size,0,c_white,1);
}
draw_set_font(font_boon);
draw_set_alpha(1);
draw_set_colour(c_white);