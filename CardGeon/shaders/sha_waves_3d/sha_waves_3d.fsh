//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying float fTime;

const float outline = 0.08;
uniform float sat;

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
	vec4 col = vec4(
		smoothstep(v_vTexcoord.x, outline, .5)+
		smoothstep(1.-v_vTexcoord.x, outline, .5)+
		smoothstep(v_vTexcoord.y, outline, .5)+
		smoothstep(1.-v_vTexcoord.y, outline, .5)
		);
		
		
	float grad = gl_FragCoord.y*0.001;
	col.r *= fbm(v_vTexcoord*1.+fTime*10.)*grad*sat;
	col.g *= fbm(v_vTexcoord*2.+fTime*10.)*grad*.4*sat;
	col.b *= fbm(v_vTexcoord*2.+fTime*10.)*grad*sat;
	col.a = 1.;
	
	
    gl_FragColor = col;
}
