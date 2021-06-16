/// @desc Audio Parser for Volume, returns volume from preset range (See script for a list of all ranges)
function audio_parser_volume_music(sound_index) {
	// @arg index

	// This script takes the name of a sound file WITHOUT the numbered suffix.
	// Example: "sfx_footstep_wood_<number>" becomes just "sfx_footstep_wood"

	// It then returns a given volume from a preset list of ranges.
	// This script is meant for randomization inside other audio play scripts, not for direct usage.
	// ~WangleLine
	var output = .5;
	switch(sound_index)
	{
		case mus_lofi:
		case mus_city_nights:
		case mus_sketch1_alt:
				output = .4; //these songs are too loud
		break;	

	}

		if output > global.volume_music{
			output = global.volume_music;	
		}
	return output;
}
