/// @description SQUARE OPEN
//create bubbles
if instance_exists(o_locked_chest) exit;
//Top rectangle 
draw_rectangle(0,-1,width,top_box_y,false);
//Bot Rectangle
draw_rectangle(0,bot_box_y,width, height,false);


if(timer <= SEC*1.5)
{
	top_box_y = easings(e_ease.easeinquint,height/2,-height,SEC*1.5,timer);
	bot_box_y = easings(e_ease.easeinquint, height/2,height,SEC*1.5,timer);
}
timer++;
