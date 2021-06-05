// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.

// Parser tokens
if(live_enabled)function mc_gml_token()constructor{
	static getIndex=method(undefined,gml_std_enum_getIndex);
	static toString=method(undefined,gml_std_enum_toString);
	static __enum__=mt_gml_token;
}

if(live_enabled)
global.__mp_gml_token_header=["h_d","h_name","h_lb"];
if(live_enabled)
function mc_gml_token_header():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_header;
	static __enumIndex__=0;
}

if(live_enabled)
function gml_token_header(l_h_d,l_h_name,l_h_lb){
	var this=new mc_gml_token_header();
	this.h_d=l_h_d;
	this.h_name=l_h_name;
	this.h_lb=l_h_lb;
	return this
}

if(live_enabled)
global.__mp_gml_token_macro=["h_d"];
if(live_enabled)
function mc_gml_token_macro():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_macro;
	static __enumIndex__=1;
}

if(live_enabled)
function gml_token_macro(l_h_d){
	var this=new mc_gml_token_macro();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_hash=["h_d"];
if(live_enabled)
function mc_gml_token_hash():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_hash;
	static __enumIndex__=2;
}

if(live_enabled)
function gml_token_hash(l_h_d){
	var this=new mc_gml_token_hash();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_semico=["h_d"];
if(live_enabled)
function mc_gml_token_semico():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_semico;
	static __enumIndex__=3;
}

if(live_enabled)
function gml_token_semico(l_h_d){
	var this=new mc_gml_token_semico();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_comma=["h_d"];
if(live_enabled)
function mc_gml_token_comma():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_comma;
	static __enumIndex__=4;
}

if(live_enabled)
function gml_token_comma(l_h_d){
	var this=new mc_gml_token_comma();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_period=["h_d"];
if(live_enabled)
function mc_gml_token_period():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_period;
	static __enumIndex__=5;
}

if(live_enabled)
function gml_token_period(l_h_d){
	var this=new mc_gml_token_period();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_colon=["h_d"];
if(live_enabled)
function mc_gml_token_colon():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_colon;
	static __enumIndex__=6;
}

if(live_enabled)
function gml_token_colon(l_h_d){
	var this=new mc_gml_token_colon();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_qmark=["h_d"];
if(live_enabled)
function mc_gml_token_qmark():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_qmark;
	static __enumIndex__=7;
}

if(live_enabled)
function gml_token_qmark(l_h_d){
	var this=new mc_gml_token_qmark();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_at_sign=["h_d"];
if(live_enabled)
function mc_gml_token_at_sign():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_at_sign;
	static __enumIndex__=8;
}

if(live_enabled)
function gml_token_at_sign(l_h_d){
	var this=new mc_gml_token_at_sign();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_keyword=["h_d","h_kw"];
if(live_enabled)
function mc_gml_token_keyword():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_keyword;
	static __enumIndex__=9;
}

if(live_enabled)
function gml_token_keyword(l_h_d,l_h_kw){
	var this=new mc_gml_token_keyword();
	this.h_d=l_h_d;
	this.h_kw=l_h_kw;
	return this
}

if(live_enabled)
global.__mp_gml_token_ident=["h_d","h_id"];
if(live_enabled)
function mc_gml_token_ident():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_ident;
	static __enumIndex__=10;
}

if(live_enabled)
function gml_token_ident(l_h_d,l_h_id){
	var this=new mc_gml_token_ident();
	this.h_d=l_h_d;
	this.h_id=l_h_id;
	return this
}

if(live_enabled)
global.__mp_gml_token_undefined=["h_d"];
if(live_enabled)
function mc_gml_token_undefined():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_undefined;
	static __enumIndex__=11;
}

if(live_enabled)
function gml_token_undefined(l_h_d){
	var this=new mc_gml_token_undefined();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_number=["h_d","h_nu","h_src"];
if(live_enabled)
function mc_gml_token_number():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_number;
	static __enumIndex__=12;
}

if(live_enabled)
function gml_token_number(l_h_d,l_h_nu,l_h_src){
	var this=new mc_gml_token_number();
	this.h_d=l_h_d;
	this.h_nu=l_h_nu;
	this.h_src=l_h_src;
	return this
}

if(live_enabled)
global.__mp_gml_token_cstring=["h_d","h_st"];
if(live_enabled)
function mc_gml_token_cstring():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_cstring;
	static __enumIndex__=13;
}

if(live_enabled)
function gml_token_cstring(l_h_d,l_h_st){
	var this=new mc_gml_token_cstring();
	this.h_d=l_h_d;
	this.h_st=l_h_st;
	return this
}

if(live_enabled)
global.__mp_gml_token_un_op=["h_d","h_op"];
if(live_enabled)
function mc_gml_token_un_op():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_un_op;
	static __enumIndex__=14;
}

if(live_enabled)
function gml_token_un_op(l_h_d,l_h_op){
	var this=new mc_gml_token_un_op();
	this.h_d=l_h_d;
	this.h_op=l_h_op;
	return this
}

if(live_enabled)
global.__mp_gml_token_adjfix=["h_d","h_inc"];
if(live_enabled)
function mc_gml_token_adjfix():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_adjfix;
	static __enumIndex__=15;
}

if(live_enabled)
function gml_token_adjfix(l_h_d,l_h_inc){
	var this=new mc_gml_token_adjfix();
	this.h_d=l_h_d;
	this.h_inc=l_h_inc;
	return this
}

if(live_enabled)
global.__mp_gml_token_bin_op=["h_d","h_op"];
if(live_enabled)
function mc_gml_token_bin_op():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_bin_op;
	static __enumIndex__=16;
}

if(live_enabled)
function gml_token_bin_op(l_h_d,l_h_op){
	var this=new mc_gml_token_bin_op();
	this.h_d=l_h_d;
	this.h_op=l_h_op;
	return this
}

if(live_enabled)
global.__mp_gml_token_set_op=["h_d","h_op"];
if(live_enabled)
function mc_gml_token_set_op():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_set_op;
	static __enumIndex__=17;
}

if(live_enabled)
function gml_token_set_op(l_h_d,l_h_op){
	var this=new mc_gml_token_set_op();
	this.h_d=l_h_d;
	this.h_op=l_h_op;
	return this
}

if(live_enabled)
global.__mp_gml_token_par_open=["h_d"];
if(live_enabled)
function mc_gml_token_par_open():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_par_open;
	static __enumIndex__=18;
}

if(live_enabled)
function gml_token_par_open(l_h_d){
	var this=new mc_gml_token_par_open();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_par_close=["h_d"];
if(live_enabled)
function mc_gml_token_par_close():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_par_close;
	static __enumIndex__=19;
}

if(live_enabled)
function gml_token_par_close(l_h_d){
	var this=new mc_gml_token_par_close();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_sqb_open=["h_d"];
if(live_enabled)
function mc_gml_token_sqb_open():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_sqb_open;
	static __enumIndex__=20;
}

if(live_enabled)
function gml_token_sqb_open(l_h_d){
	var this=new mc_gml_token_sqb_open();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_sqb_close=["h_d"];
if(live_enabled)
function mc_gml_token_sqb_close():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_sqb_close;
	static __enumIndex__=21;
}

if(live_enabled)
function gml_token_sqb_close(l_h_d){
	var this=new mc_gml_token_sqb_close();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_cub_open=["h_d"];
if(live_enabled)
function mc_gml_token_cub_open():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_cub_open;
	static __enumIndex__=22;
}

if(live_enabled)
function gml_token_cub_open(l_h_d){
	var this=new mc_gml_token_cub_open();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_cub_close=["h_d"];
if(live_enabled)
function mc_gml_token_cub_close():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_cub_close;
	static __enumIndex__=23;
}

if(live_enabled)
function gml_token_cub_close(l_h_d){
	var this=new mc_gml_token_cub_close();
	this.h_d=l_h_d;
	return this
}

if(live_enabled)
global.__mp_gml_token_arg_const=["h_d","h_i"];
if(live_enabled)
function mc_gml_token_arg_const():mc_gml_token()constructor{
	static __enumParams__=global.__mp_gml_token_arg_const;
	static __enumIndex__=24;
}

if(live_enabled)
function gml_token_arg_const(l_h_d,l_h_i){
	var this=new mc_gml_token_arg_const();
	this.h_d=l_h_d;
	this.h_i=l_h_i;
	return this
}
