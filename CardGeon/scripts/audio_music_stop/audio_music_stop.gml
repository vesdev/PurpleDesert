function audio_music_stop() {
	if !instance_exists(o_audio) exit;

	audio_stop_sound(o_audio.music_current);


}
