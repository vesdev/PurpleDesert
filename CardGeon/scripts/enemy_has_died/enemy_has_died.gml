// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function enemy_has_died(active_enemies_enemy_index){

var struct = active_enemies[@ active_enemies_enemy_index];


array_delete(active_enemies,active_enemies_enemy_index,1 )
	var len = array_length(active_enemies);
//give other enemies a buff it the cornored rat buff is active on them

if len = 1 { 
	var last_enemy = active_enemies[@ 0];
	if last_enemy.buff.cornered_rat.amount > 0 {
		add_buff(last_enemy, all_buffs.attack,last_enemy.buff.cornered_rat.amount );
		enemy_armor_change(last_enemy,last_enemy.buff.cornered_rat.amount);
		last_enemy.buff.cornered_rat.amount = 0;
	}	
}
	
	

}
