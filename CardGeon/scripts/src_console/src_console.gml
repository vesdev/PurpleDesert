
/*
rez  <width> <height> //for simulating a display resolution
clear //clears console
quit //exits game
hp <amount> //sets hp to this number
mana <amount> //sets mana to this number
time <framerate> //sets game speed in fps
*/


function _toGuiX(xx, camera)
{
	return xx-camera.x+camera.width*camera.zoom/2;
}

function _toGuiY(yy, camera)
{
	return yy-camera.y+camera.height*camera.zoom/2;
}

function _strSplit(str, delimiter)
{
	var s = str, d = delimiter;
	var rl = [];
	var p = string_pos(d, s), o = 1;
	var dl = string_length(d);
	if (dl) while (p) {
	    array_push(rl, string_copy(s, o, p - o));
	    o = p + dl;
	    p = string_pos_ext(d, s, o);
	}
	array_push(rl, string_delete(s, 1, o - 1));

	return rl;
}

function Console() constructor
{
	
	show = false;
	output = "Welcome To the HACKERMANS console :)\n";
	inputStr = "";
	
	_startIdx = 0;
	_endIdx = 0;
	_selecting = false;
	
	static draw = function(camera)
	{
		if show
		{
			var _boxH = camera.height*0.2;
			var _inputH = camera.height*0.05;
			
			draw_set_alpha(0.8);
			draw_rectangle_color(0,0,camera.width,_boxH, c_gray, c_gray, c_gray, c_gray, false);
			draw_rectangle_color(0,_boxH-_inputH,camera.width,_boxH, c_black, c_black, c_black, c_black, false);
			
			var _textY = string_height(output);
			var _margin = camera.height*0.02;
			
			draw_set_alpha(0.3);
			
			if (_selecting) _drawSelection(_margin,_boxH-_inputH-_margin-_textY);
			
			draw_set_alpha(1);
			draw_text(_margin,_boxH-_inputH-_margin-_textY,output);
			
			draw_set_valign(fa_middle);
			draw_text(_margin, _boxH-_inputH/2, inputStr);
			draw_set_valign(fa_top);
		}
	}
	
	static update = function(camera)
	{
		
		if keyboard_check_pressed(vk_f1)
		{
			show = !show;
		}
		
		if show{
			var _boxH = camera.height*0.2;
			var _inputH = camera.height*0.05;
			var _textY = string_height(output);
			var _margin = camera.height*0.02;
			if mouse_check_button_pressed(mb_left)
			{
				_startIdx = _getIdx(_toGuiX(MX, camera),_toGuiY(MY, camera),_margin,_boxH-_inputH-_margin-_textY)
			}
			
			if mouse_check_button(mb_left)
			{
				_endIdx = _getIdx(_toGuiX(MX, camera),_toGuiY(MY, camera),_margin,_boxH-_inputH-_margin-_textY)
				
				if _startIdx != 0 && _endIdx != 0 && _endIdx >= _startIdx
				{
					_selecting = true;
				}
			}
			
			if keyboard_check(vk_control) && keyboard_check_pressed(ord("A"))
			{
				_startIdx = 1;
				_endIdx = string_length(output)+1;
				_selecting = true;
			}
			
			if _selecting && mouse_check_button_pressed(mb_left)
			{
				_selecting = false;
			}
			
			if _selecting && keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))
			{
				_selecting = false;
				clipboard_set_text(string_copy(output, _startIdx, _endIdx-_startIdx+1));
			}
			
			if  keyboard_check(vk_control) && keyboard_check_pressed(ord("V"))
			{
				keyboard_string += clipboard_get_text();
			}
			
			inputStr = keyboard_string;
			
			if keyboard_check_pressed(vk_enter)
			{
				writeCommand(inputStr);
				keyboard_string = "";
			}
		}
	}
	
	static _getIdx = function(px,py,tx,ty)
	{
		
		var _c = "";
		
		var _x = tx;
		var _y = ty;
		var _w = 0;
		var _h = 0;
		for(var _i = 1; _i < string_length(output)+1; _i++)
		{
			_c = string_char_at(output,_i);
			if (_c != "\n")
			{
				//_x += string_width(string_copy(output,_startI, _endI-_startI));
				
				_w = string_width(_c);
				_h = string_height(_c);

				if point_in_rectangle(px,py, _x,_y,_x+_w,_y+_h)
				{
					return _i;
				}
				
				_x += _w;
			}
			else
			{
				_x = tx;
				_y += string_height("|");
			}
		}
		
		return 0;
	}
	
	static _drawSelection = function(tx,ty)
	{
		
		var _c = "";
		
		var _x = tx;
		var _y = ty;
		var _w = 0;
		var _h = 0;
		for(var _i = 1; _i < string_length(output)+1; _i++)
		{
			_c = string_char_at(output,_i);
			if (_c != "\n")
			{
				//_x += string_width(string_copy(output,_startI, _endI-_startI));
				
				_w = string_width(_c);
				_h = string_height(_c);

				if (_i >= _startIdx && _i <= _endIdx)
				{
					draw_rectangle(_x,_y,_x+_w-1,_y+_h-1, false);
				}
				
				_x += _w;
			}
			else
			{
				_x = tx;
				_y += string_height("|");
			}
		}
		
		return 0;
	}
	
	static writeLine = function(str)
	{
		output += str+"\n";
	}
	
	static writeCommand = function(str)
	{
		writeLine(">"+str);
		try{
			var _args = _strSplit(str, " ");
			switch(_args[0])
			{
				case "rez":
				
					var _w, _h;
				
					_w = real(_args[1]);
					_h = real(_args[2]);
					
					o_game.camera.resize(o_game.camera.width,o_game.camera.height, _w,_h);

					break;
				
				case "scale":
					o_game.camera.scaleWindow(real(_args[1]));
					break;
					
				case "clear":
					output = "";
					break;
					
				case "time":
					game_set_speed(real(_args[1]), gamespeed_fps)
					break;
					
				case "restart":
					game_restart();
					break;
				
				case "quit":
					game_end();
					break;
				
				case "hp":
					player.hp = real(_args[1]);
					break;
				case "mana":
					player.mana = real(_args[1]);
					break;
				
				default:
					writeLine("Command does not exist:\n-"+ str);
					break;
			}
		}
		catch(_exc)
		{
			writeLine("Exception caught:\n-" + _exc.message);
		}
				
	}
	
}