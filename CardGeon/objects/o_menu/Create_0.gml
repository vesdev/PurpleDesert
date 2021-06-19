//camera stuff

var aspect = 16/9; //widescreen 1.777778 1920 / 1080 
w = 960;
h = w/aspect;

display_set_gui_size(w,h);
camera = new Camera(w, h, display_get_width(), display_get_height());
camera.set();

//manu

page = undefined;

p_main = new UiPage(10, 
	[
		new UiButton(128, 32, s_nine_slice_default_menu, "Play", function(){
			room_goto(r_battle);
		}),
		new UiButton(128, 32, s_nine_slice_default_menu, "Settings", function(){
			o_menu.page = o_menu.p_settings;
		}),
		new UiButton(128, 32, s_nine_slice_default_menu, "Quit", function(){
			game_end();
		}),
	]
)

p_settings = new UiPage(10, 
	[
		new UiButton(128, 32, s_nine_slice_default_menu, "Return", function(){
			o_menu.page = o_menu.p_main;
		}),
		new UiCheck(32, s_checkbox, "Fullscreen", 0, function(value){
			o_menu.camera.setFullscreen(value, o_menu.w, o_menu.h);
		}),
		new UiSlider(128, 32, s_nine_slice_default_menu, s_slider, "Sfx Volume",0, 1, 2, 1, function(value){
			global.volume_sfx = value;
			audio_group_set_gain(audiogroup_sfx,value,0);
		}),
		new UiSlider(128, 32, s_nine_slice_default_menu, s_slider, "Music Volume",0, 1, 2, 1, function(value){
			global.volume_music = value;
			audio_group_set_gain(audiogroup_sfx,value,0);
		})
	]
)

page = p_main;