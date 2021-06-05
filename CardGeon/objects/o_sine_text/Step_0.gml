/// @description 



if timer < time{
//alpha = easings(e_ease.easeoutexpo,.1,.9,time,timer);	
y_amount = easings(e_ease.easeoutexpo,0,-32,time,timer);
size = easings(e_ease.easeoutexpo,0,size_final,time,timer);

}

if alarm[0] = -1{
y_amount -= 0.5;
size = easings(e_ease.easeinquad,size_final,-size_final,SEC,timer2);	
timer2 ++;
}
if size <= 0 and alarm[0] <= -1{
	instance_destroy();	
}