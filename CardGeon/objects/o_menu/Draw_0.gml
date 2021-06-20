
if (room = r_menu)
{
	
	
	
draw_set_alpha(.8);
stars.Draw(camera.x-camera.width/2,camera.y-camera.height/2, camera.width, camera.height);
draw_set_alpha(1);

lights[0].x = mouse_x;
lights[0].y = mouse_y;

page.x = 0;
page.y = 0;

var str = "[fa_center][c_yellow]STORY:[]\nSTRANGE ANOMALIES ARE HAPPENING IN THE DARK SIDE OF THE MOON. EVERYONE IS TERRIFIED OF WHAT LURKS IN THE SHADOWS SO NASA SENT THEIR BEST MAN FOR THE JOB: THE UNPAID EXPANDABLE INTERN TO INVESTIGATE.";
var scr = scribble(str);
scr.wrap(250);
scr.draw(-350,-100)

draw_sprite(s_char_idle_coco,0,0,150);

var str = "[fa_center]YOUR STARTING GEAR:\n\n[s_passive_tight_goggles][c_yellow]TIGHT GOGGLES[]\n YOUR [c_gum]RED[] CARDS HAVE A [c_lime]10%[] OF DEALING [c_lime]200%[] DAMAGE";
var scr = scribble(str);


scr.draw(0,160);





//function(x,y, lightNodeArray, drawSolids)
//lighting.Draw(camera.x-camera.width/2,camera.y-camera.height/2,lights,drawLightSolids);

page.Draw();
}
if (room = r_end)
{
	lights[0].x = mouse_x;
	lights[0].y = mouse_y;

	scroll+=.5;
	draw_set_alpha(.8);
	stars.Draw(camera.x-camera.width/2,camera.y-camera.height/2, camera.width, camera.height);
	draw_set_alpha(1);
	lighting.Draw(camera.x-camera.width/2,camera.y-camera.height/2,lights,drawCredits);
	
	drawCredits();
}