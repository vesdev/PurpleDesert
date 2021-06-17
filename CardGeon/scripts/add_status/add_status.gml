function get_status_arg(creator,struct) { 


	//creator is the unit with the status effect
	//struct is the status struct list
	//struct.amount

	switch struct { 
			case creator.buff.fragile: return buff_multipliers.fragile*100; //translates 1.5 -> 150 
				break;
			case creator.buff.weak: return round((1-buff_multipliers.weak)*100); //translates 1.5 -> 150 
				break;
			case creator.buff.armor_reduction: return round((1-buff_multipliers.weak)*100); //translates 1.5 -> 150 
				break;
			case creator.buff.horror_timepiece: return creator.buff.horror_timepiece.amount;
			break;
			default:
				return  struct.amount; //returns the amount if not specified
				break;
		}
	
}


