global.__uiMX = 0;
global.__uiMY = 0;

function UiButton(width, height, sprite, text, onPress) constructor
{
	x = 0;
	y = 0;
	self.width = width;
	self.height = height;
	self.sprite = sprite;
	self.text = text;
	self.onPress = onPress;
	subimg = 0;
	pressed = false;
	
	static Update = function()
	{
		if pressed && mouse_check_button_released(mb_left)
		{
			pressed = false;
			onPress();
		}
		
		if (point_in_rectangle(global.__uiMX,global.__uiMY, x-width*.5,y-height*.5, x+width*.5, y+height*.5))
		{
			subimg = 1;
			
			if mouse_check_button_pressed(mb_left)
			{
				pressed = true;
			}
		}
		else{
			subimg = 0;
		}
		
		if mouse_check_button(mb_left) && pressed
		{
			subimg = 2;
		}
	}
	
	static Draw = function()
	{
		draw_sprite_stretched(sprite, subimg, x-width*.5, y-height*.5, width, height);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
			draw_set_color(c_black);
			
			draw_text(x,y, text);
			
			draw_set_color(c_white);
			
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}

function UiSlider(width, height, sprite, sliderSprite, text, minBound, maxBound, decimals, def, onPress) constructor
{
	x = 0;
	y = 0;
	self.width = width;
	self.height = height;
	self.sprite = sprite;
	self.text = text;
	self.onPress = onPress;
	slider = sliderSprite;
	subimg = 0;
	self.decimals = decimals;
	
	self.minBound = minBound;
	self.maxBound = maxBound;
	self.rad = sprite_get_width(slider)/2;
	self.pressed = false;
	
	value = def;
	sliderPos = (def-minBound)/(maxBound-minBound);
	
	
	static Update = function()
	{
		if pressed && mouse_check_button_released(mb_left)
		{
			pressed = false;
			onPress(value);
		}
		if (point_in_circle(global.__uiMX,global.__uiMY, x+width*sliderPos, y, rad))
		{
			subimg = 1;
			if mouse_check_button_pressed(mb_left)
			{
				pressed = true;
			}
			
		}
		else if !pressed{
			subimg = 0;
		}
		
		
		if pressed
		{
			if mouse_check_button(mb_left)
			{
				subimg = 2;
				var _x = (global.__uiMX-x)/width;
				_x = clamp(_x,0,1);
				
				sliderPos = _x;
				value = real(string_format((maxBound-minBound)*sliderPos, 1, decimals));
			}
		}
		
	}
	
	static Draw = function()
	{
		//slide
		draw_sprite_stretched(sprite, 0, x, y-5*.5, width, 5);
		
		draw_sprite(slider, subimg, x+width*sliderPos, y);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
			
			var _x = x-width*.5;
			var _str =  text + ": " + string_format(value, 1, decimals);
			if (string_width(_str) > width)
			{
				draw_set_halign(fa_right);
				_x = x-20;
			}
			
			draw_text(_x,y,_str);
			
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}

function UiCheck(height, sprite, text, def, onPress) constructor
{
	x = 0;
	y = 0;
	self.sprite = sprite;
	self.text = text;
	self.onPress = onPress;
	pressed = false;
	self.height = height;
	
	state = def;
	
	w = sprite_get_width(sprite);
	h = sprite_get_height(sprite);
	
	static Update = function()
	{
		if pressed && mouse_check_button_released(mb_left)
		{
			state = !state;
			pressed = false;
			onPress(state);
		}
		var _x = x+20;
		if (point_in_rectangle(global.__uiMX,global.__uiMY, _x-w*.5,y-h*.5, _x+w*.5, y+h*.5))
		{
			
			if mouse_check_button_pressed(mb_left)
			{
				pressed = true;
			}
		}
	}
	
	static Draw = function()
	{
		draw_sprite(sprite, state, x+20, y);
		
		draw_set_halign(fa_right);
		draw_set_valign(fa_middle);
			
			
			draw_text(x,y, text);
			
			
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}

function UiPage(spacing, list) constructor
{
	x = 0;
	y = 0;
	self.list = list;
	gap = spacing;
	
	static Update = function(mx,my)
	{
		global.__uiMX = mx;
		global.__uiMY = my;
		
		var _i = 0;
		var _h = 0;
		var _g = 0;
		
		var _totalH = 0;
		repeat(array_length(list))
		{
			with (list[_i])
			{
				_totalH += height;
			}
			_i++;
		}
		
		_i = 0;
		
		repeat(array_length(list))
		{
			with (list[_i])
			{
				_h += height/2;
				y = other.y - _totalH/2 + _h + _g;
				x = other.x;
				Update();
				_h += height/2;
			}
			_g += gap;
			_i++;
		}
	}
	
	static Draw = function()
	{
		var _i = 0;
		repeat(array_length(list))
		{
			list[_i].Draw();
			_i++;
		}
	}
	
}
