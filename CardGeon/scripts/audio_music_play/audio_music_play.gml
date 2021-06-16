/// @params index,loops
function audio_music_play(music_changeto, music_loops) {
	if !instance_exists(o_audio) exit;




	if o_audio.music_current == music_changeto exit;

o_audio.music_current =music_changeto;

audio_play_sound(music_changeto,1,0);
	exit;


	with o_audio {
		fade_out_flag = false;
		fade_out_mod = 1;
		fade_out_amount = .1;	//ro_gameeset fade outs to false

		self.music_changeto = music_changeto;
		self.music_loops = music_loops;
	}
}
