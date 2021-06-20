/// @description Insert description here
// You can write your code in this editor


scribble_font_add_all();
scribble_font_bake_outline("f_round", "outline_default", 1,  4, c_black, false); //default 1 not 1.5

var _font_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz1234567890<>,!¡':-+%*?¿()/@=_АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюяÑÜ{};\"ÁÂÃÀÇÉÊÍÓÔÕÚáâãàçéêíóôõúúåÅäÄöÖΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΎΌΉΏαβγδεζηθικλμνξοπρστυφχψωάέύίόήώ\\È$ÄÖÜäöüß`";
scribble_font_add_from_sprite("s_font_boon", _font_string, 1, 4);
scribble_font_add_from_sprite("s_font_boon_sunset", _font_string, 1, 4);
scribble_font_set_default("s_font_boon");
scribble_font_bake_outline("s_font_boon","outline_boon", 1, 4, c_black, false); //default 1 not 1.5

globalvar font_boon,font_boon_sunset, font_damage_number, font_health_number, font_outrun, font_health_number_white;

font_boon = font_add_sprite_ext(s_font_boon, _font_string, true, 1);//characters I gotta add 死ぁあぃいぅうぇえぉおかがきぎくぐけこごしじすせぜそぞただだちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼェエォオカガキギクグケゲコゴサザシジスズソゾタダテデッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャュユョヨラリルレロワヌンヴカケブ
font_boon_sunset = font_add_sprite_ext(s_font_boon_sunset, _font_string, true, 1);//characters I gotta add 死ぁあぃいぅうぇえぉおかがきぎくぐけこごしじすせぜそぞただだちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼェエォオカガキギクグケゲコゴサザシジスズソゾタダテデッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャュユョヨラリルレロワヌンヴカケブ


var _font_string = "0123456789.-Xx*";
font_damage_number = font_add_sprite_ext(s_font_crit_number_large, _font_string, true, 1);

font_health_number_white = font_add_sprite_ext(s_font_health_numbers_white, _font_string, true, 1);

scribble_font_add_from_sprite("s_font_health_numbers_white", _font_string, 1);
scribble_font_add_from_sprite("s_font_crit_number_large", _font_string, 1);
scribble_font_add_from_sprite("s_font_health_numbers", _font_string, 1);

var _font_string = "0123456789-+./";
font_health_number = f_vhs;// font_add_sprite_ext(s_font_health, _font_string, true, 1);
//font_health_number = font_add(f_vhs)
global.font_ui_numbers = "f_outrun";
scribble_font_add_from_sprite("s_font_health", _font_string, 1);
scribble_add_colors();
//scribble_font_bake_outline("s_font_boon","outline_boon", 1, 4, c_black, false); //default 1 not 1.5



create(0,0,obj_gmlive);
create(0,0,o_audio);
create(0,0,o_menu);