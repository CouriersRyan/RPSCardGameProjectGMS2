/// @description Insert description here
// You can write your code in this editor

if face_up{
	switch(card_type){
		case face_index.rock:
			sprite_index = spr_rock;
		break;
	
		case face_index.paper:
			sprite_index = spr_paper;
		break;
	
		case face_index.scissors:
			sprite_index = spr_scissors;
		break;
	}
}else{
	sprite_index = spr_back;
}

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);