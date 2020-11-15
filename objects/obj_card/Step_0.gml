/// @description Insert description here
// You can write your code in this editor

//TODO: Move x and y towards target position with lerp.
//Also use move_towards_point

x = lerp(x, target_x, 0.25);
y = lerp(y, target_y, 0.25);
image_xscale = lerp(image_xscale, target_size, 0.5);
image_yscale = lerp(image_yscale, target_size, 0.5);

if(global.selected = id && global.state == state.play) {
	image_index = 1;
} else {
	image_index = 0;
}

if(target_size == image_xscale) target_size = 1;