/// @description top down close
if alarm[1] = -1 and bubble_flag = false{
alarm[1] = SEC*.41;
}
//Top rectangle 
draw_rectangle(0,0,width,top_box_y,false);
//Bot Rectangle
draw_rectangle(0,bot_box_y,width, height,false);



if(timer <= SEC*1.3)
{
	top_box_y = easings(e_ease.easeoutexpo,0,height/2,SEC*1.3,timer);
	bot_box_y = easings(e_ease.easeoutexpo, height,-height/2,SEC*1.3,timer);
	
}
timer++;