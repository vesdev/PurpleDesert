//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying float fTime;

uniform float time;

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
	vec2 coord = in_Position.xy*0.01;
	
	//vec2 roadCoord = vec2((in_TextureCoord.x-.5)*7., in_TextureCoord.y);
	//float roadMask = step(1.-roadCoord.x, 1.)*step(roadCoord.x, 1.);
	
	float heightMap = getHeight(coord+time);
	float scale = sin(in_Position.y*0.05+time*10.)*25.-abs(in_Position.x*.4)*2.;
	
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z+heightMap*scale+200., 1.0);
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	float stp = 10.*0.01;
	vec4 bump = bumpFromDepth(heightMap, coord+time, stp, scale);
	
    v_vColour = vec4(vec3(dot(bump.xyz,vec3(1.,-1., 1.))), 1.);

    v_vTexcoord = in_TextureCoord;
	fTime = time;
}
