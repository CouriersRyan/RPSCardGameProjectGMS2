// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function move_card(_card, _target_x, _target_y){
	_card.target_x = _target_x;
	_card.target_y = _target_y;
	audio_play_sound(snd_shuffle, 1, false);
}

function move_card_soundless(_card, _target_x, _target_y){
	_card.target_x = _target_x;
	_card.target_y = _target_y;
}