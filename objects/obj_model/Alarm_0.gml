/// @description Insert description here
// You can write your code in this editor
global.state = state.play;
for(i = 0; i < ds_list_size(global.hand); i++){
	global.hand[| i].face_up = true;
}