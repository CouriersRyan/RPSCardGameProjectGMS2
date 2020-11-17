/// @description Insert description here
// You can write your code in this editor
draw_set_font(font);

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text_transformed_color(20, room_height - 20, string(global.player_score), 1, 1, 0, c_white, c_white, c_white, c_white, 1);

draw_set_valign(fa_top);
draw_text_transformed_color(20, 20, string(global.ai_score), 1, 1, 0, c_white, c_white, c_white, c_white, 1);

draw_set_halign(fa_right);
draw_text_transformed_color(room_width - 20, 20, string(global.roundCount) + " of " + string(max_rounds) + " Rounds", 1, 1, 0, c_white, c_white, c_white, c_white, 1);

if(global.state == state.results){
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	if(global.player_score > global.ai_score){
		draw_text_transformed_color(room_width / 2, room_height / 2, "PLAYER WINS", 1, 1, 0, c_white, c_white, c_white, c_white, 1);
	}
	else if(global.player_score < global.ai_score){
		draw_text_transformed_color(room_width / 2, room_height / 2, "AI WINS", 1, 1, 0, c_white, c_white, c_white, c_white, 1);
	}
	else if(global.player_score == global.ai_score){
		draw_text_transformed_color(room_width / 2, room_height / 2, "TIE", 1, 1, 0, c_white, c_white, c_white, c_white, 1);
	}
}