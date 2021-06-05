/// @description Insert description here
// You can write your code in this editor
view_surf = surface_create(1, 1);
if (surface_exists(view_surf)) {
	surface_free(view_surf);
	view_surf = -1;
}