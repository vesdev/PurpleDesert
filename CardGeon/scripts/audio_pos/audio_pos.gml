/// @description audio_play(index,x,y)
// @function audio_play
// @arg index
// @arg x
// @arg y
// @arg [pitch1]
// @arg [pitch1]
// @arg [volume1]
// @arg [volume2]
function audio_pos() {

	var sfx    = argument[0];
	var xx     = argument[1];
	var yy     = argument[2];				//if return argumetn[3] else return Scribble
///	var _occurance_name = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : SCRIBBLE_DEFAULT_OCCURANCE_NAME;

	if is_array(sfx) {
		var len = array_length(sfx);
		sfx = sfx[irandom(len)];
	}
	
	//if there are no arguments return 1
	var p1 = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 1;
	var p2 = ((argument_count > 4) && (argument[4] != undefined))? argument[4] : 1;
	var v1 = ((argument_count > 5) && (argument[5] != undefined))? argument[5] : 1;
	var v2 = ((argument_count > 6) && (argument[6] != undefined))? argument[6] : 1;
	

	// Check if Positioned or Not
	if ((argument[1] == noone) && (argument[2] == noone)) || ((argument[1] == 0) && (argument[2] == 0))
	{
		// Play Global Sound
		var sound = audio_play_sound(sfx,1,false);
		audio_sound_pitch(sound,random_range(p1,p2));
		audio_sound_gain(sound, random_range(v1,v2),0);
	}
	else
	{
		// Play Local Sound
		var emitter = audio_emitter_create();
		audio_emitter_falloff(emitter,o_audio.emitter_falloff_distance_ref,o_audio.emitter_falloff_distance_max,1);
		audio_emitter_position(emitter,xx,yy,0);
		audio_emitter_pitch(emitter,random_range(p1,p2));
		audio_emitter_gain(emitter,random_range(v1,v2));
		var sound = audio_play_sound_on(emitter,sfx,false,1);
		ds_list_add(o_audio.emitter_list,emitter);
		ds_list_add(o_audio.emitter_list_time,SEC*audio_sound_length(sound));
	}
	return sound;
}