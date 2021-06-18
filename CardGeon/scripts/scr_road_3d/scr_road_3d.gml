
function road3D() constructor
{

	tempCam = camera_create();

	u_time = shader_get_uniform(sha_road_3d, "time");
	u_width = shader_get_uniform(sha_road_3d, "width");

	//Begin defining a format
	vertex_format_begin();

	vertex_format_add_position_3d();//Add 3D position info
	vertex_format_add_color();//Add color info
	vertex_format_add_texcoord();

	//End building the format, and assign the format to the variable "format"
	format = vertex_format_end();

	//Vertex buffer setup (triangle model)
	vb_plane = vertex_create_buffer();

	//Begin building the buffer using the format defined previously
	vertex_begin(vb_plane, format);
	
	//Using size to keep it square if we decide to change how iug it is.
	size = 10;

	width = 150;
	height = 95;

	var _x = -width*size/2;
	var _y = -height*size/2;
	
	// i/width
	// j/height
	// i/width+1/width
	// j/height+1/height
	
	//Add the six vertices needed to draw a simple square plane.
	for(var i = 0; i < width; i++)
	{
		for(var j = 0; j < height; j++)
		{
			//The first triangle
			vertex_position_3d(vb_plane, _x+size*i, _y+size*j, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, i/width, j/height);

			vertex_position_3d(vb_plane, _x+size*i+size, _y+size*j, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, i/width+1/width, j/height);

			vertex_position_3d(vb_plane, _x+size*i, _y+size*j+size, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, i/width, j/height+1/height);
		
			//The second triangle. The winding order has been maintained so drawing is consistent if culling is enabled.
			vertex_position_3d(vb_plane, _x+size*i, _y+size*j+size, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, i/width, j/height+1/height);
		
			vertex_position_3d(vb_plane, _x+size*i+size, _y+size*j, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, i/width+1/width, j/height);

			vertex_position_3d(vb_plane, _x+size*i+size, _y+size*j+size, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, i/width+1/width, j/height+1/height);
		}
	}

	vertex_end(vb_plane);
	
	static Draw = function()
	{
		gpu_push_state();
		gpu_set_cullmode(cull_clockwise);
		
		var _s = sin(current_time*0.001)*20;
		var _cam = view_current;
		var _vm = matrix_get(matrix_world);
		var _mat = matrix_build(0,0,0,-45,0,0,1,1,1);
		
		camera_set_proj_mat(tempCam, matrix_build_projection_perspective_fov(-45, -view_get_wport(_cam)/view_get_hport(_cam), 1, 99999));
		camera_set_view_mat(tempCam, matrix_build_lookat(0, 0, -999, 0, 0, 0, 0, 1, 0));

		camera_apply(tempCam);
		matrix_set(matrix_world, _mat);

		shader_set(sha_road_3d);
		shader_set_uniform_f(u_time, current_time*0.0001);
		vertex_submit(vb_plane, pr_trianglelist, -1);
		shader_reset();

		matrix_set(matrix_world,_vm);
		camera_apply(_cam);
		
		gpu_pop_state();

	}
}