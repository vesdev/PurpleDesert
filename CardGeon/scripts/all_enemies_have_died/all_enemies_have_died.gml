// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function all_enemies_have_died(){
	repeat(check_stuff(e_stuff.royal_jelly)){ 
		restore_health(player,7);	
	}
}