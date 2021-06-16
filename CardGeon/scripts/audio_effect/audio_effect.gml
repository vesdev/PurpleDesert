/// @description audio_effect(sound_id, loops, priority);
/// @function audio_effect
/// @param sound_id
/// @param  loops
/// @param  priority

function audio_effect(argument0, argument1, argument2) {


	var sound_id = argument0;
	var loops = argument1;
	var priority = argument2;

	return audio_play_sound(sound_id,  priority,loops);


}
