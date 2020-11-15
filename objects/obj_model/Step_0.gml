/// @description Insert description here
// You can write your code in this editor
#macro choiceOffset 160

var cards_in_hand = ds_list_size(global.hand);
var cards_in_ai_hand = ds_list_size(global.aiHand);
var cards_in_prize = ds_list_size(global.prize);

if(delay <= 0){
	switch(global.state){
	
		case state.setup:
			if(ds_list_size(global.deck) > 0){
				if(cards_in_ai_hand < cards_in_hand){
					var ai_card = global.deck[| 0];
					ds_list_add(global.aiHand, ai_card);
					ds_list_delete(global.deck, 0);
					move_card(ai_card, hand_x_position(cards_in_ai_hand), room_height / 8);
					delay = 250;
					break;
				}
				if(cards_in_hand < 3){
					var card = global.deck[| 0];
					ds_list_add(global.hand, card);
					ds_list_delete(global.deck, 0);
					move_card(card, hand_x_position(cards_in_hand), 7 * room_height / 8);
					delay = 250;
					break;
				}
			}
			if(alarm[0] < 0) alarm[0] = 50;
		break;
	
		//ai selects a card
		case state.play:
			if(global.aiChoice == noone) {
				global.aiChoice = ds_list_find_value(global.aiHand, ai_pick_card());
				move_card(global.aiChoice, hand_x, global.aiChoice.y + choiceOffset);
			}
			if(global.selected != noone && mouse_check_button_pressed(mb_left)){
				global.choice = global.selected;
				move_card(global.selected, hand_x, global.selected.y - choiceOffset);
				global.state = state.compare;
			}
	/*		var cards_face_up = 0;
			for(i = 0; i < cards_in_hand; i++){
				var card = ds_list_find_value(global.hand, i);
				if (card.face_up) cards_face_up++;
			}
		
			if(cards_face_up >= 2){
				for(i = 0; i < cards_in_hand; i++){
					var card = ds_list_find_value(global.hand, i);
					card.face_up = false;
				}
		
			
			}*/
		break;
	
		case state.compare:
			if (wait(1000, 0)) break;
			global.aiChoice.face_up = true;
			if (wait(1000, 1)) break;
			if(global.choice.card_type == global.aiChoice.card_type){
				//tie
				global.winningCard = noone;
			}else if(global.choice.card_type + 1 == global.aiChoice.card_type || global.choice.card_type - 2 == global.aiChoice.card_type){
				//lose
				global.winningCard = global.aiChoice;
				audio_play_sound(snd_lose, 1, false);
				global.ai_score++;
				card_victory_animation(global.aiChoice);
				if(is_bonus){
					for(i = 0; i < ds_list_size(global.prize); i++){
						if(global.prize[|i].card_type == global.aiChoice.card_type){
							global.ai_score++;
							card_victory_animation(global.prize[|i]);
						}
					}
				} else is_bonus = true;
			}else if(global.choice.card_type - 1 == global.aiChoice.card_type || global.choice.card_type + 2 == global.aiChoice.card_type){
				//win
				global.winningCard = global.choice;
				audio_play_sound(snd_win, 1, false);
				global.player_score++;
				card_victory_animation(global.choice);
				if(is_bonus){
					for(i = 0; i < ds_list_size(global.prize); i++){
						if(global.prize[|i].card_type == global.choice.card_type){
							global.player_score++;
							card_victory_animation(global.prize[|i]);
						}
					}
				} else is_bonus = true;
			}
			global.state = state.effect;
		break;
		
		case state.effect:
			if (wait(1000, 0)) break;
			if(global.winningCard){
				if(global.winningCard.card_type == face_index.rock){
					is_bonus = false;
				} else if (global.winningCard.card_type == face_index.scissors){
					if(scissored_cards < 2 && ds_list_size(global.deck) > 0){
						var card = global.deck[| 0];
						ds_list_insert(global.discard, 0, card);
						ds_list_delete(global.deck, 0);
						var size = ds_list_size(global.discard);
						move_card(card, discard_x, discard_y - spacing * size);
						card.depth = -size;
						scissored_cards++;
						delay = 250;
						break;
					}
					scissored_cards = 0;
				} else if (global.winningCard.card_type == face_index.paper){
					if(cards_in_hand > 0){
						var card = global.hand[|cards_in_hand - 1];
						card.face_up = true;
						ds_list_delete(global.hand, ds_list_find_index(global.hand, card));
						if (card != global.choice){ 
							ds_list_insert(global.deck, 0, card);
							var size = ds_list_size(global.deck);
							move_card(card, deck_x, deck_y - spacing * size);
							card.depth = -size;
						}
						delay = 250;
						break;
					}
					if(cards_in_ai_hand > 0){
						var card = global.aiHand[|cards_in_ai_hand - 1];
						card.face_up = true;
						ds_list_delete(global.aiHand, ds_list_find_index(global.aiHand, card));
						if (card != global.aiChoice){ 
							ds_list_insert(global.deck, 0, card);
							var size = ds_list_size(global.deck);
							move_card(card, deck_x, deck_y - spacing * size);
							card.depth = -size;
						}
						delay = 250;
						break;
					}
					global.state = state.shuffle;
					is_shuffled = false;
					break;
				} else {
				
				}
			}
			global.state = state.resolve;
		break;

		case state.resolve:
			if(global.choice != noone){
				var card = global.choice;
				card.face_up = true;
				ds_list_insert(global.discard, 0, card);
				ds_list_delete(global.hand, ds_list_find_index(global.hand, card));
				var size = ds_list_size(global.discard);
				move_card(card, discard_x, discard_y - spacing * size);
				card.depth = -size;
				global.choice = noone;
				delay = 250;
				break;
			}
			if(global.aiChoice != noone){
				var card = global.aiChoice;
				card.face_up = true;
				ds_list_insert(global.discard, 0, card);
				ds_list_delete(global.aiHand, ds_list_find_index(global.aiHand, card));
				var size = ds_list_size(global.discard);
				move_card(card, discard_x, discard_y - spacing * size);
				card.depth = -size;
				global.aiChoice = noone;
				delay = 250;
				break;
			}
			if(cards_in_ai_hand > 0 && cards_in_hand > 0){
				for(i = 0; i < cards_in_ai_hand; i++){
					move_card_soundless(global.hand[|i], hand_x_position(i), 7 * room_height / 8);
					move_card_soundless(global.aiHand[|i], hand_x_position(i), room_height / 8);
				}
			}
			if(ds_list_size(global.hand) == 0 && ds_list_size(global.deck) == 0){
				if(wait(500, 50)) break;
				global.state = state.reshuffle;
			}else{
				global.state = state.setup;
			}
		break;
	
		case state.reshuffle:
			if(ds_list_size(global.discard) > 0){
				
				var card = ds_list_find_value(global.discard, 0);
				card.face_up = false;
				var deck_pos = ds_list_size(global.deck);
				move_card(card, deck_x, deck_y - spacing * deck_pos);
				ds_list_insert(global.deck, 0, card);
				ds_list_delete(global.discard, 0);
				card.depth = -deck_pos;
				delay = 50;
				break;
			}
			if(ds_list_size(global.prize) > 0){
				
				var card = ds_list_find_value(global.prize, 0);
				card.face_up = false;
				var deck_pos = ds_list_size(global.deck);
				move_card(card, deck_x, deck_y - spacing * deck_pos);
				ds_list_insert(global.deck, 0, card);
				ds_list_delete(global.prize, 0);
				card.image_angle = 0;
				card.depth = -deck_pos;
				delay = 50;
				break;
			}
			ds_list_clear(global.discard);
			is_shuffled = false;
			global.state = state.shuffle;
		break;
		
		case state.shuffle:
			if(!is_shuffled) {
				show_debug_message("Shuffle");
				ds_list_shuffle(global.deck);
				is_shuffled = true;
				deck_index = 0;
			}
			if(deck_index < ds_list_size(global.deck)){
				var card = global.deck[| deck_index];
				card.depth = deck_index;
				move_card(card, deck_x, deck_y - spacing * (ds_list_size(global.deck) - deck_index - 1))
				deck_index++;
				delay = 30;
				break;
			}
			
			if (ds_list_size(global.deck) == global.numcards) global.state = state.prize;
			else global.state = state.resolve;
		break;
		
		case state.prize:
			if(cards_in_prize < max_prize_size){
				var card = global.deck[| 0];
				ds_list_add(global.prize, card);
				ds_list_delete(global.deck, 0);
				move_card(card, prize_x, prize_y_position(cards_in_prize));
				card.image_angle = 90;
				card.face_up = true;
				delay = 250;
				break;
			}
			global.state = state.setup;
		break;
	}
} else {
	delay -= delta_time / 1000;
}