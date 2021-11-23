//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform vec2 texel;

uniform float speed;
uniform float amplitude;
uniform float frequency;

//const float speed = 0.001;
//const float amplitude = 0.001;
//const float frequency = 359.;

void main()
{
	vec2 uv = floor(v_vTexcoord/texel)*texel;
	vec2 offset = vec2(0);
	offset.x = sin(uv.y*frequency+time*speed)*amplitude;
	offset.y = sin(uv.x*frequency+time*speed)*amplitude;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, uv + offset);
}
