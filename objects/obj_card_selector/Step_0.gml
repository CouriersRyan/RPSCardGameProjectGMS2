/// @description Insert description here
// You can write your code in this editor
var card = instance_position(mouse_x, mouse_y, obj_card)
if(card && card.face_up && ds_list_find_index(global.hand, card) >= 0){
	global.selected = card;
}else{
	global.selected = noone;
}