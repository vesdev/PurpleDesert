/////RAIN

audio_play_sound(amb_rain,5,1);
sys_rain = part_system_create();
pt_rain1 = part_type_create();
pt_rain2 = part_type_create();
pt_rain3 = part_type_create();
pt_rain4 = part_type_create();
sys_puddle = part_system_create();
pt_puddle = part_type_create();


part_type_sprite(pt_rain1,s_pt_rain_1,0,0,true);
part_type_size(pt_rain1,1,1,0,0);
part_type_color1(pt_rain1,c_white);
part_type_alpha2(pt_rain1,1,.1);
part_type_gravity(pt_rain1,0,0);
part_type_speed(pt_rain1,10.5,15.5,0,0);
var angle = 315;
part_type_direction(pt_rain1,angle,angle,0,0);
part_type_orientation(pt_rain1,0,0,0,0,0);
part_type_life(pt_rain1,SEC*.1,SEC*1.4);

part_type_sprite(pt_rain2,s_pt_rain_1,0,0,true);
part_type_size(pt_rain2,1,1,0,0);
part_type_color1(pt_rain2,c_white);
part_type_alpha2(pt_rain2,1,.1);
part_type_gravity(pt_rain2,0,0);
part_type_speed(pt_rain2,10.5,15.5,0,0);
var angle = 315;
part_type_direction(pt_rain2,angle,angle,0,0);
part_type_orientation(pt_rain2,0,0,0,0,0);
part_type_life(pt_rain2,SEC*.1,SEC*1.4);


part_type_sprite(pt_rain3,s_pt_rain_3,0,0,true);
part_type_size(pt_rain3,1,1,0,0);
part_type_color1(pt_rain3,c_white);
part_type_alpha2(pt_rain3,1,.1);
part_type_gravity(pt_rain3,0,0);
part_type_speed(pt_rain3,10.5,15.5,0,0);
var angle = 315;
part_type_direction(pt_rain3,angle,angle,0,0);
part_type_orientation(pt_rain3,0,0,0,0,0);
part_type_life(pt_rain3,SEC*.1,SEC*1.4);


part_type_sprite(pt_rain4,s_pt_rain_4,0,0,true);
part_type_size(pt_rain4,1,1,0,0);
part_type_color1(pt_rain4,c_white);
part_type_alpha2(pt_rain4,1,.1);
part_type_gravity(pt_rain4,0,0);
part_type_speed(pt_rain4,10.5,15.5,0,0);
var angle = 315;
part_type_direction(pt_rain4,angle,angle,0,0);
part_type_orientation(pt_rain4,0,0,0,0,0);
part_type_life(pt_rain4,SEC*.1,SEC*1.4);






//part_type_shape(pt_puddle,pt_shape_circle);
part_type_sprite(pt_puddle,s_pt_rain_splatter,1,1,1);
part_type_size(pt_puddle,1,1,0,0);
part_type_scale(pt_puddle,1,1);
part_type_color1(pt_puddle,c_silver);
part_type_alpha2(pt_puddle,.2,.2);
part_type_speed(pt_puddle,0,0,0,0);
part_type_direction(pt_puddle,0,0,0,0);
part_type_gravity(pt_puddle,0,270);
part_type_life(pt_puddle,SEC*.4,SEC*.5);
//emitter
//emit_rain = part_emitter_create(sys_rain);
//Set Sequence
part_type_death(pt_rain1,1,pt_puddle);
part_type_death(pt_rain2,1,pt_puddle);
//create(random_range(x_,x_+width_),y_-15, o_confetti_SUPER_LARGE);
