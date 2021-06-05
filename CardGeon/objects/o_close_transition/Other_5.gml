/// @description move to second transition



if second_target = noone exit;
if next_song != noone{
//	audio_music_play(next_song,true);	
}

state = close.circle_open;
persistent = true;
//variables for open transition
timer = 0;
time = SEC*1;
radius = 1;
alarm[3] = SEC*2.4;