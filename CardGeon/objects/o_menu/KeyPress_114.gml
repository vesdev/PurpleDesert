/// @description 
var aspect = 16/9; //widescreen 1.777778 1920 / 1080 
var w = 960;
var h = w/aspect;

switch zoom { 
case 1: zoom = 2; break;
case 2: zoom = 1; break;

}

window_set_size(w*zoom,h*zoom);
alarm[0] = 1;