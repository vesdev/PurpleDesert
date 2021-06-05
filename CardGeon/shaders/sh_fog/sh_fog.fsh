varying vec2 v_vTexcoord;
varying vec4 v_vColour;
 
uniform vec2 uResolution;
uniform float uTime;
uniform float uOpacity;
 
uniform float cloudscale;
 
const lowp float speed = 0.01;
const lowp float clouddark = 0.5;
const lowp float cloudlight = 0.3;
const lowp float cloudcover = 0.2;
const lowp float cloudalpha = 8.0;
 
const lowp mat2 m = mat2( 1.6,  1.2, -1.2,  1.6 );
 
vec2 hash( vec2 _p ) {
    _p = vec2(dot(_p,vec2(127.1,311.7)), dot(_p,vec2(269.5,183.3)));
    return -1.0 + 2.0*fract(sin(_p)*43758.5453123);
}
 
float noise( in vec2 _p ) {
    const lowp float K1 = 0.366025404; // (s_qrt(3)-1)/2;
    const lowp float K2 = 0.211324865; // (3-s_qrt(3))/6;
    lowp vec2 _i = floor(_p + (_p.x+_p.y)*K1);  
    lowp vec2 _a = _p - _i + (_i.x+_i.y)*K2;
    lowp vec2 o = (_a.x>_a.y) ? vec2(1.0,0.0) : vec2(0.0,1.0); //vec2 of = 0.5 + 0.5*vec2(sign(_a.x-_a.y), sign(_a.y-_a.x));
    lowp vec2 _b = _a - o + K2;
    lowp vec2 c = _a - 1.0 + 2.0*K2;
    lowp vec3 h = max(0.5-vec3(dot(_a,_a), dot(_b,_b), dot(c,c) ), 0.0 );
    lowp vec3 n = h*h*h*h*vec3( dot(_a,hash(_i+0.0)), dot(_b,hash(_i+o)), dot(c,hash(_i+1.0)));
    return dot(n, vec3(70.0));
}
 
float fbm(vec2 n) {
    lowp float total = 0.0, amplitude = 0.1;
    for (int _i = 0; _i < 7; _i++) {
        total += noise(n) * amplitude;
        n = m * n;
        amplitude *= 0.4;
    }
    return total;
}
 
// -----------------------------------------------
 
void main() {
   
    lowp vec2 _p = v_vTexcoord.xy / uResolution.xy;
    lowp vec2 uv = _p*vec2(uResolution.x / uResolution.y, 1.0);    
    lowp float _q = fbm(uv * cloudscale * 0.5);
    lowp float _time = uTime * -speed;
   
    lowp float _r = 0.0;
    uv *= cloudscale;
    uv -= _q - _time;
    lowp float weight = 0.8;
    for (int _i=0; _i<4; _i++){
        _r += abs(weight*noise( uv ));
        uv = m*uv + _time;
        weight *= 0.6;
    }
   
    lowp float _f = 0.0;
    uv = _p*vec2(uResolution.x/uResolution.y,1.0);
    uv *= cloudscale;
    uv -= _q - _time;
    weight = 0.4;
    for (int _i=0; _i<3; _i++){
        _f += weight*noise( uv );
        uv = m*uv + _time;
        weight *= 0.2;
    }
   
    lowp vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = vec4( base_col.rgb, clamp(cloudcover + cloudalpha*_f*(_r+_f)*_r, 0.0, 1.0) * uOpacity);
    /*if(clamp(cloudcover + cloudalpha*_f*(_r+_f)*_r, 0.0, 1.0) > 0.4){
        gl_FragColor = base_col;
        gl_FragColor.a = 0.2;
    } else
        gl_FragColor = vec4(0);
	*/
}