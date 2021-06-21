if live_call() return live_result;


if (room = r_menu)
{
	
	
draw_set_alpha(1);
stars.Draw(camera.x-camera.width/2,camera.y-camera.height/2, camera.width, camera.height);
draw_set_alpha(1);
draw_sprite_ext(s_pixel,0, camera.x-camera.width/2,camera.y-camera.height/2,room_width,room_height,0,c_black,.5);

draw_sprite(s_logo,0,0,-120);


lights[0].x = mouse_x;
lights[0].y = mouse_y;

page.x = 0;
page.y = 80;

var str = "[fa_center][fa_top][c_yellow]STORY:[]\nSTRANGE ANOMALIES ARE HAPPENING IN THE DARK SIDE OF THE MOON. EVERYONE IS TERRIFIED OF WHAT LURKS IN THE SHADOWS SO NASA SENT THEIR BEST MAN FOR THE JOB: THE UNPAID EXPANDABLE INTERN TO INVESTIGATE.";
var scr = scribble(str);
scr.wrap(250);
scr.draw(-350,-100);


var str = "[fa_center][fa_top]STARTING TREASURE\n[s_passive_tight_goggles][c_yellow]CRIT GOGGLES[]\n YOUR [c_gum]RED[] CARDS HAVE A [c_lime]10%[] CRITICAL HIT CHANCE OF DEALING [c_lime]200%[] DAMAGE\n\n[s_char_idle_coco]\nCOCO";
var scr = scribble(str);
scr.wrap(250);
scr.draw(350,-100);

//function(x,y, lightNodeArray, drawSolids)
//lighting.Draw(camera.x-camera.width/2,camera.y-camera.height/2,lights,drawLightSolids);
draw_set_font(f_outrun)
page.Draw();


}
if (room = r_end)
{
	lights[0].x = mouse_x;
	lights[0].y = mouse_y;

	scroll+=.5;
	draw_set_font(f_vhs)
	draw_set_alpha(.8);
	stars.Draw(camera.x-camera.width/2,camera.y-camera.height/2, camera.width, camera.height);
	draw_set_alpha(1);
	lighting.Draw(camera.x-camera.width/2,camera.y-camera.height/2,lights,drawCredits);
	drawCredits();
	draw_set_font(font_boon)
}