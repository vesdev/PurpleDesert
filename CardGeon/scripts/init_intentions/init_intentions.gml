// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function init_intentions(){



function intention_struct(sprite, script_can_be_many_with_array , desc) constructor{ 
	self.sprite = sprite;
	self.desc = desc;
	remove_on_use = false;
}

enum e_intentions{ 
	attack			,	
	buff_armor		,
	armor			,
	buff		   ,
	debuff		   ,
	unkown		   ,
	unaware  	   ,
	attack_buff	   ,
	attack_debuff  ,
	attack_armor   ,
	buff_debuff    ,
	debuff_armor,
	add_card,
	size_
}

function  intent() : playable_entity() constructor{
	self.creator = noone;//typically the enemy
	self.target = noone;//typically the player
	script_ = noone;
	self.sprite = s_pixel;
	type = noone;
	remove_on_use = false;
	card_enum = noone;
	self.keywords = []; //keywords the card contains  for example exhaust, if none then use noone
	remove_after_combat = false;//for discovered cards
	remove_on_end_turn = false;
	self.token_struct = false;
	self.enum_ = noone;
	amount = noone;
}

function intent_attack(amount) : intent() constructor {
	script_ = enemy_damage;
	self.amount = amount;
	self.type = e_intentions.attack;
	self.sprite = s_ui_sword_1;		
	desc = function(amount){ return "INTENDS TO INFLICT [c_gum]"+string(get_enemy_intended_damage(amount))+"[] DAMAGE."}
	main_script = function() { script_(creator,target,amount) } 
}

function intent_armor(amount) : intent() constructor {
	script_ = enemy_armor_change;
	self.amount = amount;
	self.type = e_intentions.armor;
	self.sprite = s_ui_shield;	
	desc = function(amount){ return "INTENDS TO [c_yellow]ARMOR[] THEMSELVES."}
	main_script = function() { script_(creator,amount) } 
}



function intent_add_card(list_location, card_enum, amount) : intent() constructor {
	script_ = add_card_to;
	self.amount = amount;
	self.type = e_intentions.add_card;
	self.sprite = s_ui_bad_card;	
	self.list_location = list_location;
	self.card_enum = card_enum;
	desc = function(amount){ return "INTENDS TO ADD A [c_yellow]CRAPPY CARD[] TO YOUR [c_yellow]DECK[]."}
	main_script = function() { 
		
		
				repeat(amount){ 
				script_(list_location,card_enum , 0)
				}
		} 
}

function intent_buff(all_buff_enum_, buff_amount) : intent() constructor {
	self.sprite = s_ui_buff;
	self.all_buff_enum_ = all_buff_enum_;	
	self.buff_amount = buff_amount;
	self.type = e_intentions.buff;
	desc = function(){ return "INTENDS TO [s_status_buff][c_yellow]BUFF[]."}
	main_script = function() {	
				enemy_buff(creator, all_buff_enum_, buff_amount);
		} 
}


function intent_buff_armor(all_buff_enum_, buff_amount, armor_amount) : intent() constructor {
	self.sprite = s_ui_buff_and_armor;
	self.all_buff_enum_ = all_buff_enum_;	
	self.buff_amount = buff_amount;
	self.type = e_intentions.buff_armor;
	self.armor_amount = armor_amount;
	desc = function(){ return "INTENDS TO GAIN [s_status_armor][c_yellow]ARMOR[] AND APPLY A [s_status_buff][c_yellow]BUFF[]."}
	main_script = function() {	
				enemy_buff(creator, all_buff_enum_, buff_amount);
				enemy_armor_change(creator, armor_amount);
		} 
}


function intent_armor_attack(armor_amount, attack_amount) : intent() constructor {
	self.sprite = s_ui_shield_attack;
	self.type = e_intentions.attack_armor;
	self.armor_amount = armor_amount;
	self.amount = attack_amount;
	
	desc = function(amount){ return "INTENDS TO INFLICT [c_gum]"+string(get_enemy_intended_damage(amount))+"[] DAMAGE. AND GAIN [s_status_armor][c_yellow]ARMOR[]."}
	main_script = function() {	
			enemy_damage(creator,target,amount)
			enemy_armor_change(creator, armor_amount);
	} 
}


function intent_debuff(all_buff_enum_, buff_amount) : intent() constructor {
	self.sprite = s_ui_debuff;
	self.all_buff_enum_ = all_buff_enum_;	
	self.buff_amount = buff_amount;
	self.type = e_intentions.debuff;
	desc = function(amount){ return "INTENDS TO APPLY A [c_yellow]DEBUFF[]."}
	main_script = function() {	
		var s = add_buff(target, all_buff_enum_,buff_amount);
			s.delay_status_for_a_turn = true;
	
	}
}

function intent_attack_debuff(all_buff_enum_, buff_amount, amount) : intent() constructor {
	self.sprite = s_ui_attack_debuff;
	self.all_buff_enum_ = all_buff_enum_;	
	self.buff_amount = buff_amount;
	self.type = e_intentions.attack_debuff;
	self.amount = amount;
	desc = function(amount){ return "INTENDS TO INFLICT [c_gum]"+string(get_enemy_intended_damage(amount))+"[] DAMAGE. AND APPLY A [c_yellow]DEBUFF[]."}
	main_script = function() {	
			enemy_damage(creator,target,amount)
			var s = add_buff(target, all_buff_enum_,buff_amount);
				s.delay_status_for_a_turn = true;
	}
}





}