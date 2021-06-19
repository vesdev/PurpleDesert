// Set Number Of Available Audio Channels
music_mod = 0;
audio_channel_num(1024);


fade_out_flag = false;
fade_out_mod = 1;
fade_out_amount = .1;
// Set Position to 0,0 for now, will be changed in Step
xx = 0;
yy = 0;

// Create Emitter Lists for both the Emitter ID and the time until deletion
emitter_list = ds_list_create();
emitter_list_time = ds_list_create();


// Load Audiogroups
audio_group_load(audiogroup_default); // should be redundant at some point in the future
audio_group_load(audiogroup_sfx);
audio_group_load(audiogroup_music);



// commented out to check if this is necessary, considering these values are set later in the save/load part

emitter_falloff_distance_ref = 200;
emitter_falloff_distance_max = 1800;

music_current = noone;
music_changeto = noone;
music_loops = 0;


current_song_bg = noone;
combo_bg_gain = 0;//BG of the combo sound effects
coin_additional_pitch = 0;
global.volume_sfx = .5;
global.volume_music = 1;


audio_group_set_gain(audiogroup_sfx,global.volume_sfx,0);
audio_group_set_gain(audiogroup_music,global.volume_music,0);
audio_group_set_gain(audiogroup_default, global.volume_sfx*.6,0);

//music system
musicPlayer = new MusicPlayer();


//music groups
sketch1 = new MusicGroup(
	sketch1_sub_bass,
	sketch1_midsection_strings_with_fx,
	sketch1_midsection_strings_without_fx,
	sketch1_drums_without_fx,
	sketch1_deep_synth_ultimate_layer,
	sketch1_drums_with_fx,
	sketch1_minimal_overworld,
	sketch1_pad_highlights
)
//group.SetTrackGain(index,volume,time);

sketch1.SetTrackGain(0,0,0);
sketch1.SetTrackGain(1,0,0);
sketch1.SetTrackGain(2,0,0);
sketch1.SetTrackGain(3,0,0);

sketch1.SetTrackGain(5,0,0);

musicPlayer.Play(sketch1);



