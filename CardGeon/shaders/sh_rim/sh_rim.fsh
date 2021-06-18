//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//vvv number has to be a multiple of 6

//30 = 6 
//90 / 6 = 15 max lights
//9 * 6 = 54

uniform float lightData[54]; //x,y,radius, red, green, blue
uniform float lightCount;
uniform vec2 texel;

const float lightIntensity = .1;

uniform float rimSize;

void main()
{
	
	
    vec4 rim_col = vec4(0);
    
    //rim light
    if (texture2D(gm_BaseTexture, v_vTexcoord).a != 0.){
     
        vec2 rim = vec2(0.0);
        float addedAlpha = 0.0; 
        vec2 aux = vec2(texel.x*rimSize,0.);
        float value = 0.;
        value = texture2D(gm_BaseTexture, v_vTexcoord + aux).a;
        rim.x -= value;
        addedAlpha += value;
        value = texture2D(gm_BaseTexture, v_vTexcoord - aux).a;
        rim.x += value;
        addedAlpha += value;
 
        aux = vec2(0.0,texel.y*rimSize);
        value = texture2D(gm_BaseTexture, v_vTexcoord + aux).a;
        rim.y -= value;
        addedAlpha += value;
        value = texture2D(gm_BaseTexture, v_vTexcoord - aux).a;
        rim.y += value;
        addedAlpha += value;
    
        if (addedAlpha < 4.)
        {
            vec2 lightVec;
            for(int i = 0; i < int(lightCount)*6; i+=6){
            
                lightVec = vec2(lightData[i],lightData[i+1])-(v_vTexcoord/texel);
            
                rim_col += vec4(lightData[i+3],lightData[i+4],lightData[i+5],1.0) * vec4(max(dot( lightVec, rim),0.)*((1.-min(length(lightVec)/lightData[i+2],1.))*lightIntensity));
                
            }
        }
    }
    gl_FragColor =  rim_col;
}