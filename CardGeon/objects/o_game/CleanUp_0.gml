/// @description Insert description here
// You can write your code in this editor

surface_free(surf_bg);

ds_list_destroy(discard_to_deck_queue.list);
ds_list_destroy(deck);
ds_list_destroy(hand);
ds_list_destroy(discard);
ds_list_destroy(exhaust);
ds_list_destroy(all_added_cards);
ds_list_destroy(card_shop);



ds_list_destroy(end_turn_queue);
ds_list_destroy(active_cards_list);
ds_list_destroy(card_spoils);
ds_list_destroy(all_token_list);
ds_list_destroy(enemy_dungeon_list);
ds_list_destroy(stuff_list);
ds_list_destroy(stuff_list_golden);
ds_list_destroy(draw_tempoary_list_deck);
//surfaces 
surface_free(caret_surface);

part_system_destroy(global.pt_confetti)
part_system_destroy(global.sys_confetti)