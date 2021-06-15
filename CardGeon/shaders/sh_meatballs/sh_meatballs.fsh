//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec2 u_resolution = vec2(320,180);
uniform float u_time;
uniform float u_size_mod;

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(.0);

    // Scale
    st *= 4.0;

    // Tile the space
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);
    float m_dist = 1.;  // minimum distance
    for (int j= -1; j <= 1; j++ ) {
        for (int i= -1; i <= 1; i++ ) {
            // Neighbor place in the grid
            vec2 neighbor = vec2(float(i),float(j));
            // Random position from current + neighbor place in the grid
            vec2 offset = random2(i_st + neighbor);
            // Animate the offset
            offset = 0.5 + 0.5*sin(u_time + 6.2831*offset);
            // Position of the cell
            vec2 pos = neighbor + offset - f_st;
            // Cell distance
            float dist = length(pos);
            // Metaball it!
            m_dist = min(m_dist, m_dist*dist);
        }
    }
 
    // Draw cells
    color += step((0.060*u_size_mod), m_dist);
	
	vec3 new_col = vec3(0.0);
	
    new_col = abs(color -1.0);


    gl_FragColor = vec4(new_col,new_col.x);
}