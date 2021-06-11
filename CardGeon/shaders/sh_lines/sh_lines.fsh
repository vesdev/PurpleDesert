//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{

	//get actual pixel color 
	vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	//grab pixels x and y coordinate
	vec2 pixel = gl_FragCoord.xy;
	
	//check if x coord is even
	float check = 0.0;
	if (mod(pixel.x, 2.0) < 1.0)
	{
		check = 1.0;
	}	

	//if even x coord - set it to "white" color
	if(check == 1.0)
	{
		gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	}

}
