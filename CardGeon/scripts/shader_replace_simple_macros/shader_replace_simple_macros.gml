#macro shader_set shader_replace_simple_set_hook
#macro shader_replace_simple_set_base shader_set
#macro shader_reset shader_replace_simple_reset_hook
#macro shader_replace_simple_reset_base shader_reset
function shader_replace_simple_macros(){
	if (false) {
		shader_replace_simple_set_base(0);
		shader_replace_simple_reset_base();
	}
}