/// @description RESET THE GAME

boon_randomize();

ds_list_clear(deck);
ds_list_clear(hand);
ds_list_clear(discard);
ds_list_clear(exhaust);
//1add_card_for_run(deck, e_card.coco_coupe_de_grace);

repeat(5) {
//	add_card_for_run(deck , e_card.coco_token_summoning);
//	add_card_for_run(deck , e_card.coco_token_salmon);
	add_card_for_run(deck , e_card.coco_default_attack);
	add_card_for_run(deck , e_card.coco_default_armor);
}


ds_list_shuffle(deck);

//ds_list_add(deck,  card_struct(e_card.coco_add_temp_attack));
//ds_list_add(deck,  card_struct(e_card.coco_nut_kick));
//ds_list_add(deck,  card_struct(e_card.coco_discover_token));
//ds_list_add(deck, card_struct(e_card.coco_pebble_throw));
//ds_list_add(deck, card_struct(e_card.coco_boomerang));
//ds_list_add(deck,  card_struct(e_card.coco_lucky_punch));
//ds_list_add(deck,  card_struct(e_card.coco_token_bat));
//ds_list_add(deck,  card_struct(e_card.coco_token_bat));
//ds_list_add(deck,  card_struct(e_card.coco_token_salmon));
//ds_list_add(deck,  card_struct(e_card.coco_pebble_throw));
//ds_list_add(deck,  card_struct(e_card.coco_hot_sauce));
