//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord; //texture page
varying vec4 v_vColour;
varying vec2 v_vPos; //room position

uniform float u_Time;
uniform vec4 u_uvInfo;

uniform float u_xamount;
uniform float u_yamount;
//uniform vec2 u_Scale;

vec2 invPixelSize = vec2(1.0) / vec2(32.0, 32.0);  // 1/36 for x, 1/36 for y
//vec2 Size = vec2(96,96);
//vec2 Wave = vec2(10, 1); //vec2(50,10);

const float scale = 1.0;

void main()
{
	float scaledTime = u_Time * 4.0; // feel-good value
	vec2 virtualCoord = v_vPos * invPixelSize * scale; //vision, 
	
    //vec2 Coord = (v_vTexcoord - u_uvInfo.xy) / u_uvInfo.zw;// + vec2(cos((v_vPos.y/Wave.x+u_Time)*1.2)*Wave.y,0)/Size*(1.0-v_vTexcoord.y);
	vec2 Offset = vec2(0.0);
	//Offset.x = cos(v_vPos.y * 1.0 + scaledTime) * 1.1;// * 10.0;
	Offset.x = cos(virtualCoord.y + scaledTime + 0.0) * u_xamount;
	Offset.y = sin(virtualCoord.x + scaledTime + 1.0) * u_yamount;
	virtualCoord = fract(virtualCoord + Offset) * u_uvInfo.zw + u_uvInfo.xy;
	//multiplying the x coordinate and the width and the same for the y coordinate by the height
	//
	vec4 topColor = texture2D( gm_BaseTexture, virtualCoord );
	
	//float top = float(topColor.r > 0.9);
	
	virtualCoord = (v_vPos + vec2(16.0, 0.0)) * invPixelSize * scale;
    
	Offset = vec2(0.0);
	
	Offset.x = cos(virtualCoord.y + scaledTime + 1.0) * u_xamount;
	Offset.y = sin(virtualCoord.x + scaledTime + 0.0) * u_yamount;
	virtualCoord = fract(virtualCoord + Offset) * u_uvInfo.zw + u_uvInfo.xy;
	//rgb colors 1 113 137
	vec4 botColor = texture2D( gm_BaseTexture, virtualCoord ) * v_vColour + v_vColour;
	
	//float bot = float(botColor.r > 0.9);	
	//if (Coord.x < 0.1 || Coord.x > 0.9) col = vec4(1.0, 0.0, 0.0, 1.0);
    gl_FragColor = clamp(topColor + botColor, 0.0, 1.0);
}