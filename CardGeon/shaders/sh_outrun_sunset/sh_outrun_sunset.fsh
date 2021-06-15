//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec3 yellow = vec3(1, 0.957, 0.298);
vec3 pink = vec3(1, 0.396, 0.635);

 

uniform float time;

void main()
{
    
	vec2 coord = v_vTexcoord  - 0.5;
	vec4 circle = vec4( step(  length(coord), 0.5)) ;
	circle.rgb *= mix( yellow,pink ,v_vTexcoord.y*1.5 );
		
	float offsety = v_vTexcoord.y +time*0.1*-1.; //animate that SHIIIIIT
	
	vec4 stripes =  vec4( sin( offsety*60.0  )*.08  ) ;// mod( offsety ,  0.1)

	
	stripes = step( stripes,  vec4(  0.13 - v_vTexcoord.y *.14)  );

	stripes.a *= step( v_vTexcoord.y, 1.0 );
	//stripes.a = 1.0;
	
	gl_FragColor = stripes * circle; // v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
