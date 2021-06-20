if (room = r_menu || room = r_end) camera.update();

if (room = r_menu)
{
if page != undefined{
	page.Update(mouse_x, mouse_y);
}

}

if (room = r_end)
{
	global.__uiMX = mouse_x;
	global.__uiMY = mouse_y;
	skip.Update();
}