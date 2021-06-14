randomize();

function LightSystem(ambientColor) constructor
{
	
	self.ambientColor = ambientColor;
		
	renderScale = 1;
	
	solidSurface = -1;
	shadowSurface = -1;
	
	width = undefined;
	height = undefined;
	
	scaleMatrix = undefined;
	
	u_lightData = shader_get_uniform(sha_light_system, "lightData");
	u_lightCount = shader_get_uniform(sha_light_system, "lightCount");
	u_resolution = shader_get_uniform(sha_light_system, "resolution");

	//bloom
	u_blurSize = shader_get_uniform(sha_light_system_post, "blurSize");
	u_intensity = shader_get_uniform(sha_light_system_post, "intensity");
	u_smooth_1 = shader_get_uniform(sha_light_system_post, "smooth_1");
	u_smooth_2 = shader_get_uniform(sha_light_system_post, "smooth_2");
	
	static SetSize = function(w,h,scale)
	{
		renderScale = scale;
		width = w*scale;
		height = h*scale;
		
		if (width % 2 != 0) width++;
		if (height % 2 != 0) height++;
		
		scaleMatrix = [
			renderScale,0          ,0,0,
			0          ,renderScale,0,0,
			0          ,0          ,1,0,
			0          ,0          ,0,1,
		];
		
		surface_free(solidSurface);
		surface_free(shadowSurface);
	}
	
	static Draw = function(x,y, lightNodeArray, drawSolids)
	{

		if (!surface_exists(solidSurface) || !surface_exists(shadowSurface))
		{
			solidSurface = surface_create(width,height);
			shadowSurface  = surface_create(width,height);
		}
		else
		{
			//format lightNodeArray for the shader
			var _i = 0;
			var _array = [];
			
			repeat(array_length(lightNodeArray))
			{
				
				_array[_i*4] = (lightNodeArray[_i].x-x);
				_array[_i*4+1] = (lightNodeArray[_i].y-y);
				_array[_i*4+2] = (lightNodeArray[_i].falloff);
				_array[_i*4+3] = lightNodeArray[_i].color;
				
				_i++;
			}
			
			//fill out array to fit required size
			repeat(10-_i)
			{
				_array[_i*4] = 0;
				_array[_i*4+1] = 0;
				_array[_i*4+2] = 0;
				_array[_i*4+3] = 0;
				
				_i++;
			}
		
			//draw everything to solid surface
			var _cam = view_current;
			var _mat = matrix_get(matrix_world);
			
			surface_set_target(solidSurface);
			
				draw_clear_alpha(0,0);
				camera_apply(_cam);
				
				scaleMatrix[12] = camera_get_view_width(_cam)/2;
				scaleMatrix[13] = camera_get_view_height(_cam)/2;
				
				matrix_set(
					matrix_world,
					matrix_multiply(
						_mat,
						scaleMatrix
					)
				);
				//call user defined draw function
				drawSolids(); 
				
			surface_reset_target();
			
			matrix_set(matrix_world, _mat);
			
			//render lighting
			gpu_set_tex_filter(true); //smooth out for low renderscale
			
			surface_set_target(shadowSurface);
				draw_clear_alpha(ambientColor,1);
				
				gpu_set_blendmode(bm_add);
				shader_set(sha_light_system);
				
					shader_set_uniform_f_array(u_lightData, _array);
					shader_set_uniform_f(u_lightCount, array_length(lightNodeArray));
					shader_set_uniform_f(u_resolution, width/renderScale, height/renderScale);
					
					draw_surface(solidSurface, 0,0);
					
				shader_reset();
				gpu_set_blendmode(bm_normal);
			
			surface_reset_target();
			
			//upscale
			gpu_set_blendmode_ext(bm_zero,bm_subtract);
				shader_set(sha_light_system_post);
					shader_set_uniform_f(u_smooth_1, .6);
					shader_set_uniform_f(u_smooth_1, .9);
					shader_set_uniform_f(u_blurSize, .01);
					shader_set_uniform_f(u_intensity, .4);
					draw_surface_ext(shadowSurface, x, y, 1/renderScale, 1/renderScale, 0, c_white, 1);
				shader_reset();
			gpu_set_blendmode(bm_normal);
			
			gpu_set_tex_filter(false);
			
		}
	}
	
}

function LightNode(x,y,falloff,color) constructor
{
	self.x = x;
	self.y = y;
	self.falloff = falloff;
	self.color = color;
}