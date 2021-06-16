//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying float fTime;

const float outline = 0.05;
const float line = 0.01;
const float glow = 0.3;

const vec4 color = vec4(0.4,0.1,0.7,1.);

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define OCTAVES 6
float fbm (in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitude = .5;
    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(st);
        st *= 2.;
        amplitude *= .5;
    }
    return value;
}


void main()
{
	//road color
	vec2 coord = vec2((v_vTexcoord.x-.5)*7., v_vTexcoord.y);
	vec4 col = vec4(0.3,0.3,0.3, 1);
	col += vec4(
		smoothstep(coord.x, outline,(1.-glow))+
		smoothstep(1.-coord.x, outline,(1.-glow))
		)*color*4.;
		
	float yellowLine = step(1.-coord.x-0.5, line)*step(coord.x-0.5, line);
	yellowLine *= step(sin((coord.y*150.+fTime*150.)), 0.5);
	
	//line color
	col.rgb += yellowLine*color.rgb*2.;
	
	
	float roadMask = step(1.-coord.x, 1.)*step(coord.x, 1.);
	
	col *= roadMask;
	
	vec4 groundCol = color*(1.-roadMask);
	groundCol.rgb *= fbm(v_vTexcoord*10.+vec2(0,fTime*10.))*0.5+0.5;
	
	float dist = smoothstep(v_vTexcoord.y, outline, .5);
		
	groundCol *= dist*2.;
	groundCol.a = 1.;
	
    gl_FragColor = groundCol+col;
}
