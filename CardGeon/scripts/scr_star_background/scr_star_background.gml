
function starBackground() constructor
{
	u_time = shader_get_uniform(sha_star_background, "time");
	u_res = shader_get_uniform(sha_star_background, "resolution");
	
	static Draw = function(x,y,w,h)
	{
		shader_set(sha_star_background);
			shader_set_uniform_f(u_time, current_time*0.001);
			shader_set_uniform_f(u_res, w,h);
			draw_rectangle(x, y, x+w, y+h, false);
		shader_reset();
		
	}
}