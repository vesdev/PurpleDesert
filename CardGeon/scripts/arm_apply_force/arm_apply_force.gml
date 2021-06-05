/// @func arm_apply_force(force, dir);
/// @arg force	gravitational force
/// @arg dir	direction of gravity
function arm_apply_force() {


	for (var j = 0; j < array_length(wire_array) ; j++){ 
		for(var tony_i = wire_array[@ j].seg_amount; tony_i >= 0; tony_i--) {
			seg_apply_force(tony_i, argument[0], argument[1]);
		}
	}
}
