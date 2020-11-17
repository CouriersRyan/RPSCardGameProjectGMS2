// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_rock_icon(){
	rock_icon = instance_create_layer(x, y, "Effects", obj_rock_icon);
	rock_icon.image_alpha = 0;
	rock_icon.x = room_width - 32;
	rock_icon.y = room_height / 2;
	rock_icon.image_xscale = 2;
	rock_icon.image_yscale = 2;
	rock_icon.depth = -101;
}