if (room = r_menu)
{
draw_set_alpha(.8);
stars.Draw(camera.x-camera.width/2,camera.y-camera.height/2, camera.width, camera.height);
draw_set_alpha(1);

lights[0].x = mouse_x;
lights[0].y = mouse_y;

page.x = 0;
page.y = 0;

//function(x,y, lightNodeArray, drawSolids)
lighting.Draw(camera.x-camera.width/2,camera.y-camera.height/2,lights,drawLightSolids);

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