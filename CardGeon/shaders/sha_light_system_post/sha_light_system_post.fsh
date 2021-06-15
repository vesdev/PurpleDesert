//
// Simple passthrough fragment shader
//

//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float blurSize;
uniform float intensity;

uniform float smooth_1;
uniform float smooth_2;

vec4 sample(sampler2D tex, vec2 coord)
{
	vec4 col = texture2D(tex,coord);
	float gray = dot(col,vec4(0.199,0.587,0.014,0.0));//dot(col,vec4(0.299,0.587,0.114,0.0));
	return col*vec4(vec3(smoothstep(smooth_1,smooth_2,gray)),1);
}




void main()
{
   vec4 sum = vec4(0);
   int j;
   int i;

   // take nine samples, with the distance blurSize between them
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x - 4.0*blurSize, v_vTexcoord.y)) * 0.05;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x - 3.0*blurSize, v_vTexcoord.y)) * 0.09;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x - 2.0*blurSize, v_vTexcoord.y)) * 0.12;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x - blurSize, v_vTexcoord.y)) * 0.15;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y)) * 0.16;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x + blurSize, v_vTexcoord.y)) * 0.15;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x + 2.0*blurSize, v_vTexcoord.y)) * 0.12;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x + 3.0*blurSize, v_vTexcoord.y)) * 0.09;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x + 4.0*blurSize, v_vTexcoord.y)) * 0.05;

   // take nine samples, with the distance blurSize between them
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 4.0*blurSize)) * 0.05;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 3.0*blurSize)) * 0.09;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - 2.0*blurSize)) * 0.12;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - blurSize)) * 0.15;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y)) * 0.16;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + blurSize)) * 0.15;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 2.0*blurSize)) * 0.12;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 3.0*blurSize)) * 0.09;
   sum += sample(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + 4.0*blurSize)) * 0.05;

   //increase blur with intensity!
   gl_FragColor = sum * intensity + texture2D(gm_BaseTexture, v_vTexcoord);
}



