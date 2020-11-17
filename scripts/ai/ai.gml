// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ai_pick_card(){
	//all cards the players don't have
	//prize cards & whether that is available
	//what cards the player has
	//cards the ai has\
	var _choice = 0;
	var ai_choices;
	
	var cards_in_ai_hand = ds_list_size(global.aiHand);
	
	var player_hand;
	player_hand[0] = 0; //rock
	player_hand[1] = 0; //paper
	player_hand[2] = 0; //scissors
	
	var possible_cards;
	possible_cards[0] = global.numcards / 3; //rock
	possible_cards[1] = global.numcards / 3; //paper
	possible_cards[2] = global.numcards / 3; //scissors
	
	var ratio;
	
	for(i = 0; i < ds_list_size(global.prize); i++){
		possible_cards[global.prize[| i].card_type]--;
	}
	
	for(i = 0; i < ds_list_size(global.discard); i++){
		if(global.discard[|i].face_up) possible_cards[global.discard[| i].card_type]--;
	}
	
	for(i = 0; i < ds_list_size(global.deck); i++){
		if(global.deck[|i].face_up) possible_cards[global.deck[| i].card_type]--;
	}
	
	for(i = 0; i < cards_in_ai_hand; i++){
		if(global.aiHand[|i].face_up) possible_cards[global.aiHand[| i].card_type]--;
	}
	
	for(i = 0; i < ds_list_size(global.hand); i++){
		if(global.hand[|i].is_revealed) possible_cards[global.hand[| i].card_type]--;
	}
	
	var total_possibilities = possible_cards[0] + possible_cards[1] + possible_cards[2];
	ratio[0] = possible_cards[0] / total_possibilities;
	ratio[1] = possible_cards[1] / total_possibilities;
	ratio[2] = possible_cards[2] / total_possibilities;
	
	for(i = 0; i < ds_list_size(global.hand); i++){
		if(global.hand[| i].is_revealed) player_hand[global.hand[| i].card_type] += 1;
		else {
			for(j = 0; j < 3; j++){
				player_hand[j] += ratio[j];
			}
		}
	}
	
	for(i = 0; i < cards_in_ai_hand; i++){
		var _score = 0;
		//lose
		if(global.aiHand[| i].card_type + 1 > 2){
			_score -= ratio[global.aiHand[| i].card_type - 2]
		} else {
			_score -= ratio[global.aiHand[| i].card_type + 1];
		}
		//win
		if(global.aiHand[| i].card_type - 1 < 0){
			_score += ratio[global.aiHand[| i].card_type + 2]
		} else {
			_score += ratio[global.aiHand[| i].card_type - 1];
		}
		//tie
		_score += ratio[global.aiHand[| i].card_type] * 0.1;
		
		ai_choices[i] = _score;
	}
	
	for(i = 0; i < cards_in_ai_hand; i++){
		if (ai_choices[_choice] > ai_choices[i]) _choice = _choice
		else _choice = i;
	}
	
	return _choice;
	
	//return floor(random(ds_list_size(global.aiHand)));
}