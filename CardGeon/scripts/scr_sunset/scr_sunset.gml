// Script assets have changed for v2.3.0 see
function sunset(x, y) constructor{
	//initializes the sunset
	self.x = x;
	self.y = y;
	
	color1 = C_YELLOW;
	color2 = C_PEACH;
	color3 = C_PINK;
	radius = 50;
	sprite = s_shader_pixel;
	
	uv = sprite_get_uvs(sprite,0 );
	
	u_time = shader_get_uniform(sh_outrun_sunset, "time");
	
	alpha = 1;
	surf = surface_create(250, 250);
	
	
	static draw = function(){ 
		
		//draws the function
		
		if !surface_exists(surf){ 
			surf = surface_create(250, 250);
		
		}else{
			
			
			
		surface_set_target(surf);
		draw_clear_alpha(c_white,0);
		
		shader_set(sh_outrun_sunset);		
		shader_set_uniform_f(u_time, current_time*.001 );
		draw_sprite_ext(sprite,0,0,0,radius*2,radius*2,0,c_white,alpha);
		shader_reset();
		surface_reset_target();
		
		gpu_set_fog(1,c_black,0,1);
			draw_surface(surf,x+radius+2,y+radius+2);
		draw_surface(surf,x+radius+1,y+radius+1);
		draw_surface(surf,x+radius-1,y+radius);
		draw_surface(surf,x+radius+1,y+radius);
		draw_surface(surf,x+radius,y+radius+1);
		draw_surface(surf,x+radius,y+radius-1);
		gpu_set_fog(0,c_white,0,1);
		
		draw_surface(surf,x+radius,y+radius);
		
		}
	}

}

