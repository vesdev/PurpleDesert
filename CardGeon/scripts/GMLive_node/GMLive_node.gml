// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.

// AST nodes
if(live_enabled)function mc_gml_node()constructor{
	static getIndex=method(undefined,gml_std_enum_getIndex);
	static toString=method(undefined,gml_std_enum_toString);
	static __enum__=mt_gml_node;
}

if(live_enabled)
global.__mp_gml_node_undefined=["h_d"];
if(live_enabled)
function mc_gml_node_undefined():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_undefined;
	static __enumIndex__=0;
}

if(live_enabled)
function gml_node_undefined(l_h_d){
	var this=new mc_gml_node_undefined();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_number=["h_d","h_value","h_src"];
if(live_enabled)
function mc_gml_node_number():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_number;
	static __enumIndex__=1;
}

if(live_enabled)
function gml_node_number(l_h_d,l_h_value,l_h_src){
	var this=new mc_gml_node_number();
	this.h_d=l_h_d;
	this.h_value=l_h_value;
	this.h_src=l_h_src;
	return this
}

if(live_enabled)
global.__mp_gml_node_cstring=["h_d","h_value"];
if(live_enabled)
function mc_gml_node_cstring():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_cstring;
	static __enumIndex__=2;
}

if(live_enabled)
function gml_node_cstring(l_h_d,l_h_value){
	var this=new mc_gml_node_cstring();
	this.h_d=l_h_d;
	this.h_value=l_h_value;
	return this
}

if(live_enabled)
global.__mp_gml_node_enum_ctr=["h_d","h_e","h_ctr"];
if(live_enabled)
function mc_gml_node_enum_ctr():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_enum_ctr;
	static __enumIndex__=3;
}

if(live_enabled)
function gml_node_enum_ctr(l_h_d,l_h_e,l_h_ctr){
	var this=new mc_gml_node_enum_ctr();
	this.h_d=l_h_d;
	this.h_e=l_h_e;
	this.h_ctr=l_h_ctr;
	return this
}

if(live_enabled)
global.__mp_gml_node_array_decl=["h_d","h_values"];
if(live_enabled)
function mc_gml_node_array_decl():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_array_decl;
	static __enumIndex__=4;
}

if(live_enabled)
function gml_node_array_decl(l_h_d,l_h_values){
	var this=new mc_gml_node_array_decl();
	this.h_d=l_h_d;
	this.h_values=l_h_values;
	return this
}

if(live_enabled)
global.__mp_gml_node_object_decl=["h_d","h_keys","h_values"];
if(live_enabled)
function mc_gml_node_object_decl():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_object_decl;
	static __enumIndex__=5;
}

if(live_enabled)
function gml_node_object_decl(l_h_d,l_h_keys,l_h_values){
	var this=new mc_gml_node_object_decl();
	this.h_d=l_h_d;
	this.h_keys=l_h_keys;
	this.h_values=l_h_values;
	return this
}

if(live_enabled)
global.__mp_gml_node_ensure_array=["h_d","h_expr"];
if(live_enabled)
function mc_gml_node_ensure_array():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ensure_array;
	static __enumIndex__=6;
}

if(live_enabled)
function gml_node_ensure_array(l_h_d,l_h_expr){
	var this=new mc_gml_node_ensure_array();
	this.h_d=l_h_d;
	this.h_expr=l_h_expr;
	return this
}

if(live_enabled)
global.__mp_gml_node_ident=["h_d","h_id"];
if(live_enabled)
function mc_gml_node_ident():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ident;
	static __enumIndex__=7;
}

if(live_enabled)
function gml_node_ident(l_h_d,l_h_id){
	var this=new mc_gml_node_ident();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_self=["h_d"];
if(live_enabled)
function mc_gml_node_self():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_self;
	static __enumIndex__=8;
}

if(live_enabled)
function gml_node_self(l_h_d){
	var this=new mc_gml_node_self();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_other=["h_d"];
if(live_enabled)
function mc_gml_node_other():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_other;
	static __enumIndex__=9;
}

if(live_enabled)
function gml_node_other(l_h_d){
	var this=new mc_gml_node_other();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_global_ref=["h_d"];
if(live_enabled)
function mc_gml_node_global_ref():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_global_ref;
	static __enumIndex__=10;
}

if(live_enabled)
function gml_node_global_ref(l_h_d){
	var this=new mc_gml_node_global_ref();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_script=["h_d","h_ref"];
if(live_enabled)
function mc_gml_node_script():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_script;
	static __enumIndex__=11;
}

if(live_enabled)
function gml_node_script(l_h_d,l_h_ref){
	var this=new mc_gml_node_script();
	this.h_d=l_h_d;
	this.h_ref=l_h_ref;
	return this
}

if(live_enabled)
global.__mp_gml_node_native_script=["h_d","h_name","h_id"];
if(live_enabled)
function mc_gml_node_native_script():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_native_script;
	static __enumIndex__=12;
}

if(live_enabled)
function gml_node_native_script(l_h_d,l_h_name,l_h_id){
	var this=new mc_gml_node_native_script();
	this.h_d=l_h_d;
	this.h_name=l_h_name;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_const=["h_d","h_id"];
if(live_enabled)
function mc_gml_node_const():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_const;
	static __enumIndex__=13;
}

if(live_enabled)
function gml_node_const(l_h_d,l_h_id){
	var this=new mc_gml_node_const();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_arg_const=["h_d","h_id"];
if(live_enabled)
function mc_gml_node_arg_const():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_arg_const;
	static __enumIndex__=14;
}

if(live_enabled)
function gml_node_arg_const(l_h_d,l_h_id){
	var this=new mc_gml_node_arg_const();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_arg_index=["h_d","h_id"];
if(live_enabled)
function mc_gml_node_arg_index():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_arg_index;
	static __enumIndex__=15;
}

if(live_enabled)
function gml_node_arg_index(l_h_d,l_h_id){
	var this=new mc_gml_node_arg_index();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_arg_count=["h_d"];
if(live_enabled)
function mc_gml_node_arg_count():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_arg_count;
	static __enumIndex__=16;
}

if(live_enabled)
function gml_node_arg_count(l_h_d){
	var this=new mc_gml_node_arg_count();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_call=["h_d","h_x","h_args"];
if(live_enabled)
function mc_gml_node_call():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_call;
	static __enumIndex__=17;
}

if(live_enabled)
function gml_node_call(l_h_d,l_h_x,l_h_args){
	var this=new mc_gml_node_call();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_args=l_h_args;
	return this
}

if(live_enabled)
global.__mp_gml_node_call_script=["h_d","h_name","h_args"];
if(live_enabled)
function mc_gml_node_call_script():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_call_script;
	static __enumIndex__=18;
}

if(live_enabled)
function gml_node_call_script(l_h_d,l_h_name,l_h_args){
	var this=new mc_gml_node_call_script();
	this.h_d=l_h_d;
	this.h_name=l_h_name;
	this.h_args=l_h_args;
	return this
}

if(live_enabled)
global.__mp_gml_node_call_script_at=["h_d","h_inst","h_script","h_args"];
if(live_enabled)
function mc_gml_node_call_script_at():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_call_script_at;
	static __enumIndex__=19;
}

if(live_enabled)
function gml_node_call_script_at(l_h_d,l_h_inst,l_h_script,l_h_args){
	var this=new mc_gml_node_call_script_at();
	this.h_d=l_h_d;
	this.h_inst=l_h_inst;
	this.h_script=l_h_script;
	this.h_args=l_h_args;
	return this
}

if(live_enabled)
global.__mp_gml_node_call_script_id=["h_d","h_index","h_args"];
if(live_enabled)
function mc_gml_node_call_script_id():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_call_script_id;
	static __enumIndex__=20;
}

if(live_enabled)
function gml_node_call_script_id(l_h_d,l_h_index,l_h_args){
	var this=new mc_gml_node_call_script_id();
	this.h_d=l_h_d;
	this.h_index=l_h_index;
	this.h_args=l_h_args;
	return this
}

if(live_enabled)
global.__mp_gml_node_call_script_with_array=["h_d","h_index","h_array"];
if(live_enabled)
function mc_gml_node_call_script_with_array():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_call_script_with_array;
	static __enumIndex__=21;
}

if(live_enabled)
function gml_node_call_script_with_array(l_h_d,l_h_index,l_h_array){
	var this=new mc_gml_node_call_script_with_array();
	this.h_d=l_h_d;
	this.h_index=l_h_index;
	this.h_array=l_h_array;
	return this
}

if(live_enabled)
global.__mp_gml_node_call_field=["h_d","h_inst","h_prop","h_args"];
if(live_enabled)
function mc_gml_node_call_field():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_call_field;
	static __enumIndex__=22;
}

if(live_enabled)
function gml_node_call_field(l_h_d,l_h_inst,l_h_prop,l_h_args){
	var this=new mc_gml_node_call_field();
	this.h_d=l_h_d;
	this.h_inst=l_h_inst;
	this.h_prop=l_h_prop;
	this.h_args=l_h_args;
	return this
}

if(live_enabled)
global.__mp_gml_node_call_func=["h_d","h_funcName","h_args"];
if(live_enabled)
function mc_gml_node_call_func():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_call_func;
	static __enumIndex__=23;
}

if(live_enabled)
function gml_node_call_func(l_h_d,l_h_funcName,l_h_args){
	var this=new mc_gml_node_call_func();
	this.h_d=l_h_d;
	this.h_funcName=l_h_funcName;
	this.h_args=l_h_args;
	return this
}

if(live_enabled)
global.__mp_gml_node_call_func_at=["h_d","h_x","h_s","h_args"];
if(live_enabled)
function mc_gml_node_call_func_at():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_call_func_at;
	static __enumIndex__=24;
}

if(live_enabled)
function gml_node_call_func_at(l_h_d,l_h_x,l_h_s,l_h_args){
	var this=new mc_gml_node_call_func_at();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_s=l_h_s;
	this.h_args=l_h_args;
	return this
}

if(live_enabled)
global.__mp_gml_node_construct=["h_d","h_ctr","h_args"];
if(live_enabled)
function mc_gml_node_construct():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_construct;
	static __enumIndex__=25;
}

if(live_enabled)
function gml_node_construct(l_h_d,l_h_ctr,l_h_args){
	var this=new mc_gml_node_construct();
	this.h_d=l_h_d;
	this.h_ctr=l_h_ctr;
	this.h_args=l_h_args;
	return this
}

if(live_enabled)
global.__mp_gml_node_func_literal=["h_d","h_name"];
if(live_enabled)
function mc_gml_node_func_literal():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_func_literal;
	static __enumIndex__=26;
}

if(live_enabled)
function gml_node_func_literal(l_h_d,l_h_name){
	var this=new mc_gml_node_func_literal();
	this.h_d=l_h_d;
	this.h_name=l_h_name;
	return this
}

if(live_enabled)
global.__mp_gml_node_prefix=["h_d","h_x","h_inc"];
if(live_enabled)
function mc_gml_node_prefix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_prefix;
	static __enumIndex__=27;
}

if(live_enabled)
function gml_node_prefix(l_h_d,l_h_x,l_h_inc){
	var this=new mc_gml_node_prefix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_postfix=["h_d","h_x","h_inc"];
if(live_enabled)
function mc_gml_node_postfix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_postfix;
	static __enumIndex__=28;
}

if(live_enabled)
function gml_node_postfix(l_h_d,l_h_x,l_h_inc){
	var this=new mc_gml_node_postfix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_un_op=["h_d","h_x","h_o"];
if(live_enabled)
function mc_gml_node_un_op():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_un_op;
	static __enumIndex__=29;
}

if(live_enabled)
function gml_node_un_op(l_h_d,l_h_x,l_h_o){
	var this=new mc_gml_node_un_op();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_o=l_h_o;
	return this
}

if(live_enabled)
global.__mp_gml_node_bin_op=["h_d","h_o","h_a","h_b"];
if(live_enabled)
function mc_gml_node_bin_op():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_bin_op;
	static __enumIndex__=30;
}

if(live_enabled)
function gml_node_bin_op(l_h_d,l_h_o,l_h_a,l_h_b){
	var this=new mc_gml_node_bin_op();
	this.h_d=l_h_d;
	this.h_o=l_h_o;
	this.h_a=l_h_a;
	this.h_b=l_h_b;
	return this
}

if(live_enabled)
global.__mp_gml_node_set_op=["h_d","h_o","h_a","h_b"];
if(live_enabled)
function mc_gml_node_set_op():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_set_op;
	static __enumIndex__=31;
}

if(live_enabled)
function gml_node_set_op(l_h_d,l_h_o,l_h_a,l_h_b){
	var this=new mc_gml_node_set_op();
	this.h_d=l_h_d;
	this.h_o=l_h_o;
	this.h_a=l_h_a;
	this.h_b=l_h_b;
	return this
}

if(live_enabled)
global.__mp_gml_node_to_bool=["h_d","h_v"];
if(live_enabled)
function mc_gml_node_to_bool():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_to_bool;
	static __enumIndex__=32;
}

if(live_enabled)
function gml_node_to_bool(l_h_d,l_h_v){
	var this=new mc_gml_node_to_bool();
	this.h_d=l_h_d;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_from_bool=["h_d","h_v"];
if(live_enabled)
function mc_gml_node_from_bool():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_from_bool;
	static __enumIndex__=33;
}

if(live_enabled)
function gml_node_from_bool(l_h_d,l_h_v){
	var this=new mc_gml_node_from_bool();
	this.h_d=l_h_d;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_in=["h_d","h_fd","h_val","h_not"];
if(live_enabled)
function mc_gml_node_in():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_in;
	static __enumIndex__=34;
}

if(live_enabled)
function gml_node_in(l_h_d,l_h_fd,l_h_val,l_h_not){
	var this=new mc_gml_node_in();
	this.h_d=l_h_d;
	this.h_fd=l_h_fd;
	this.h_val=l_h_val;
	this.h_not=l_h_not;
	return this
}

if(live_enabled)
global.__mp_gml_node_local=["h_d","h_id"];
if(live_enabled)
function mc_gml_node_local():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_local;
	static __enumIndex__=35;
}

if(live_enabled)
function gml_node_local(l_h_d,l_h_id){
	var this=new mc_gml_node_local();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_local_set=["h_d","h_id","h_val"];
if(live_enabled)
function mc_gml_node_local_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_local_set;
	static __enumIndex__=36;
}

if(live_enabled)
function gml_node_local_set(l_h_d,l_h_id,l_h_val){
	var this=new mc_gml_node_local_set();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_local_aop=["h_d","h_id","h_op","h_val"];
if(live_enabled)
function mc_gml_node_local_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_local_aop;
	static __enumIndex__=37;
}

if(live_enabled)
function gml_node_local_aop(l_h_d,l_h_id,l_h_op,l_h_val){
	var this=new mc_gml_node_local_aop();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_op=l_h_op;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_global=["h_d","h_id"];
if(live_enabled)
function mc_gml_node_global():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_global;
	static __enumIndex__=38;
}

if(live_enabled)
function gml_node_global(l_h_d,l_h_id){
	var this=new mc_gml_node_global();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_global_set=["h_d","h_id","h_val"];
if(live_enabled)
function mc_gml_node_global_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_global_set;
	static __enumIndex__=39;
}

if(live_enabled)
function gml_node_global_set(l_h_d,l_h_id,l_h_val){
	var this=new mc_gml_node_global_set();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_global_aop=["h_d","h_id","h_op","h_val"];
if(live_enabled)
function mc_gml_node_global_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_global_aop;
	static __enumIndex__=40;
}

if(live_enabled)
function gml_node_global_aop(l_h_d,l_h_id,l_h_op,l_h_val){
	var this=new mc_gml_node_global_aop();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_op=l_h_op;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_field=["h_d","h_x","h_fd"];
if(live_enabled)
function mc_gml_node_field():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_field;
	static __enumIndex__=41;
}

if(live_enabled)
function gml_node_field(l_h_d,l_h_x,l_h_fd){
	var this=new mc_gml_node_field();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_fd=l_h_fd;
	return this
}

if(live_enabled)
global.__mp_gml_node_field_set=["h_d","h_x","h_fd","h_val"];
if(live_enabled)
function mc_gml_node_field_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_field_set;
	static __enumIndex__=42;
}

if(live_enabled)
function gml_node_field_set(l_h_d,l_h_x,l_h_fd,l_h_val){
	var this=new mc_gml_node_field_set();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_fd=l_h_fd;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_field_aop=["h_d","h_x","h_fd","h_op","h_val"];
if(live_enabled)
function mc_gml_node_field_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_field_aop;
	static __enumIndex__=43;
}

if(live_enabled)
function gml_node_field_aop(l_h_d,l_h_x,l_h_fd,l_h_op,l_h_val){
	var this=new mc_gml_node_field_aop();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_fd=l_h_fd;
	this.h_op=l_h_op;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_env=["h_d","h_id"];
if(live_enabled)
function mc_gml_node_env():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env;
	static __enumIndex__=44;
}

if(live_enabled)
function gml_node_env(l_h_d,l_h_id){
	var this=new mc_gml_node_env();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_env_set=["h_d","h_id","h_val"];
if(live_enabled)
function mc_gml_node_env_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env_set;
	static __enumIndex__=45;
}

if(live_enabled)
function gml_node_env_set(l_h_d,l_h_id,l_h_val){
	var this=new mc_gml_node_env_set();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_env_aop=["h_d","h_id","h_op","h_val"];
if(live_enabled)
function mc_gml_node_env_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env_aop;
	static __enumIndex__=46;
}

if(live_enabled)
function gml_node_env_aop(l_h_d,l_h_id,l_h_op,l_h_val){
	var this=new mc_gml_node_env_aop();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_op=l_h_op;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_env_fd=["h_d","h_x","h_fd"];
if(live_enabled)
function mc_gml_node_env_fd():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env_fd;
	static __enumIndex__=47;
}

if(live_enabled)
function gml_node_env_fd(l_h_d,l_h_x,l_h_fd){
	var this=new mc_gml_node_env_fd();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_fd=l_h_fd;
	return this
}

if(live_enabled)
global.__mp_gml_node_env_fd_set=["h_d","h_x","h_fd","h_v"];
if(live_enabled)
function mc_gml_node_env_fd_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env_fd_set;
	static __enumIndex__=48;
}

if(live_enabled)
function gml_node_env_fd_set(l_h_d,l_h_x,l_h_fd,l_h_v){
	var this=new mc_gml_node_env_fd_set();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_fd=l_h_fd;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_env_fd_aop=["h_d","h_x","h_fd","h_op","h_v"];
if(live_enabled)
function mc_gml_node_env_fd_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env_fd_aop;
	static __enumIndex__=49;
}

if(live_enabled)
function gml_node_env_fd_aop(l_h_d,l_h_x,l_h_fd,l_h_op,l_h_v){
	var this=new mc_gml_node_env_fd_aop();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_fd=l_h_fd;
	this.h_op=l_h_op;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_env1d=["h_d","h_id","h_k"];
if(live_enabled)
function mc_gml_node_env1d():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env1d;
	static __enumIndex__=50;
}

if(live_enabled)
function gml_node_env1d(l_h_d,l_h_id,l_h_k){
	var this=new mc_gml_node_env1d();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_k=l_h_k;
	return this
}

if(live_enabled)
global.__mp_gml_node_env1d_set=["h_d","h_id","h_k","h_val"];
if(live_enabled)
function mc_gml_node_env1d_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env1d_set;
	static __enumIndex__=51;
}

if(live_enabled)
function gml_node_env1d_set(l_h_d,l_h_id,l_h_k,l_h_val){
	var this=new mc_gml_node_env1d_set();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_k=l_h_k;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_env1d_aop=["h_d","h_id","h_k","h_op","h_val"];
if(live_enabled)
function mc_gml_node_env1d_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_env1d_aop;
	static __enumIndex__=52;
}

if(live_enabled)
function gml_node_env1d_aop(l_h_d,l_h_id,l_h_k,l_h_op,l_h_val){
	var this=new mc_gml_node_env1d_aop();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	this.h_k=l_h_k;
	this.h_op=l_h_op;
	this.h_val=l_h_val;
	return this
}

if(live_enabled)
global.__mp_gml_node_alarm=["h_d","h_x","h_i"];
if(live_enabled)
function mc_gml_node_alarm():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_alarm;
	static __enumIndex__=53;
}

if(live_enabled)
function gml_node_alarm(l_h_d,l_h_x,l_h_i){
	var this=new mc_gml_node_alarm();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	return this
}

if(live_enabled)
global.__mp_gml_node_alarm_set=["h_d","h_x","h_i","h_v"];
if(live_enabled)
function mc_gml_node_alarm_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_alarm_set;
	static __enumIndex__=54;
}

if(live_enabled)
function gml_node_alarm_set(l_h_d,l_h_x,l_h_i,l_h_v){
	var this=new mc_gml_node_alarm_set();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_alarm_aop=["h_d","h_x","h_i","h_op","h_v"];
if(live_enabled)
function mc_gml_node_alarm_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_alarm_aop;
	static __enumIndex__=55;
}

if(live_enabled)
function gml_node_alarm_aop(l_h_d,l_h_x,l_h_i,l_h_op,l_h_v){
	var this=new mc_gml_node_alarm_aop();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_op=l_h_op;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_index=["h_d","h_x","h_id"];
if(live_enabled)
function mc_gml_node_index():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index;
	static __enumIndex__=56;
}

if(live_enabled)
function gml_node_index(l_h_d,l_h_x,l_h_id){
	var this=new mc_gml_node_index();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_index_set=["h_d","h_x","h_id","h_v"];
if(live_enabled)
function mc_gml_node_index_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index_set;
	static __enumIndex__=57;
}

if(live_enabled)
function gml_node_index_set(l_h_d,l_h_x,l_h_id,l_h_v){
	var this=new mc_gml_node_index_set();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_id=l_h_id;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_index_aop=["h_d","h_x","h_id","h_o","h_v"];
if(live_enabled)
function mc_gml_node_index_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index_aop;
	static __enumIndex__=58;
}

if(live_enabled)
function gml_node_index_aop(l_h_d,l_h_x,l_h_id,l_h_o,l_h_v){
	var this=new mc_gml_node_index_aop();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_id=l_h_id;
	this.h_o=l_h_o;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_index_prefix=["h_d","h_x","h_i","h_inc"];
if(live_enabled)
function mc_gml_node_index_prefix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index_prefix;
	static __enumIndex__=59;
}

if(live_enabled)
function gml_node_index_prefix(l_h_d,l_h_x,l_h_i,l_h_inc){
	var this=new mc_gml_node_index_prefix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_index_postfix=["h_d","h_x","h_i","h_inc"];
if(live_enabled)
function mc_gml_node_index_postfix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index_postfix;
	static __enumIndex__=60;
}

if(live_enabled)
function gml_node_index_postfix(l_h_d,l_h_x,l_h_i,l_h_inc){
	var this=new mc_gml_node_index_postfix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_index2d=["h_d","h_x","h_i1","h_i2"];
if(live_enabled)
function mc_gml_node_index2d():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index2d;
	static __enumIndex__=61;
}

if(live_enabled)
function gml_node_index2d(l_h_d,l_h_x,l_h_i1,l_h_i2){
	var this=new mc_gml_node_index2d();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	return this
}

if(live_enabled)
global.__mp_gml_node_index2d_set=["h_d","h_x","h_i1","h_i2","h_v"];
if(live_enabled)
function mc_gml_node_index2d_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index2d_set;
	static __enumIndex__=62;
}

if(live_enabled)
function gml_node_index2d_set(l_h_d,l_h_x,l_h_i1,l_h_i2,l_h_v){
	var this=new mc_gml_node_index2d_set();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_index2d_aop=["h_d","h_x","h_i1","h_i2","h_o","h_v"];
if(live_enabled)
function mc_gml_node_index2d_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index2d_aop;
	static __enumIndex__=63;
}

if(live_enabled)
function gml_node_index2d_aop(l_h_d,l_h_x,l_h_i1,l_h_i2,l_h_o,l_h_v){
	var this=new mc_gml_node_index2d_aop();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	this.h_o=l_h_o;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_index2d_prefix=["h_d","h_x","h_i","h_k","h_inc"];
if(live_enabled)
function mc_gml_node_index2d_prefix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index2d_prefix;
	static __enumIndex__=64;
}

if(live_enabled)
function gml_node_index2d_prefix(l_h_d,l_h_x,l_h_i,l_h_k,l_h_inc){
	var this=new mc_gml_node_index2d_prefix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_k=l_h_k;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_index2d_postfix=["h_d","h_x","h_i","h_k","h_inc"];
if(live_enabled)
function mc_gml_node_index2d_postfix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_index2d_postfix;
	static __enumIndex__=65;
}

if(live_enabled)
function gml_node_index2d_postfix(l_h_d,l_h_x,l_h_i,l_h_k,l_h_inc){
	var this=new mc_gml_node_index2d_postfix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_k=l_h_k;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id=["h_d","h_x","h_id"];
if(live_enabled)
function mc_gml_node_raw_id():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id;
	static __enumIndex__=66;
}

if(live_enabled)
function gml_node_raw_id(l_h_d,l_h_x,l_h_id){
	var this=new mc_gml_node_raw_id();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id_set=["h_d","h_x","h_id","h_v"];
if(live_enabled)
function mc_gml_node_raw_id_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id_set;
	static __enumIndex__=67;
}

if(live_enabled)
function gml_node_raw_id_set(l_h_d,l_h_x,l_h_id,l_h_v){
	var this=new mc_gml_node_raw_id_set();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_id=l_h_id;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id_aop=["h_d","h_x","h_id","h_o","h_v"];
if(live_enabled)
function mc_gml_node_raw_id_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id_aop;
	static __enumIndex__=68;
}

if(live_enabled)
function gml_node_raw_id_aop(l_h_d,l_h_x,l_h_id,l_h_o,l_h_v){
	var this=new mc_gml_node_raw_id_aop();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_id=l_h_id;
	this.h_o=l_h_o;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id_prefix=["h_d","h_x","h_i","h_inc"];
if(live_enabled)
function mc_gml_node_raw_id_prefix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id_prefix;
	static __enumIndex__=69;
}

if(live_enabled)
function gml_node_raw_id_prefix(l_h_d,l_h_x,l_h_i,l_h_inc){
	var this=new mc_gml_node_raw_id_prefix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id_postfix=["h_d","h_x","h_i","h_inc"];
if(live_enabled)
function mc_gml_node_raw_id_postfix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id_postfix;
	static __enumIndex__=70;
}

if(live_enabled)
function gml_node_raw_id_postfix(l_h_d,l_h_x,l_h_i,l_h_inc){
	var this=new mc_gml_node_raw_id_postfix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id2d=["h_d","h_x","h_i1","h_i2"];
if(live_enabled)
function mc_gml_node_raw_id2d():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id2d;
	static __enumIndex__=71;
}

if(live_enabled)
function gml_node_raw_id2d(l_h_d,l_h_x,l_h_i1,l_h_i2){
	var this=new mc_gml_node_raw_id2d();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id2d_set=["h_d","h_x","h_i1","h_i2","h_v"];
if(live_enabled)
function mc_gml_node_raw_id2d_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id2d_set;
	static __enumIndex__=72;
}

if(live_enabled)
function gml_node_raw_id2d_set(l_h_d,l_h_x,l_h_i1,l_h_i2,l_h_v){
	var this=new mc_gml_node_raw_id2d_set();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id2d_aop=["h_d","h_x","h_i1","h_i2","h_o","h_v"];
if(live_enabled)
function mc_gml_node_raw_id2d_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id2d_aop;
	static __enumIndex__=73;
}

if(live_enabled)
function gml_node_raw_id2d_aop(l_h_d,l_h_x,l_h_i1,l_h_i2,l_h_o,l_h_v){
	var this=new mc_gml_node_raw_id2d_aop();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	this.h_o=l_h_o;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id2d_prefix=["h_d","h_x","h_i","h_k","h_inc"];
if(live_enabled)
function mc_gml_node_raw_id2d_prefix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id2d_prefix;
	static __enumIndex__=74;
}

if(live_enabled)
function gml_node_raw_id2d_prefix(l_h_d,l_h_x,l_h_i,l_h_k,l_h_inc){
	var this=new mc_gml_node_raw_id2d_prefix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_k=l_h_k;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_raw_id2d_postfix=["h_d","h_x","h_i","h_k","h_inc"];
if(live_enabled)
function mc_gml_node_raw_id2d_postfix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_raw_id2d_postfix;
	static __enumIndex__=75;
}

if(live_enabled)
function gml_node_raw_id2d_postfix(l_h_d,l_h_x,l_h_i,l_h_k,l_h_inc){
	var this=new mc_gml_node_raw_id2d_postfix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_k=l_h_k;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_list=["h_d","h_lx","h_id"];
if(live_enabled)
function mc_gml_node_ds_list():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_list;
	static __enumIndex__=76;
}

if(live_enabled)
function gml_node_ds_list(l_h_d,l_h_lx,l_h_id){
	var this=new mc_gml_node_ds_list();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_list_set=["h_d","h_lx","h_id","h_v"];
if(live_enabled)
function mc_gml_node_ds_list_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_list_set;
	static __enumIndex__=77;
}

if(live_enabled)
function gml_node_ds_list_set(l_h_d,l_h_lx,l_h_id,l_h_v){
	var this=new mc_gml_node_ds_list_set();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_id=l_h_id;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_list_aop=["h_d","h_lx","h_id","h_o","h_v"];
if(live_enabled)
function mc_gml_node_ds_list_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_list_aop;
	static __enumIndex__=78;
}

if(live_enabled)
function gml_node_ds_list_aop(l_h_d,l_h_lx,l_h_id,l_h_o,l_h_v){
	var this=new mc_gml_node_ds_list_aop();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_id=l_h_id;
	this.h_o=l_h_o;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_list_prefix=["h_d","h_x","h_i","h_inc"];
if(live_enabled)
function mc_gml_node_ds_list_prefix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_list_prefix;
	static __enumIndex__=79;
}

if(live_enabled)
function gml_node_ds_list_prefix(l_h_d,l_h_x,l_h_i,l_h_inc){
	var this=new mc_gml_node_ds_list_prefix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_list_postfix=["h_d","h_x","h_i","h_inc"];
if(live_enabled)
function mc_gml_node_ds_list_postfix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_list_postfix;
	static __enumIndex__=80;
}

if(live_enabled)
function gml_node_ds_list_postfix(l_h_d,l_h_x,l_h_i,l_h_inc){
	var this=new mc_gml_node_ds_list_postfix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_map=["h_d","h_lx","h_id"];
if(live_enabled)
function mc_gml_node_ds_map():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_map;
	static __enumIndex__=81;
}

if(live_enabled)
function gml_node_ds_map(l_h_d,l_h_lx,l_h_id){
	var this=new mc_gml_node_ds_map();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_map_set=["h_d","h_lx","h_id","h_v"];
if(live_enabled)
function mc_gml_node_ds_map_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_map_set;
	static __enumIndex__=82;
}

if(live_enabled)
function gml_node_ds_map_set(l_h_d,l_h_lx,l_h_id,l_h_v){
	var this=new mc_gml_node_ds_map_set();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_id=l_h_id;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_map_aop=["h_d","h_lx","h_id","h_o","h_v"];
if(live_enabled)
function mc_gml_node_ds_map_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_map_aop;
	static __enumIndex__=83;
}

if(live_enabled)
function gml_node_ds_map_aop(l_h_d,l_h_lx,l_h_id,l_h_o,l_h_v){
	var this=new mc_gml_node_ds_map_aop();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_id=l_h_id;
	this.h_o=l_h_o;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_map_prefix=["h_d","h_x","h_i","h_inc"];
if(live_enabled)
function mc_gml_node_ds_map_prefix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_map_prefix;
	static __enumIndex__=84;
}

if(live_enabled)
function gml_node_ds_map_prefix(l_h_d,l_h_x,l_h_i,l_h_inc){
	var this=new mc_gml_node_ds_map_prefix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_map_postfix=["h_d","h_x","h_i","h_inc"];
if(live_enabled)
function mc_gml_node_ds_map_postfix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_map_postfix;
	static __enumIndex__=85;
}

if(live_enabled)
function gml_node_ds_map_postfix(l_h_d,l_h_x,l_h_i,l_h_inc){
	var this=new mc_gml_node_ds_map_postfix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_grid=["h_d","h_lx","h_i1","h_i2"];
if(live_enabled)
function mc_gml_node_ds_grid():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_grid;
	static __enumIndex__=86;
}

if(live_enabled)
function gml_node_ds_grid(l_h_d,l_h_lx,l_h_i1,l_h_i2){
	var this=new mc_gml_node_ds_grid();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_grid_set=["h_d","h_lx","h_i1","h_i2","h_v"];
if(live_enabled)
function mc_gml_node_ds_grid_set():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_grid_set;
	static __enumIndex__=87;
}

if(live_enabled)
function gml_node_ds_grid_set(l_h_d,l_h_lx,l_h_i1,l_h_i2,l_h_v){
	var this=new mc_gml_node_ds_grid_set();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_grid_aop=["h_d","h_lx","h_i1","h_i2","h_o","h_v"];
if(live_enabled)
function mc_gml_node_ds_grid_aop():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_grid_aop;
	static __enumIndex__=88;
}

if(live_enabled)
function gml_node_ds_grid_aop(l_h_d,l_h_lx,l_h_i1,l_h_i2,l_h_o,l_h_v){
	var this=new mc_gml_node_ds_grid_aop();
	this.h_d=l_h_d;
	this.h_lx=l_h_lx;
	this.h_i1=l_h_i1;
	this.h_i2=l_h_i2;
	this.h_o=l_h_o;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_grid_prefix=["h_d","h_x","h_i","h_k","h_inc"];
if(live_enabled)
function mc_gml_node_ds_grid_prefix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_grid_prefix;
	static __enumIndex__=89;
}

if(live_enabled)
function gml_node_ds_grid_prefix(l_h_d,l_h_x,l_h_i,l_h_k,l_h_inc){
	var this=new mc_gml_node_ds_grid_prefix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_k=l_h_k;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_ds_grid_postfix=["h_d","h_x","h_i","h_k","h_inc"];
if(live_enabled)
function mc_gml_node_ds_grid_postfix():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ds_grid_postfix;
	static __enumIndex__=90;
}

if(live_enabled)
function gml_node_ds_grid_postfix(l_h_d,l_h_x,l_h_i,l_h_k,l_h_inc){
	var this=new mc_gml_node_ds_grid_postfix();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_i=l_h_i;
	this.h_k=l_h_k;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_node_var_decl=["h_d","h_name","h_value"];
if(live_enabled)
function mc_gml_node_var_decl():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_var_decl;
	static __enumIndex__=91;
}

if(live_enabled)
function gml_node_var_decl(l_h_d,l_h_name,l_h_value){
	var this=new mc_gml_node_var_decl();
	this.h_d=l_h_d;
	this.h_name=l_h_name;
	this.h_value=l_h_value;
	if(false)throw argument[2];
	return this
}

if(live_enabled)
global.__mp_gml_node_block=["h_d","h_nodes"];
if(live_enabled)
function mc_gml_node_block():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_block;
	static __enumIndex__=92;
}

if(live_enabled)
function gml_node_block(l_h_d,l_h_nodes){
	var this=new mc_gml_node_block();
	this.h_d=l_h_d;
	this.h_nodes=l_h_nodes;
	return this
}

if(live_enabled)
global.__mp_gml_node_if_then=["h_d","h_cond","h_then","h_not"];
if(live_enabled)
function mc_gml_node_if_then():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_if_then;
	static __enumIndex__=93;
}

if(live_enabled)
function gml_node_if_then(l_h_d,l_h_cond,l_h_then,l_h_not){
	var this=new mc_gml_node_if_then();
	this.h_d=l_h_d;
	this.h_cond=l_h_cond;
	this.h_then=l_h_then;
	this.h_not=l_h_not;
	if(false)throw argument[3];
	return this
}

if(live_enabled)
global.__mp_gml_node_ternary=["h_d","h_cond","h_then","h_not"];
if(live_enabled)
function mc_gml_node_ternary():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_ternary;
	static __enumIndex__=94;
}

if(live_enabled)
function gml_node_ternary(l_h_d,l_h_cond,l_h_then,l_h_not){
	var this=new mc_gml_node_ternary();
	this.h_d=l_h_d;
	this.h_cond=l_h_cond;
	this.h_then=l_h_then;
	this.h_not=l_h_not;
	return this
}

if(live_enabled)
global.__mp_gml_node_switch=["h_d","h_expr","h_list","h_def"];
if(live_enabled)
function mc_gml_node_switch():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_switch;
	static __enumIndex__=95;
}

if(live_enabled)
function gml_node_switch(l_h_d,l_h_expr,l_h_list,l_h_def){
	var this=new mc_gml_node_switch();
	this.h_d=l_h_d;
	this.h_expr=l_h_expr;
	this.h_list=l_h_list;
	this.h_def=l_h_def;
	if(false)throw argument[3];
	return this
}

if(live_enabled)
global.__mp_gml_node_wait=["h_d","h_time"];
if(live_enabled)
function mc_gml_node_wait():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_wait;
	static __enumIndex__=96;
}

if(live_enabled)
function gml_node_wait(l_h_d,l_h_time){
	var this=new mc_gml_node_wait();
	this.h_d=l_h_d;
	this.h_time=l_h_time;
	return this
}

if(live_enabled)
global.__mp_gml_node_fork=["h_d"];
if(live_enabled)
function mc_gml_node_fork():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_fork;
	static __enumIndex__=97;
}

if(live_enabled)
function gml_node_fork(l_h_d){
	var this=new mc_gml_node_fork();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_while=["h_d","h_cond","h_node"];
if(live_enabled)
function mc_gml_node_while():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_while;
	static __enumIndex__=98;
}

if(live_enabled)
function gml_node_while(l_h_d,l_h_cond,l_h_node){
	var this=new mc_gml_node_while();
	this.h_d=l_h_d;
	this.h_cond=l_h_cond;
	this.h_node=l_h_node;
	return this
}

if(live_enabled)
global.__mp_gml_node_do_until=["h_d","h_node","h_cond"];
if(live_enabled)
function mc_gml_node_do_until():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_do_until;
	static __enumIndex__=99;
}

if(live_enabled)
function gml_node_do_until(l_h_d,l_h_node,l_h_cond){
	var this=new mc_gml_node_do_until();
	this.h_d=l_h_d;
	this.h_node=l_h_node;
	this.h_cond=l_h_cond;
	return this
}

if(live_enabled)
global.__mp_gml_node_do_while=["h_d","h_node","h_cond"];
if(live_enabled)
function mc_gml_node_do_while():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_do_while;
	static __enumIndex__=100;
}

if(live_enabled)
function gml_node_do_while(l_h_d,l_h_node,l_h_cond){
	var this=new mc_gml_node_do_while();
	this.h_d=l_h_d;
	this.h_node=l_h_node;
	this.h_cond=l_h_cond;
	return this
}

if(live_enabled)
global.__mp_gml_node_repeat=["h_d","h_times","h_node"];
if(live_enabled)
function mc_gml_node_repeat():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_repeat;
	static __enumIndex__=101;
}

if(live_enabled)
function gml_node_repeat(l_h_d,l_h_times,l_h_node){
	var this=new mc_gml_node_repeat();
	this.h_d=l_h_d;
	this.h_times=l_h_times;
	this.h_node=l_h_node;
	return this
}

if(live_enabled)
global.__mp_gml_node_for=["h_d","h_pre","h_cond","h_post","h_loop"];
if(live_enabled)
function mc_gml_node_for():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_for;
	static __enumIndex__=102;
}

if(live_enabled)
function gml_node_for(l_h_d,l_h_pre,l_h_cond,l_h_post,l_h_loop){
	var this=new mc_gml_node_for();
	this.h_d=l_h_d;
	this.h_pre=l_h_pre;
	this.h_cond=l_h_cond;
	this.h_post=l_h_post;
	this.h_loop=l_h_loop;
	return this
}

if(live_enabled)
global.__mp_gml_node_with=["h_d","h_ctx","h_node"];
if(live_enabled)
function mc_gml_node_with():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_with;
	static __enumIndex__=103;
}

if(live_enabled)
function gml_node_with(l_h_d,l_h_ctx,l_h_node){
	var this=new mc_gml_node_with();
	this.h_d=l_h_d;
	this.h_ctx=l_h_ctx;
	this.h_node=l_h_node;
	return this
}

if(live_enabled)
global.__mp_gml_node_once=["h_d","h_node"];
if(live_enabled)
function mc_gml_node_once():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_once;
	static __enumIndex__=104;
}

if(live_enabled)
function gml_node_once(l_h_d,l_h_node){
	var this=new mc_gml_node_once();
	this.h_d=l_h_d;
	this.h_node=l_h_node;
	return this
}

if(live_enabled)
global.__mp_gml_node_return=["h_d","h_v"];
if(live_enabled)
function mc_gml_node_return():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_return;
	static __enumIndex__=105;
}

if(live_enabled)
function gml_node_return(l_h_d,l_h_v){
	var this=new mc_gml_node_return();
	this.h_d=l_h_d;
	this.h_v=l_h_v;
	return this
}

if(live_enabled)
global.__mp_gml_node_exit=["h_d"];
if(live_enabled)
function mc_gml_node_exit():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_exit;
	static __enumIndex__=106;
}

if(live_enabled)
function gml_node_exit(l_h_d){
	var this=new mc_gml_node_exit();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_break=["h_d"];
if(live_enabled)
function mc_gml_node_break():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_break;
	static __enumIndex__=107;
}

if(live_enabled)
function gml_node_break(l_h_d){
	var this=new mc_gml_node_break();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_continue=["h_d"];
if(live_enabled)
function mc_gml_node_continue():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_continue;
	static __enumIndex__=108;
}

if(live_enabled)
function gml_node_continue(l_h_d){
	var this=new mc_gml_node_continue();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_debugger=["h_d"];
if(live_enabled)
function mc_gml_node_debugger():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_debugger;
	static __enumIndex__=109;
}

if(live_enabled)
function gml_node_debugger(l_h_d){
	var this=new mc_gml_node_debugger();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_node_try_catch=["h_d","h_node","h_cap","h_cat"];
if(live_enabled)
function mc_gml_node_try_catch():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_try_catch;
	static __enumIndex__=110;
}

if(live_enabled)
function gml_node_try_catch(l_h_d,l_h_node,l_h_cap,l_h_cat){
	var this=new mc_gml_node_try_catch();
	this.h_d=l_h_d;
	this.h_node=l_h_node;
	this.h_cap=l_h_cap;
	this.h_cat=l_h_cat;
	return this
}

if(live_enabled)
global.__mp_gml_node_throw=["h_d","h_x"];
if(live_enabled)
function mc_gml_node_throw():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_throw;
	static __enumIndex__=111;
}

if(live_enabled)
function gml_node_throw(l_h_d,l_h_x){
	var this=new mc_gml_node_throw();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	return this
}

if(live_enabled)
global.__mp_gml_node_comment_line=["h_d","h_s"];
if(live_enabled)
function mc_gml_node_comment_line():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_comment_line;
	static __enumIndex__=112;
}

if(live_enabled)
function gml_node_comment_line(l_h_d,l_h_s){
	var this=new mc_gml_node_comment_line();
	this.h_d=l_h_d;
	this.h_s=l_h_s;
	return this
}

if(live_enabled)
global.__mp_gml_node_comment_line_pre=["h_d","h_s","h_x"];
if(live_enabled)
function mc_gml_node_comment_line_pre():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_comment_line_pre;
	static __enumIndex__=113;
}

if(live_enabled)
function gml_node_comment_line_pre(l_h_d,l_h_s,l_h_x){
	var this=new mc_gml_node_comment_line_pre();
	this.h_d=l_h_d;
	this.h_s=l_h_s;
	this.h_x=l_h_x;
	return this
}

if(live_enabled)
global.__mp_gml_node_comment_line_post=["h_d","h_x","h_s"];
if(live_enabled)
function mc_gml_node_comment_line_post():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_comment_line_post;
	static __enumIndex__=114;
}

if(live_enabled)
function gml_node_comment_line_post(l_h_d,l_h_x,l_h_s){
	var this=new mc_gml_node_comment_line_post();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_s=l_h_s;
	return this
}

if(live_enabled)
global.__mp_gml_node_comment_line_sep=["h_d","h_s","h_x"];
if(live_enabled)
function mc_gml_node_comment_line_sep():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_comment_line_sep;
	static __enumIndex__=115;
}

if(live_enabled)
function gml_node_comment_line_sep(l_h_d,l_h_s,l_h_x){
	var this=new mc_gml_node_comment_line_sep();
	this.h_d=l_h_d;
	this.h_s=l_h_s;
	this.h_x=l_h_x;
	return this
}

if(live_enabled)
global.__mp_gml_node_comment_block=["h_d","h_s"];
if(live_enabled)
function mc_gml_node_comment_block():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_comment_block;
	static __enumIndex__=116;
}

if(live_enabled)
function gml_node_comment_block(l_h_d,l_h_s){
	var this=new mc_gml_node_comment_block();
	this.h_d=l_h_d;
	this.h_s=l_h_s;
	return this
}

if(live_enabled)
global.__mp_gml_node_comment_block_pre=["h_d","h_s","h_x","h_pl"];
if(live_enabled)
function mc_gml_node_comment_block_pre():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_comment_block_pre;
	static __enumIndex__=117;
}

if(live_enabled)
function gml_node_comment_block_pre(l_h_d,l_h_s,l_h_x,l_h_pl){
	var this=new mc_gml_node_comment_block_pre();
	this.h_d=l_h_d;
	this.h_s=l_h_s;
	this.h_x=l_h_x;
	this.h_pl=l_h_pl;
	return this
}

if(live_enabled)
global.__mp_gml_node_comment_block_post=["h_d","h_x","h_s","h_pl"];
if(live_enabled)
function mc_gml_node_comment_block_post():mc_gml_node()constructor{
	static __enumParams__=global.__mp_gml_node_comment_block_post;
	static __enumIndex__=118;
}

if(live_enabled)
function gml_node_comment_block_post(l_h_d,l_h_x,l_h_s,l_h_pl){
	var this=new mc_gml_node_comment_block_post();
	this.h_d=l_h_d;
	this.h_x=l_h_x;
	this.h_s=l_h_s;
	this.h_pl=l_h_pl;
	return this
}
