// Script assets have changed for v2.3.0 see
function draw_synth(){
	
	if live_call() return live_result;
	

	with o_game.synth_wave{
		
		xscale_target = 2;
		yscale_target = 2;
		
		
		var currnet_enemy = 0;
	
		var current_x = 0; //enmy position
		var current_y = 50;
	
		x_position = lerp( x_position , xtarget, .2);
		
		
		xscale = lerp( xscale , xscale_target, .2);
		yscale = lerp( yscale , yscale_target, .2);
		
		var yy = -150;
		var xx = x_position;
		//debug(MY );
		//debug("MX " , MX, "MY ", MY);
 			
		var sprite = s_impending_damage_icon;
		var ww = sprite_get_width(sprite)*2;
		var hh = sprite_get_height(sprite)*2;
		/// @description 
		var surf_width = surface_get_width(surf);
		var surf_height = surface_get_height(surf);
		var cam_x =  current_x - xx - surf_width/2 + ww/2;
		var cam_y = camera_get_view_y(view_camera[0]) +  current_y - yy - surf_height - 80 + hh/2;

		//cam_y = clamp(cam_y, -30, 30); //use if want to clamp vertical camera

		//spd is the speed of which things move/rotate/shrink etc
		var spd = current_time/8000;

		//the horizon coordinates
		var horizon_y = round(cam_y + 60);
		var horizon_x = surf_width/2 + (cam_x)

		if surface_exists(surf)
		{
			//start drawing to the surface
		    surface_set_target(surf);
			//fill with bakcround color
		    draw_clear_alpha(c_black, 1);
			//start drawing in randomised color (create event)
		    draw_set_colour(col);
			//set to additive blendmode for glowy effects
		    gpu_set_blendmode(bm_add);
	
			//draw glare
			//glare circles fade to black - due to additive blend mode, then act like glowy lights
			draw_circle_colour(horizon_x , round(horizon_y), 16, col, c_black, false);
		    draw_circle_colour(surf_width/2 + (cam_x/1.5) , round(horizon_y), 64, col, c_black, false);
	
			//draw shapes
			for (var i = -0; i < 10; i += 1)
			{
				//this formula is used a lot: 1 + ((5*((spd + i/10) % 1)))
				//1 - this is base value
				//5 * - this is the value to proceed to
				//spd + i/10 - this is the speed and how many steps needed to reach max level - so in this case, 10 steps to get to 5
				//% 1 - this is the magic part, the values preceeding this return a value between 0 and 1 - once it reaches 1 it returns to 0 allows perfect loops
				var radius = round((surf_width*2*((spd + i/10) % 1)));
				var thickness =1 + ((5*((spd + i/10) % 1)));
				var ang = round((360*((spd + i/360) % 1)));
		
				//custom shape script
				draw_shape(horizon_x + 1, round(horizon_y), sides , ang, radius, col, 1,0,thickness);
			}
	
			draw_set_colour(c_black);
			gpu_set_blendmode(bm_normal);
			draw_rectangle(-1, horizon_y, surf_width, surf_height, false);
			draw_set_colour(col);
			gpu_set_blendmode(bm_add);


				//draw vertical lines
				var lines_ = ceil((surf_width));
				//note we start from "-lines" so we are drawing essentially double the amount of lines  - I could make them less, but theres magic numbers below which are determined off this value - requires more play if needs to be more efficient
			    for (var i = -lines_+1; i < lines_; i += 1)
				{
					//drawing the lines slightly out of screen and spread them from the horizon point  - it's hard to explain, but the magic numbers make it look good.
					draw_line(lines_/2 * i - i*5 - 12 , surf_height, horizon_x + i*5 - 5, horizon_y );
				}
	
				//draw moving horizontal lines
				draw_line(-1, round(horizon_y), surf_width, round(horizon_y))
				for (var i = 0; i <30; i += 1)
				{
					//very similar code as above for the shapes
					// will travel 30 steps and loop back when it reaches 3*surfheight 
					var yy_ = horizon_y + (((spd + i/30)%1) * surf_height*3);
					draw_line(-1, yy_, surf_width , yy_);
				}
	
				//return to normal drawing
			surface_reset_target();
		    gpu_set_blendmode(bm_normal)
		}
		else
		{
			

			surf = surface_create(200,200);
		}

		if surface_exists(clipping_mask)
		{
			//start drawing to our clipping mask surface
			surface_set_target(clipping_mask);
	
			//set the background to a 0 alpha (without this stretching or animating the mask causes black bars)
			draw_clear_alpha(c_white, 0);
			//for rotating the clipping mask
			var ang = round((360*((spd+ 1/360) % 1)));
			//draw the white sprite we are using for our clipping mask - note this has to be a sprite, you can't draw a shape here
			//draw_sprite_ext(s_impending_damage_icon, 1, ww/2 +80 , hh/2   +80, xscale, yscale, -ang, c_white, 1);
			draw_sprite_ext(s_impending_damage_icon, 1, ww/2 , hh/2 , xscale, yscale, ang, c_white, 1);
		
			//this blend mode allows the clipping mask to work
			gpu_set_blendmode_ext(9, 1);
			draw_surface(surf, 0, 0);
				//back to normal
			gpu_set_blendmode(bm_normal);
		    surface_reset_target()  

		//draw my cool scanlines shader on the surface
		draw_surface_ext(clipping_mask, xx - ww/2, yy - hh/2, 1, 1, 0, c_white, 1);
		gpu_set_blendmode(bm_add);
		shader_set(sh_lines);
		draw_surface_ext(clipping_mask, xx - ww/2,yy - hh/2 , 1, 1, 0,c_white, 1);
		shader_reset();
		gpu_set_blendmode(bm_normal);




  
	  //ignore comment below, this is just me testing out blending modes - it was to get the clipping mask working
	  // draw_text(x - 20, y - 20, "BM_1: " + string(bm_1) + " BM_2: " + string(bm_2));
	}
	else //if surface doesn't exist create new surfac
	{
		clipping_mask = surface_create(320, 320);
	}

	//hope this helps
	//@joellikespigs
	}
}