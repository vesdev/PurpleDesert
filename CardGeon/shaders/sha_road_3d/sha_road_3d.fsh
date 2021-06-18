//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying float fTime;

const float outline = 0.05;
const float line = 0.01;
const float glow = 0.3;

const vec4 color = vec4(0.3,0.05,0.5,1.);
const vec4 lightColor = vec4(1, 0.957, 0.298, 1)*.3;

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

#define OCTAVES 2
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

float getHeight(vec2 uv)
{
	return fbm(uv);
}

vec4 bumpFromDepth(float height, vec2 uv, float stp, float scale) {

	vec2 dxy = height - vec2(
		getHeight(uv + vec2(stp, 0.)),
		getHeight(uv + vec2(0., stp))
	);

	return vec4(normalize(vec3(dxy * scale, 1.)), height);
}


void main()
{
	//magic
	vec2 coord = vec2((v_vTexcoord.x-.5)*7., v_vTexcoord.y);
	vec4 groundCol = color;
	float dist = smoothstep(v_vTexcoord.y, outline, .5);
	groundCol *= dist*2.;
	groundCol.a = 1.;
	
	vec4 light = smoothstep(0.7,1.,v_vColour);
	vec4 shadow = -smoothstep(-0.3,-1.,v_vColour)*.1;
	
	vec4 final = groundCol+(light+shadow)*dist*lightColor;
	final.a = 1.;
	
	//done
    gl_FragColor = final;
}