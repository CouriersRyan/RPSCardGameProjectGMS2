/// @description Insert description here
// You can write your code in this editor
create_rock_icon();

blackout = instance_create_layer(x, y, "Effects", obj_blackout);
blackout.image_alpha = 0;
blackout.x = room_width;
blackout.y = room_height / 2;

inst = instance_nearest(x, y, obj_model)