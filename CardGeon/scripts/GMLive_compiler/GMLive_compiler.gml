// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.

// converts AST to "instructions"!
if(live_enabled)
function gml_compile_error(l_text,l_pos){
	gml_compile_error_text=l_pos.h_to_string()+" "+l_text;
	gml_compile_error_pos=l_pos;
	return true;
}

if(live_enabled)
function gml_compile_node(l_q,l_r,l_out){
	var l_x,l_x2,l_w,l_i,l_k,l_l,l_n,l_p0,l_p1,l_p2,l_p3,l_pc,l_pb,l_s,l_v,l_d,l_o;
	var l__g=l_q;
	switch(l__g.__enumIndex__){
		case 0:if(l_out)ds_list_add(l_r,gml_action_undefined(l__g.h_d));break;
		case 1:
			var l_d1=l__g.h_d;
			var l_f=l__g.h_value;
			if(l_out)ds_list_add(l_r,gml_action_number(l_d1,l_f));
			break;
		case 2:if(l_out)ds_list_add(l_r,gml_action_cstring(l__g.h_d,l__g.h_value));break;
		case 8:ds_list_add(l_r,gml_action_self(l__g.h_d));break;
		case 9:ds_list_add(l_r,gml_action_other(l__g.h_d));break;
		case 10:ds_list_add(l_r,gml_action_number(l__g.h_d,-5));break;
		case 6:
			l_d=l__g.h_d;
			l_x=l__g.h_expr;
			var l__g1=l_x;
			switch(l__g1.__enumIndex__){
				case 35:ds_list_add(l_r,gml_action_ensure_array_local(l_d,gml_compile_curr_script.h_local_map.h_get(l__g1.h_id)));break;
				case 38:ds_list_add(l_r,gml_action_ensure_array_global(l_d,l__g1.h_id));break;
				case 41:
					l_x2=l__g1.h_x;
					if(gml_node_tools_is_simple(l_x2)){
						if(gml_compile_node(l_x2,l_r,true))return true;
						ds_list_add(l_r,gml_action_ensure_array_field(l_d,l__g1.h_fd));
					} else return gml_compile_error("Cannot ensure array type - expression may have side effects.",l__g1.h_d);
					break;
				default:return gml_compile_error("Cannot ensure array type for value. Use [@index] if it does not need allocation or create it explicitly.",l_d);
			}
			break;
		case 34:
			if(gml_compile_node(l__g.h_fd,l_r,true))return true;
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_in(l__g.h_d,l__g.h_not));
			break;
		case 11:ds_list_add(l_r,gml_action_const(l__g.h_d,l__g.h_ref.h_index));break;
		case 13:ds_list_add(l_r,gml_action_const(l__g.h_d,gml_const_val.h_get(l__g.h_id)));break;
		case 12:ds_list_add(l_r,gml_action_const(l__g.h_d,l__g.h_id));break;
		case 4:
			l_w=l__g.h_values;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_r,true))return true;
			}
			ds_list_add(l_r,gml_action_array_decl(l__g.h_d,l_n));
			break;
		case 5:
			var l_keys=l__g.h_keys;
			l_w=l__g.h_values;
			l_n=array_length(l_w);
			l_s="";
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_r,true))return true;
				l_s+=l_keys[l_i]+"\n";
			}
			ds_list_add(l_r,gml_action_object_decl(l__g.h_d,l_keys));
			break;
		case 91:
			l_x=l__g.h_value;
			if(l_x!=undefined){
				if(gml_compile_node(l_x,l_r,true))return true;
				ds_list_add(l_r,gml_action_local_set(l__g.h_d,gml_compile_curr_script.h_local_map.h_get(l__g.h_name)));
			}
			break;
		case 35:ds_list_add(l_r,gml_action_local(l__g.h_d,gml_compile_curr_script.h_local_map.h_get(l__g.h_id)));break;
		case 36:
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_local_set(l__g.h_d,gml_compile_curr_script.h_local_map.h_get(l__g.h_id)));
			break;
		case 37:
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_local_aop(l__g.h_d,l__g.h_op,gml_compile_curr_script.h_local_map.h_get(l__g.h_id)));
			break;
		case 38:ds_list_add(l_r,gml_action_global(l__g.h_d,l__g.h_id));break;
		case 39:
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_global_set(l__g.h_d,l__g.h_id));
			break;
		case 40:
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_global_aop(l__g.h_d,l__g.h_op,l__g.h_id));
			break;
		case 41:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			ds_list_add(l_r,gml_action_field(l__g.h_d,l__g.h_fd));
			break;
		case 42:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_field_set(l__g.h_d,l__g.h_fd));
			break;
		case 43:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_field_aop(l__g.h_d,l__g.h_op,l__g.h_fd));
			break;
		case 53:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i,l_r,true))return true;
			ds_list_add(l_r,gml_action_alarm(l__g.h_d));
			break;
		case 54:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_alarm_set(l__g.h_d));
			break;
		case 55:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_alarm_aop(l__g.h_d,l__g.h_op));
			break;
		case 66:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_id,l_r,true))return true;
			ds_list_add(l_r,gml_action_index(l__g.h_d));
			break;
		case 56:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_id,l_r,true))return true;
			ds_list_add(l_r,gml_action_index(l__g.h_d));
			break;
		case 67:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_id,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_index_set(l__g.h_d));
			break;
		case 57:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_id,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_index_set(l__g.h_d));
			break;
		case 58:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_id,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_index_aop(l__g.h_d,l__g.h_o));
			break;
		case 68:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_id,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_index_aop(l__g.h_d,l__g.h_o));
			break;
		case 71:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i1,l_r,true))return true;
			if(gml_compile_node(l__g.h_i2,l_r,true))return true;
			ds_list_add(l_r,gml_action_index2d(l__g.h_d));
			break;
		case 61:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i1,l_r,true))return true;
			if(gml_compile_node(l__g.h_i2,l_r,true))return true;
			ds_list_add(l_r,gml_action_index2d(l__g.h_d));
			break;
		case 72:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i1,l_r,true))return true;
			if(gml_compile_node(l__g.h_i2,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_index2d_set(l__g.h_d));
			break;
		case 62:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i1,l_r,true))return true;
			if(gml_compile_node(l__g.h_i2,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_index2d_set(l__g.h_d));
			break;
		case 73:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i1,l_r,true))return true;
			if(gml_compile_node(l__g.h_i2,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_index2d_aop(l__g.h_d,l__g.h_o));
			break;
		case 63:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			if(gml_compile_node(l__g.h_i1,l_r,true))return true;
			if(gml_compile_node(l__g.h_i2,l_r,true))return true;
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_index2d_aop(l__g.h_d,l__g.h_o));
			break;
		case 44:ds_list_add(l_r,gml_action_env(l__g.h_d,gml_var_refs.h_get(l__g.h_id)));break;
		case 45:
			var l_s1=l__g.h_id;
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_env_set(l__g.h_d,gml_var_refs.h_get(l_s1),gml_var_types.h_get(l_s1)));
			break;
		case 46:
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_env_aop(l__g.h_d,l__g.h_op,gml_var_refs.h_get(l__g.h_id)));
			break;
		case 50:
			if(gml_compile_node(l__g.h_k,l_r,true))return true;
			ds_list_add(l_r,gml_action_env1d(l__g.h_d,gml_var_refs.h_get(l__g.h_id)));
			break;
		case 51:
			var l_s1=l__g.h_id;
			if(gml_compile_node(l__g.h_k,l_r,true))return true;
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_env1d_set(l__g.h_d,gml_var_refs.h_get(l_s1),gml_var_types.h_get(l_s1)));
			break;
		case 52:
			if(gml_compile_node(l__g.h_k,l_r,true))return true;
			if(gml_compile_node(l__g.h_val,l_r,true))return true;
			ds_list_add(l_r,gml_action_env1d_aop(l__g.h_d,l__g.h_op,gml_var_refs.h_get(l__g.h_id)));
			break;
		case 76:
			l_s="ds_list_find_value";
			if(gml_func_script.h_exists(l_s)){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_id,l_r,true))return true;
				ds_list_add(l_r,gml_action_call_func(l__g.h_d,gml_func_script.h_get(l_s),2,gml_func_args.h_get(l_s),gml_func_rest.h_get(l_s),0,l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 77:
			l_s="ds_list_set";
			if(gml_func_script.h_exists(l_s)){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_id,l_r,true))return true;
				if(gml_compile_node(l__g.h_v,l_r,true))return true;
				ds_list_add(l_r,gml_action_call_func(l__g.h_d,gml_func_script.h_get(l_s),3,gml_func_args.h_get(l_s),gml_func_rest.h_get(l_s),0,l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 78:
			if(gml_func_script.h_exists("ds_list_find_value")&&gml_func_script.h_exists("ds_list_set")){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_id,l_r,true))return true;
				if(gml_compile_node(l__g.h_v,l_r,true))return true;
				ds_list_add(l_r,gml_action_ds_aop(l__g.h_d,l__g.h_o,3,gml_func_script.h_get("ds_list_find_value"),gml_func_script.h_get("ds_list_set"),l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 81:
			l_s="ds_map_find_value";
			if(gml_func_script.h_exists(l_s)){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_id,l_r,true))return true;
				ds_list_add(l_r,gml_action_call_func(l__g.h_d,gml_func_script.h_get(l_s),2,gml_func_args.h_get(l_s),gml_func_rest.h_get(l_s),0,l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 82:
			l_s="ds_map_set";
			if(gml_func_script.h_exists(l_s)){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_id,l_r,true))return true;
				if(gml_compile_node(l__g.h_v,l_r,true))return true;
				ds_list_add(l_r,gml_action_call_func(l__g.h_d,gml_func_script.h_get(l_s),3,gml_func_args.h_get(l_s),gml_func_rest.h_get(l_s),0,l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 83:
			if(gml_func_script.h_exists("ds_map_find_value")&&gml_func_script.h_exists("ds_map_set")){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_id,l_r,true))return true;
				if(gml_compile_node(l__g.h_v,l_r,true))return true;
				ds_list_add(l_r,gml_action_ds_aop(l__g.h_d,l__g.h_o,3,gml_func_script.h_get("ds_map_find_value"),gml_func_script.h_get("ds_map_set"),l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 86:
			l_s="ds_grid_get";
			if(gml_func_script.h_exists(l_s)){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_i1,l_r,true))return true;
				if(gml_compile_node(l__g.h_i2,l_r,true))return true;
				ds_list_add(l_r,gml_action_call_func(l__g.h_d,gml_func_script.h_get(l_s),3,gml_func_args.h_get(l_s),gml_func_rest.h_get(l_s),0,l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 87:
			l_s="ds_grid_set";
			if(gml_func_script.h_exists(l_s)){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_i1,l_r,true))return true;
				if(gml_compile_node(l__g.h_i2,l_r,true))return true;
				if(gml_compile_node(l__g.h_v,l_r,true))return true;
				ds_list_add(l_r,gml_action_call_func(l__g.h_d,gml_func_script.h_get(l_s),4,gml_func_args.h_get(l_s),gml_func_rest.h_get(l_s),0,l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 88:
			if(gml_func_script.h_exists("ds_grid_get")&&gml_func_script.h_exists("ds_grid_set")){
				if(gml_compile_node(l__g.h_lx,l_r,true))return true;
				if(gml_compile_node(l__g.h_i1,l_r,true))return true;
				if(gml_compile_node(l__g.h_i2,l_r,true))return true;
				if(gml_compile_node(l__g.h_v,l_r,true))return true;
				ds_list_add(l_r,gml_action_ds_aop(l__g.h_d,l__g.h_o,4,gml_func_script.h_get("ds_grid_get"),gml_func_script.h_get("ds_grid_set"),l_out));
			} else return gml_compile_error("Accessor not supported",l__g.h_d);
			break;
		case 14:ds_list_add(l_r,gml_action_arg_const(l__g.h_d,l__g.h_id));break;
		case 15:
			if(gml_compile_node(l__g.h_id,l_r,true))return true;
			ds_list_add(l_r,gml_action_arg_index(l__g.h_d));
			break;
		case 16:ds_list_add(l_r,gml_action_arg_count(l__g.h_d));break;
		case 31:
			l_d=l__g.h_d;
			l_o=l__g.h_o;
			l_x=l__g.h_a;
			l_x2=l__g.h_b;
			var l__g1=l_x;
			switch(l__g1.__enumIndex__){
				case 14:
					l_i=l__g1.h_id;
					if(gml_compile_node(l_x2,l_r,true))return true;
					if(l_o!=-1)ds_list_add(l_r,gml_action_arg_const_aop(l_d,l_o,l_i)); else ds_list_add(l_r,gml_action_arg_const_set(l_d,l_i));
					break;
				case 15:
					if(gml_compile_node(l__g1.h_id,l_r,true))return true;
					if(gml_compile_node(l_x2,l_r,true))return true;
					if(l_o!=-1)ds_list_add(l_r,gml_action_arg_index_aop(l_d,l_o)); else ds_list_add(l_r,gml_action_arg_index_set(l_d));
					break;
				default:return gml_compile_error("Cannot set "+gml_std_Type_enumConstructor(l_x),l_d);
			}
			break;
		case 30:
			l_d=l__g.h_d;
			l_o=l__g.h_o;
			l_x=l__g.h_a;
			l_x2=l__g.h_b;
			switch(l_o){
				case 18:
					if(gml_compile_node(l_x,l_r,true))return true;
					if(gml_compile_node(l_x2,l_r,true))return true;
					ds_list_add(l_r,gml_action_concat(l_d));
					break;
				case 64:
					if(gml_compile_node(l_x,l_r,true))return true;
					if(gml_compile_node(l_x2,l_r,true))return true;
					ds_list_add(l_r,gml_action_equ_op(l_d));
					break;
				case 65:
					if(gml_compile_node(l_x,l_r,true))return true;
					if(gml_compile_node(l_x2,l_r,true))return true;
					ds_list_add(l_r,gml_action_neq_op(l_d));
					break;
				case 80:
					if(gml_compile_node(l_x,l_r,true))return true;
					l_p0=ds_list_size(l_r);
					ds_list_add(l_r,gml_action_bool_and(l_d,0));
					if(gml_compile_node(l_x2,l_r,true))return true;
					ds_list_set(l_r,l_p0,gml_action_bool_and(l_d,ds_list_size(l_r)));
					break;
				case 96:
					if(gml_compile_node(l_x,l_r,true))return true;
					l_p0=ds_list_size(l_r);
					ds_list_add(l_r,gml_action_bool_or(l_d,0));
					if(gml_compile_node(l_x2,l_r,true))return true;
					ds_list_set(l_r,l_p0,gml_action_bool_or(l_d,ds_list_size(l_r)));
					break;
				default:
					if(gml_compile_node(l_x,l_r,true))return true;
					if(gml_compile_node(l_x2,l_r,true))return true;
					ds_list_add(l_r,gml_action_bin_op(l_d,l_o));
			}
			break;
		case 29:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			ds_list_add(l_r,gml_action_un_op(l__g.h_d,l__g.h_o));
			break;
		case 27:
			l_d=l__g.h_d;
			l_x=l__g.h_x;
			l_i=(l__g.h_inc?1:-1);
			var l__g1=l_x;
			switch(l__g1.__enumIndex__){
				case 35:
					l_k=gml_compile_curr_script.h_local_map.h_get(l__g1.h_id);
					ds_list_add(l_r,gml_action_local(l_d,l_k));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					if(l_out)ds_list_add(l_r,gml_action_dup(l_d));
					ds_list_add(l_r,gml_action_local_set(l_d,l_k));
					break;
				case 38:
					l_s=l__g1.h_id;
					ds_list_add(l_r,gml_action_global(l_d,l_s));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					if(l_out)ds_list_add(l_r,gml_action_dup(l_d));
					ds_list_add(l_r,gml_action_global_set(l_d,l_s));
					break;
				case 41:
					l_s=l__g1.h_fd;
					if(gml_compile_node(l__g1.h_x,l_r,true))return true;
					ds_list_add(l_r,gml_action_dup(l_d));
					ds_list_add(l_r,gml_action_field(l_d,l_s));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					if(l_out)ds_list_add(l_r,gml_action_dup_in(l_d,2));
					ds_list_add(l_r,gml_action_field_set(l_d,l_s));
					break;
				case 56:
					if(gml_compile_node(l__g1.h_x,l_r,true))return true;
					if(gml_compile_node(l__g1.h_id,l_r,true))return true;
					ds_list_add(l_r,gml_action_dup2x(l_d));
					ds_list_add(l_r,gml_action_index(l_d));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					if(l_out)ds_list_add(l_r,gml_action_dup_in(l_d,3));
					ds_list_add(l_r,gml_action_index_set(l_d));
					break;
				case 66:
					if(gml_compile_node(l__g1.h_x,l_r,true))return true;
					if(gml_compile_node(l__g1.h_id,l_r,true))return true;
					ds_list_add(l_r,gml_action_dup2x(l_d));
					ds_list_add(l_r,gml_action_index(l_d));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					if(l_out)ds_list_add(l_r,gml_action_dup_in(l_d,3));
					ds_list_add(l_r,gml_action_index_set(l_d));
					break;
				default:return gml_compile_error("Can't apply prefix to "+gml_std_Type_enumConstructor(l_x),l_d);
			}
			break;
		case 28:
			l_d=l__g.h_d;
			l_x=l__g.h_x;
			l_i=(l__g.h_inc?1:-1);
			var l__g1=l_x;
			switch(l__g1.__enumIndex__){
				case 35:
					l_k=gml_compile_curr_script.h_local_map.h_get(l__g1.h_id);
					ds_list_add(l_r,gml_action_local(l_d,l_k));
					if(l_out)ds_list_add(l_r,gml_action_dup(l_d));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					ds_list_add(l_r,gml_action_local_set(l_d,l_k));
					break;
				case 38:
					l_s=l__g1.h_id;
					ds_list_add(l_r,gml_action_global(l_d,l_s));
					if(l_out)ds_list_add(l_r,gml_action_dup(l_d));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					ds_list_add(l_r,gml_action_global_set(l_d,l_s));
					break;
				case 41:
					l_s=l__g1.h_fd;
					if(gml_compile_node(l__g1.h_x,l_r,true))return true;
					ds_list_add(l_r,gml_action_dup(l_d));
					ds_list_add(l_r,gml_action_field(l_d,l_s));
					if(l_out)ds_list_add(l_r,gml_action_dup_in(l_d,2));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					ds_list_add(l_r,gml_action_field_set(l_d,l_s));
					break;
				case 56:
					if(gml_compile_node(l__g1.h_x,l_r,true))return true;
					if(gml_compile_node(l__g1.h_id,l_r,true))return true;
					ds_list_add(l_r,gml_action_dup2x(l_d));
					ds_list_add(l_r,gml_action_index(l_d));
					if(l_out)ds_list_add(l_r,gml_action_dup_in(l_d,3));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					ds_list_add(l_r,gml_action_index_set(l_d));
					break;
				case 66:
					if(gml_compile_node(l__g1.h_x,l_r,true))return true;
					if(gml_compile_node(l__g1.h_id,l_r,true))return true;
					ds_list_add(l_r,gml_action_dup2x(l_d));
					ds_list_add(l_r,gml_action_index(l_d));
					if(l_out)ds_list_add(l_r,gml_action_dup_in(l_d,3));
					ds_list_add(l_r,gml_action_add_int(l_d,l_i));
					ds_list_add(l_r,gml_action_index_set(l_d));
					break;
				default:return gml_compile_error("Can't apply postfix to "+gml_std_Type_enumConstructor(l_x),l_d);
			}
			break;
		case 18:
			l_d=l__g.h_d;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_r,true))return true;
			}
			ds_list_add(l_r,gml_action_call_script(l_d,gml_compile_curr_program.h_script_map.h_get(l__g.h_name),l_n));
			if(l_out)ds_list_add(l_r,gml_action_result(l_d));
			break;
		case 20:
			l_d=l__g.h_d;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			if(gml_compile_node(l__g.h_index,l_r,true))return true;
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_r,true))return true;
			}
			ds_list_add(l_r,gml_action_call_script_id(l_d,l_n));
			if(l_out)ds_list_add(l_r,gml_action_result(l_d));
			break;
		case 24:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				gml_compile_node(l_w[l_i],l_r,true);
			}
			ds_list_add(l_r,gml_action_call_field(l_d,l__g.h_s,l_n));
			if(l_out)ds_list_add(l_r,gml_action_result(l_d));
			break;
		case 22:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_inst,l_r,true))return true;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				gml_compile_node(l_w[l_i],l_r,true);
			}
			ds_list_add(l_r,gml_action_call_field(l_d,l__g.h_prop,l_n));
			if(l_out)ds_list_add(l_r,gml_action_result(l_d));
			break;
		case 25:
			l_d=l__g.h_d;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			if(gml_compile_node(l__g.h_ctr,l_r,true))return true;
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_r,true))return true;
			}
			ds_list_add(l_r,gml_action_construct(l_d,l_n));
			if(l_out)ds_list_add(l_r,gml_action_result(l_d));
			break;
		case 21:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_index,l_r,true))return true;
			if(gml_compile_node(l__g.h_array,l_r,true))return true;
			ds_list_add(l_r,gml_action_call_script_with_array(l_d));
			if(l_out)ds_list_add(l_r,gml_action_result(l_d));
			break;
		case 19:
			l_d=l__g.h_d;
			return gml_compile_error("dot-calls are currently not supported.",l_d);
		case 23:
			var l__d=l__g.h_d;
			l_s=l__g.h_funcName;
			l_d=l__d;
			l_w=l__g.h_args;
			l_n=array_length(l_w);
			for(l_i=0;l_i<l_n;l_i++){
				if(gml_compile_node(l_w[l_i],l_r,true))return true;
			}
			if(gml_func_script.h_get(l_s)==-1)return gml_compile_error("Function `"+l_s+"` is pointing at an invalid script.",l__d);
			l_i=gml_inst_data.h_get(l_s);
			ds_list_add(l_r,gml_action_call_func(l_d,gml_func_script.h_get(l_s),l_n,gml_func_args.h_get(l_s),gml_func_rest.h_get(l_s),l_i,l_out&&l_i!=-5));
			if(l_out&&l_i==-5)ds_list_add(l_r,gml_action_result(l_d));
			break;
		case 26:ds_list_add(l_r,gml_action_func_literal(l__g.h_d,l__g.h_name));break;
		case 92:
			l_w=l__g.h_nodes;
			l_n=array_length(l_w);
			if(l_n>0){
				l_n--;
				for(l_i=0;l_i<l_n;l_i++){
					if(gml_compile_node(l_w[l_i],l_r,false))return true;
				}
				if(gml_compile_node(l_w[l_i],l_r,l_out))return true;
			}
			break;
		case 93:
			l_d=l__g.h_d;
			l_x=l__g.h_not;
			if(gml_compile_node(l__g.h_cond,l_r,true))return true;
			l_i=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_jump_unless(l_d,0));
			if(gml_compile_node(l__g.h_then,l_r,false))return true;
			if(l_x!=undefined){
				l_n=ds_list_size(l_r);
				ds_list_add(l_r,gml_action_jump(l_d,0));
				ds_list_set(l_r,l_i,gml_action_jump_unless(l_d,ds_list_size(l_r)));
				if(gml_compile_node(l_x,l_r,false))return true;
				ds_list_set(l_r,l_n,gml_action_jump(l_d,ds_list_size(l_r)));
			} else ds_list_set(l_r,l_i,gml_action_jump_unless(l_d,ds_list_size(l_r)));
			break;
		case 94:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_cond,l_r,true))return true;
			l_i=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_jump_unless(l_d,0));
			if(gml_compile_node(l__g.h_then,l_r,l_out))return true;
			l_n=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_jump(l_d,0));
			ds_list_set(l_r,l_i,gml_action_jump_unless(l_d,ds_list_size(l_r)));
			if(gml_compile_node(l__g.h_not,l_r,l_out))return true;
			ds_list_set(l_r,l_n,gml_action_jump(l_d,ds_list_size(l_r)));
			break;
		case 101:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_times,l_r,true))return true;
			l_n=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_repeat_pre(l_d,0));
			l_p0=ds_list_size(l_r);
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_r,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			l_p1=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_repeat_jump(l_d,l_p0));
			l_p2=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_discard(l_d));
			for(l_k=l_p0;l_k<l_p2;l_k++){
				var l__g1=ds_list_find_value(l_r,l_k);
				switch(l__g1.__enumIndex__){
					case 68:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p1));break;
					case 67:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
				}
			}
			ds_list_set(l_r,l_n,gml_action_repeat_pre(l_d,ds_list_size(l_r)));
			break;
		case 98:
			l_d=l__g.h_d;
			l_p0=ds_list_size(l_r);
			if(gml_compile_node(l__g.h_cond,l_r,true))return true;
			l_p1=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_jump_unless(l_d,0));
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_r,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			ds_list_add(l_r,gml_action_jump(l_d,l_p0));
			l_p2=ds_list_size(l_r);
			ds_list_set(l_r,l_p1,gml_action_jump_unless(l_d,l_p2));
			for(l_k=l_p1;l_k<l_p2;l_k++){
				var l__g1=ds_list_find_value(l_r,l_k);
				switch(l__g1.__enumIndex__){
					case 68:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p0));break;
					case 67:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
				}
			}
			break;
		case 100:
			l_d=l__g.h_d;
			l_p0=ds_list_size(l_r);
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_r,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			l_p1=ds_list_size(l_r);
			if(gml_compile_node(l__g.h_cond,l_r,true))return true;
			var l__g1=l_q;
			var l_tmp;
			if(l__g1.__enumIndex__==99)l_tmp=true; else l_tmp=false;
			if(l_tmp)ds_list_add(l_r,gml_action_jump_unless(l_d,l_p0)); else ds_list_add(l_r,gml_action_jump_if(l_d,l_p0));
			l_p2=ds_list_size(l_r);
			for(l_k=l_p0;l_k<l_p1;l_k++){
				var l__g1=ds_list_find_value(l_r,l_k);
				switch(l__g1.__enumIndex__){
					case 68:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p1));break;
					case 67:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
				}
			}
			break;
		case 99:
			l_d=l__g.h_d;
			l_p0=ds_list_size(l_r);
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_r,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			l_p1=ds_list_size(l_r);
			if(gml_compile_node(l__g.h_cond,l_r,true))return true;
			var l__g1=l_q;
			var l_tmp;
			if(l__g1.__enumIndex__==99)l_tmp=true; else l_tmp=false;
			if(l_tmp)ds_list_add(l_r,gml_action_jump_unless(l_d,l_p0)); else ds_list_add(l_r,gml_action_jump_if(l_d,l_p0));
			l_p2=ds_list_size(l_r);
			for(l_k=l_p0;l_k<l_p1;l_k++){
				var l__g1=ds_list_find_value(l_r,l_k);
				switch(l__g1.__enumIndex__){
					case 68:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p1));break;
					case 67:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
				}
			}
			break;
		case 102:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_pre,l_r,false))return true;
			l_p0=ds_list_size(l_r);
			if(gml_compile_node(l__g.h_cond,l_r,true))return true;
			l_p1=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_jump_unless(l_d,0));
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_loop,l_r,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			l_p2=ds_list_size(l_r);
			if(gml_compile_node(l__g.h_post,l_r,false))return true;
			ds_list_add(l_r,gml_action_jump(l_d,l_p0));
			l_p3=ds_list_size(l_r);
			ds_list_set(l_r,l_p1,gml_action_jump_unless(l_d,l_p3));
			for(l_k=l_p1;l_k<l_p2;l_k++){
				var l__g1=ds_list_find_value(l_r,l_k);
				switch(l__g1.__enumIndex__){
					case 68:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p2));break;
					case 67:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p3));break;
				}
			}
			break;
		case 95:
			var l__cc=l__g.h_list;
			l_d=l__g.h_d;
			var l_jt=ds_map_create();
			if(gml_compile_node(l__g.h_expr,l_r,true))return true;
			l_p0=ds_list_size(l_r);
			l_n=array_length(l__cc);
			for(l_i=0;l_i<l_n;l_i++){
				var l__cv=l__cc[l_i].values;
				l_l=array_length(l__cv);
				for(l_k=0;l_k<l_l;l_k++){
					if(!gml_node_tools_has_value(l__cv[l_k]))break;
				}
				if(l_k<l_l)break;
			}
			if(l_i<l_n){
				var l_caseLabels=[];
				l_pb=gml_compile_curr_break;
				gml_compile_curr_break=l_p0;
				for(l_i=0;l_i<l_n;l_i++){
					var l__cv=l__cc[l_i].values;
					l_l=array_length(l__cv);
					var l_cl1=[];
					for(l_k=0;l_k<l_l;l_k++){
						if(gml_compile_node(l__cv[l_k],l_r,true))return true;
						l_cl1[@l_k]=ds_list_size(l_r);
						ds_list_add(l_r,gml_action_switch_case(l_d,0));
					}
					l_caseLabels[@l_i]=l_cl1;
				}
				ds_list_add(l_r,gml_action_discard(l_d));
				var l_defCasePos=ds_list_size(l_r);
				ds_list_add(l_r,gml_action_jump(l_d,0));
				for(l_i=0;l_i<l_n;l_i++){
					var l_cl1=l_caseLabels[l_i];
					l_l=array_length(l_cl1);
					for(l_k=0;l_k<l_l;l_k++){
						ds_list_set(l_r,l_cl1[l_k],gml_action_switch_case(l_d,ds_list_size(l_r)));
					}
					if(gml_compile_node(l__cc[l_i].expr,l_r,false))return true;
				}
				ds_list_set(l_r,l_defCasePos,gml_action_jump(l_d,ds_list_size(l_r)));
				l_x=l__g.h_def;
				if(l_x!=undefined&&gml_compile_node(l_x,l_r,false))return true;
				gml_compile_curr_break=l_pb;
			} else {
				ds_list_add(l_r,gml_action_switch(l_d,l_jt,0));
				l_pb=gml_compile_curr_break;
				gml_compile_curr_break=l_p0;
				l_n=array_length(l__cc);
				for(l_i=0;l_i<l_n;l_i++){
					var l__cv=l__cc[l_i].values;
					l_l=array_length(l__cv);
					for(l_k=0;l_k<l_l;l_k++){
						var l_v=gml_node_tools_to_value(l__cv[l_k]);
						ds_map_set(l_jt,l_v[0],ds_list_size(l_r));
					}
					if(gml_compile_node(l__cc[l_i].expr,l_r,false))return true;
				}
				l_p1=ds_list_size(l_r);
				l_x=l__g.h_def;
				if(l_x!=undefined&&gml_compile_node(l_x,l_r,false))return true;
				gml_compile_curr_break=l_pb;
				ds_list_set(l_r,l_p0,gml_action_switch(l_d,l_jt,l_p1));
			}
			l_p2=ds_list_size(l_r);
			for(l_k=l_p0;l_k<l_p2;l_k++){
				var l__g1=ds_list_find_value(l_r,l_k);
				if(l__g1.__enumIndex__==67){
					var l_d1=l__g1.h_d;
					if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l_d1,l_p2));
				}
			}
			break;
		case 103:
			l_d=l__g.h_d;
			if(gml_compile_node(l__g.h_ctx,l_r,true))return true;
			ds_list_add(l_r,gml_action_with_pre(l_d));
			l_p0=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_with_next(l_d,0));
			l_pc=gml_compile_curr_continue;
			l_pb=gml_compile_curr_break;
			gml_compile_curr_continue=l_p0;
			gml_compile_curr_break=l_p0;
			if(gml_compile_node(l__g.h_node,l_r,false))return true;
			gml_compile_curr_continue=l_pc;
			gml_compile_curr_break=l_pb;
			ds_list_add(l_r,gml_action_jump(l_d,l_p0));
			l_p1=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_with_post(l_d));
			ds_list_set(l_r,l_p0,gml_action_with_next(l_d,l_p1));
			for(l_k=l_p0;l_k<l_p1;l_k++){
				var l__g1=ds_list_find_value(l_r,l_k);
				switch(l__g1.__enumIndex__){
					case 68:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p0));break;
					case 67:if(l__g1.h_lp==l_p0)ds_list_set(l_r,l_k,gml_action_jump(l__g1.h_d,l_p1));break;
				}
			}
			break;
		case 110:
			l_d=l__g.h_d;
			l_p0=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_try(l_d,0));
			if(gml_compile_node(l__g.h_node,l_r,false))return true;
			l_p1=ds_list_size(l_r);
			ds_list_add(l_r,gml_action_finally(l_d,0));
			ds_list_set(l_r,l_p0,gml_action_try(l_d,ds_list_size(l_r)));
			ds_list_add(l_r,gml_action_catch(l_d,gml_compile_curr_script.h_local_map.h_get(l__g.h_cap)));
			if(gml_compile_node(l__g.h_cat,l_r,false))return true;
			ds_list_set(l_r,l_p1,gml_action_finally(l_d,ds_list_size(l_r)));
			break;
		case 111:
			if(gml_compile_node(l__g.h_x,l_r,true))return true;
			ds_list_add(l_r,gml_action_throw(l__g.h_d));
			break;
		case 107:
			l_d=l__g.h_d;
			l_i=gml_compile_curr_break;
			if(l_i>=0)ds_list_add(l_r,gml_action_break(l_d,l_i)); else return gml_compile_error("Cannot `break` here",l_d);
			break;
		case 108:
			l_d=l__g.h_d;
			l_i=gml_compile_curr_continue;
			if(l_i>=0)ds_list_add(l_r,gml_action_continue(l_d,l_i)); else return gml_compile_error("Cannot `continue` here",l_d);
			break;
		case 105:
			if(gml_compile_node(l__g.h_v,l_r,true))return true;
			ds_list_add(l_r,gml_action_return(l__g.h_d));
			break;
		case 106:
			l_d=l__g.h_d;
			ds_list_add(l_r,gml_action_number(l_d,0));
			ds_list_add(l_r,gml_action_return(l_d));
			break;
		case 96:
			if(gml_compile_node(l__g.h_time,l_r,true))return true;
			ds_list_add(l_r,gml_action_wait(l__g.h_d));
			break;
		case 97:ds_list_add(l_r,gml_action_fork(l__g.h_d,l_out));break;
		default:return gml_compile_error("Cannot compile "+gml_std_Type_enumConstructor(l_q),gml_std_haxe_enum_tools_getParameter(l_q,0));
	}
	return false;
}

if(live_enabled)
function gml_compile_script(l_q){
	var l_r=ds_list_create();
	l_q.h_actions=l_r;
	gml_compile_curr_script=l_q;
	gml_compile_curr_break=-1;
	gml_compile_curr_continue=-1;
	var l_e=gml_compile_node(l_q.h_node,l_r,false);
	gml_compile_curr_script=undefined;
	return l_e;
}

if(live_enabled)
function gml_compile_program(l_p){
	gml_compile_curr_program=l_p;
	var l_arr=l_p.h_script_array;
	var l_i;
	var l_num=array_length(l_arr);
	for(l_i=0;l_i<l_num;l_i++){
		if(gml_compile_script(l_arr[l_i]))break;
	}
	gml_compile_curr_program=undefined;
	return l_i<l_num;
}
