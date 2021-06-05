/// @desc apply vector force to a segment
/// @func seg_apply_force(seg, force, dir)
/// @arg seg	segment index
/// @arg force	force to apply
/// @arg dir	direction to apply force
function seg_apply_force() {

	var tony_sid = argument[0],
		tony_len = argument[1],
		tony_dir = argument[2];
	
	
	for (var j = 0; j < array_length(wire_array) ; j++){ 
	
	if (tony_sid < 0 || tony_sid > wire_array[@ j].seg_amount) show_error("segment index out of range: seg[" + string(tony_sid) + "], seg_amount = " + string(wire_array[@ j].seg_amount), true);
	
	var tony_ldx = lengthdir_x(tony_len, tony_dir),
		tony_ldy = lengthdir_y(tony_len, tony_dir);
	
	wire_array[@ j].seg_x[@ tony_sid] += tony_ldx;
	wire_array[@ j].seg_y[@ tony_sid] += tony_ldy;

	
	}
}
