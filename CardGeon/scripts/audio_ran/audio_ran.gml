///@arg sound
///@arg gain1
///@arg gain2
///@arg pitch1
///@arg pitch2
function audio_ran(argument0, argument1, argument2, argument3, argument4) {
	var sound = argument0;
	var gain_1 = argument1;
	var gain_2 = argument2;
	var pitch_1 = argument3;
	var pitch_2 = argument4;

	if instance_exists(o_player)
	{
		audio_emitter_position(o_audio.ran_emitter,x,y,0);
	}
	audio_emitter_gain(o_audio.ran_emitter,random_range(gain_1,gain_2));
	audio_emitter_pitch(o_audio.ran_emitter,random_range(pitch_1,pitch_2));
	audio_play_sound_on(o_audio.ran_emitter,sound,false,1);


}
