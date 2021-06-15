//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 lightData[10];
uniform float lightCount;
uniform vec2 resolution;

const float shadowDarkness = 1.5;

void main()
{
	vec2 aspectRatio = vec2(resolution.x/resolution.y, 1.0);
	vec2 uv = v_vTexcoord*aspectRatio;
	
	vec4 final = vec4(0);
	
	vec4 col, col1;
	
	vec4 light, t;
	vec2 dt;
	//loop through every light
	int i, j;
	
	for(i = 0; i < 10; i++)
	{
		if (i >= int(lightCount)) break;
		col = vec4(1);
		
		light = lightData[i];
		dt = normalize(v_vTexcoord*resolution-light.xy)/resolution*aspectRatio;
		light.xy = light.xy/resolution*aspectRatio;

		
		t = light;
		//col += distance(light.xy/resolution*aspectRatio, v_vTexcoord*aspectRatio);
		
		//raycast
		for(j = 0; j < 500; j++) //max steps
		{
			
			col1 = texture2D(gm_BaseTexture, t.xy/aspectRatio);
			col.rgb*=((1.0-col1.a*shadowDarkness)*t.z);
			//if(col1.a != 0.) break; // we hit a opaque pixel
			if (dot(uv-t.xy,dt) <= 0.) break; // we passed target pixel
			if (col.r+col.g+col.b<=0.001) break;
			t.xy += dt;
		}
		//convert bgr to vec4
		float blueC = float(int(light.a) / 256 / 256);
		float greenC = float(int(light.a) / 256 - int(blueC * 256.));
		float redC = float(int(light.a) - int(blueC * 256. * 256.) - int(greenC * 256.));
		
		vec4 lightCol = vec4(redC/255.,greenC/255.,blueC/255., 1);
		final += col*lightCol;
	}
	
    gl_FragColor = final;
}
