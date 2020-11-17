// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function hand_x_position(_index){
	if(_index == 0){
		return hand_x;
	} else if(_index % 2 > 0){
		return hand_x + ceil(_index / 2) * 100;
	} else if(_index % 2 == 0){
		return hand_x - floor(_index / 2) * 100;
	}
	return 0;
}

function prize_y_position(_index){
	return prize_y - max_prize_size/2 * 75 + 75 / 2 + _index * 75;
}