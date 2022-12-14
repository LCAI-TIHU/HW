// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_DP_intp.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CDP_define.h
//
`define SYNTHESIS
//
///////////////////////////////////////////////////
//#ifdef NVDLA_FEATURE_DATA_TYPE_INT8
//#if ( NVDLA_CDP_THROUGHPUT  ==  8 )
//    #define LARGE_FIFO_RAM
//#endif
//#if ( NVDLA_CDP_THROUGHPUT == 1 )
//    #define SMALL_FIFO_RAM
//#endif
//#endif
module NV_NVDLA_CDP_DP_intp (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,dp2reg_done //|< i
  ,intp2mul_prdy //|< i
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,lut2intp_X_data_${m}0 //|> o
//: ,lut2intp_X_data_${m}0_17b //|> o
//: ,lut2intp_X_data_${m}1 //|> o
//: ,lut2intp_X_info_${m} //|> o
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,lut2intp_X_data_00 //|> o
,lut2intp_X_data_00_17b //|> o
,lut2intp_X_data_01 //|> o
,lut2intp_X_info_0 //|> o

,lut2intp_X_data_10 //|> o
,lut2intp_X_data_10_17b //|> o
,lut2intp_X_data_11 //|> o
,lut2intp_X_info_1 //|> o

,lut2intp_X_data_20 //|> o
,lut2intp_X_data_20_17b //|> o
,lut2intp_X_data_21 //|> o
,lut2intp_X_info_2 //|> o

,lut2intp_X_data_30 //|> o
,lut2intp_X_data_30_17b //|> o
,lut2intp_X_data_31 //|> o
,lut2intp_X_info_3 //|> o

,lut2intp_X_data_40 //|> o
,lut2intp_X_data_40_17b //|> o
,lut2intp_X_data_41 //|> o
,lut2intp_X_info_4 //|> o

,lut2intp_X_data_50 //|> o
,lut2intp_X_data_50_17b //|> o
,lut2intp_X_data_51 //|> o
,lut2intp_X_info_5 //|> o

,lut2intp_X_data_60 //|> o
,lut2intp_X_data_60_17b //|> o
,lut2intp_X_data_61 //|> o
,lut2intp_X_info_6 //|> o

,lut2intp_X_data_70 //|> o
,lut2intp_X_data_70_17b //|> o
,lut2intp_X_data_71 //|> o
,lut2intp_X_info_7 //|> o

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,lut2intp_X_sel //|< i
  ,lut2intp_Y_sel //|< i
  ,lut2intp_pvld //|< i
  ,pwrbus_ram_pd //|< i
  ,reg2dp_lut_le_end_high //|< i
  ,reg2dp_lut_le_end_low //|< i
  ,reg2dp_lut_le_function //|< i
  ,reg2dp_lut_le_index_offset //|< i
  ,reg2dp_lut_le_slope_oflow_scale //|< i
  ,reg2dp_lut_le_slope_oflow_shift //|< i
  ,reg2dp_lut_le_slope_uflow_scale //|< i
  ,reg2dp_lut_le_slope_uflow_shift //|< i
  ,reg2dp_lut_le_start_high //|< i
  ,reg2dp_lut_le_start_low //|< i
  ,reg2dp_lut_lo_end_high //|< i
  ,reg2dp_lut_lo_end_low //|< i
  ,reg2dp_lut_lo_slope_oflow_scale //|< i
  ,reg2dp_lut_lo_slope_oflow_shift //|< i
  ,reg2dp_lut_lo_slope_uflow_scale //|< i
  ,reg2dp_lut_lo_slope_uflow_shift //|< i
  ,reg2dp_lut_lo_start_high //|< i
  ,reg2dp_lut_lo_start_low //|< i
  ,reg2dp_sqsum_bypass //|< i
  ,sync2itp_pd //|< i
  ,sync2itp_pvld //|< i
  ,dp2reg_d0_perf_lut_hybrid //|> o
  ,dp2reg_d0_perf_lut_le_hit //|> o
  ,dp2reg_d0_perf_lut_lo_hit //|> o
  ,dp2reg_d0_perf_lut_oflow //|> o
  ,dp2reg_d0_perf_lut_uflow //|> o
  ,dp2reg_d1_perf_lut_hybrid //|> o
  ,dp2reg_d1_perf_lut_le_hit //|> o
  ,dp2reg_d1_perf_lut_lo_hit //|> o
  ,dp2reg_d1_perf_lut_oflow //|> o
  ,dp2reg_d1_perf_lut_uflow //|> o
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,intp2mul_pd_$m //|> o
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,intp2mul_pd_0 //|> o

,intp2mul_pd_1 //|> o

,intp2mul_pd_2 //|> o

,intp2mul_pd_3 //|> o

,intp2mul_pd_4 //|> o

,intp2mul_pd_5 //|> o

,intp2mul_pd_6 //|> o

,intp2mul_pd_7 //|> o

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,intp2mul_pvld //|> o
  ,lut2intp_prdy //|> o
  ,sync2itp_prdy //|> o
  );
//////////////////////////////////////////////////////////////////////
input nvdla_core_clk;
input nvdla_core_rstn;
input dp2reg_done;
input intp2mul_prdy;
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: input [31:0] lut2intp_X_data_${m}0;
//: input [16:0] lut2intp_X_data_${m}0_17b;
//: input [31:0] lut2intp_X_data_${m}1;
//: input [19:0] lut2intp_X_info_${m};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

input [31:0] lut2intp_X_data_00;
input [16:0] lut2intp_X_data_00_17b;
input [31:0] lut2intp_X_data_01;
input [19:0] lut2intp_X_info_0;

input [31:0] lut2intp_X_data_10;
input [16:0] lut2intp_X_data_10_17b;
input [31:0] lut2intp_X_data_11;
input [19:0] lut2intp_X_info_1;

input [31:0] lut2intp_X_data_20;
input [16:0] lut2intp_X_data_20_17b;
input [31:0] lut2intp_X_data_21;
input [19:0] lut2intp_X_info_2;

input [31:0] lut2intp_X_data_30;
input [16:0] lut2intp_X_data_30_17b;
input [31:0] lut2intp_X_data_31;
input [19:0] lut2intp_X_info_3;

input [31:0] lut2intp_X_data_40;
input [16:0] lut2intp_X_data_40_17b;
input [31:0] lut2intp_X_data_41;
input [19:0] lut2intp_X_info_4;

input [31:0] lut2intp_X_data_50;
input [16:0] lut2intp_X_data_50_17b;
input [31:0] lut2intp_X_data_51;
input [19:0] lut2intp_X_info_5;

input [31:0] lut2intp_X_data_60;
input [16:0] lut2intp_X_data_60_17b;
input [31:0] lut2intp_X_data_61;
input [19:0] lut2intp_X_info_6;

input [31:0] lut2intp_X_data_70;
input [16:0] lut2intp_X_data_70_17b;
input [31:0] lut2intp_X_data_71;
input [19:0] lut2intp_X_info_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input [8 -1:0] lut2intp_X_sel;
input [8 -1:0] lut2intp_Y_sel;
input lut2intp_pvld;
input [31:0] pwrbus_ram_pd;
input [5:0] reg2dp_lut_le_end_high;
input [31:0] reg2dp_lut_le_end_low;
input reg2dp_lut_le_function;
input [7:0] reg2dp_lut_le_index_offset;
input [15:0] reg2dp_lut_le_slope_oflow_scale;
input [4:0] reg2dp_lut_le_slope_oflow_shift;
input [15:0] reg2dp_lut_le_slope_uflow_scale;
input [4:0] reg2dp_lut_le_slope_uflow_shift;
input [5:0] reg2dp_lut_le_start_high;
input [31:0] reg2dp_lut_le_start_low;
input [5:0] reg2dp_lut_lo_end_high;
input [31:0] reg2dp_lut_lo_end_low;
input [15:0] reg2dp_lut_lo_slope_oflow_scale;
input [4:0] reg2dp_lut_lo_slope_oflow_shift;
input [15:0] reg2dp_lut_lo_slope_uflow_scale;
input [4:0] reg2dp_lut_lo_slope_uflow_shift;
input [5:0] reg2dp_lut_lo_start_high;
input [31:0] reg2dp_lut_lo_start_low;
input reg2dp_sqsum_bypass;
//: my $k = 8;
//: my $icvto = (8 +1);
//: print "input  [${k}*(${icvto}*2+3)-1:0] sync2itp_pd;  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
input  [8*(9*2+3)-1:0] sync2itp_pd;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
input sync2itp_pvld;
output [31:0] dp2reg_d0_perf_lut_hybrid;
output [31:0] dp2reg_d0_perf_lut_le_hit;
output [31:0] dp2reg_d0_perf_lut_lo_hit;
output [31:0] dp2reg_d0_perf_lut_oflow;
output [31:0] dp2reg_d0_perf_lut_uflow;
output [31:0] dp2reg_d1_perf_lut_hybrid;
output [31:0] dp2reg_d1_perf_lut_le_hit;
output [31:0] dp2reg_d1_perf_lut_lo_hit;
output [31:0] dp2reg_d1_perf_lut_oflow;
output [31:0] dp2reg_d1_perf_lut_uflow;
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: output [16:0] intp2mul_pd_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [16:0] intp2mul_pd_0;

output [16:0] intp2mul_pd_1;

output [16:0] intp2mul_pd_2;

output [16:0] intp2mul_pd_3;

output [16:0] intp2mul_pd_4;

output [16:0] intp2mul_pd_5;

output [16:0] intp2mul_pd_6;

output [16:0] intp2mul_pd_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output intp2mul_pvld;
output lut2intp_prdy;
output sync2itp_prdy;
//////////////////////////////////////////////////////////////////////
reg X_exp;
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: reg [38:0] Xinterp_in0_pd_$m;
//: reg [37:0] Xinterp_in1_pd_$m;
//: reg [16:0] Xinterp_in_pd_$m;
//: reg [16:0] Xinterp_in_scale_$m;
//: reg [5:0] Xinterp_in_shift_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

reg [38:0] Xinterp_in0_pd_0;
reg [37:0] Xinterp_in1_pd_0;
reg [16:0] Xinterp_in_pd_0;
reg [16:0] Xinterp_in_scale_0;
reg [5:0] Xinterp_in_shift_0;

reg [38:0] Xinterp_in0_pd_1;
reg [37:0] Xinterp_in1_pd_1;
reg [16:0] Xinterp_in_pd_1;
reg [16:0] Xinterp_in_scale_1;
reg [5:0] Xinterp_in_shift_1;

reg [38:0] Xinterp_in0_pd_2;
reg [37:0] Xinterp_in1_pd_2;
reg [16:0] Xinterp_in_pd_2;
reg [16:0] Xinterp_in_scale_2;
reg [5:0] Xinterp_in_shift_2;

reg [38:0] Xinterp_in0_pd_3;
reg [37:0] Xinterp_in1_pd_3;
reg [16:0] Xinterp_in_pd_3;
reg [16:0] Xinterp_in_scale_3;
reg [5:0] Xinterp_in_shift_3;

reg [38:0] Xinterp_in0_pd_4;
reg [37:0] Xinterp_in1_pd_4;
reg [16:0] Xinterp_in_pd_4;
reg [16:0] Xinterp_in_scale_4;
reg [5:0] Xinterp_in_shift_4;

reg [38:0] Xinterp_in0_pd_5;
reg [37:0] Xinterp_in1_pd_5;
reg [16:0] Xinterp_in_pd_5;
reg [16:0] Xinterp_in_scale_5;
reg [5:0] Xinterp_in_shift_5;

reg [38:0] Xinterp_in0_pd_6;
reg [37:0] Xinterp_in1_pd_6;
reg [16:0] Xinterp_in_pd_6;
reg [16:0] Xinterp_in_scale_6;
reg [5:0] Xinterp_in_shift_6;

reg [38:0] Xinterp_in0_pd_7;
reg [37:0] Xinterp_in1_pd_7;
reg [16:0] Xinterp_in_pd_7;
reg [16:0] Xinterp_in_scale_7;
reg [5:0] Xinterp_in_shift_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
reg [31:0] both_hybrid_counter;
reg [8 -1:0] both_hybrid_flag;
reg [31:0] both_of_counter;
reg [8 -1:0] both_of_flag;
reg [31:0] both_uf_counter;
reg [8 -1:0] both_uf_flag;
reg [31:0] dp2reg_d0_perf_lut_hybrid;
reg [31:0] dp2reg_d0_perf_lut_le_hit;
reg [31:0] dp2reg_d0_perf_lut_lo_hit;
reg [31:0] dp2reg_d0_perf_lut_oflow;
reg [31:0] dp2reg_d0_perf_lut_uflow;
reg [31:0] dp2reg_d1_perf_lut_hybrid;
reg [31:0] dp2reg_d1_perf_lut_le_hit;
reg [31:0] dp2reg_d1_perf_lut_lo_hit;
reg [31:0] dp2reg_d1_perf_lut_oflow;
reg [31:0] dp2reg_d1_perf_lut_uflow;
//reg [8*17-1:0] intp2mul_pd;
//reg intp2mul_pvld;
reg intp_pvld_d;
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: reg [16:0] ip2mul_pd_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

reg [16:0] ip2mul_pd_0;

reg [16:0] ip2mul_pd_1;

reg [16:0] ip2mul_pd_2;

reg [16:0] ip2mul_pd_3;

reg [16:0] ip2mul_pd_4;

reg [16:0] ip2mul_pd_5;

reg [16:0] ip2mul_pd_6;

reg [16:0] ip2mul_pd_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
//reg ip2mul_prdy;
reg layer_flg;
//reg [8*103-1:0] lut2intp_data;
//reg lut2intp_prdy;
//reg lut2intp_valid;
reg [37:0] lut_le_max;
reg [38:0] lut_le_min;
reg [37:0] lut_lo_max;
reg [37:0] lut_lo_min;
reg [8 -1:0] only_le_hit;
reg [31:0] only_le_hit_counter;
reg [8 -1:0] only_lo_hit;
reg [31:0] only_lo_hit_counter;
reg [15:0] reg2dp_lut_le_slope_oflow_scale_sync;
reg [4:0] reg2dp_lut_le_slope_oflow_shift_sync;
reg [15:0] reg2dp_lut_le_slope_uflow_scale_sync;
reg [4:0] reg2dp_lut_le_slope_uflow_shift_sync;
reg [15:0] reg2dp_lut_lo_slope_oflow_scale_sync;
reg [4:0] reg2dp_lut_lo_slope_oflow_shift_sync;
reg [15:0] reg2dp_lut_lo_slope_uflow_scale_sync;
reg [4:0] reg2dp_lut_lo_slope_uflow_shift_sync;
reg sqsum_bypass_enable;
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: wire [1:0] X_info_$m;
//: wire X_oflow_$m;
//: wire X_uflow_$m;
//: wire [1:0] Y_info_$m;
//: wire Y_oflow_$m;
//: wire Y_uflow_$m;
//: wire [16:0] Xinterp_out_pd_$m;
//: wire [37:0] hit_in1_pd_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [1:0] X_info_0;
wire X_oflow_0;
wire X_uflow_0;
wire [1:0] Y_info_0;
wire Y_oflow_0;
wire Y_uflow_0;
wire [16:0] Xinterp_out_pd_0;
wire [37:0] hit_in1_pd_0;

wire [1:0] X_info_1;
wire X_oflow_1;
wire X_uflow_1;
wire [1:0] Y_info_1;
wire Y_oflow_1;
wire Y_uflow_1;
wire [16:0] Xinterp_out_pd_1;
wire [37:0] hit_in1_pd_1;

wire [1:0] X_info_2;
wire X_oflow_2;
wire X_uflow_2;
wire [1:0] Y_info_2;
wire Y_oflow_2;
wire Y_uflow_2;
wire [16:0] Xinterp_out_pd_2;
wire [37:0] hit_in1_pd_2;

wire [1:0] X_info_3;
wire X_oflow_3;
wire X_uflow_3;
wire [1:0] Y_info_3;
wire Y_oflow_3;
wire Y_uflow_3;
wire [16:0] Xinterp_out_pd_3;
wire [37:0] hit_in1_pd_3;

wire [1:0] X_info_4;
wire X_oflow_4;
wire X_uflow_4;
wire [1:0] Y_info_4;
wire Y_oflow_4;
wire Y_uflow_4;
wire [16:0] Xinterp_out_pd_4;
wire [37:0] hit_in1_pd_4;

wire [1:0] X_info_5;
wire X_oflow_5;
wire X_uflow_5;
wire [1:0] Y_info_5;
wire Y_oflow_5;
wire Y_uflow_5;
wire [16:0] Xinterp_out_pd_5;
wire [37:0] hit_in1_pd_5;

wire [1:0] X_info_6;
wire X_oflow_6;
wire X_uflow_6;
wire [1:0] Y_info_6;
wire Y_oflow_6;
wire Y_uflow_6;
wire [16:0] Xinterp_out_pd_6;
wire [37:0] hit_in1_pd_6;

wire [1:0] X_info_7;
wire X_oflow_7;
wire X_uflow_7;
wire [1:0] Y_info_7;
wire Y_oflow_7;
wire Y_uflow_7;
wire [16:0] Xinterp_out_pd_7;
wire [37:0] hit_in1_pd_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8 -1:0] Xinterp_in_rdy;
wire [8 -1:0] Xinterp_in_vld;
wire [8 -1:0] Xinterp_out_rdy;
wire [8 -1:0] Xinterp_out_vld;
wire [31:0] both_hybrid_counter_nxt;
wire [3:0] both_hybrid_ele;
wire [31:0] both_of_counter_nxt;
wire [3:0] both_of_ele;
wire [31:0] both_uf_counter_nxt;
wire [3:0] both_uf_ele;
wire [8*4-1:0] dat_info_in;
wire [8*2-1:0] info_Xin_pd;
wire [8*2-1:0] info_Yin_pd;
wire [8*4-1:0] info_in_pd;
wire info_in_rdy;
wire info_in_vld;
wire [8*4-1:0] info_o_pd;
wire info_o_rdy;
wire info_o_vld;
wire intp_in_prdy;
wire intp_in_pvld;
wire intp_prdy;
wire intp_prdy_d;
wire intp_pvld;
wire [8*17-1:0] ip2mul_pd;
wire ip2mul_pvld;
wire layer_done;
wire [127:0] le_offset_exp;
wire [6:0] le_offset_use;
wire [16:0] le_slope_oflow_scale;
wire [16:0] le_slope_uflow_scale;
wire [16:0] lo_slope_oflow_scale;
wire [16:0] lo_slope_uflow_scale;
wire [8*103-1:0] lut2intp_pd;
wire lut2intp_ready;
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: wire [31:0] lut2ip_X_data_${m}0;
//: wire [16:0] lut2ip_X_data_${m}0_17b;
//: wire [31:0] lut2ip_X_data_${m}1;
//: wire [19:0] lut2ip_X_info_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [31:0] lut2ip_X_data_00;
wire [16:0] lut2ip_X_data_00_17b;
wire [31:0] lut2ip_X_data_01;
wire [19:0] lut2ip_X_info_0;

wire [31:0] lut2ip_X_data_10;
wire [16:0] lut2ip_X_data_10_17b;
wire [31:0] lut2ip_X_data_11;
wire [19:0] lut2ip_X_info_1;

wire [31:0] lut2ip_X_data_20;
wire [16:0] lut2ip_X_data_20_17b;
wire [31:0] lut2ip_X_data_21;
wire [19:0] lut2ip_X_info_2;

wire [31:0] lut2ip_X_data_30;
wire [16:0] lut2ip_X_data_30_17b;
wire [31:0] lut2ip_X_data_31;
wire [19:0] lut2ip_X_info_3;

wire [31:0] lut2ip_X_data_40;
wire [16:0] lut2ip_X_data_40_17b;
wire [31:0] lut2ip_X_data_41;
wire [19:0] lut2ip_X_info_4;

wire [31:0] lut2ip_X_data_50;
wire [16:0] lut2ip_X_data_50_17b;
wire [31:0] lut2ip_X_data_51;
wire [19:0] lut2ip_X_info_5;

wire [31:0] lut2ip_X_data_60;
wire [16:0] lut2ip_X_data_60_17b;
wire [31:0] lut2ip_X_data_61;
wire [19:0] lut2ip_X_info_6;

wire [31:0] lut2ip_X_data_70;
wire [16:0] lut2ip_X_data_70_17b;
wire [31:0] lut2ip_X_data_71;
wire [19:0] lut2ip_X_info_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8 -1:0] lut2ip_X_sel;
wire [8 -1:0] lut2ip_Y_sel;
wire [37:0] lut_le_end;
wire [38:0] lut_le_min_int;
wire [37:0] lut_le_start;
wire [37:0] lut_lo_end;
wire [37:0] lut_lo_start;
wire mon_both_hybrid_counter_nxt;
wire mon_both_of_counter_nxt;
wire mon_both_uf_counter_nxt;
wire [90:0] mon_lut_le_min_int;
wire mon_only_le_hit_counter_nxt;
wire mon_only_lo_hit_counter_nxt;
wire [31:0] only_le_hit_counter_nxt;
wire [3:0] only_le_hit_ele;
wire [31:0] only_lo_hit_counter_nxt;
wire [3:0] only_lo_hit_ele;
///////////////////////////////////////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    X_exp <= 1'b0;
  end else begin
  X_exp <= reg2dp_lut_le_function == 1'h0;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    sqsum_bypass_enable <= 1'b0;
  end else begin
  sqsum_bypass_enable <= reg2dp_sqsum_bypass == 1'h1;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_lut_le_slope_uflow_shift_sync <= {5{1'b0}};
  end else begin
  reg2dp_lut_le_slope_uflow_shift_sync <= reg2dp_lut_le_slope_uflow_shift[4:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_lut_le_slope_oflow_shift_sync <= {5{1'b0}};
  end else begin
  reg2dp_lut_le_slope_oflow_shift_sync <= reg2dp_lut_le_slope_oflow_shift[4:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_lut_lo_slope_uflow_shift_sync <= {5{1'b0}};
  end else begin
  reg2dp_lut_lo_slope_uflow_shift_sync <= reg2dp_lut_lo_slope_uflow_shift[4:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_lut_lo_slope_oflow_shift_sync <= {5{1'b0}};
  end else begin
  reg2dp_lut_lo_slope_oflow_shift_sync <= reg2dp_lut_lo_slope_oflow_shift[4:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_lut_le_slope_uflow_scale_sync <= {16{1'b0}};
  end else begin
  reg2dp_lut_le_slope_uflow_scale_sync <= reg2dp_lut_le_slope_uflow_scale[15:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_lut_le_slope_oflow_scale_sync <= {16{1'b0}};
  end else begin
  reg2dp_lut_le_slope_oflow_scale_sync <= reg2dp_lut_le_slope_oflow_scale[15:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_lut_lo_slope_uflow_scale_sync <= {16{1'b0}};
  end else begin
  reg2dp_lut_lo_slope_uflow_scale_sync <= reg2dp_lut_lo_slope_uflow_scale[15:0];
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    reg2dp_lut_lo_slope_oflow_scale_sync <= {16{1'b0}};
  end else begin
  reg2dp_lut_lo_slope_oflow_scale_sync <= reg2dp_lut_lo_slope_oflow_scale[15:0];
  end
end
///////////////////////////////////////////
assign le_slope_uflow_scale = {reg2dp_lut_le_slope_uflow_scale_sync[15],reg2dp_lut_le_slope_uflow_scale_sync[15:0]};
assign le_slope_oflow_scale = {reg2dp_lut_le_slope_oflow_scale_sync[15],reg2dp_lut_le_slope_oflow_scale_sync[15:0]};
assign lo_slope_uflow_scale = {reg2dp_lut_lo_slope_uflow_scale_sync[15],reg2dp_lut_lo_slope_uflow_scale_sync[15:0]};
assign lo_slope_oflow_scale = {reg2dp_lut_lo_slope_oflow_scale_sync[15],reg2dp_lut_lo_slope_oflow_scale_sync[15:0]};
///////////////////////////////////////////
//lut2intp pipe sync for timing
assign lut2intp_pd = {
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: lut2intp_X_data_${m}0[31:0],lut2intp_X_data_${m}0_17b[16:0],lut2intp_X_data_${m}1[31:0],
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: lut2intp_X_info_${m}[19:0],
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

lut2intp_X_data_00[31:0],lut2intp_X_data_00_17b[16:0],lut2intp_X_data_01[31:0],

lut2intp_X_data_10[31:0],lut2intp_X_data_10_17b[16:0],lut2intp_X_data_11[31:0],

lut2intp_X_data_20[31:0],lut2intp_X_data_20_17b[16:0],lut2intp_X_data_21[31:0],

lut2intp_X_data_30[31:0],lut2intp_X_data_30_17b[16:0],lut2intp_X_data_31[31:0],

lut2intp_X_data_40[31:0],lut2intp_X_data_40_17b[16:0],lut2intp_X_data_41[31:0],

lut2intp_X_data_50[31:0],lut2intp_X_data_50_17b[16:0],lut2intp_X_data_51[31:0],

lut2intp_X_data_60[31:0],lut2intp_X_data_60_17b[16:0],lut2intp_X_data_61[31:0],

lut2intp_X_data_70[31:0],lut2intp_X_data_70_17b[16:0],lut2intp_X_data_71[31:0],

lut2intp_X_info_0[19:0],

lut2intp_X_info_1[19:0],

lut2intp_X_info_2[19:0],

lut2intp_X_info_3[19:0],

lut2intp_X_info_4[19:0],

lut2intp_X_info_5[19:0],

lut2intp_X_info_6[19:0],

lut2intp_X_info_7[19:0],

//| eperl: generated_end (DO NOT EDIT ABOVE)
               lut2intp_X_sel,
               lut2intp_Y_sel
               };
//: my $k = 8*103;
//: &eperl::pipe(" -is -wid $k -do lut2intp_data -vo lut2intp_valid -ri lut2intp_ready -di lut2intp_pd -vi lut2intp_pvld -ro lut2intp_prdy ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg lut2intp_prdy;
reg skid_flop_lut2intp_prdy;
reg skid_flop_lut2intp_pvld;
reg [824-1:0] skid_flop_lut2intp_pd;
reg pipe_skid_lut2intp_pvld;
reg [824-1:0] pipe_skid_lut2intp_pd;
// Wire
wire skid_lut2intp_pvld;
wire [824-1:0] skid_lut2intp_pd;
wire skid_lut2intp_prdy;
wire pipe_skid_lut2intp_prdy;
wire lut2intp_valid;
wire [824-1:0] lut2intp_data;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       lut2intp_prdy <= 1'b1;
       skid_flop_lut2intp_prdy <= 1'b1;
   end else begin
       lut2intp_prdy <= skid_lut2intp_prdy;
       skid_flop_lut2intp_prdy <= skid_lut2intp_prdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_lut2intp_pvld <= 1'b0;
    end else begin
        if (skid_flop_lut2intp_prdy) begin
            skid_flop_lut2intp_pvld <= lut2intp_pvld;
        end
   end
end
assign skid_lut2intp_pvld = (skid_flop_lut2intp_prdy) ? lut2intp_pvld : skid_flop_lut2intp_pvld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_lut2intp_prdy & lut2intp_pvld) begin
        skid_flop_lut2intp_pd[824-1:0] <= lut2intp_pd[824-1:0];
    end
end
assign skid_lut2intp_pd[824-1:0] = (skid_flop_lut2intp_prdy) ? lut2intp_pd[824-1:0] : skid_flop_lut2intp_pd[824-1:0];


// PIPE READY
assign skid_lut2intp_prdy = pipe_skid_lut2intp_prdy || !pipe_skid_lut2intp_pvld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_lut2intp_pvld <= 1'b0;
    end else begin
        if (skid_lut2intp_prdy) begin
            pipe_skid_lut2intp_pvld <= skid_lut2intp_pvld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_lut2intp_prdy && skid_lut2intp_pvld) begin
        pipe_skid_lut2intp_pd[824-1:0] <= skid_lut2intp_pd[824-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_lut2intp_prdy = lut2intp_ready;
assign lut2intp_valid = pipe_skid_lut2intp_pvld;
assign lut2intp_data = pipe_skid_lut2intp_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign {
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: lut2ip_X_data_${m}0[31:0],lut2ip_X_data_${m}0_17b[16:0],lut2ip_X_data_${m}1[31:0],
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: lut2ip_X_info_${m}[19:0],
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

lut2ip_X_data_00[31:0],lut2ip_X_data_00_17b[16:0],lut2ip_X_data_01[31:0],

lut2ip_X_data_10[31:0],lut2ip_X_data_10_17b[16:0],lut2ip_X_data_11[31:0],

lut2ip_X_data_20[31:0],lut2ip_X_data_20_17b[16:0],lut2ip_X_data_21[31:0],

lut2ip_X_data_30[31:0],lut2ip_X_data_30_17b[16:0],lut2ip_X_data_31[31:0],

lut2ip_X_data_40[31:0],lut2ip_X_data_40_17b[16:0],lut2ip_X_data_41[31:0],

lut2ip_X_data_50[31:0],lut2ip_X_data_50_17b[16:0],lut2ip_X_data_51[31:0],

lut2ip_X_data_60[31:0],lut2ip_X_data_60_17b[16:0],lut2ip_X_data_61[31:0],

lut2ip_X_data_70[31:0],lut2ip_X_data_70_17b[16:0],lut2ip_X_data_71[31:0],

lut2ip_X_info_0[19:0],

lut2ip_X_info_1[19:0],

lut2ip_X_info_2[19:0],

lut2ip_X_info_3[19:0],

lut2ip_X_info_4[19:0],

lut2ip_X_info_5[19:0],

lut2ip_X_info_6[19:0],

lut2ip_X_info_7[19:0],

//| eperl: generated_end (DO NOT EDIT ABOVE)
        lut2ip_X_sel,
        lut2ip_Y_sel} = lut2intp_data;
///////////////////////////////////////////
//lock
//from lut2int and sync2itp to intp_in
assign lut2intp_ready = intp_in_prdy & sync2itp_pvld;
assign sync2itp_prdy = intp_in_prdy & lut2intp_valid;
assign intp_in_pvld = sync2itp_pvld & lut2intp_valid;
///////////////////////////////////////////
assign intp_in_prdy = (&Xinterp_in_rdy) & info_in_rdy;
//: my $k = 8;
//: my $icvto=(8 +1);
//: my $sqbw=${icvto}*2+3;
//: foreach my $m (0..$k -1) {
//: print qq(
//: assign hit_in1_pd_$m = (sqsum_bypass_enable ? {{(38-${sqbw}){sync2itp_pd[${sqbw}*$m+${sqbw}-1]}} ,sync2itp_pd[${sqbw}*$m+${sqbw}-1:${sqbw}*$m]} : {17'd0,sync2itp_pd[${sqbw}*$m+${sqbw}-1:${sqbw}*$m] });
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign hit_in1_pd_0 = (sqsum_bypass_enable ? {{(38-21){sync2itp_pd[21*0+21-1]}} ,sync2itp_pd[21*0+21-1:21*0]} : {17'd0,sync2itp_pd[21*0+21-1:21*0] });

assign hit_in1_pd_1 = (sqsum_bypass_enable ? {{(38-21){sync2itp_pd[21*1+21-1]}} ,sync2itp_pd[21*1+21-1:21*1]} : {17'd0,sync2itp_pd[21*1+21-1:21*1] });

assign hit_in1_pd_2 = (sqsum_bypass_enable ? {{(38-21){sync2itp_pd[21*2+21-1]}} ,sync2itp_pd[21*2+21-1:21*2]} : {17'd0,sync2itp_pd[21*2+21-1:21*2] });

assign hit_in1_pd_3 = (sqsum_bypass_enable ? {{(38-21){sync2itp_pd[21*3+21-1]}} ,sync2itp_pd[21*3+21-1:21*3]} : {17'd0,sync2itp_pd[21*3+21-1:21*3] });

assign hit_in1_pd_4 = (sqsum_bypass_enable ? {{(38-21){sync2itp_pd[21*4+21-1]}} ,sync2itp_pd[21*4+21-1:21*4]} : {17'd0,sync2itp_pd[21*4+21-1:21*4] });

assign hit_in1_pd_5 = (sqsum_bypass_enable ? {{(38-21){sync2itp_pd[21*5+21-1]}} ,sync2itp_pd[21*5+21-1:21*5]} : {17'd0,sync2itp_pd[21*5+21-1:21*5] });

assign hit_in1_pd_6 = (sqsum_bypass_enable ? {{(38-21){sync2itp_pd[21*6+21-1]}} ,sync2itp_pd[21*6+21-1:21*6]} : {17'd0,sync2itp_pd[21*6+21-1:21*6] });

assign hit_in1_pd_7 = (sqsum_bypass_enable ? {{(38-21){sync2itp_pd[21*7+21-1]}} ,sync2itp_pd[21*7+21-1:21*7]} : {17'd0,sync2itp_pd[21*7+21-1:21*7] });

//| eperl: generated_end (DO NOT EDIT ABOVE)
/////////////////////////////////////////////////
//start/end prepare for out of range interpolation
/////////////////////////////////////////////////
assign lut_le_end[37:0] = {reg2dp_lut_le_end_high[5:0],reg2dp_lut_le_end_low[31:0]};
assign lut_le_start[37:0] = {reg2dp_lut_le_start_high[5:0],reg2dp_lut_le_start_low[31:0]};
assign lut_lo_end[37:0] = {reg2dp_lut_lo_end_high[5:0],reg2dp_lut_lo_end_low[31:0]};
assign lut_lo_start[37:0] = {reg2dp_lut_lo_start_high[5:0],reg2dp_lut_lo_start_low[31:0]};
assign le_offset_use = reg2dp_lut_le_index_offset[6:0];
assign le_offset_exp[127:0] = reg2dp_lut_le_index_offset[7] ? 128'd0 : (1'b1 << le_offset_use);
assign {mon_lut_le_min_int[90:0],lut_le_min_int[38:0]} = X_exp ? ($signed({{91{lut_le_start[37]}}, lut_le_start[37:0]}) + $signed({1'b0,le_offset_exp})) : {{92{lut_le_start[37]}}, lut_le_start[37:0]};
//
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    lut_le_max[37:0] <= {38{1'b0}};
  end else begin
  lut_le_max[37:0] <= lut_le_end;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    lut_le_min[38:0] <= {39{1'b0}};
  end else begin
  lut_le_min[38:0] <= lut_le_min_int;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    lut_lo_max[37:0] <= {38{1'b0}};
  end else begin
  lut_lo_max[37:0] <= lut_lo_end;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    lut_lo_min[37:0] <= {38{1'b0}};
  end else begin
  lut_lo_min[37:0] <= lut_lo_start;
  end
end
/////////////////////////////////////////////////
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: assign X_uflow_${m} = lut2ip_X_info_${m}[16];
//: assign X_oflow_${m} = lut2ip_X_info_${m}[17];
//: assign Y_uflow_${m} = lut2ip_X_info_${m}[18];
//: assign Y_oflow_${m} = lut2ip_X_info_${m}[19];
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: always @(*) begin
//: if(lut2ip_X_sel[$m]) begin
//: if(X_uflow_$m)
//: Xinterp_in0_pd_$m = lut_le_min[38:0];
//: else if(X_oflow_$m)
//: Xinterp_in0_pd_$m = {lut_le_max[37],lut_le_max[37:0]};
//: else
//: Xinterp_in0_pd_$m = {{7{lut2ip_X_data_${m}0[31]}},lut2ip_X_data_${m}0[31:0]};
//: end else if(lut2ip_Y_sel[$m]) begin
//: if(Y_uflow_$m)
//: Xinterp_in0_pd_$m = {lut_lo_min[37],lut_lo_min[37:0]};
//: else if(Y_oflow_$m)
//: Xinterp_in0_pd_$m = {lut_lo_max[37],lut_lo_max[37:0]};
//: else
//: Xinterp_in0_pd_$m = {{7{lut2ip_X_data_${m}0[31]}},lut2ip_X_data_${m}0[31:0]};
//: end else
//: Xinterp_in0_pd_$m = 39'd0;
//: end
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: always @(*) begin
//: if(lut2ip_X_sel[$m]) begin
//: if(X_uflow_$m | X_oflow_$m)
//: Xinterp_in1_pd_$m = hit_in1_pd_$m;
//: else
//: Xinterp_in1_pd_$m = {{6{lut2ip_X_data_${m}1[31]}},lut2ip_X_data_${m}1[31:0]};
//: end else if(lut2ip_Y_sel[$m]) begin
//: if(Y_uflow_$m | Y_oflow_$m)
//: Xinterp_in1_pd_$m = hit_in1_pd_$m;
//: else
//: Xinterp_in1_pd_$m = {{6{lut2ip_X_data_${m}1[31]}},lut2ip_X_data_${m}1[31:0]};
//: end else
//: Xinterp_in1_pd_$m = 38'd0;
//: end
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: always @(*) begin
//: if(lut2ip_X_sel[$m] | lut2ip_Y_sel[$m])
//: Xinterp_in_pd_$m = lut2ip_X_data_${m}0_17b[16:0];
//: else
//: Xinterp_in_pd_$m = 17'd0;
//: end
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: always @(*) begin
//: if(lut2ip_X_sel[$m]) begin
//: if(X_uflow_$m)
//: Xinterp_in_scale_$m = le_slope_uflow_scale[16:0];
//: else if(X_oflow_$m)
//: Xinterp_in_scale_$m = le_slope_oflow_scale[16:0];
//: else
//: Xinterp_in_scale_$m = {1'b0,lut2ip_X_info_${m}[15:0]};
//: end else if(lut2ip_Y_sel[$m]) begin
//: if(Y_uflow_$m)
//: Xinterp_in_scale_$m = lo_slope_uflow_scale[16:0];
//: else if(Y_oflow_$m)
//: Xinterp_in_scale_$m = lo_slope_oflow_scale[16:0];
//: else
//: Xinterp_in_scale_$m = {1'b0,lut2ip_X_info_${m}[15:0]};
//: end else
//: Xinterp_in_scale_$m = 17'd0;
//: end
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: always @(*) begin
//: if(lut2ip_X_sel[$m]) begin
//: if(X_uflow_$m)
//: Xinterp_in_shift_$m = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
//: else if(X_oflow_$m)
//: Xinterp_in_shift_$m = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
//: else
//: Xinterp_in_shift_$m = {1'b0,5'd16};
//: end else if(lut2ip_Y_sel[$m]) begin
//: if(Y_uflow_$m)
//: Xinterp_in_shift_$m = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
//: else if(Y_oflow_$m)
//: Xinterp_in_shift_$m = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
//: else
//: Xinterp_in_shift_$m = {1'b0,5'd16};
//: end else
//: Xinterp_in_shift_$m = 6'd0;
//: end
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: assign Xinterp_in_vld[$m] = intp_in_pvld & info_in_rdy
//: );
//: foreach my $i (0..$k-1) {
//: if($i != $m) {
//: print qq(
//: & Xinterp_in_rdy[$i]
//: );
//: }
//: }
//: print qq(
//: ;
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: NV_NVDLA_CDP_DP_INTP_unit u_interp_X$m (
//: .nvdla_core_clk (nvdla_core_clk)
//: ,.nvdla_core_rstn (nvdla_core_rstn)
//: ,.interp_in0_pd (Xinterp_in0_pd_${m}[38:0])
//: ,.interp_in1_pd (Xinterp_in1_pd_${m}[37:0])
//: ,.interp_in_pd (Xinterp_in_pd_${m}[16:0])
//: ,.interp_in_scale (Xinterp_in_scale_${m}[16:0])
//: ,.interp_in_shift (Xinterp_in_shift_${m}[5:0])
//: ,.interp_in_vld (Xinterp_in_vld[$m])
//: ,.interp_out_rdy (Xinterp_out_rdy[$m])
//: ,.interp_in_rdy (Xinterp_in_rdy[$m])
//: ,.interp_out_pd (Xinterp_out_pd_${m}[16:0])
//: ,.interp_out_vld (Xinterp_out_vld[$m])
//: );
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: assign Xinterp_out_rdy[$m] = intp_prdy & info_o_vld
//: );
//: foreach my $i (0..$k-1) {
//: if($i != $m) {
//: print qq(
//: & Xinterp_out_vld[$i]
//: );
//: }
//: }
//: print qq(
//: ;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign X_uflow_0 = lut2ip_X_info_0[16];
assign X_oflow_0 = lut2ip_X_info_0[17];
assign Y_uflow_0 = lut2ip_X_info_0[18];
assign Y_oflow_0 = lut2ip_X_info_0[19];

assign X_uflow_1 = lut2ip_X_info_1[16];
assign X_oflow_1 = lut2ip_X_info_1[17];
assign Y_uflow_1 = lut2ip_X_info_1[18];
assign Y_oflow_1 = lut2ip_X_info_1[19];

assign X_uflow_2 = lut2ip_X_info_2[16];
assign X_oflow_2 = lut2ip_X_info_2[17];
assign Y_uflow_2 = lut2ip_X_info_2[18];
assign Y_oflow_2 = lut2ip_X_info_2[19];

assign X_uflow_3 = lut2ip_X_info_3[16];
assign X_oflow_3 = lut2ip_X_info_3[17];
assign Y_uflow_3 = lut2ip_X_info_3[18];
assign Y_oflow_3 = lut2ip_X_info_3[19];

assign X_uflow_4 = lut2ip_X_info_4[16];
assign X_oflow_4 = lut2ip_X_info_4[17];
assign Y_uflow_4 = lut2ip_X_info_4[18];
assign Y_oflow_4 = lut2ip_X_info_4[19];

assign X_uflow_5 = lut2ip_X_info_5[16];
assign X_oflow_5 = lut2ip_X_info_5[17];
assign Y_uflow_5 = lut2ip_X_info_5[18];
assign Y_oflow_5 = lut2ip_X_info_5[19];

assign X_uflow_6 = lut2ip_X_info_6[16];
assign X_oflow_6 = lut2ip_X_info_6[17];
assign Y_uflow_6 = lut2ip_X_info_6[18];
assign Y_oflow_6 = lut2ip_X_info_6[19];

assign X_uflow_7 = lut2ip_X_info_7[16];
assign X_oflow_7 = lut2ip_X_info_7[17];
assign Y_uflow_7 = lut2ip_X_info_7[18];
assign Y_oflow_7 = lut2ip_X_info_7[19];

always @(*) begin
if(lut2ip_X_sel[0]) begin
if(X_uflow_0)
Xinterp_in0_pd_0 = lut_le_min[38:0];
else if(X_oflow_0)
Xinterp_in0_pd_0 = {lut_le_max[37],lut_le_max[37:0]};
else
Xinterp_in0_pd_0 = {{7{lut2ip_X_data_00[31]}},lut2ip_X_data_00[31:0]};
end else if(lut2ip_Y_sel[0]) begin
if(Y_uflow_0)
Xinterp_in0_pd_0 = {lut_lo_min[37],lut_lo_min[37:0]};
else if(Y_oflow_0)
Xinterp_in0_pd_0 = {lut_lo_max[37],lut_lo_max[37:0]};
else
Xinterp_in0_pd_0 = {{7{lut2ip_X_data_00[31]}},lut2ip_X_data_00[31:0]};
end else
Xinterp_in0_pd_0 = 39'd0;
end

always @(*) begin
if(lut2ip_X_sel[1]) begin
if(X_uflow_1)
Xinterp_in0_pd_1 = lut_le_min[38:0];
else if(X_oflow_1)
Xinterp_in0_pd_1 = {lut_le_max[37],lut_le_max[37:0]};
else
Xinterp_in0_pd_1 = {{7{lut2ip_X_data_10[31]}},lut2ip_X_data_10[31:0]};
end else if(lut2ip_Y_sel[1]) begin
if(Y_uflow_1)
Xinterp_in0_pd_1 = {lut_lo_min[37],lut_lo_min[37:0]};
else if(Y_oflow_1)
Xinterp_in0_pd_1 = {lut_lo_max[37],lut_lo_max[37:0]};
else
Xinterp_in0_pd_1 = {{7{lut2ip_X_data_10[31]}},lut2ip_X_data_10[31:0]};
end else
Xinterp_in0_pd_1 = 39'd0;
end

always @(*) begin
if(lut2ip_X_sel[2]) begin
if(X_uflow_2)
Xinterp_in0_pd_2 = lut_le_min[38:0];
else if(X_oflow_2)
Xinterp_in0_pd_2 = {lut_le_max[37],lut_le_max[37:0]};
else
Xinterp_in0_pd_2 = {{7{lut2ip_X_data_20[31]}},lut2ip_X_data_20[31:0]};
end else if(lut2ip_Y_sel[2]) begin
if(Y_uflow_2)
Xinterp_in0_pd_2 = {lut_lo_min[37],lut_lo_min[37:0]};
else if(Y_oflow_2)
Xinterp_in0_pd_2 = {lut_lo_max[37],lut_lo_max[37:0]};
else
Xinterp_in0_pd_2 = {{7{lut2ip_X_data_20[31]}},lut2ip_X_data_20[31:0]};
end else
Xinterp_in0_pd_2 = 39'd0;
end

always @(*) begin
if(lut2ip_X_sel[3]) begin
if(X_uflow_3)
Xinterp_in0_pd_3 = lut_le_min[38:0];
else if(X_oflow_3)
Xinterp_in0_pd_3 = {lut_le_max[37],lut_le_max[37:0]};
else
Xinterp_in0_pd_3 = {{7{lut2ip_X_data_30[31]}},lut2ip_X_data_30[31:0]};
end else if(lut2ip_Y_sel[3]) begin
if(Y_uflow_3)
Xinterp_in0_pd_3 = {lut_lo_min[37],lut_lo_min[37:0]};
else if(Y_oflow_3)
Xinterp_in0_pd_3 = {lut_lo_max[37],lut_lo_max[37:0]};
else
Xinterp_in0_pd_3 = {{7{lut2ip_X_data_30[31]}},lut2ip_X_data_30[31:0]};
end else
Xinterp_in0_pd_3 = 39'd0;
end

always @(*) begin
if(lut2ip_X_sel[4]) begin
if(X_uflow_4)
Xinterp_in0_pd_4 = lut_le_min[38:0];
else if(X_oflow_4)
Xinterp_in0_pd_4 = {lut_le_max[37],lut_le_max[37:0]};
else
Xinterp_in0_pd_4 = {{7{lut2ip_X_data_40[31]}},lut2ip_X_data_40[31:0]};
end else if(lut2ip_Y_sel[4]) begin
if(Y_uflow_4)
Xinterp_in0_pd_4 = {lut_lo_min[37],lut_lo_min[37:0]};
else if(Y_oflow_4)
Xinterp_in0_pd_4 = {lut_lo_max[37],lut_lo_max[37:0]};
else
Xinterp_in0_pd_4 = {{7{lut2ip_X_data_40[31]}},lut2ip_X_data_40[31:0]};
end else
Xinterp_in0_pd_4 = 39'd0;
end

always @(*) begin
if(lut2ip_X_sel[5]) begin
if(X_uflow_5)
Xinterp_in0_pd_5 = lut_le_min[38:0];
else if(X_oflow_5)
Xinterp_in0_pd_5 = {lut_le_max[37],lut_le_max[37:0]};
else
Xinterp_in0_pd_5 = {{7{lut2ip_X_data_50[31]}},lut2ip_X_data_50[31:0]};
end else if(lut2ip_Y_sel[5]) begin
if(Y_uflow_5)
Xinterp_in0_pd_5 = {lut_lo_min[37],lut_lo_min[37:0]};
else if(Y_oflow_5)
Xinterp_in0_pd_5 = {lut_lo_max[37],lut_lo_max[37:0]};
else
Xinterp_in0_pd_5 = {{7{lut2ip_X_data_50[31]}},lut2ip_X_data_50[31:0]};
end else
Xinterp_in0_pd_5 = 39'd0;
end

always @(*) begin
if(lut2ip_X_sel[6]) begin
if(X_uflow_6)
Xinterp_in0_pd_6 = lut_le_min[38:0];
else if(X_oflow_6)
Xinterp_in0_pd_6 = {lut_le_max[37],lut_le_max[37:0]};
else
Xinterp_in0_pd_6 = {{7{lut2ip_X_data_60[31]}},lut2ip_X_data_60[31:0]};
end else if(lut2ip_Y_sel[6]) begin
if(Y_uflow_6)
Xinterp_in0_pd_6 = {lut_lo_min[37],lut_lo_min[37:0]};
else if(Y_oflow_6)
Xinterp_in0_pd_6 = {lut_lo_max[37],lut_lo_max[37:0]};
else
Xinterp_in0_pd_6 = {{7{lut2ip_X_data_60[31]}},lut2ip_X_data_60[31:0]};
end else
Xinterp_in0_pd_6 = 39'd0;
end

always @(*) begin
if(lut2ip_X_sel[7]) begin
if(X_uflow_7)
Xinterp_in0_pd_7 = lut_le_min[38:0];
else if(X_oflow_7)
Xinterp_in0_pd_7 = {lut_le_max[37],lut_le_max[37:0]};
else
Xinterp_in0_pd_7 = {{7{lut2ip_X_data_70[31]}},lut2ip_X_data_70[31:0]};
end else if(lut2ip_Y_sel[7]) begin
if(Y_uflow_7)
Xinterp_in0_pd_7 = {lut_lo_min[37],lut_lo_min[37:0]};
else if(Y_oflow_7)
Xinterp_in0_pd_7 = {lut_lo_max[37],lut_lo_max[37:0]};
else
Xinterp_in0_pd_7 = {{7{lut2ip_X_data_70[31]}},lut2ip_X_data_70[31:0]};
end else
Xinterp_in0_pd_7 = 39'd0;
end

always @(*) begin
if(lut2ip_X_sel[0]) begin
if(X_uflow_0 | X_oflow_0)
Xinterp_in1_pd_0 = hit_in1_pd_0;
else
Xinterp_in1_pd_0 = {{6{lut2ip_X_data_01[31]}},lut2ip_X_data_01[31:0]};
end else if(lut2ip_Y_sel[0]) begin
if(Y_uflow_0 | Y_oflow_0)
Xinterp_in1_pd_0 = hit_in1_pd_0;
else
Xinterp_in1_pd_0 = {{6{lut2ip_X_data_01[31]}},lut2ip_X_data_01[31:0]};
end else
Xinterp_in1_pd_0 = 38'd0;
end

always @(*) begin
if(lut2ip_X_sel[1]) begin
if(X_uflow_1 | X_oflow_1)
Xinterp_in1_pd_1 = hit_in1_pd_1;
else
Xinterp_in1_pd_1 = {{6{lut2ip_X_data_11[31]}},lut2ip_X_data_11[31:0]};
end else if(lut2ip_Y_sel[1]) begin
if(Y_uflow_1 | Y_oflow_1)
Xinterp_in1_pd_1 = hit_in1_pd_1;
else
Xinterp_in1_pd_1 = {{6{lut2ip_X_data_11[31]}},lut2ip_X_data_11[31:0]};
end else
Xinterp_in1_pd_1 = 38'd0;
end

always @(*) begin
if(lut2ip_X_sel[2]) begin
if(X_uflow_2 | X_oflow_2)
Xinterp_in1_pd_2 = hit_in1_pd_2;
else
Xinterp_in1_pd_2 = {{6{lut2ip_X_data_21[31]}},lut2ip_X_data_21[31:0]};
end else if(lut2ip_Y_sel[2]) begin
if(Y_uflow_2 | Y_oflow_2)
Xinterp_in1_pd_2 = hit_in1_pd_2;
else
Xinterp_in1_pd_2 = {{6{lut2ip_X_data_21[31]}},lut2ip_X_data_21[31:0]};
end else
Xinterp_in1_pd_2 = 38'd0;
end

always @(*) begin
if(lut2ip_X_sel[3]) begin
if(X_uflow_3 | X_oflow_3)
Xinterp_in1_pd_3 = hit_in1_pd_3;
else
Xinterp_in1_pd_3 = {{6{lut2ip_X_data_31[31]}},lut2ip_X_data_31[31:0]};
end else if(lut2ip_Y_sel[3]) begin
if(Y_uflow_3 | Y_oflow_3)
Xinterp_in1_pd_3 = hit_in1_pd_3;
else
Xinterp_in1_pd_3 = {{6{lut2ip_X_data_31[31]}},lut2ip_X_data_31[31:0]};
end else
Xinterp_in1_pd_3 = 38'd0;
end

always @(*) begin
if(lut2ip_X_sel[4]) begin
if(X_uflow_4 | X_oflow_4)
Xinterp_in1_pd_4 = hit_in1_pd_4;
else
Xinterp_in1_pd_4 = {{6{lut2ip_X_data_41[31]}},lut2ip_X_data_41[31:0]};
end else if(lut2ip_Y_sel[4]) begin
if(Y_uflow_4 | Y_oflow_4)
Xinterp_in1_pd_4 = hit_in1_pd_4;
else
Xinterp_in1_pd_4 = {{6{lut2ip_X_data_41[31]}},lut2ip_X_data_41[31:0]};
end else
Xinterp_in1_pd_4 = 38'd0;
end

always @(*) begin
if(lut2ip_X_sel[5]) begin
if(X_uflow_5 | X_oflow_5)
Xinterp_in1_pd_5 = hit_in1_pd_5;
else
Xinterp_in1_pd_5 = {{6{lut2ip_X_data_51[31]}},lut2ip_X_data_51[31:0]};
end else if(lut2ip_Y_sel[5]) begin
if(Y_uflow_5 | Y_oflow_5)
Xinterp_in1_pd_5 = hit_in1_pd_5;
else
Xinterp_in1_pd_5 = {{6{lut2ip_X_data_51[31]}},lut2ip_X_data_51[31:0]};
end else
Xinterp_in1_pd_5 = 38'd0;
end

always @(*) begin
if(lut2ip_X_sel[6]) begin
if(X_uflow_6 | X_oflow_6)
Xinterp_in1_pd_6 = hit_in1_pd_6;
else
Xinterp_in1_pd_6 = {{6{lut2ip_X_data_61[31]}},lut2ip_X_data_61[31:0]};
end else if(lut2ip_Y_sel[6]) begin
if(Y_uflow_6 | Y_oflow_6)
Xinterp_in1_pd_6 = hit_in1_pd_6;
else
Xinterp_in1_pd_6 = {{6{lut2ip_X_data_61[31]}},lut2ip_X_data_61[31:0]};
end else
Xinterp_in1_pd_6 = 38'd0;
end

always @(*) begin
if(lut2ip_X_sel[7]) begin
if(X_uflow_7 | X_oflow_7)
Xinterp_in1_pd_7 = hit_in1_pd_7;
else
Xinterp_in1_pd_7 = {{6{lut2ip_X_data_71[31]}},lut2ip_X_data_71[31:0]};
end else if(lut2ip_Y_sel[7]) begin
if(Y_uflow_7 | Y_oflow_7)
Xinterp_in1_pd_7 = hit_in1_pd_7;
else
Xinterp_in1_pd_7 = {{6{lut2ip_X_data_71[31]}},lut2ip_X_data_71[31:0]};
end else
Xinterp_in1_pd_7 = 38'd0;
end

always @(*) begin
if(lut2ip_X_sel[0] | lut2ip_Y_sel[0])
Xinterp_in_pd_0 = lut2ip_X_data_00_17b[16:0];
else
Xinterp_in_pd_0 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[1] | lut2ip_Y_sel[1])
Xinterp_in_pd_1 = lut2ip_X_data_10_17b[16:0];
else
Xinterp_in_pd_1 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[2] | lut2ip_Y_sel[2])
Xinterp_in_pd_2 = lut2ip_X_data_20_17b[16:0];
else
Xinterp_in_pd_2 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[3] | lut2ip_Y_sel[3])
Xinterp_in_pd_3 = lut2ip_X_data_30_17b[16:0];
else
Xinterp_in_pd_3 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[4] | lut2ip_Y_sel[4])
Xinterp_in_pd_4 = lut2ip_X_data_40_17b[16:0];
else
Xinterp_in_pd_4 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[5] | lut2ip_Y_sel[5])
Xinterp_in_pd_5 = lut2ip_X_data_50_17b[16:0];
else
Xinterp_in_pd_5 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[6] | lut2ip_Y_sel[6])
Xinterp_in_pd_6 = lut2ip_X_data_60_17b[16:0];
else
Xinterp_in_pd_6 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[7] | lut2ip_Y_sel[7])
Xinterp_in_pd_7 = lut2ip_X_data_70_17b[16:0];
else
Xinterp_in_pd_7 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[0]) begin
if(X_uflow_0)
Xinterp_in_scale_0 = le_slope_uflow_scale[16:0];
else if(X_oflow_0)
Xinterp_in_scale_0 = le_slope_oflow_scale[16:0];
else
Xinterp_in_scale_0 = {1'b0,lut2ip_X_info_0[15:0]};
end else if(lut2ip_Y_sel[0]) begin
if(Y_uflow_0)
Xinterp_in_scale_0 = lo_slope_uflow_scale[16:0];
else if(Y_oflow_0)
Xinterp_in_scale_0 = lo_slope_oflow_scale[16:0];
else
Xinterp_in_scale_0 = {1'b0,lut2ip_X_info_0[15:0]};
end else
Xinterp_in_scale_0 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[1]) begin
if(X_uflow_1)
Xinterp_in_scale_1 = le_slope_uflow_scale[16:0];
else if(X_oflow_1)
Xinterp_in_scale_1 = le_slope_oflow_scale[16:0];
else
Xinterp_in_scale_1 = {1'b0,lut2ip_X_info_1[15:0]};
end else if(lut2ip_Y_sel[1]) begin
if(Y_uflow_1)
Xinterp_in_scale_1 = lo_slope_uflow_scale[16:0];
else if(Y_oflow_1)
Xinterp_in_scale_1 = lo_slope_oflow_scale[16:0];
else
Xinterp_in_scale_1 = {1'b0,lut2ip_X_info_1[15:0]};
end else
Xinterp_in_scale_1 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[2]) begin
if(X_uflow_2)
Xinterp_in_scale_2 = le_slope_uflow_scale[16:0];
else if(X_oflow_2)
Xinterp_in_scale_2 = le_slope_oflow_scale[16:0];
else
Xinterp_in_scale_2 = {1'b0,lut2ip_X_info_2[15:0]};
end else if(lut2ip_Y_sel[2]) begin
if(Y_uflow_2)
Xinterp_in_scale_2 = lo_slope_uflow_scale[16:0];
else if(Y_oflow_2)
Xinterp_in_scale_2 = lo_slope_oflow_scale[16:0];
else
Xinterp_in_scale_2 = {1'b0,lut2ip_X_info_2[15:0]};
end else
Xinterp_in_scale_2 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[3]) begin
if(X_uflow_3)
Xinterp_in_scale_3 = le_slope_uflow_scale[16:0];
else if(X_oflow_3)
Xinterp_in_scale_3 = le_slope_oflow_scale[16:0];
else
Xinterp_in_scale_3 = {1'b0,lut2ip_X_info_3[15:0]};
end else if(lut2ip_Y_sel[3]) begin
if(Y_uflow_3)
Xinterp_in_scale_3 = lo_slope_uflow_scale[16:0];
else if(Y_oflow_3)
Xinterp_in_scale_3 = lo_slope_oflow_scale[16:0];
else
Xinterp_in_scale_3 = {1'b0,lut2ip_X_info_3[15:0]};
end else
Xinterp_in_scale_3 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[4]) begin
if(X_uflow_4)
Xinterp_in_scale_4 = le_slope_uflow_scale[16:0];
else if(X_oflow_4)
Xinterp_in_scale_4 = le_slope_oflow_scale[16:0];
else
Xinterp_in_scale_4 = {1'b0,lut2ip_X_info_4[15:0]};
end else if(lut2ip_Y_sel[4]) begin
if(Y_uflow_4)
Xinterp_in_scale_4 = lo_slope_uflow_scale[16:0];
else if(Y_oflow_4)
Xinterp_in_scale_4 = lo_slope_oflow_scale[16:0];
else
Xinterp_in_scale_4 = {1'b0,lut2ip_X_info_4[15:0]};
end else
Xinterp_in_scale_4 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[5]) begin
if(X_uflow_5)
Xinterp_in_scale_5 = le_slope_uflow_scale[16:0];
else if(X_oflow_5)
Xinterp_in_scale_5 = le_slope_oflow_scale[16:0];
else
Xinterp_in_scale_5 = {1'b0,lut2ip_X_info_5[15:0]};
end else if(lut2ip_Y_sel[5]) begin
if(Y_uflow_5)
Xinterp_in_scale_5 = lo_slope_uflow_scale[16:0];
else if(Y_oflow_5)
Xinterp_in_scale_5 = lo_slope_oflow_scale[16:0];
else
Xinterp_in_scale_5 = {1'b0,lut2ip_X_info_5[15:0]};
end else
Xinterp_in_scale_5 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[6]) begin
if(X_uflow_6)
Xinterp_in_scale_6 = le_slope_uflow_scale[16:0];
else if(X_oflow_6)
Xinterp_in_scale_6 = le_slope_oflow_scale[16:0];
else
Xinterp_in_scale_6 = {1'b0,lut2ip_X_info_6[15:0]};
end else if(lut2ip_Y_sel[6]) begin
if(Y_uflow_6)
Xinterp_in_scale_6 = lo_slope_uflow_scale[16:0];
else if(Y_oflow_6)
Xinterp_in_scale_6 = lo_slope_oflow_scale[16:0];
else
Xinterp_in_scale_6 = {1'b0,lut2ip_X_info_6[15:0]};
end else
Xinterp_in_scale_6 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[7]) begin
if(X_uflow_7)
Xinterp_in_scale_7 = le_slope_uflow_scale[16:0];
else if(X_oflow_7)
Xinterp_in_scale_7 = le_slope_oflow_scale[16:0];
else
Xinterp_in_scale_7 = {1'b0,lut2ip_X_info_7[15:0]};
end else if(lut2ip_Y_sel[7]) begin
if(Y_uflow_7)
Xinterp_in_scale_7 = lo_slope_uflow_scale[16:0];
else if(Y_oflow_7)
Xinterp_in_scale_7 = lo_slope_oflow_scale[16:0];
else
Xinterp_in_scale_7 = {1'b0,lut2ip_X_info_7[15:0]};
end else
Xinterp_in_scale_7 = 17'd0;
end

always @(*) begin
if(lut2ip_X_sel[0]) begin
if(X_uflow_0)
Xinterp_in_shift_0 = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
else if(X_oflow_0)
Xinterp_in_shift_0 = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_0 = {1'b0,5'd16};
end else if(lut2ip_Y_sel[0]) begin
if(Y_uflow_0)
Xinterp_in_shift_0 = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
else if(Y_oflow_0)
Xinterp_in_shift_0 = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_0 = {1'b0,5'd16};
end else
Xinterp_in_shift_0 = 6'd0;
end

always @(*) begin
if(lut2ip_X_sel[1]) begin
if(X_uflow_1)
Xinterp_in_shift_1 = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
else if(X_oflow_1)
Xinterp_in_shift_1 = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_1 = {1'b0,5'd16};
end else if(lut2ip_Y_sel[1]) begin
if(Y_uflow_1)
Xinterp_in_shift_1 = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
else if(Y_oflow_1)
Xinterp_in_shift_1 = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_1 = {1'b0,5'd16};
end else
Xinterp_in_shift_1 = 6'd0;
end

always @(*) begin
if(lut2ip_X_sel[2]) begin
if(X_uflow_2)
Xinterp_in_shift_2 = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
else if(X_oflow_2)
Xinterp_in_shift_2 = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_2 = {1'b0,5'd16};
end else if(lut2ip_Y_sel[2]) begin
if(Y_uflow_2)
Xinterp_in_shift_2 = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
else if(Y_oflow_2)
Xinterp_in_shift_2 = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_2 = {1'b0,5'd16};
end else
Xinterp_in_shift_2 = 6'd0;
end

always @(*) begin
if(lut2ip_X_sel[3]) begin
if(X_uflow_3)
Xinterp_in_shift_3 = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
else if(X_oflow_3)
Xinterp_in_shift_3 = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_3 = {1'b0,5'd16};
end else if(lut2ip_Y_sel[3]) begin
if(Y_uflow_3)
Xinterp_in_shift_3 = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
else if(Y_oflow_3)
Xinterp_in_shift_3 = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_3 = {1'b0,5'd16};
end else
Xinterp_in_shift_3 = 6'd0;
end

always @(*) begin
if(lut2ip_X_sel[4]) begin
if(X_uflow_4)
Xinterp_in_shift_4 = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
else if(X_oflow_4)
Xinterp_in_shift_4 = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_4 = {1'b0,5'd16};
end else if(lut2ip_Y_sel[4]) begin
if(Y_uflow_4)
Xinterp_in_shift_4 = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
else if(Y_oflow_4)
Xinterp_in_shift_4 = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_4 = {1'b0,5'd16};
end else
Xinterp_in_shift_4 = 6'd0;
end

always @(*) begin
if(lut2ip_X_sel[5]) begin
if(X_uflow_5)
Xinterp_in_shift_5 = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
else if(X_oflow_5)
Xinterp_in_shift_5 = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_5 = {1'b0,5'd16};
end else if(lut2ip_Y_sel[5]) begin
if(Y_uflow_5)
Xinterp_in_shift_5 = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
else if(Y_oflow_5)
Xinterp_in_shift_5 = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_5 = {1'b0,5'd16};
end else
Xinterp_in_shift_5 = 6'd0;
end

always @(*) begin
if(lut2ip_X_sel[6]) begin
if(X_uflow_6)
Xinterp_in_shift_6 = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
else if(X_oflow_6)
Xinterp_in_shift_6 = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_6 = {1'b0,5'd16};
end else if(lut2ip_Y_sel[6]) begin
if(Y_uflow_6)
Xinterp_in_shift_6 = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
else if(Y_oflow_6)
Xinterp_in_shift_6 = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_6 = {1'b0,5'd16};
end else
Xinterp_in_shift_6 = 6'd0;
end

always @(*) begin
if(lut2ip_X_sel[7]) begin
if(X_uflow_7)
Xinterp_in_shift_7 = {{1{reg2dp_lut_le_slope_uflow_shift_sync[4]}}, reg2dp_lut_le_slope_uflow_shift_sync[4:0]};
else if(X_oflow_7)
Xinterp_in_shift_7 = {{1{reg2dp_lut_le_slope_oflow_shift_sync[4]}}, reg2dp_lut_le_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_7 = {1'b0,5'd16};
end else if(lut2ip_Y_sel[7]) begin
if(Y_uflow_7)
Xinterp_in_shift_7 = {{1{reg2dp_lut_lo_slope_uflow_shift_sync[4]}}, reg2dp_lut_lo_slope_uflow_shift_sync[4:0]};
else if(Y_oflow_7)
Xinterp_in_shift_7 = {{1{reg2dp_lut_lo_slope_oflow_shift_sync[4]}}, reg2dp_lut_lo_slope_oflow_shift_sync[4:0]};
else
Xinterp_in_shift_7 = {1'b0,5'd16};
end else
Xinterp_in_shift_7 = 6'd0;
end

assign Xinterp_in_vld[0] = intp_in_pvld & info_in_rdy

& Xinterp_in_rdy[1]

& Xinterp_in_rdy[2]

& Xinterp_in_rdy[3]

& Xinterp_in_rdy[4]

& Xinterp_in_rdy[5]

& Xinterp_in_rdy[6]

& Xinterp_in_rdy[7]

;

assign Xinterp_in_vld[1] = intp_in_pvld & info_in_rdy

& Xinterp_in_rdy[0]

& Xinterp_in_rdy[2]

& Xinterp_in_rdy[3]

& Xinterp_in_rdy[4]

& Xinterp_in_rdy[5]

& Xinterp_in_rdy[6]

& Xinterp_in_rdy[7]

;

assign Xinterp_in_vld[2] = intp_in_pvld & info_in_rdy

& Xinterp_in_rdy[0]

& Xinterp_in_rdy[1]

& Xinterp_in_rdy[3]

& Xinterp_in_rdy[4]

& Xinterp_in_rdy[5]

& Xinterp_in_rdy[6]

& Xinterp_in_rdy[7]

;

assign Xinterp_in_vld[3] = intp_in_pvld & info_in_rdy

& Xinterp_in_rdy[0]

& Xinterp_in_rdy[1]

& Xinterp_in_rdy[2]

& Xinterp_in_rdy[4]

& Xinterp_in_rdy[5]

& Xinterp_in_rdy[6]

& Xinterp_in_rdy[7]

;

assign Xinterp_in_vld[4] = intp_in_pvld & info_in_rdy

& Xinterp_in_rdy[0]

& Xinterp_in_rdy[1]

& Xinterp_in_rdy[2]

& Xinterp_in_rdy[3]

& Xinterp_in_rdy[5]

& Xinterp_in_rdy[6]

& Xinterp_in_rdy[7]

;

assign Xinterp_in_vld[5] = intp_in_pvld & info_in_rdy

& Xinterp_in_rdy[0]

& Xinterp_in_rdy[1]

& Xinterp_in_rdy[2]

& Xinterp_in_rdy[3]

& Xinterp_in_rdy[4]

& Xinterp_in_rdy[6]

& Xinterp_in_rdy[7]

;

assign Xinterp_in_vld[6] = intp_in_pvld & info_in_rdy

& Xinterp_in_rdy[0]

& Xinterp_in_rdy[1]

& Xinterp_in_rdy[2]

& Xinterp_in_rdy[3]

& Xinterp_in_rdy[4]

& Xinterp_in_rdy[5]

& Xinterp_in_rdy[7]

;

assign Xinterp_in_vld[7] = intp_in_pvld & info_in_rdy

& Xinterp_in_rdy[0]

& Xinterp_in_rdy[1]

& Xinterp_in_rdy[2]

& Xinterp_in_rdy[3]

& Xinterp_in_rdy[4]

& Xinterp_in_rdy[5]

& Xinterp_in_rdy[6]

;

NV_NVDLA_CDP_DP_INTP_unit u_interp_X0 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.interp_in0_pd (Xinterp_in0_pd_0[38:0])
,.interp_in1_pd (Xinterp_in1_pd_0[37:0])
,.interp_in_pd (Xinterp_in_pd_0[16:0])
,.interp_in_scale (Xinterp_in_scale_0[16:0])
,.interp_in_shift (Xinterp_in_shift_0[5:0])
,.interp_in_vld (Xinterp_in_vld[0])
,.interp_out_rdy (Xinterp_out_rdy[0])
,.interp_in_rdy (Xinterp_in_rdy[0])
,.interp_out_pd (Xinterp_out_pd_0[16:0])
,.interp_out_vld (Xinterp_out_vld[0])
);

NV_NVDLA_CDP_DP_INTP_unit u_interp_X1 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.interp_in0_pd (Xinterp_in0_pd_1[38:0])
,.interp_in1_pd (Xinterp_in1_pd_1[37:0])
,.interp_in_pd (Xinterp_in_pd_1[16:0])
,.interp_in_scale (Xinterp_in_scale_1[16:0])
,.interp_in_shift (Xinterp_in_shift_1[5:0])
,.interp_in_vld (Xinterp_in_vld[1])
,.interp_out_rdy (Xinterp_out_rdy[1])
,.interp_in_rdy (Xinterp_in_rdy[1])
,.interp_out_pd (Xinterp_out_pd_1[16:0])
,.interp_out_vld (Xinterp_out_vld[1])
);

NV_NVDLA_CDP_DP_INTP_unit u_interp_X2 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.interp_in0_pd (Xinterp_in0_pd_2[38:0])
,.interp_in1_pd (Xinterp_in1_pd_2[37:0])
,.interp_in_pd (Xinterp_in_pd_2[16:0])
,.interp_in_scale (Xinterp_in_scale_2[16:0])
,.interp_in_shift (Xinterp_in_shift_2[5:0])
,.interp_in_vld (Xinterp_in_vld[2])
,.interp_out_rdy (Xinterp_out_rdy[2])
,.interp_in_rdy (Xinterp_in_rdy[2])
,.interp_out_pd (Xinterp_out_pd_2[16:0])
,.interp_out_vld (Xinterp_out_vld[2])
);

NV_NVDLA_CDP_DP_INTP_unit u_interp_X3 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.interp_in0_pd (Xinterp_in0_pd_3[38:0])
,.interp_in1_pd (Xinterp_in1_pd_3[37:0])
,.interp_in_pd (Xinterp_in_pd_3[16:0])
,.interp_in_scale (Xinterp_in_scale_3[16:0])
,.interp_in_shift (Xinterp_in_shift_3[5:0])
,.interp_in_vld (Xinterp_in_vld[3])
,.interp_out_rdy (Xinterp_out_rdy[3])
,.interp_in_rdy (Xinterp_in_rdy[3])
,.interp_out_pd (Xinterp_out_pd_3[16:0])
,.interp_out_vld (Xinterp_out_vld[3])
);

NV_NVDLA_CDP_DP_INTP_unit u_interp_X4 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.interp_in0_pd (Xinterp_in0_pd_4[38:0])
,.interp_in1_pd (Xinterp_in1_pd_4[37:0])
,.interp_in_pd (Xinterp_in_pd_4[16:0])
,.interp_in_scale (Xinterp_in_scale_4[16:0])
,.interp_in_shift (Xinterp_in_shift_4[5:0])
,.interp_in_vld (Xinterp_in_vld[4])
,.interp_out_rdy (Xinterp_out_rdy[4])
,.interp_in_rdy (Xinterp_in_rdy[4])
,.interp_out_pd (Xinterp_out_pd_4[16:0])
,.interp_out_vld (Xinterp_out_vld[4])
);

NV_NVDLA_CDP_DP_INTP_unit u_interp_X5 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.interp_in0_pd (Xinterp_in0_pd_5[38:0])
,.interp_in1_pd (Xinterp_in1_pd_5[37:0])
,.interp_in_pd (Xinterp_in_pd_5[16:0])
,.interp_in_scale (Xinterp_in_scale_5[16:0])
,.interp_in_shift (Xinterp_in_shift_5[5:0])
,.interp_in_vld (Xinterp_in_vld[5])
,.interp_out_rdy (Xinterp_out_rdy[5])
,.interp_in_rdy (Xinterp_in_rdy[5])
,.interp_out_pd (Xinterp_out_pd_5[16:0])
,.interp_out_vld (Xinterp_out_vld[5])
);

NV_NVDLA_CDP_DP_INTP_unit u_interp_X6 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.interp_in0_pd (Xinterp_in0_pd_6[38:0])
,.interp_in1_pd (Xinterp_in1_pd_6[37:0])
,.interp_in_pd (Xinterp_in_pd_6[16:0])
,.interp_in_scale (Xinterp_in_scale_6[16:0])
,.interp_in_shift (Xinterp_in_shift_6[5:0])
,.interp_in_vld (Xinterp_in_vld[6])
,.interp_out_rdy (Xinterp_out_rdy[6])
,.interp_in_rdy (Xinterp_in_rdy[6])
,.interp_out_pd (Xinterp_out_pd_6[16:0])
,.interp_out_vld (Xinterp_out_vld[6])
);

NV_NVDLA_CDP_DP_INTP_unit u_interp_X7 (
.nvdla_core_clk (nvdla_core_clk)
,.nvdla_core_rstn (nvdla_core_rstn)
,.interp_in0_pd (Xinterp_in0_pd_7[38:0])
,.interp_in1_pd (Xinterp_in1_pd_7[37:0])
,.interp_in_pd (Xinterp_in_pd_7[16:0])
,.interp_in_scale (Xinterp_in_scale_7[16:0])
,.interp_in_shift (Xinterp_in_shift_7[5:0])
,.interp_in_vld (Xinterp_in_vld[7])
,.interp_out_rdy (Xinterp_out_rdy[7])
,.interp_in_rdy (Xinterp_in_rdy[7])
,.interp_out_pd (Xinterp_out_pd_7[16:0])
,.interp_out_vld (Xinterp_out_vld[7])
);

assign Xinterp_out_rdy[0] = intp_prdy & info_o_vld

& Xinterp_out_vld[1]

& Xinterp_out_vld[2]

& Xinterp_out_vld[3]

& Xinterp_out_vld[4]

& Xinterp_out_vld[5]

& Xinterp_out_vld[6]

& Xinterp_out_vld[7]

;

assign Xinterp_out_rdy[1] = intp_prdy & info_o_vld

& Xinterp_out_vld[0]

& Xinterp_out_vld[2]

& Xinterp_out_vld[3]

& Xinterp_out_vld[4]

& Xinterp_out_vld[5]

& Xinterp_out_vld[6]

& Xinterp_out_vld[7]

;

assign Xinterp_out_rdy[2] = intp_prdy & info_o_vld

& Xinterp_out_vld[0]

& Xinterp_out_vld[1]

& Xinterp_out_vld[3]

& Xinterp_out_vld[4]

& Xinterp_out_vld[5]

& Xinterp_out_vld[6]

& Xinterp_out_vld[7]

;

assign Xinterp_out_rdy[3] = intp_prdy & info_o_vld

& Xinterp_out_vld[0]

& Xinterp_out_vld[1]

& Xinterp_out_vld[2]

& Xinterp_out_vld[4]

& Xinterp_out_vld[5]

& Xinterp_out_vld[6]

& Xinterp_out_vld[7]

;

assign Xinterp_out_rdy[4] = intp_prdy & info_o_vld

& Xinterp_out_vld[0]

& Xinterp_out_vld[1]

& Xinterp_out_vld[2]

& Xinterp_out_vld[3]

& Xinterp_out_vld[5]

& Xinterp_out_vld[6]

& Xinterp_out_vld[7]

;

assign Xinterp_out_rdy[5] = intp_prdy & info_o_vld

& Xinterp_out_vld[0]

& Xinterp_out_vld[1]

& Xinterp_out_vld[2]

& Xinterp_out_vld[3]

& Xinterp_out_vld[4]

& Xinterp_out_vld[6]

& Xinterp_out_vld[7]

;

assign Xinterp_out_rdy[6] = intp_prdy & info_o_vld

& Xinterp_out_vld[0]

& Xinterp_out_vld[1]

& Xinterp_out_vld[2]

& Xinterp_out_vld[3]

& Xinterp_out_vld[4]

& Xinterp_out_vld[5]

& Xinterp_out_vld[7]

;

assign Xinterp_out_rdy[7] = intp_prdy & info_o_vld

& Xinterp_out_vld[0]

& Xinterp_out_vld[1]

& Xinterp_out_vld[2]

& Xinterp_out_vld[3]

& Xinterp_out_vld[4]

& Xinterp_out_vld[5]

& Xinterp_out_vld[6]

;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign info_o_rdy = intp_prdy & ((&Xinterp_out_vld));
///////////////////////////////////////////////
//process for normal uflow/oflow info
assign info_in_vld = intp_in_pvld & (&Xinterp_in_rdy);
assign info_Xin_pd = {
//: my $k = 8;
//: if($k > 1) {
//: foreach my $m (0..$k-2) {
//: my $i = $k -$m - 1;
//: print qq(
//: lut2ip_X_info_${i}[17:16],
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

lut2ip_X_info_7[17:16],

lut2ip_X_info_6[17:16],

lut2ip_X_info_5[17:16],

lut2ip_X_info_4[17:16],

lut2ip_X_info_3[17:16],

lut2ip_X_info_2[17:16],

lut2ip_X_info_1[17:16],

//| eperl: generated_end (DO NOT EDIT ABOVE)
        lut2ip_X_info_0[17:16]};
assign info_Yin_pd = {
//: my $k = 8;
//: if($k > 1) {
//: foreach my $m (0..$k-2) {
//: my $i = $k -$m - 1;
//: print qq(
//: lut2ip_X_info_${i}[19:18],
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

lut2ip_X_info_7[19:18],

lut2ip_X_info_6[19:18],

lut2ip_X_info_5[19:18],

lut2ip_X_info_4[19:18],

lut2ip_X_info_3[19:18],

lut2ip_X_info_2[19:18],

lut2ip_X_info_1[19:18],

//| eperl: generated_end (DO NOT EDIT ABOVE)
            lut2ip_X_info_0[19:18]};
assign dat_info_in = {info_Yin_pd,info_Xin_pd};
assign info_in_pd = dat_info_in;
//: my $s = 8*4;
//: print " NV_NVDLA_CDP_DP_intpinfo_fifo_20x${s} u_intpinfo_sync_fifo (    \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
 NV_NVDLA_CDP_DP_intpinfo_fifo_20x32 u_intpinfo_sync_fifo (    

//| eperl: generated_end (DO NOT EDIT ABOVE)
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.intpinfo_wr_prdy (info_in_rdy) //|> w
  ,.intpinfo_wr_pvld (info_in_vld) //|< w
  ,.intpinfo_wr_pd (info_in_pd) //|< w
  ,.intpinfo_rd_prdy (info_o_rdy) //|< w
  ,.intpinfo_rd_pvld (info_o_vld) //|> w
  ,.intpinfo_rd_pd (info_o_pd) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  );
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: assign X_info_$m = info_o_pd[${m}*2+1:${m}*2];
//: assign Y_info_$m = info_o_pd[${k}*2+${m}*2+1:${k}*2+${m}*2];
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign X_info_0 = info_o_pd[0*2+1:0*2];
assign Y_info_0 = info_o_pd[8*2+0*2+1:8*2+0*2];

assign X_info_1 = info_o_pd[1*2+1:1*2];
assign Y_info_1 = info_o_pd[8*2+1*2+1:8*2+1*2];

assign X_info_2 = info_o_pd[2*2+1:2*2];
assign Y_info_2 = info_o_pd[8*2+2*2+1:8*2+2*2];

assign X_info_3 = info_o_pd[3*2+1:3*2];
assign Y_info_3 = info_o_pd[8*2+3*2+1:8*2+3*2];

assign X_info_4 = info_o_pd[4*2+1:4*2];
assign Y_info_4 = info_o_pd[8*2+4*2+1:8*2+4*2];

assign X_info_5 = info_o_pd[5*2+1:5*2];
assign Y_info_5 = info_o_pd[8*2+5*2+1:8*2+5*2];

assign X_info_6 = info_o_pd[6*2+1:6*2];
assign Y_info_6 = info_o_pd[8*2+6*2+1:8*2+6*2];

assign X_info_7 = info_o_pd[7*2+1:7*2];
assign Y_info_7 = info_o_pd[8*2+7*2+1:8*2+7*2];

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////
assign intp_pvld = info_o_vld & ((&Xinterp_out_vld));
assign intp_prdy = ~intp_pvld_d | intp_prdy_d;
////////
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    intp_pvld_d <= 1'b0;
  end else begin
    if(intp_pvld)
        intp_pvld_d <= 1'b1;
    else if(intp_prdy_d)
        intp_pvld_d <= 1'b0;
  end
end
//assign intp_prdy_d = ip2mul_prdy;
assign ip2mul_pvld = intp_pvld_d;
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn) begin
//: ip2mul_pd_$m <= {17{1'b0}};
//: end else if(intp_pvld & intp_prdy) begin
//: ip2mul_pd_$m <= Xinterp_out_pd_$m;
//: end
//: end
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
ip2mul_pd_0 <= {17{1'b0}};
end else if(intp_pvld & intp_prdy) begin
ip2mul_pd_0 <= Xinterp_out_pd_0;
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
ip2mul_pd_1 <= {17{1'b0}};
end else if(intp_pvld & intp_prdy) begin
ip2mul_pd_1 <= Xinterp_out_pd_1;
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
ip2mul_pd_2 <= {17{1'b0}};
end else if(intp_pvld & intp_prdy) begin
ip2mul_pd_2 <= Xinterp_out_pd_2;
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
ip2mul_pd_3 <= {17{1'b0}};
end else if(intp_pvld & intp_prdy) begin
ip2mul_pd_3 <= Xinterp_out_pd_3;
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
ip2mul_pd_4 <= {17{1'b0}};
end else if(intp_pvld & intp_prdy) begin
ip2mul_pd_4 <= Xinterp_out_pd_4;
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
ip2mul_pd_5 <= {17{1'b0}};
end else if(intp_pvld & intp_prdy) begin
ip2mul_pd_5 <= Xinterp_out_pd_5;
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
ip2mul_pd_6 <= {17{1'b0}};
end else if(intp_pvld & intp_prdy) begin
ip2mul_pd_6 <= Xinterp_out_pd_6;
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
ip2mul_pd_7 <= {17{1'b0}};
end else if(intp_pvld & intp_prdy) begin
ip2mul_pd_7 <= Xinterp_out_pd_7;
end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
////////////////////////////////////////////////
//LUT perf counters
////////////////////////////////////////////////
assign layer_done = dp2reg_done;
//: my $k = 8;
//: foreach my $i (0..$k-1) {
//: print qq(
//: always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//: if (!nvdla_core_rstn) begin
//: both_hybrid_flag[$i] <= 1'b0;
//: both_of_flag[$i] <= 1'b0;
//: both_uf_flag[$i] <= 1'b0;
//: only_le_hit[$i] <= 1'b0;
//: only_lo_hit[$i] <= 1'b0;
//: end else begin
//: if(intp_pvld & intp_prdy) begin
//: both_hybrid_flag[$i] <= ({X_info_$i,Y_info_$i} == 4'b0000) | ({X_info_$i,Y_info_$i} == 4'b0110) | ({X_info_$i,Y_info_$i} == 4'b1001);
//: both_of_flag[$i] <= ({X_info_$i,Y_info_$i} == 4'b1010);
//: both_uf_flag[$i] <= ({X_info_$i,Y_info_$i} == 4'b0101);
//: only_le_hit[$i] <= ({X_info_$i,Y_info_$i} == 4'b0001) | ({X_info_$i,Y_info_$i} == 4'b0010);
//: only_lo_hit[$i] <= ({X_info_$i,Y_info_$i} == 4'b0100) | ({X_info_$i,Y_info_$i} == 4'b1000);
//: end
//: end
//: end
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
both_hybrid_flag[0] <= 1'b0;
both_of_flag[0] <= 1'b0;
both_uf_flag[0] <= 1'b0;
only_le_hit[0] <= 1'b0;
only_lo_hit[0] <= 1'b0;
end else begin
if(intp_pvld & intp_prdy) begin
both_hybrid_flag[0] <= ({X_info_0,Y_info_0} == 4'b0000) | ({X_info_0,Y_info_0} == 4'b0110) | ({X_info_0,Y_info_0} == 4'b1001);
both_of_flag[0] <= ({X_info_0,Y_info_0} == 4'b1010);
both_uf_flag[0] <= ({X_info_0,Y_info_0} == 4'b0101);
only_le_hit[0] <= ({X_info_0,Y_info_0} == 4'b0001) | ({X_info_0,Y_info_0} == 4'b0010);
only_lo_hit[0] <= ({X_info_0,Y_info_0} == 4'b0100) | ({X_info_0,Y_info_0} == 4'b1000);
end
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
both_hybrid_flag[1] <= 1'b0;
both_of_flag[1] <= 1'b0;
both_uf_flag[1] <= 1'b0;
only_le_hit[1] <= 1'b0;
only_lo_hit[1] <= 1'b0;
end else begin
if(intp_pvld & intp_prdy) begin
both_hybrid_flag[1] <= ({X_info_1,Y_info_1} == 4'b0000) | ({X_info_1,Y_info_1} == 4'b0110) | ({X_info_1,Y_info_1} == 4'b1001);
both_of_flag[1] <= ({X_info_1,Y_info_1} == 4'b1010);
both_uf_flag[1] <= ({X_info_1,Y_info_1} == 4'b0101);
only_le_hit[1] <= ({X_info_1,Y_info_1} == 4'b0001) | ({X_info_1,Y_info_1} == 4'b0010);
only_lo_hit[1] <= ({X_info_1,Y_info_1} == 4'b0100) | ({X_info_1,Y_info_1} == 4'b1000);
end
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
both_hybrid_flag[2] <= 1'b0;
both_of_flag[2] <= 1'b0;
both_uf_flag[2] <= 1'b0;
only_le_hit[2] <= 1'b0;
only_lo_hit[2] <= 1'b0;
end else begin
if(intp_pvld & intp_prdy) begin
both_hybrid_flag[2] <= ({X_info_2,Y_info_2} == 4'b0000) | ({X_info_2,Y_info_2} == 4'b0110) | ({X_info_2,Y_info_2} == 4'b1001);
both_of_flag[2] <= ({X_info_2,Y_info_2} == 4'b1010);
both_uf_flag[2] <= ({X_info_2,Y_info_2} == 4'b0101);
only_le_hit[2] <= ({X_info_2,Y_info_2} == 4'b0001) | ({X_info_2,Y_info_2} == 4'b0010);
only_lo_hit[2] <= ({X_info_2,Y_info_2} == 4'b0100) | ({X_info_2,Y_info_2} == 4'b1000);
end
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
both_hybrid_flag[3] <= 1'b0;
both_of_flag[3] <= 1'b0;
both_uf_flag[3] <= 1'b0;
only_le_hit[3] <= 1'b0;
only_lo_hit[3] <= 1'b0;
end else begin
if(intp_pvld & intp_prdy) begin
both_hybrid_flag[3] <= ({X_info_3,Y_info_3} == 4'b0000) | ({X_info_3,Y_info_3} == 4'b0110) | ({X_info_3,Y_info_3} == 4'b1001);
both_of_flag[3] <= ({X_info_3,Y_info_3} == 4'b1010);
both_uf_flag[3] <= ({X_info_3,Y_info_3} == 4'b0101);
only_le_hit[3] <= ({X_info_3,Y_info_3} == 4'b0001) | ({X_info_3,Y_info_3} == 4'b0010);
only_lo_hit[3] <= ({X_info_3,Y_info_3} == 4'b0100) | ({X_info_3,Y_info_3} == 4'b1000);
end
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
both_hybrid_flag[4] <= 1'b0;
both_of_flag[4] <= 1'b0;
both_uf_flag[4] <= 1'b0;
only_le_hit[4] <= 1'b0;
only_lo_hit[4] <= 1'b0;
end else begin
if(intp_pvld & intp_prdy) begin
both_hybrid_flag[4] <= ({X_info_4,Y_info_4} == 4'b0000) | ({X_info_4,Y_info_4} == 4'b0110) | ({X_info_4,Y_info_4} == 4'b1001);
both_of_flag[4] <= ({X_info_4,Y_info_4} == 4'b1010);
both_uf_flag[4] <= ({X_info_4,Y_info_4} == 4'b0101);
only_le_hit[4] <= ({X_info_4,Y_info_4} == 4'b0001) | ({X_info_4,Y_info_4} == 4'b0010);
only_lo_hit[4] <= ({X_info_4,Y_info_4} == 4'b0100) | ({X_info_4,Y_info_4} == 4'b1000);
end
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
both_hybrid_flag[5] <= 1'b0;
both_of_flag[5] <= 1'b0;
both_uf_flag[5] <= 1'b0;
only_le_hit[5] <= 1'b0;
only_lo_hit[5] <= 1'b0;
end else begin
if(intp_pvld & intp_prdy) begin
both_hybrid_flag[5] <= ({X_info_5,Y_info_5} == 4'b0000) | ({X_info_5,Y_info_5} == 4'b0110) | ({X_info_5,Y_info_5} == 4'b1001);
both_of_flag[5] <= ({X_info_5,Y_info_5} == 4'b1010);
both_uf_flag[5] <= ({X_info_5,Y_info_5} == 4'b0101);
only_le_hit[5] <= ({X_info_5,Y_info_5} == 4'b0001) | ({X_info_5,Y_info_5} == 4'b0010);
only_lo_hit[5] <= ({X_info_5,Y_info_5} == 4'b0100) | ({X_info_5,Y_info_5} == 4'b1000);
end
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
both_hybrid_flag[6] <= 1'b0;
both_of_flag[6] <= 1'b0;
both_uf_flag[6] <= 1'b0;
only_le_hit[6] <= 1'b0;
only_lo_hit[6] <= 1'b0;
end else begin
if(intp_pvld & intp_prdy) begin
both_hybrid_flag[6] <= ({X_info_6,Y_info_6} == 4'b0000) | ({X_info_6,Y_info_6} == 4'b0110) | ({X_info_6,Y_info_6} == 4'b1001);
both_of_flag[6] <= ({X_info_6,Y_info_6} == 4'b1010);
both_uf_flag[6] <= ({X_info_6,Y_info_6} == 4'b0101);
only_le_hit[6] <= ({X_info_6,Y_info_6} == 4'b0001) | ({X_info_6,Y_info_6} == 4'b0010);
only_lo_hit[6] <= ({X_info_6,Y_info_6} == 4'b0100) | ({X_info_6,Y_info_6} == 4'b1000);
end
end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
if (!nvdla_core_rstn) begin
both_hybrid_flag[7] <= 1'b0;
both_of_flag[7] <= 1'b0;
both_uf_flag[7] <= 1'b0;
only_le_hit[7] <= 1'b0;
only_lo_hit[7] <= 1'b0;
end else begin
if(intp_pvld & intp_prdy) begin
both_hybrid_flag[7] <= ({X_info_7,Y_info_7} == 4'b0000) | ({X_info_7,Y_info_7} == 4'b0110) | ({X_info_7,Y_info_7} == 4'b1001);
both_of_flag[7] <= ({X_info_7,Y_info_7} == 4'b1010);
both_uf_flag[7] <= ({X_info_7,Y_info_7} == 4'b0101);
only_le_hit[7] <= ({X_info_7,Y_info_7} == 4'b0001) | ({X_info_7,Y_info_7} == 4'b0010);
only_lo_hit[7] <= ({X_info_7,Y_info_7} == 4'b0100) | ({X_info_7,Y_info_7} == 4'b1000);
end
end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
function [3:0] fun_bit_sum_8;
  input [7:0] idata;
  reg [3:0] ocnt;
  begin
    ocnt =
        (( idata[0]
      + idata[1]
      + idata[2] )
      + ( idata[3]
      + idata[4]
      + idata[5] ))
      + ( idata[6]
      + idata[7] ) ;
    fun_bit_sum_8 = ocnt;
  end
endfunction
//: my $tp = 8;
//: if($tp ==8) {
//: print qq(
//: assign both_hybrid_ele = fun_bit_sum_8({both_hybrid_flag});
//: assign both_of_ele = fun_bit_sum_8({both_of_flag});
//: assign both_uf_ele = fun_bit_sum_8({both_uf_flag});
//: assign only_le_hit_ele = fun_bit_sum_8({only_le_hit});
//: assign only_lo_hit_ele = fun_bit_sum_8({only_lo_hit});
//: );
//: } else {
//: print qq(
//: assign both_hybrid_ele = fun_bit_sum_8({{(8-${tp}){1'b0}},both_hybrid_flag});
//: assign both_of_ele = fun_bit_sum_8({{(8-${tp}){1'b0}},both_of_flag});
//: assign both_uf_ele = fun_bit_sum_8({{(8-${tp}){1'b0}},both_uf_flag});
//: assign only_le_hit_ele = fun_bit_sum_8({{(8-${tp}){1'b0}},only_le_hit});
//: assign only_lo_hit_ele = fun_bit_sum_8({{(8-${tp}){1'b0}},only_lo_hit});
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign both_hybrid_ele = fun_bit_sum_8({both_hybrid_flag});
assign both_of_ele = fun_bit_sum_8({both_of_flag});
assign both_uf_ele = fun_bit_sum_8({both_uf_flag});
assign only_le_hit_ele = fun_bit_sum_8({only_le_hit});
assign only_lo_hit_ele = fun_bit_sum_8({only_lo_hit});

//| eperl: generated_end (DO NOT EDIT ABOVE)
//assign both_hybrid_ele = fun_bit_sum_8({{(8-8){1'b0}},both_hybrid_flag});
//assign both_of_ele = fun_bit_sum_8({{(8-8){1'b0}},both_of_flag});
//assign both_uf_ele = fun_bit_sum_8({{(8-8){1'b0}},both_uf_flag});
//assign only_le_hit_ele = fun_bit_sum_8({{(8-8){1'b0}},only_le_hit});
//assign only_lo_hit_ele = fun_bit_sum_8({{(8-8){1'b0}},only_lo_hit});
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    both_hybrid_counter <= {32{1'b0}};
    both_of_counter <= {32{1'b0}};
    both_uf_counter <= {32{1'b0}};
    only_le_hit_counter <= {32{1'b0}};
    only_lo_hit_counter <= {32{1'b0}};
  end else begin
    if(layer_done) begin
        both_hybrid_counter <= 32'd0;
        both_of_counter <= 32'd0;
        both_uf_counter <= 32'd0;
        only_le_hit_counter <= 32'd0;
        only_lo_hit_counter <= 32'd0;
    end else if(intp_pvld_d & intp_prdy_d) begin
        both_hybrid_counter <= mon_both_hybrid_counter_nxt ? 32'hffff_ffff : both_hybrid_counter_nxt ;
        both_of_counter <= mon_both_of_counter_nxt ? 32'hffff_ffff : both_of_counter_nxt ;
        both_uf_counter <= mon_both_uf_counter_nxt ? 32'hffff_ffff : both_uf_counter_nxt ;
        only_le_hit_counter <= mon_only_le_hit_counter_nxt ? 32'hffff_ffff : only_le_hit_counter_nxt ;
        only_lo_hit_counter <= mon_only_lo_hit_counter_nxt ? 32'hffff_ffff : only_lo_hit_counter_nxt ;
    end
  end
end
assign {mon_both_hybrid_counter_nxt ,both_hybrid_counter_nxt[31:0]} = both_hybrid_counter + both_hybrid_ele;
assign {mon_both_of_counter_nxt ,both_of_counter_nxt[31:0] } = both_of_counter + both_of_ele ;
assign {mon_both_uf_counter_nxt ,both_uf_counter_nxt[31:0] } = both_uf_counter + both_uf_ele ;
assign {mon_only_le_hit_counter_nxt ,only_le_hit_counter_nxt[31:0]} = only_le_hit_counter + only_le_hit_ele ;
assign {mon_only_lo_hit_counter_nxt ,only_lo_hit_counter_nxt[31:0]} = only_lo_hit_counter + only_lo_hit_ele ;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    layer_flg <= 1'b0;
  end else begin
  if ((layer_done) == 1'b1) begin
    layer_flg <= ~layer_flg;
// VCS coverage off
  end else if ((layer_done) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_3x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d0_perf_lut_hybrid <= {32{1'b0}};
  end else begin
  if ((layer_done & (~layer_flg)) == 1'b1) begin
    dp2reg_d0_perf_lut_hybrid <= both_hybrid_counter;
// VCS coverage off
  end else if ((layer_done & (~layer_flg)) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_4x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & (~layer_flg)))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d1_perf_lut_hybrid <= {32{1'b0}};
  end else begin
  if ((layer_done & layer_flg ) == 1'b1) begin
    dp2reg_d1_perf_lut_hybrid <= both_hybrid_counter;
// VCS coverage off
  end else if ((layer_done & layer_flg ) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_5x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & layer_flg ))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d0_perf_lut_oflow <= {32{1'b0}};
  end else begin
  if ((layer_done & (~layer_flg)) == 1'b1) begin
    dp2reg_d0_perf_lut_oflow <= both_of_counter;
// VCS coverage off
  end else if ((layer_done & (~layer_flg)) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_6x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & (~layer_flg)))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d1_perf_lut_oflow <= {32{1'b0}};
  end else begin
  if ((layer_done & layer_flg ) == 1'b1) begin
    dp2reg_d1_perf_lut_oflow <= both_of_counter;
// VCS coverage off
  end else if ((layer_done & layer_flg ) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_7x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & layer_flg ))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d0_perf_lut_uflow <= {32{1'b0}};
  end else begin
  if ((layer_done & (~layer_flg)) == 1'b1) begin
    dp2reg_d0_perf_lut_uflow <= both_uf_counter;
// VCS coverage off
  end else if ((layer_done & (~layer_flg)) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_8x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & (~layer_flg)))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d1_perf_lut_uflow <= {32{1'b0}};
  end else begin
  if ((layer_done & layer_flg ) == 1'b1) begin
    dp2reg_d1_perf_lut_uflow <= both_uf_counter;
// VCS coverage off
  end else if ((layer_done & layer_flg ) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_9x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & layer_flg ))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d0_perf_lut_le_hit <= {32{1'b0}};
  end else begin
  if ((layer_done & (~layer_flg)) == 1'b1) begin
    dp2reg_d0_perf_lut_le_hit <= only_le_hit_counter;
// VCS coverage off
  end else if ((layer_done & (~layer_flg)) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_10x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & (~layer_flg)))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d1_perf_lut_le_hit <= {32{1'b0}};
  end else begin
  if ((layer_done & layer_flg ) == 1'b1) begin
    dp2reg_d1_perf_lut_le_hit <= only_le_hit_counter;
// VCS coverage off
  end else if ((layer_done & layer_flg ) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_11x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & layer_flg ))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d0_perf_lut_lo_hit <= {32{1'b0}};
  end else begin
  if ((layer_done & (~layer_flg)) == 1'b1) begin
    dp2reg_d0_perf_lut_lo_hit <= only_lo_hit_counter;
// VCS coverage off
  end else if ((layer_done & (~layer_flg)) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_12x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & (~layer_flg)))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    dp2reg_d1_perf_lut_lo_hit <= {32{1'b0}};
  end else begin
  if ((layer_done & layer_flg ) == 1'b1) begin
    dp2reg_d1_perf_lut_lo_hit <= only_lo_hit_counter;
// VCS coverage off
  end else if ((layer_done & layer_flg ) == 1'b0) begin
// VCS coverage on
  end
  end
end
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET nvdla_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b0 : nvdla_core_rstn)
`else
`define ASSERT_RESET ((1'bx === nvdla_core_rstn) ? 1'b1 : nvdla_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  nv_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_13x (nvdla_core_clk, `ASSERT_RESET, 1'd1, (^(layer_done & layer_flg ))); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
////////////////////////////////////////////////
//intp output pipe sync for timing
////////////////////////////////////////////////
assign ip2mul_pd = {
//: my $k = 8;
//: if($k > 1) {
//: foreach my $m (0..$k-2) {
//: my $i = $k - $m -1;
//: print qq(
//: ip2mul_pd_${i}[16:0],
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

ip2mul_pd_7[16:0],

ip2mul_pd_6[16:0],

ip2mul_pd_5[16:0],

ip2mul_pd_4[16:0],

ip2mul_pd_3[16:0],

ip2mul_pd_2[16:0],

ip2mul_pd_1[16:0],

//| eperl: generated_end (DO NOT EDIT ABOVE)
ip2mul_pd_0[16:0]};
////////::pipe -bc -is intp2mul_pd(intp2mul_pvld,intp2mul_prdy) <= ip2mul_pd(ip2mul_pvld,ip2mul_prdy);
//: my $k = 8*17;
//: &eperl::pipe(" -wid $k -is -do intp2mul_pd -vo intp2mul_pvld -ri intp2mul_prdy -di ip2mul_pd -vi ip2mul_pvld -ro ip2mul_prdy ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg ip2mul_prdy;
reg skid_flop_ip2mul_prdy;
reg skid_flop_ip2mul_pvld;
reg [136-1:0] skid_flop_ip2mul_pd;
reg pipe_skid_ip2mul_pvld;
reg [136-1:0] pipe_skid_ip2mul_pd;
// Wire
wire skid_ip2mul_pvld;
wire [136-1:0] skid_ip2mul_pd;
wire skid_ip2mul_prdy;
wire pipe_skid_ip2mul_prdy;
wire intp2mul_pvld;
wire [136-1:0] intp2mul_pd;
// Code
// SKID READY
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       ip2mul_prdy <= 1'b1;
       skid_flop_ip2mul_prdy <= 1'b1;
   end else begin
       ip2mul_prdy <= skid_ip2mul_prdy;
       skid_flop_ip2mul_prdy <= skid_ip2mul_prdy;
   end
end

// SKID VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        skid_flop_ip2mul_pvld <= 1'b0;
    end else begin
        if (skid_flop_ip2mul_prdy) begin
            skid_flop_ip2mul_pvld <= ip2mul_pvld;
        end
   end
end
assign skid_ip2mul_pvld = (skid_flop_ip2mul_prdy) ? ip2mul_pvld : skid_flop_ip2mul_pvld;

// SKID DATA
always @(posedge nvdla_core_clk) begin
    if (skid_flop_ip2mul_prdy & ip2mul_pvld) begin
        skid_flop_ip2mul_pd[136-1:0] <= ip2mul_pd[136-1:0];
    end
end
assign skid_ip2mul_pd[136-1:0] = (skid_flop_ip2mul_prdy) ? ip2mul_pd[136-1:0] : skid_flop_ip2mul_pd[136-1:0];


// PIPE READY
assign skid_ip2mul_prdy = pipe_skid_ip2mul_prdy || !pipe_skid_ip2mul_pvld;

// PIPE VALID
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_skid_ip2mul_pvld <= 1'b0;
    end else begin
        if (skid_ip2mul_prdy) begin
            pipe_skid_ip2mul_pvld <= skid_ip2mul_pvld;
        end
    end
end

// PIPE DATA
always @(posedge nvdla_core_clk) begin
    if (skid_ip2mul_prdy && skid_ip2mul_pvld) begin
        pipe_skid_ip2mul_pd[136-1:0] <= skid_ip2mul_pd[136-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_ip2mul_prdy = intp2mul_prdy;
assign intp2mul_pvld = pipe_skid_ip2mul_pvld;
assign intp2mul_pd = pipe_skid_ip2mul_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign intp_prdy_d = ip2mul_prdy;
assign {
//: my $k = 8;
//: if($k > 1) {
//: foreach my $m (0..$k-2) {
//: my $i = $k - $m -1;
//: print qq(
//: intp2mul_pd_${i}[16:0],
//: );
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

intp2mul_pd_7[16:0],

intp2mul_pd_6[16:0],

intp2mul_pd_5[16:0],

intp2mul_pd_4[16:0],

intp2mul_pd_3[16:0],

intp2mul_pd_2[16:0],

intp2mul_pd_1[16:0],

//| eperl: generated_end (DO NOT EDIT ABOVE)
intp2mul_pd_0[16:0]} = intp2mul_pd;
////////////////////////////////////////////////
endmodule // NV_NVDLA_CDP_DP_intp
//
// AUTOMATICALLY GENERATED -- DO NOT EDIT OR CHECK IN
//
// /home/nvtools/engr/2017/03/11_05_00_06/nvtools/scripts/fifogen
// fifogen -input_config_yaml ../../../../../../../socd/ip_chip_tools/1.0/defs/public/fifogen/golden/tlit5/fifogen.yml -no_make_ram -no_make_ram -stdout -m NV_NVDLA_CDP_DP_intpinfo_fifo -clk_name nvdla_core_clk -reset_name nvdla_core_rstn -wr_pipebus intpinfo_wr -rd_pipebus intpinfo_rd -rd_reg -ram_bypass -d 19 -w 80 -ram ra2 [Chosen ram type: ra2 - ramgen_generic (user specified, thus no other ram type is allowed)]
// chip config vars: assertion_module_prefix=nv_ strict_synchronizers=1 strict_synchronizers_use_lib_cells=1 strict_synchronizers_use_tm_lib_cells=1 strict_sync_randomizer=1 assertion_message_prefix=FIFOGEN_ASSERTION allow_async_fifola=0 ignore_ramgen_fifola_variant=1 uses_p_SSYNC=0 uses_prand=1 uses_rammake_inc=1 use_x_or_0=1 force_wr_reg_gated=1 no_force_reset=1 no_timescale=1 no_pli_ifdef=1 requires_full_throughput=1 ram_auto_ff_bits_cutoff=16 ram_auto_ff_width_cutoff=2 ram_auto_ff_width_cutoff_max_depth=32 ram_auto_ff_depth_cutoff=-1 ram_auto_ff_no_la2_depth_cutoff=5 ram_auto_la2_width_cutoff=8 ram_auto_la2_width_cutoff_max_depth=56 ram_auto_la2_depth_cutoff=16 flopram_emu_model=1 dslp_single_clamp_port=1 dslp_clamp_port=1 slp_single_clamp_port=1 slp_clamp_port=1 master_clk_gated=1 clk_gate_module=NV_CLK_gate_power redundant_timing_flops=0 hot_reset_async_force_ports_and_loopback=1 ram_sleep_en_width=1 async_cdc_reg_id=NV_AFIFO_ rd_reg_default_for_async=1 async_ram_instance_prefix=NV_ASYNC_RAM_ allow_rd_busy_reg_warning=0 do_dft_xelim_gating=1 add_dft_xelim_wr_clkgate=1 add_dft_xelim_rd_clkgate=1
//
// leda B_3208_NV OFF -- Unequal length LHS and RHS in assignment
// leda B_1405 OFF -- 2 asynchronous resets in this unit detected
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
