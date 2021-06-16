/// @description audio_play(index,x,y)
/// @function audio_play
function audio_play(audio) {

	var sound = audio_play_sound(audio,1,false);
	//audio_sound_pitch(sound,audio_parser_pitch(audio,input_id));
	
	
	exit;

//	show_debug_message(argument0)

	var output = audio_parser_index(audio);
	var input_id = argument3;
	if argument3 == 0
	{
		input_id = noone;
	}
	// Check for Only-One-At-A-Time-Sounds
	if argument0 == aud.hitmarker_beer
	{
		audio_stop_sound(sfx_hitmarker_bass);
	}

	// Check if Positioned or Not
	if ((x == noone) && (y == noone)) || ((x == 0) && (y == 0))
	{
		// Play Global Sound
		var sound = audio_play_sound(output,1,false);
		audio_sound_pitch(sound,audio_parser_pitch(audio,input_id));
		audio_sound_gain(sound,audio_parser_volume(audio,input_id),0);
	}
	else
	{
		// Play Local Sound
		var emitter = audio_emitter_create();
		audio_emitter_falloff(emitter,o_audio.emitter_falloff_distance_ref,o_audio.emitter_falloff_distance_max,1);
		audio_emitter_position(emitter,argument1,argument2,0);
		audio_emitter_pitch(emitter,audio_parser_pitch(audio,input_id));
		audio_emitter_gain(emitter,audio_parser_volume(audio,input_id));
		var sound = audio_play_sound_on(emitter,output,false,1);
		ds_list_add(o_audio.emitter_list,emitter);
		ds_list_add(o_audio.emitter_list_time,room_speed*audio_sound_length(sound));
	}
	return output;
}
