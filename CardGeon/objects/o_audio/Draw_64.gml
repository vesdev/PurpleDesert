// Display all Emitters, as well as their ID

/*
draw_set_color(c_white);
draw_set_alpha(1);
for(i=0;i<ds_list_size(emitter_list);i++)
{
	draw_text(8,8+(i*12),string(ds_list_find_value(emitter_list,i)));
}