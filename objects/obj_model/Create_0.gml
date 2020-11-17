/// @description Insert description here
// You can write your code in this editor
global.roundCount = 0;
#macro max_rounds 4

global.numcards = 24;
global.deck = ds_list_create();
global.discard = ds_list_create();
global.prize = ds_list_create();
global.hand = ds_list_create();
global.aiHand = ds_list_create();
global.selected = noone;
global.choice = noone;
global.aiChoice = noone;
global.winningCard = noone;

global.player_score = 0;
global.ai_score = 0;

enum state {
	setup,
	play,
	compare,
	effect,
	resolve,
	reshuffle,
	shuffle,
	prize,
	results
}

global.state = state.shuffle;

#macro deck_x 200
#macro deck_y 584
#macro discard_x room_width - 260
#macro discard_y 584
#macro hand_x room_width / 2
#macro max_prize_size 6
#macro prize_x room_width
#macro prize_y room_height / 2

ini_open("./read.ini");
spacing = ini_read_real("game", "spacing", 2);
ini_close();

waitTime = 0;
waitTarget = -1;
waiting = false;

scissored_cards = 0;

randomize();

for(i = 0; i < global.numcards; i++){
	var newcard = instance_create_layer(-100, -100, "Instances", obj_card);
	
	newcard.target_x = -100;
	newcard.target_y = -100;
	
	newcard.card_type = floor(i % 3);
	
	ds_list_insert(global.deck, 0, newcard);
}
global.roundCount += 1;