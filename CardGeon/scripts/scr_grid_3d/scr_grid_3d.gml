
function grid3D() constructor
{

	tempCam = camera_create();

	u_time = shader_get_uniform(sha_grid_3d, "time");
	u_width = shader_get_uniform(sha_grid_3d, "width");

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
	size = 64;

	width = 32;
	height = 32;

	var _x = -width*size/2;
	var _y = -height*size/2;
	//Add the six vertices needed to draw a simple square plane.
	for(var i = 0; i < width; i++)
	{
		for(var j = 0; j < height; j++)
		{
			//The first triangle
			vertex_position_3d(vb_plane, _x+size*i, _y+size*j, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, 0, 0);

			vertex_position_3d(vb_plane, _x+size*i+size, _y+size*j, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, 1, 0);

			vertex_position_3d(vb_plane, _x+size*i, _y+size*j+size, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, 0, 1);
		
			//The second triangle. The winding order has been maintained so drawing is consistent if culling is enabled.
			vertex_position_3d(vb_plane, _x+size*i, _y+size*j+size, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, 0, 1);
		
			vertex_position_3d(vb_plane, _x+size*i+size, _y+size*j, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, 1, 0);

			vertex_position_3d(vb_plane, _x+size*i+size, _y+size*j+size, 0);
			vertex_color(vb_plane, c_white, 1);
			vertex_texcoord(vb_plane, 1, 1);
		}
	}

	vertex_end(vb_plane);
	
	static Draw = function()
	{
		var _s = sin(current_time*0.001)*20;
		var _cam = view_current;
		var _mat = matrix_build(0,0,0,-90+55,0,0,1,1,1);

		camera_set_proj_mat(tempCam, matrix_build_projection_perspective_fov(-45, -camera_get_view_width(_cam)/camera_get_view_height(_cam), 1, 99999));
		camera_set_view_mat(tempCam, matrix_build_lookat(0, 0, -999, 0, 0, 0, 0, 1, 0));

		camera_apply(tempCam);
		matrix_set(matrix_world, _mat);

		shader_set(sha_grid_3d);
		shader_set_uniform_f(u_time, current_time*0.0001);
		vertex_submit(vb_plane, pr_trianglelist, -1);
		shader_reset();

		matrix_set(matrix_world,matrix_build_identity());

		camera_apply(_cam);
	}
}