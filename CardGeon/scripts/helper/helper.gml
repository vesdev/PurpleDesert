// scripts that make our life easier <3 Can be used in any project

function debug() {
	var str = ""
	for(var i=0; i<argument_count; i++) {
		str += string(argument[i]);
	}
	show_debug_message(str);
}
function draw_shape(xx, yy, sides, angle, radius, color, alpha, fill, width)
{

	var prim = pr_trianglefan;
	var dir = 0;
	draw_set_colour(color);
	draw_set_alpha(alpha);
	
	if(fill)
	{
		draw_primitive_begin(prim);
	}
	else
	{
		draw_primitive_begin(pr_trianglestrip);
	}
	
	for (var i = 0; i <= ceil((sides)); i++)
	{
	    dir = ((((360 / sides) * i) + angle) - (360 / sides))
	    radius = radius
	       
	    draw_vertex_colour((xx + lengthdir_x((radius - width), dir)), (yy + lengthdir_y((radius - width), dir)), color, alpha);
	    draw_vertex_colour((xx + lengthdir_x(radius, dir)), (yy + lengthdir_y(radius, dir)), color, alpha); 
	}
	draw_primitive_end();
	draw_set_alpha(1)
	return;
	

}
//BOON's perfect collision system, because I don't trust instance_place or instance_position
function boon_collision(_l,_t,_r,_b, x_check, y_check) { 

	return x_check > _l and x_check < _r and 
			y_check > _t and y_check < _b;
}

function boon_collision_on_grid(_l,_t,_r,_b, x_check, y_check) { 

	_l = draw_on_grid(_l);
	_t = draw_on_grid(_t);
	_r = draw_on_grid(_r);
	_b = draw_on_grid(_b);
	
	return x_check > _l and x_check < _r and 
			y_check > _t and y_check < _b;
}




function boon_collision_polygon(x0,y0,x1,y1,x2,y2,x3,y3, x_check, y_check) { 
	
	return x_check > x0 and x_check > x2 and 
	    	x_check < x1 and x_check < x3 and 
			
			 y_check > y0 and y_check > y1 and 
	    	y_check < y2 and y_check < y3;
}

function divide(numerator,denominator) { 
	//use this if you think the denominator can be 0
	if denominator  = 0 return 0;
	
	return numerator / denominator;	
}

function sleep(Milliseconds) {

/*
	var sleep_dur = Milliseconds;
	var end_time = current_time + sleep_dur;

	while (current_time < end_time){};
*/
}

function draw_outline(sprite, index, xx, yy, xscale, yscale, angle, outline_color, alpha) {
	
	shader_set(sh_fill_with_image_blend);
	draw_sprite_ext(sprite, index, xx+1,yy,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx-1,yy,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx,yy+1,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx,yy-1,xscale, yscale, angle, outline_color, alpha);
	shader_reset();
	
}


function draw_sprite_ext_outline(sprite, index, xx, yy, xscale, yscale, angle, outline_color, alpha) {
	
	draw_sprite_ext(sprite, index, xx+1,yy,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx-1,yy,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx,yy+1,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx,yy-1,xscale, yscale, angle, outline_color, alpha);
	
}

function draw_outline_thick(sprite, index, xx, yy, xscale, yscale, angle, outline_color, alpha) {
	
	shader_set(sh_fill_with_image_blend);
	draw_sprite_ext(sprite, index, xx+2,yy,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx-2,yy,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx,yy+2,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx,yy-2,xscale, yscale, angle, outline_color, alpha);	
	
	draw_sprite_ext(sprite, index, xx+2,yy+1,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx-2,yy-1,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx+1,yy+2,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx-1,yy-2,xscale, yscale, angle, outline_color, alpha);	

	draw_sprite_ext(sprite, index, xx+2,yy-1,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx-2,yy+1,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx+1,yy-2,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx-1,yy+2,xscale, yscale, angle, outline_color, alpha);	
		
	draw_sprite_ext(sprite, index, xx+1,yy,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx-1,yy,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx,yy+1,xscale, yscale, angle, outline_color, alpha);
	draw_sprite_ext(sprite, index, xx,yy-1,xscale, yscale, angle, outline_color, alpha);
	shader_reset();
	
}


function array_mean(_array) {
	var _s = 0;
	var len = array_length(_array);
	for (var i=0;i<len;i++) {
	    _s+=_array[i];	
	}
	return _s/len;
}

function array_sum(_array) {
	var _s = 0;
	for (var i=0;i< array_length(_array);i++) {
	    _s +=_array[i];	
	}
	return _s;
}

function array_find_value(what_we_are_looking_for, _array) {
	var _array_size = array_length(_array);
	//Look for value

	for (var i =0;i< _array_size;i++){
		if what_we_are_looking_for == _array[i]{
			//if it finds it , it will return i
			return i;
		}
	}
	//if it cannot find it , it will return negative 1
	return -1;
}

function array_find_index(_value, _array) {
	var _array_size = array_length(_array);
	//Look for value

	for (var i =0;i< _array_size;i++){
		if _value == _array[i]{
			//if it finds it , it will return i
			return _array[i];
		}
	}
	//if it cannot find it , it will return negative 1
	return -1;
}



//Juju Adam's talk, "I love data" https://youtu.be/Uj7nr6vSRvs?t=306
function array_add(array_, index_, value_) {

	var length_ = array_length( array_);

	for (var i = length_; i > index_; i--){
		array_[@ i] = array_[i-1];	
	}

	array_[@ index_] = value_;
}


function array_add_return(array_, index_, value_) {

	//creates a new array so we don't mess with the original one
	var new_array = [];
	
	var length_ = array_length(array_);
   array_copy(new_array, 0, array_, 0, length_);
   

	for (var i = length_; i > index_; i--){
		new_array[@ i] = new_array[i-1];	
	}

	new_array[@ index_] = value_;
	return new_array;
}

function array_replace_return(array_, index_, value_) {

	//creates a new array so we don't mess with the original one
	var new_array = [];
	
	var length_ = array_length(array_);
   array_copy(new_array, 0, array_, 0, length_);
   

	new_array[@ index_] = value_;
	return new_array;
}

function array_shuffle(array) { 
	boon_randomize();
	//randomize the values in an array
	for(var i = 0; i < array_length(array); i++)
	{

		var i = irandom_range(1, array_length(array) - 1);
		var tmp = array[i];
		array[i] = array[0];
		array[0] = tmp;
	}

	return array;
}

///@desc easings(function,start,change,timer,timer);
///@param function
///@param start
///@param change
///@param time
///@param timer

enum e_ease {
	linear,
	easeinquad,
	easeoutquad,
	easeinoutquad,
	easeincubic,
	easeoutcubic,
	easeinoutcubic,
	easeinquart,
	easeoutquart,
	easeinoutquart,
	easeinquint,
	easeoutquint,
	easeinoutquint,
	easeinsine,
	easeoutsine,
	easeinoutsine,
	easeinexpo,
	easeoutexpo,
	easeinoutexpo,
	easeincirc,
	easeoutcirc,
	easeinoutcirc,
	easeinelastic,
	easeoutelastic,
	easeinoutelastic,
	easeinback,
	easeoutback,
	easeinoutback,
	easeinbounce,
	easeoutbounce,
	easeinoutbounce,
	size_
}


	
function easings(function_, start, change, time, timer) {  ///3t and then 5tr  //replaced dratin with tme
	

	//Credits:  http://www.davetech.co.uk/gamemakereasingandtweeningfunctions and http://gizma.com/easing/
	//t = time
	//b = start
	//c = change
	//d = time
	//argument0 = time
	//argument1 = start
	//argument2 = change
	//argument3 = time
	
	if timer > time return start + change;
	

	switch(function_)
	{
	case e_ease.linear:
	{
	return change*timer/time + start;
	}
	case e_ease.easeinquad:
	{
	timer /= time;
	return change*timer*timer + start;
	}
	case e_ease.easeoutquad:
	{
	timer /= time;
	return -change * timer *(timer-2) + start;
	}
	case e_ease.easeinoutquad:
	{
	timer /= time/2;
	if (timer < 1)
	return change/2*timer*timer + start;
	timer--;
	return -change/2 * (timer*(timer-2) - 1) + start;
	}
	case e_ease.easeincubic:
	{
	timer /= time;
	return change*timer*timer*timer + start;
	}
	case e_ease.easeoutcubic:
	{
	timer /= time;
	timer--;
	return change*(timer*timer*timer + 1) + start;
	}
	case e_ease.easeinoutcubic:
	{
	timer /= time/2;
	if (timer < 1)
	return change/2*timer*timer*timer + start;
	timer -= 2;
	return change/2*(timer*timer*timer + 2) + start;
	}
	case e_ease.easeinquart:
	{
	timer /= time;
	return change*timer*timer*timer*timer + start;
	}
	case e_ease.easeoutquart:
	{
	timer /= time;
	timer--;
	return -change * (timer*timer*timer*timer - 1) + start;
	}
	case e_ease.easeinoutquart:
	{
	timer /= time/2;
	if (timer < 1)
	return change/2*timer*timer*timer*timer + start;
	timer -= 2;
	return -change/2 * (timer*timer*timer*timer - 2) + start;
	}
	case e_ease.easeinquint:
	{
	timer /= time;
	return change*timer*timer*timer*timer*timer + start;
	}
	case e_ease.easeoutquint:
	{
	timer /= time;
	timer--;
	return change*(timer*timer*timer*timer*timer + 1) + start;
	}
	case e_ease.easeinoutquint:
	{
	timer /= time/2;
	if (timer < 1)
	return change/2*timer*timer*timer*timer*timer + start;
	timer -= 2;
	return change/2*(timer*timer*timer*timer*timer + 2) + start;
	}
	case e_ease.easeinsine:
	{
	return -change * cos(timer/time * (pi/2)) + change + start;
	}
	case e_ease.easeoutsine:
	{
	return change * sin(timer/time * (pi/2)) + start;
	}
	case e_ease.easeinoutsine:
	{
	return -change/2 * (cos(pi*timer/time) - 1) + start;
	}
	case e_ease.easeinexpo:
	{
	return change * power( 2, 10 * (timer/time - 1) ) + start;
	}
	case e_ease.easeoutexpo:
	{
	return change * ( -power( 2, -10 * timer/time ) + 1 ) + start;
	}
	case e_ease.easeinoutexpo:
	{
	timer /= time/2;
	if (timer < 1)
	return change/2 * power( 2, 10 * (timer - 1) ) + start;
	timer--;
	return change/2 * ( -power( 2, -10 * timer) + 2 ) + start;
	}
	case e_ease.easeincirc:
	{
	timer /= time;
	return -change * (sqrt(1 - timer*timer) - 1) + start;
	}
	case e_ease.easeoutcirc:
	{
	timer /= time;
	timer--;
	return change * sqrt(1 - timer*timer) + start;
	}
	case e_ease.easeinoutcirc:
	{
	timer /= time/2;
	if (timer < 1)
	return -change/2 * (sqrt(1 - timer*timer) - 1) + start;
	timer -= 2;
	return change/2 * (sqrt(1 - timer*timer) + 1) + start;
	}
	//I should point out that from this point I consider the easing to be "Expert" functions
	case e_ease.easeinelastic:
	{
	var _s = 1.70158;
	var _p = 0;
	var _a = change;

	if(timer == 0 || _a == 0)
	return start;

	timer /= time;

	if(timer == 1)
	return start+change;
	if(_p == 0)
	_p = time*0.3;
	if(_a < abs(change))
	{
	_a = change;
	_s = _p*0.25;
	}
	else
	{
	_s = _p / (2 * pi) * arcsin (change / _a);
	}

	return -(_a * power(2,10 * (--timer)) * sin((timer * time - _s) * (2 * pi) / _p)) + start;
	}
	case e_ease.easeoutelastic:
	{
	var _s = 1.70158;
	var _p = 0;
	var _a = change;

	if (timer == 0 || _a == 0)
	    return start;

	timer /= time;

	if (timer == 1)
	    return start + change;
	if (_p == 0)
	    _p = time * 0.3;
	if (_a < abs(change)) 
	{ 
	    _a = change;
	    _s = _p * 0.25; 
	}
	else 
	{
	    _s = _p / (2 * pi) * arcsin (change / _a);
	}

	return _a * power(2, -10 * timer) * sin((timer * time - _s) * (2 * pi) / _p ) + change + start;
	}
	case e_ease.easeinoutelastic:
	{
	var _s = 1.70158;
	var _p = 0;
	var _a = change;

	if (timer == 0 || _a == 0)
	    return start;

	timer /= time*0.5;

	if (timer == 2)
	    return start+change;
	if (_p == 0)
	    _p = time * (0.3 * 1.5);
	if (_a < abs(change))
	{ 
	    _a = change; 
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (change / _a);
	}

	if (timer < 1)
	    return -0.5 * (_a * power(2, 10 * (--timer)) * sin((timer * time - _s) * (2 * pi) / _p)) + start;

	return _a * power(2, -10 * (--timer)) * sin((timer * time - _s) * (2 * pi) / _p) * 0.5 + change + start;
	}
	case e_ease.easeinback:
	{
	var _s = 1.70158;

	timer /= time;
	return change * timer * timer * ((_s + 1) * timer - _s) + start;
	}
	case e_ease.easeoutback:
	{
	var _s = 1.70158;

	timer = timer/time - 1;
	return change * (timer * timer * ((_s + 1) * timer + _s) + 1) + start;
	}
	case e_ease.easeinoutback:
	{
	var _s = 1.70158;

	timer = timer/time*2

	if (timer < 1)
	{
	    _s *= 1.525;
	    return change * 0.5 * (timer * timer * ((_s + 1) * timer - _s)) + start;
	}

	timer -= 2;
	_s *= 1.525

	return change * 0.5 * (timer * timer * ((_s + 1) * timer + _s) + 2) + start;
	}
	case e_ease.easeinbounce:
	{
	return change - easings(e_ease.easeoutbounce,0,change,time,(time - timer)) + start;
	}
	case e_ease.easeoutbounce:
	{
	timer /= time;

	if (timer < 1/2.75)
	{
	    return change * 7.5625 * timer * timer + start;
	}
	else if (timer < 2/2.75)
	{
	    timer -= 1.5/2.75;
	    return change * (7.5625 * timer * timer + 0.75) + start;
	}
	else if (timer < 2.5/2.75)
	{
	    timer -= 2.25/2.75;
	    return change * (7.5625 * timer * timer + 0.9375) + start;
	}
	else
	{
	    timer -= 2.625/2.75;
	    return change * (7.5625 * timer * timer + 0.984375) + start;
	}
	}
	case e_ease.easeinoutbounce:
	{
	if (timer < time*0.5) 
	{
	    return (easings(e_ease.easeinbounce,0,change,time,timer*2)*0.5 + start);
	}

	return (easings(e_ease.easeoutbounce,0,change,time,timer*2 - time)*0.5 + change*0.5 + start);
	}
	default:
	return "418";
	}
}


function return_gui_x(posx) {

	var cl = camera_get_view_x(view_camera[0])
    
	var off_x = posx - cl // x is the normal x position
      
	// convert to gui
	var off_x_percent = off_x / camera_get_view_width(view_camera[0])
       
	return off_x_percent * display_get_gui_width();
}

function return_gui_y(posy) {
	var ct = camera_get_view_y(CAM);       
	var off_y = posy - _CAM_TOP;
	var off_y_percent = off_y / _CAM_HEIGHT; 
	return off_y_percent * display_get_gui_height()
}

function draw_text_outline(xx,yy,str,color) { 
	gpu_set_fog(true,color,0,1);
	draw_text(xx-1,yy,str);
	draw_text(xx+1,yy,str);
	draw_text(xx,yy-1,str);
	draw_text(xx,yy+1,str);
	gpu_set_fog(false,c_white,0,1);
}

function text_outline_thick_transformed(x_,y_,str,col_,xscale,yscale,angle) { 
	
	gpu_set_fog(true,col_,0,1);
	draw_text_transformed(x_-2,y_,str,xscale,yscale,angle);
	draw_text_transformed(x_+2,y_,str,xscale,yscale,angle);
	draw_text_transformed(x_,y_-2,str,xscale,yscale,angle);
	draw_text_transformed(x_,y_+2,str,xscale,yscale,angle);
	
	draw_text_transformed(x_-2,y_-1,str,xscale,yscale,angle);
	draw_text_transformed(x_+2,y_+1,str,xscale,yscale,angle);
	draw_text_transformed(x_-1,y_-2,str,xscale,yscale,angle);
	draw_text_transformed(x_+1,y_+2,str,xscale,yscale,angle);

	draw_text_transformed(x_-2,y_+1,str,xscale,yscale,angle);
	draw_text_transformed(x_+2,y_-1,str,xscale,yscale,angle);
	draw_text_transformed(x_+1,y_-2,str,xscale,yscale,angle);
	draw_text_transformed(x_-1,y_+2,str,xscale,yscale,angle);
	

	draw_text_transformed(x_+2,y_,str,xscale,yscale,angle);
	draw_text_transformed(x_-2,y_,str,xscale,yscale,angle);
	draw_text_transformed(x_,y_+2,str,xscale,yscale,angle);
	draw_text_transformed(x_,y_-2,str,xscale,yscale,angle);
	
	draw_text_transformed(x_+2,y_-1,str,xscale,yscale,angle);
	draw_text_transformed(x_-2,y_+1,str,xscale,yscale,angle);
	draw_text_transformed(x_+1,y_+2,str,xscale,yscale,angle);
	draw_text_transformed(x_-1,y_-2,str,xscale,yscale,angle);

	draw_text_transformed(x_+2,y_-1,str,xscale,yscale,angle);
	draw_text_transformed(x_-2,y_+1,str,xscale,yscale,angle);
	draw_text_transformed(x_-1,y_+2,str,xscale,yscale,angle);
	draw_text_transformed(x_+1,y_-2,str,xscale,yscale,angle);
	gpu_set_fog(false,c_white,0,1)
}


function text_outline_thick(x_,y_,str,col_) { 
	
	gpu_set_fog(true,col_,0,1);
	draw_text(x_-2,y_,str);
	draw_text(x_+2,y_,str);
	draw_text(x_,y_-2,str);
	draw_text(x_,y_+2,str);
	
	draw_text(x_-2,y_-1,str);
	draw_text(x_+2,y_+1,str);
	draw_text(x_-1,y_-2,str);
	draw_text(x_+1,y_+2,str);	

	draw_text(x_-2,y_+1,str);
	draw_text(x_+2,y_-1,str);
	draw_text(x_+1,y_-2,str);
	draw_text(x_-1,y_+2,str);	
	

	draw_text(x_+2,y_,str);
	draw_text(x_-2,y_,str);
	draw_text(x_,y_+2,str);
	draw_text(x_,y_-2,str);
	
	draw_text(x_+2,y_-1,str);
	draw_text(x_-2,y_+1,str);
	draw_text(x_+1,y_+2,str);
	draw_text(x_-1,y_-2,str);	

	draw_text(x_+2,y_-1,str);
	draw_text(x_-2,y_+1,str);
	draw_text(x_-1,y_+2,str);
	draw_text(x_+1,y_-2,str);
	gpu_set_fog(false,c_white,0,1)
}



function nine_slice(sprite,x1,y1,x2,y2,alpha,blend) {


	var slice_width = sprite_get_width(sprite)/3;
	var slice_height = sprite_get_height(sprite)/3;

	if (sprite_get_width(sprite)%3 != 0 || sprite_get_height(sprite)%3 != 0) {
	//	show_debug_message("WARNING: Sprite is not a multiple of 3.");
	}

	var width = abs(x2-x1);
	var height = abs(y2-y1);

	// Top
	draw_sprite_part_ext(sprite, 0, 0, 0, slice_width, slice_height, x1, y1, 1, 1, blend, alpha); // Left
	draw_sprite_part_ext(sprite, 0, slice_width, 0, slice_width, slice_height, x1+slice_width, y1, (width-slice_width*2)/slice_width, 1, blend, alpha); // Middle
	draw_sprite_part_ext(sprite, 0, slice_width*2, 0, slice_width, slice_height, x2-slice_width, y1, 1, 1, blend, alpha); // Right

	// Middle
	draw_sprite_part_ext(sprite, 0, 0, slice_height, slice_width, slice_height, x1, y1+slice_height, 1, (height-slice_height*2)/slice_height, blend, alpha); // Left
	draw_sprite_part_ext(sprite, 0, slice_width, slice_height, slice_width, slice_height, x1+slice_width, y1+slice_height, (width-slice_width*2)/slice_width, (height-slice_height*2)/slice_height, blend, alpha); // Middle
	draw_sprite_part_ext(sprite, 0, slice_width*2, slice_height, slice_width, slice_height, x2-slice_width, y1+slice_height, 1, (height-slice_height*2)/slice_height, blend, alpha); // Right

	// Bottom
	draw_sprite_part_ext(sprite, 0, 0, slice_height*2, slice_width, slice_height*2, x1, y2-slice_height, 1, 1, blend, alpha); // Left
	draw_sprite_part_ext(sprite, 0, slice_width, slice_height*2, slice_width, slice_height, x1+slice_width, y2-slice_height, (width-slice_width*2)/slice_width, 1, blend, alpha); // Middle
	draw_sprite_part_ext(sprite, 0, slice_width*2, slice_height*2, slice_width, slice_height, x2-slice_width, y2-slice_height, 1, 1, blend, alpha); // Right


}

function draw_on_grid(value) { 
var amount = CELL_SIZE;

	value = value div amount;
	value *= amount;
	
	return value;
	
}
function nine_slice_on_grid(sprite,x1,y1,x2,y2 , alpha,blend) {

	x1 = draw_on_grid(x1);
	y1 = draw_on_grid(y1);
	x2 = draw_on_grid(x2);
	y2 = draw_on_grid(y2);
				
	
	var slice_width = sprite_get_width(sprite)/3;
	var slice_height = sprite_get_height(sprite)/3;

	if (sprite_get_width(sprite)%3 != 0 || sprite_get_height(sprite)%3 != 0) {
	//	show_debug_message("WARNING: Sprite is not a multiple of 3.");
	}

	var width = abs(x2-x1);
	var height = abs(y2-y1);

	// Top
	draw_sprite_part_ext(sprite, 0, 0, 0, slice_width, slice_height, x1, y1, 1, 1, blend, alpha); // Left
	draw_sprite_part_ext(sprite, 0, slice_width, 0, slice_width, slice_height, x1+slice_width, y1, (width-slice_width*2)/slice_width, 1, blend, alpha); // Middle
	draw_sprite_part_ext(sprite, 0, slice_width*2, 0, slice_width, slice_height, x2-slice_width, y1, 1, 1, blend, alpha); // Right

	// Middle
	draw_sprite_part_ext(sprite, 0, 0, slice_height, slice_width, slice_height, x1, y1+slice_height, 1, (height-slice_height*2)/slice_height, blend, alpha); // Left
	draw_sprite_part_ext(sprite, 0, slice_width, slice_height, slice_width, slice_height, x1+slice_width, y1+slice_height, (width-slice_width*2)/slice_width, (height-slice_height*2)/slice_height, blend, alpha); // Middle
	draw_sprite_part_ext(sprite, 0, slice_width*2, slice_height, slice_width, slice_height, x2-slice_width, y1+slice_height, 1, (height-slice_height*2)/slice_height, blend, alpha); // Right

	// Bottom
	draw_sprite_part_ext(sprite, 0, 0, slice_height*2, slice_width, slice_height*2, x1, y2-slice_height, 1, 1, blend, alpha); // Left
	draw_sprite_part_ext(sprite, 0, slice_width, slice_height*2, slice_width, slice_height, x1+slice_width, y2-slice_height, (width-slice_width*2)/slice_width, 1, blend, alpha); // Middle
	draw_sprite_part_ext(sprite, 0, slice_width*2, slice_height*2, slice_width, slice_height, x2-slice_width, y2-slice_height, 1, 1, blend, alpha); // Right


}
function nine_slice_anim(sprite,index,x1,y1,x2,y2,alpha,blend) {


	var slice_width = sprite_get_width(sprite)/3;
	var slice_height = sprite_get_height(sprite)/3;

	if (sprite_get_width(sprite)%3 != 0 || sprite_get_height(sprite)%3 != 0) {
	//	show_debug_message("WARNING: Sprite is not a multiple of 3.");
	}

	var width = abs(x2-x1);
	var height = abs(y2-y1);

	// Top
	draw_sprite_part_ext(sprite, index, 0, 0, slice_width, slice_height, x1, y1, 1, 1, blend, alpha); // Left
	draw_sprite_part_ext(sprite, index, slice_width, 0, slice_width, slice_height, x1+slice_width, y1, (width-slice_width*2)/slice_width, 1, blend, alpha); // Middle
	draw_sprite_part_ext(sprite, index, slice_width*2, 0, slice_width, slice_height, x2-slice_width, y1, 1, 1, blend, alpha); // Right

	// Middle
	draw_sprite_part_ext(sprite,index, 0, slice_height, slice_width, slice_height, x1, y1+slice_height, 1, (height-slice_height*2)/slice_height, blend, alpha); // Left
	draw_sprite_part_ext(sprite,index, slice_width, slice_height, slice_width, slice_height, x1+slice_width, y1+slice_height, (width-slice_width*2)/slice_width, (height-slice_height*2)/slice_height, blend, alpha); // Middle
	draw_sprite_part_ext(sprite,index, slice_width*2, slice_height, slice_width, slice_height, x2-slice_width, y1+slice_height, 1, (height-slice_height*2)/slice_height, blend, alpha); // Right

	// Bottom
	draw_sprite_part_ext(sprite, index, 0, slice_height*2, slice_width, slice_height*2, x1, y2-slice_height, 1, 1, blend, alpha); // Left
	draw_sprite_part_ext(sprite, index, slice_width, slice_height*2, slice_width, slice_height, x1+slice_width, y2-slice_height, (width-slice_width*2)/slice_width, 1, blend, alpha); // Middle
	draw_sprite_part_ext(sprite, index, slice_width*2, slice_height*2, slice_width, slice_height, x2-slice_width, y2-slice_height, 1, 1, blend, alpha); // Right
}

function percent_to_string(amount , base_is_100_percent) {
	var add = 0;
	if base_is_100_percent { 
		add = 100;	
	}
	return string_format(amount*100+add,2,0);
}

function chance(amount) {
	boon_randomize();
	
	var _percent = amount;
	return random(1) < _percent;
}


function create_sine_text(xx, yy, time, str, color, creator_struct, destroy_text) {

	if destroy_text{
		with o_sine_text{	
			if target = creator_struct { 
				instance_destroy();	
			}
		}
	}
	var s = create(xx,yy,o_sine_text);
	s.alarm[0] = time;
	s.text = str;
	s.color = color;
	if creator_struct != 0 || creator_struct != noone{
	s.target = creator_struct;
	s.creator = creator_struct;
	}
	return s;
}

function z_control(struct) {
	
	struct.z		 += struct.z_speed;
	struct.z_speed += struct.gravity_;
		
	if struct.z >= 0{ 
		struct.z_speed = -struct.z_speed * struct.bounce_amount;
		if struct.z_speed > -.5 {
			struct.z_speed = 0;
			struct.z = 0;
		}
	}
	
}

function cubic_bezier(x1, y1, x2, y2, x3, y3, x4, y4, t){
    var q0_x = lerp(x1, x2, t)
    var q0_y = lerp(y1, y2, t)
    var q1_x = lerp(x2, x3, t)
    var q1_y = lerp(y2, y3, t)
    var q2_x = lerp(x3, x4, t)
    var q2_y = lerp(y3, y4, t)
    
    var r0_x = lerp(q0_x, q1_x, t)
    var r0_y = lerp(q0_y, q1_y, t)
    var r1_x = lerp(q1_x, q2_x, t)
    var r1_y = lerp(q1_y, q2_y, t)
    
    return [lerp(r0_x, r1_x, t), lerp(r0_y, r1_y, t)]
}

// x1 and y1 is the initial position
// x3 and y3 is the end position
// x2 and y2 is 'curve' point used for interporlation
function quadratic_bezier(x1, y1, x2, y2, x3, y3, t){
    var q0_x = lerp(x1, x2, t)
    var q0_y = lerp(y1, y2, t)
    var q1_x = lerp(x2, x3, t)
    var q1_y = lerp(y2, y3, t)
    var r0_x = lerp(q0_x, q1_x, t)
    var r0_y = lerp(q0_y, q1_y, t)
    return [r0_x, r0_y]
}

function draw_curve_line(){

    var sprite = s_passive_molding_clay
    var origin_x = 0
    var origin_y = -200
    var x_dest =  200
    var y_dest = -200

    var gap = sprite_get_width(sprite) + 15
	var gap = 10;
    var prev_point_x = origin_x
    var prev_point_y = origin_y
    var dist = point_distance(origin_x, origin_y, x_dest, y_dest)

    for(var i = 0; dist > (i * gap); i++){
        var t = (i * gap) / dist
        var vec = quadratic_bezier(origin_x, origin_y, origin_x + 100 + camera.x * 5, origin_y + 100 + camera.y * 15, x_dest, y_dest,t)
        var angle = point_direction(prev_point_x, prev_point_y, vec[0], vec[1])
		draw_line(prev_point_x,prev_point_y,vec[0],vec[1]);
      //  draw_sprite_ext(sprite, 0, vec[0], vec[1], 1, 1, angle, c_white,1)
    
        prev_point_x = vec[0]
        prev_point_y = vec[1]
    }
}
function particle_explode(xx,yy,len,col,is_rainbow, life, speed){
	
	if life = noone || life = false{ 
		life = SEC*.45;	
	}
	
	if speed = noone || speed = false{ 
		speed = 15;	
	}
		for (var i= 0; i <= len; i++){
		
			var dir = i*(360/len);
	
	if is_rainbow{ 
			col = choose(C_GUM, C_BLUE,make_color_rgb(255,50,197),  C_YELLOW,make_color_rgb(45 ,255,63));	
	}
				part_type_color1(global.pt_summon_token,col);
				part_type_speed(global.pt_summon_token,14,13,-.3,0);
				part_type_direction(global.pt_summon_token,dir,dir,0,0);
				part_type_orientation(global.pt_summon_token,dir,dir,0,0,0);
				part_type_sprite(global.pt_summon_token,s_summon_particle,true,true,0);
	
				part_type_life(global.pt_summon_token,life,life);
				part_particles_create(global.sys_summon_token,xx,yy,global.pt_summon_token,1)

		}
}

function particle_evaporate(xx,yy,len,col,spd,dir,life,dir_inc,fric ){

part_system_depth(global.sys_bubble_evaporate,DEPTH_AHEAD_GAME-1)
part_system_depth(global.sys_bubble_outline_evaporate,DEPTH_AHEAD_GAME)

	repeat(len){
	
	
	if life = false || life = noone { 
		life = random_range(SEC*.15,SEC*.25);
	}
	if spd = false || spd = noone {
		spd = random_range(2.1,3.4);
	}
	if dir = false || dir = noone {
		dir = random_range(0,360); 
	}

	part_type_sprite(global.pt_bubble_outline_evaporate, s_bubble_outline , true, true, 0);
	part_type_colour1(global.pt_bubble_outline_evaporate,c_black);
	part_type_speed(global.pt_bubble_outline_evaporate, spd,spd, fric, 0);
	part_type_gravity(global.pt_bubble_outline_evaporate, 0,90);
	part_type_direction(global.pt_bubble_outline_evaporate, dir, dir, dir_inc,0);
	part_type_life(global.pt_bubble_outline_evaporate,life,life);	
	
	
	
	part_type_sprite(global.pt_bubble_evaporate, s_bubble , true, true, 0);
	part_type_colour1(global.pt_bubble_evaporate,col);
	part_type_gravity(global.pt_bubble_evaporate, 0,90);
	part_type_speed(global.pt_bubble_evaporate, spd,spd, fric, 0);

	part_type_direction(global.pt_bubble_evaporate, dir, dir, dir_inc, 0);
	part_type_life(global.pt_bubble_evaporate,life,life);

	part_particles_create(global.sys_bubble_outline_evaporate,xx,yy,global.pt_bubble_outline_evaporate,1)
	part_particles_create(global.sys_bubble_evaporate,xx,yy,global.pt_bubble_evaporate,1)
	}
}



function particle_bubble(xx,yy,len,col,spd,dir,life,dir_inc,fric ){

part_system_depth(global.sys_bubble,DEPTH_BEHIND_GAME-1)
part_system_depth(global.sys_bubble_outline,DEPTH_BEHIND_GAME)

	repeat(len){
	
	
	if life = false || life = noone { 
		life = random_range(SEC*.15,SEC*.25);
	}
	if spd = false || spd = noone {
		spd = random_range(2.1,3.4);
	}
	if dir = false || dir = noone {
		dir = random_range(0,360); 
	}
	var dir_wiggle = 0;


	part_type_colour1(global.pt_bubble_outline,c_black);
	part_type_speed(global.pt_bubble_outline, spd,spd, fric, 0);
	part_type_gravity(global.pt_bubble_outline, 0,90);
	part_type_direction(global.pt_bubble_outline, dir, dir, dir_inc,dir_wiggle);
	part_type_life(global.pt_bubble_outline,life,life);	
	
	part_type_sprite(global.pt_bubble, s_bubble , true, true, 0);
	part_type_colour1(global.pt_bubble,col);
	part_type_gravity(global.pt_bubble, 0,90);
	part_type_speed(global.pt_bubble, spd,spd, fric, 0);

	part_type_direction(global.pt_bubble, dir, dir, dir_inc, dir_wiggle);
	part_type_life(global.pt_bubble,life,life);

	part_particles_create(global.sys_bubble_outline,xx,yy,global.pt_bubble_outline,1)
	part_particles_create(global.sys_bubble,xx,yy,global.pt_bubble,1)
	}
}

function create_animation_effect(_sprite, _x, _y, _image_speed, scale,angle,blend,alpha ) {

	var _effect = instance_create_depth(_x, _y, -3000, o_tempoary_animation);
	
	with _effect{ 
		sprite_index = _sprite;
		image_speed = _image_speed;
		image_xscale = scale;
		image_yscale = scale;
		image_angle = angle;
		image_blend = blend;
		image_alpha = alpha;
	}
	return _effect;
}


function destroy_tile(xx,yy) { 
	with obj_mapgen {
		xx = xx div CELL_SIZE;
		yy = yy div CELL_SIZE;
		xx = clamp(xx, 0, ds_grid_width(grid)-1);// ds_grid_width(grid div CELL_SIZE)-1);
		yy = clamp(yy, 0, ds_grid_height(grid)-1);// ds_grid_height(grid div CELL_SIZE)-1);
		
		if grid[# xx,yy] != FLOOR { 
			grid[# xx, yy] = FLOOR;
			scr_update_tile(grid, xx, yy, wall_tilemap, 1);
			scr_update_tile(grid, xx, yy, burn_tilemap, 0);	
		}
	}
}




function give_massage(xd) { 
		show_message(xd);
}