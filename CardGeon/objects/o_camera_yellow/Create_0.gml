smooth = true;
view_surf = -1;

// dragging variables:
dragging = false;
drag_x = 0;
drag_y = 0;
dragging_timer = SEC*3;
event_user(0);

view_surf = surface_create(game_width + 1, game_height + 1);