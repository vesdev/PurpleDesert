//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform vec2 resolution;

#define PI 3.1415
#define LAYERS 3.

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

mat2 Rot(float a){
	float s=sin(a), c=cos(a);
	return mat2(c, -s, s, c);
}

float star(vec2 uv, float flare)
{
	float d =  length(uv);
	float m = .1/d;
	
	float rays = max(0., 1.-abs(uv.x*uv.y*1000.));
	m += rays*flare;
	uv *= Rot(PI/4.);
	rays = max(0., 1.-abs(uv.x*uv.y*1000.));
	m += rays*.3*flare;
	
	m *= smoothstep(1., .2, d);
	return m;
}

vec3 starLayer(vec2 uv, float depth)
{
	vec3 col = vec3(0);
	
	vec2 gv = fract(uv)-.5;
	vec2 id = floor(uv);
	
	for(float yy=-1.; yy<=1.; yy+=1.)
	{
		for(float xx=-1.; xx<=1.; xx+=1.)
		{
			vec2 offs = vec2(xx,yy);
			
			float n = random(id+offs);
			float size = fract(n*200.);
			float str = star(gv-offs-vec2(n-.5, fract(n*10.)-0.5), smoothstep(.7, 1., size)*depth)*.5;
			
			vec3 color = sin(vec3(.2, .01, .4)*fract(n*300.)*10.)*.1+.5;
			color = color*vec3(1, .5, 1.+size)*.5;
			
			col += str*size*color;
		}
	}
	
	return col;
}

void main()
{
	vec2 uv = (gl_FragCoord.xy-resolution*0.5)/resolution.y;
	vec3 col = vec3(0);
	
	uv *= 2.;
	uv *= Rot(time*0.001);
	
	for(float i = 0.; i < 1.; i+=1./LAYERS)
	{
		float depth = fract(i+time*0.01);
		float scale = mix(20., .5,depth);
		col.rgb += starLayer(uv*scale+i*466., depth)*(depth*smoothstep(1., .9, depth));
	}
    gl_FragColor = v_vColour*vec4(col,1.);
}
