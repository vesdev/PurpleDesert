/// @func seg_exists(seg)
/// @arg seg	segment index to check
function seg_exists() {
	return ((argument[0] > 0) && (argument[0] < seg_amount));


}
