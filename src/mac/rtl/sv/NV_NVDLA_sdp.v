// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_sdp.v
// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_SDP_define.h
module NV_NVDLA_sdp (
   cacc2sdp_pd //|< i
  ,cacc2sdp_valid //|< i
  ,cacc2sdp_ready //|> o
  ,csb2sdp_rdma_req_pd //|< i
  ,csb2sdp_rdma_req_pvld //|< i
  ,csb2sdp_req_pd //|< i
  ,csb2sdp_req_pvld //|< i
  ,sdp_b2cvif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_b2cvif_rd_req_pd //|> o
  ,sdp_b2cvif_rd_req_valid //|> o
  ,sdp_b2cvif_rd_req_ready //|< i
  ,cvif2sdp_b_rd_rsp_pd //|< i
  ,cvif2sdp_b_rd_rsp_valid //|< i
  ,cvif2sdp_b_rd_rsp_ready //|> o
  ,sdp_e2cvif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_e2cvif_rd_req_pd //|> o
  ,sdp_e2cvif_rd_req_valid //|> o
  ,sdp_e2cvif_rd_req_ready //|< i
  ,cvif2sdp_e_rd_rsp_pd //|< i
  ,cvif2sdp_e_rd_rsp_valid //|< i
  ,cvif2sdp_e_rd_rsp_ready //|> o
  ,sdp_n2cvif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_n2cvif_rd_req_pd //|> o
  ,sdp_n2cvif_rd_req_valid //|> o
  ,sdp_n2cvif_rd_req_ready //|< i
  ,cvif2sdp_n_rd_rsp_pd //|< i
  ,cvif2sdp_n_rd_rsp_valid //|< i
  ,cvif2sdp_n_rd_rsp_ready //|> o
  ,sdp2cvif_rd_cdt_lat_fifo_pop //|> o
  ,sdp2cvif_rd_req_pd //|> o
  ,sdp2cvif_rd_req_valid //|> o
  ,sdp2cvif_rd_req_ready //|< i
  ,cvif2sdp_rd_rsp_pd //|< i
  ,cvif2sdp_rd_rsp_valid //|< i
  ,cvif2sdp_rd_rsp_ready //|> o
  ,sdp2cvif_wr_req_pd //|> o
  ,sdp2cvif_wr_req_valid //|> o
  ,sdp2cvif_wr_req_ready //|< i
  ,cvif2sdp_wr_rsp_complete //|< i
  ,dla_clk_ovr_on_sync //|< i
  ,global_clk_ovr_on_sync //|< i
  ,sdp_b2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_b2mcif_rd_req_pd //|> o
  ,sdp_b2mcif_rd_req_valid //|> o
  ,sdp_b2mcif_rd_req_ready //|< i
  ,mcif2sdp_b_rd_rsp_pd //|< i
  ,mcif2sdp_b_rd_rsp_valid //|< i
  ,mcif2sdp_b_rd_rsp_ready //|> o
  ,sdp_e2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_e2mcif_rd_req_pd //|> o
  ,sdp_e2mcif_rd_req_valid //|> o
  ,sdp_e2mcif_rd_req_ready //|< i
  ,mcif2sdp_e_rd_rsp_pd //|< i
  ,mcif2sdp_e_rd_rsp_valid //|< i
  ,mcif2sdp_e_rd_rsp_ready //|> o
  ,sdp_n2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_n2mcif_rd_req_pd //|> o
  ,sdp_n2mcif_rd_req_valid //|> o
  ,sdp_n2mcif_rd_req_ready //|< i
  ,mcif2sdp_n_rd_rsp_pd //|< i
  ,mcif2sdp_n_rd_rsp_valid //|< i
  ,mcif2sdp_n_rd_rsp_ready //|> o
  ,sdp2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp2mcif_rd_req_pd //|> o
  ,sdp2mcif_rd_req_valid //|> o
  ,sdp2mcif_rd_req_ready //|< i
  ,mcif2sdp_rd_rsp_pd //|< i
  ,mcif2sdp_rd_rsp_valid //|< i
  ,mcif2sdp_rd_rsp_ready //|> o
  ,sdp2mcif_wr_req_pd //|> o
  ,sdp2mcif_wr_req_valid //|> o
  ,sdp2mcif_wr_req_ready //|< i
  ,mcif2sdp_wr_rsp_complete //|< i
  ,nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,sdp2glb_done_intr_pd //|> o
  ,csb2sdp_rdma_req_prdy //|> o
  ,csb2sdp_req_prdy //|> o
  ,sdp2csb_resp_pd //|> o
  ,sdp2csb_resp_valid //|> o
  ,sdp_rdma2csb_resp_pd //|> o
  ,sdp_rdma2csb_resp_valid //|> o
  ,sdp2pdp_pd //|> o
  ,sdp2pdp_valid //|> o
  ,sdp2pdp_ready //|< i
  ,cacc2sdp_adpt_valid
  ,cacc2sdp_adpt_ready
  ,cacc2sdp_adpt_pd
  ,sdp_dp2wdma_valid
  ,sdp_dp2wdma_ready
  ,sdp_dp2wdma_pd
  );
//
// NV_NVDLA_sdp_ports.v
//
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input dla_clk_ovr_on_sync;
input global_clk_ovr_on_sync;
input tmc2slcg_disable_clock_gating;
input cacc2sdp_valid;
output cacc2sdp_ready;
input [32*16 +1:0] cacc2sdp_pd;
output sdp2pdp_valid;
input sdp2pdp_ready;
output [8*16 -1:0] sdp2pdp_pd;
output [1:0] sdp2glb_done_intr_pd;
input csb2sdp_rdma_req_pvld;
output csb2sdp_rdma_req_prdy;
input [62:0] csb2sdp_rdma_req_pd;
output sdp_rdma2csb_resp_valid;
output [33:0] sdp_rdma2csb_resp_pd;
input csb2sdp_req_pvld;
output csb2sdp_req_prdy;
input [62:0] csb2sdp_req_pd;
output sdp2csb_resp_valid;
output [33:0] sdp2csb_resp_pd;
output sdp_b2cvif_rd_cdt_lat_fifo_pop;
output sdp_b2cvif_rd_req_valid;
input sdp_b2cvif_rd_req_ready;
output [79 -1:0] sdp_b2cvif_rd_req_pd;
input cvif2sdp_b_rd_rsp_valid;
output cvif2sdp_b_rd_rsp_ready;
input [257 -1:0] cvif2sdp_b_rd_rsp_pd;
output sdp_e2cvif_rd_cdt_lat_fifo_pop;
output sdp_e2cvif_rd_req_valid;
input sdp_e2cvif_rd_req_ready;
output [79 -1:0] sdp_e2cvif_rd_req_pd;
input cvif2sdp_e_rd_rsp_valid;
output cvif2sdp_e_rd_rsp_ready;
input [257 -1:0] cvif2sdp_e_rd_rsp_pd;
output sdp_n2cvif_rd_cdt_lat_fifo_pop;
output sdp_n2cvif_rd_req_valid;
input sdp_n2cvif_rd_req_ready;
output [79 -1:0] sdp_n2cvif_rd_req_pd;
input cvif2sdp_n_rd_rsp_valid;
output cvif2sdp_n_rd_rsp_ready;
input [257 -1:0] cvif2sdp_n_rd_rsp_pd;
output sdp2cvif_rd_cdt_lat_fifo_pop;
output sdp2cvif_rd_req_valid;
input sdp2cvif_rd_req_ready;
output [79 -1:0] sdp2cvif_rd_req_pd;
input cvif2sdp_rd_rsp_valid;
output cvif2sdp_rd_rsp_ready;
input [257 -1:0] cvif2sdp_rd_rsp_pd;
output sdp2cvif_wr_req_valid;
input sdp2cvif_wr_req_ready;
output [258 -1:0] sdp2cvif_wr_req_pd;
input cvif2sdp_wr_rsp_complete;
output sdp_b2mcif_rd_cdt_lat_fifo_pop;
output sdp_b2mcif_rd_req_valid;
input sdp_b2mcif_rd_req_ready;
output [79 -1:0] sdp_b2mcif_rd_req_pd;
input mcif2sdp_b_rd_rsp_valid;
output mcif2sdp_b_rd_rsp_ready;
input [257 -1:0] mcif2sdp_b_rd_rsp_pd;
output sdp_e2mcif_rd_cdt_lat_fifo_pop;
output sdp_e2mcif_rd_req_valid;
input sdp_e2mcif_rd_req_ready;
output [79 -1:0] sdp_e2mcif_rd_req_pd;
input mcif2sdp_e_rd_rsp_valid;
output mcif2sdp_e_rd_rsp_ready;
input [257 -1:0] mcif2sdp_e_rd_rsp_pd;
output sdp_n2mcif_rd_cdt_lat_fifo_pop;
output sdp_n2mcif_rd_req_valid;
input sdp_n2mcif_rd_req_ready;
output [79 -1:0] sdp_n2mcif_rd_req_pd;
input mcif2sdp_n_rd_rsp_valid;
output mcif2sdp_n_rd_rsp_ready;
input [257 -1:0] mcif2sdp_n_rd_rsp_pd;
output sdp2mcif_rd_cdt_lat_fifo_pop;
output sdp2mcif_rd_req_valid;
input sdp2mcif_rd_req_ready;
output [79 -1:0] sdp2mcif_rd_req_pd;
input mcif2sdp_rd_rsp_valid;
output mcif2sdp_rd_rsp_ready;
input [257 -1:0] mcif2sdp_rd_rsp_pd;
output sdp2mcif_wr_req_valid;
input sdp2mcif_wr_req_ready;
output [258 -1:0] sdp2mcif_wr_req_pd;
input mcif2sdp_wr_rsp_complete;
//for debug
/////////////////////////////////////////////
output                   cacc2sdp_adpt_valid;
output                   cacc2sdp_adpt_ready;
output [32*16 +1:0]      cacc2sdp_adpt_pd;

output                   sdp_dp2wdma_valid;
output                   sdp_dp2wdma_ready;
output [32*8 -1:0]       sdp_dp2wdma_pd;
/////////////////////////////////////////////

wire dp2reg_done;
wire [31:0] dp2reg_out_saturation;
wire [31:0] dp2reg_status_nan_output_num;
wire [0:0] dp2reg_status_unequal;
wire [31:0] dp2reg_wdma_stall;
wire [4:0] reg2dp_batch_number;
wire reg2dp_bcore_slcg_op_en;
wire reg2dp_flying_mode;
wire [12:0] reg2dp_height;
wire reg2dp_interrupt_ptr;
wire [1:0] reg2dp_bn_alu_algo;
wire reg2dp_bn_alu_bypass;
wire [15:0] reg2dp_bn_alu_operand;
wire [5:0] reg2dp_bn_alu_shift_value;
wire reg2dp_bn_alu_src;
wire reg2dp_bn_bypass;
wire reg2dp_bn_mul_bypass;
wire [15:0] reg2dp_bn_mul_operand;
wire reg2dp_bn_mul_prelu;
wire [7:0] reg2dp_bn_mul_shift_value;
wire reg2dp_bn_mul_src;
wire reg2dp_bn_relu_bypass;
wire [1:0] reg2dp_bs_alu_algo;
wire reg2dp_bs_alu_bypass;
wire [15:0] reg2dp_bs_alu_operand;
wire [5:0] reg2dp_bs_alu_shift_value;
wire reg2dp_bs_alu_src;
wire reg2dp_bs_bypass;
wire reg2dp_bs_mul_bypass;
wire [15:0] reg2dp_bs_mul_operand;
wire reg2dp_bs_mul_prelu;
wire [7:0] reg2dp_bs_mul_shift_value;
wire reg2dp_bs_mul_src;
wire reg2dp_bs_relu_bypass;
wire [12:0] reg2dp_channel;
wire [31:0] reg2dp_cvt_offset;
wire [15:0] reg2dp_cvt_scale;
wire [5:0] reg2dp_cvt_shift;
wire [31:0] reg2dp_dst_base_addr_high;
wire [31:0] reg2dp_dst_base_addr_low;
wire [31:0] reg2dp_dst_batch_stride;
wire [31:0] reg2dp_dst_line_stride;
wire reg2dp_dst_ram_type;
wire [31:0] reg2dp_dst_surface_stride;
wire reg2dp_ecore_slcg_op_en;
wire [1:0] reg2dp_ew_alu_algo;
wire reg2dp_ew_alu_bypass;
wire reg2dp_ew_alu_cvt_bypass;
wire [31:0] reg2dp_ew_alu_cvt_offset;
wire [15:0] reg2dp_ew_alu_cvt_scale;
wire [5:0] reg2dp_ew_alu_cvt_truncate;
wire [31:0] reg2dp_ew_alu_operand;
wire reg2dp_ew_alu_src;
wire reg2dp_ew_bypass;
wire reg2dp_ew_lut_bypass;
wire reg2dp_ew_mul_bypass;
wire reg2dp_ew_mul_cvt_bypass;
wire [31:0] reg2dp_ew_mul_cvt_offset;
wire [15:0] reg2dp_ew_mul_cvt_scale;
wire [5:0] reg2dp_ew_mul_cvt_truncate;
wire [31:0] reg2dp_ew_mul_operand;
wire reg2dp_ew_mul_prelu;
wire reg2dp_ew_mul_src;
wire [9:0] reg2dp_ew_truncate;
wire reg2dp_lut_hybrid_priority;
wire reg2dp_lut_int_access_type;
wire [9:0] reg2dp_lut_int_addr;
wire [15:0] reg2dp_lut_int_data;
wire reg2dp_lut_int_data_wr;
wire reg2dp_lut_int_table_id;
wire [31:0] reg2dp_lut_le_end;
wire reg2dp_lut_le_function;
wire [7:0] reg2dp_lut_le_index_offset;
wire [7:0] reg2dp_lut_le_index_select;
wire [15:0] reg2dp_lut_le_slope_oflow_scale;
wire [4:0] reg2dp_lut_le_slope_oflow_shift;
wire [15:0] reg2dp_lut_le_slope_uflow_scale;
wire [4:0] reg2dp_lut_le_slope_uflow_shift;
wire [31:0] reg2dp_lut_le_start;
wire [31:0] reg2dp_lut_lo_end;
wire [7:0] reg2dp_lut_lo_index_select;
wire [15:0] reg2dp_lut_lo_slope_oflow_scale;
wire [4:0] reg2dp_lut_lo_slope_oflow_shift;
wire [15:0] reg2dp_lut_lo_slope_uflow_scale;
wire [4:0] reg2dp_lut_lo_slope_uflow_shift;
wire [31:0] reg2dp_lut_lo_start;
wire reg2dp_lut_oflow_priority;
wire reg2dp_lut_slcg_en;
wire reg2dp_lut_uflow_priority;
wire [31:0] dp2reg_lut_hybrid;
wire [15:0] dp2reg_lut_int_data;
wire [31:0] dp2reg_lut_le_hit;
wire [31:0] dp2reg_lut_lo_hit;
wire [31:0] dp2reg_lut_oflow;
wire [31:0] dp2reg_lut_uflow;
wire reg2dp_nan_to_zero;
wire reg2dp_ncore_slcg_op_en;
wire reg2dp_op_en;
wire [1:0] reg2dp_out_precision;
wire reg2dp_output_dst;
wire reg2dp_perf_dma_en;
wire reg2dp_perf_lut_en;
wire reg2dp_perf_sat_en;
wire [1:0] reg2dp_proc_precision;
wire reg2dp_wdma_slcg_op_en;
wire [12:0] reg2dp_width;
wire reg2dp_winograd;
wire [32*32 +1:0] sdp_mrdma2cmux_pd;
wire sdp_mrdma2cmux_ready;
wire sdp_mrdma2cmux_valid;
wire sdp_dp2wdma_ready;
wire sdp_dp2wdma_valid;
wire [32*8 -1:0] sdp_dp2wdma_pd;
wire [32*16:0] sdp_brdma2dp_alu_pd;
wire sdp_brdma2dp_alu_ready;
wire sdp_brdma2dp_alu_valid;
wire [32*16:0] sdp_brdma2dp_mul_pd;
wire sdp_brdma2dp_mul_ready;
wire sdp_brdma2dp_mul_valid;
wire [32*16:0] sdp_erdma2dp_alu_pd;
wire sdp_erdma2dp_alu_ready;
wire sdp_erdma2dp_alu_valid;
wire [32*16:0] sdp_erdma2dp_mul_pd;
wire sdp_erdma2dp_mul_ready;
wire sdp_erdma2dp_mul_valid;
wire [32*16:0] sdp_nrdma2dp_alu_pd;
wire sdp_nrdma2dp_alu_ready;
wire sdp_nrdma2dp_alu_valid;
wire [32*16:0] sdp_nrdma2dp_mul_pd;
wire sdp_nrdma2dp_mul_ready;
wire sdp_nrdma2dp_mul_valid;
wire cacc2sdp_adpt_valid;
wire cacc2sdp_adpt_ready;
wire [32*16 +1:0] cacc2sdp_adpt_pd;
//=======================================
//DMA
//---------------------------------------
NV_NVDLA_SDP_rdma u_rdma (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd[62:0])
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd[33:0])
  ,.sdp_mrdma2cmux_valid (sdp_mrdma2cmux_valid)
  ,.sdp_mrdma2cmux_ready (sdp_mrdma2cmux_ready)
  ,.sdp_mrdma2cmux_pd (sdp_mrdma2cmux_pd[32*32 +1:0])
  ,.sdp_b2cvif_rd_cdt_lat_fifo_pop (sdp_b2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2cvif_rd_req_valid (sdp_b2cvif_rd_req_valid)
  ,.sdp_b2cvif_rd_req_ready (sdp_b2cvif_rd_req_ready)
  ,.sdp_b2cvif_rd_req_pd (sdp_b2cvif_rd_req_pd[79 -1:0])
  ,.cvif2sdp_b_rd_rsp_valid (cvif2sdp_b_rd_rsp_valid)
  ,.cvif2sdp_b_rd_rsp_ready (cvif2sdp_b_rd_rsp_ready)
  ,.cvif2sdp_b_rd_rsp_pd (cvif2sdp_b_rd_rsp_pd[257 -1:0])
  ,.sdp_e2cvif_rd_cdt_lat_fifo_pop (sdp_e2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_e2cvif_rd_req_valid (sdp_e2cvif_rd_req_valid)
  ,.sdp_e2cvif_rd_req_ready (sdp_e2cvif_rd_req_ready)
  ,.sdp_e2cvif_rd_req_pd (sdp_e2cvif_rd_req_pd[79 -1:0])
  ,.cvif2sdp_e_rd_rsp_valid (cvif2sdp_e_rd_rsp_valid)
  ,.cvif2sdp_e_rd_rsp_ready (cvif2sdp_e_rd_rsp_ready)
  ,.cvif2sdp_e_rd_rsp_pd (cvif2sdp_e_rd_rsp_pd[257 -1:0])
  ,.sdp_n2cvif_rd_cdt_lat_fifo_pop (sdp_n2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2cvif_rd_req_valid (sdp_n2cvif_rd_req_valid)
  ,.sdp_n2cvif_rd_req_ready (sdp_n2cvif_rd_req_ready)
  ,.sdp_n2cvif_rd_req_pd (sdp_n2cvif_rd_req_pd[79 -1:0])
  ,.cvif2sdp_n_rd_rsp_valid (cvif2sdp_n_rd_rsp_valid)
  ,.cvif2sdp_n_rd_rsp_ready (cvif2sdp_n_rd_rsp_ready)
  ,.cvif2sdp_n_rd_rsp_pd (cvif2sdp_n_rd_rsp_pd[257 -1:0])
  ,.sdp2cvif_rd_cdt_lat_fifo_pop (sdp2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp2cvif_rd_req_valid (sdp2cvif_rd_req_valid)
  ,.sdp2cvif_rd_req_ready (sdp2cvif_rd_req_ready)
  ,.sdp2cvif_rd_req_pd (sdp2cvif_rd_req_pd[79 -1:0])
  ,.cvif2sdp_rd_rsp_valid (cvif2sdp_rd_rsp_valid)
  ,.cvif2sdp_rd_rsp_ready (cvif2sdp_rd_rsp_ready)
  ,.cvif2sdp_rd_rsp_pd (cvif2sdp_rd_rsp_pd[257 -1:0])
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd[79 -1:0])
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd[257 -1:0])
  ,.sdp_e2mcif_rd_cdt_lat_fifo_pop (sdp_e2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_e2mcif_rd_req_valid (sdp_e2mcif_rd_req_valid)
  ,.sdp_e2mcif_rd_req_ready (sdp_e2mcif_rd_req_ready)
  ,.sdp_e2mcif_rd_req_pd (sdp_e2mcif_rd_req_pd[79 -1:0])
  ,.mcif2sdp_e_rd_rsp_valid (mcif2sdp_e_rd_rsp_valid)
  ,.mcif2sdp_e_rd_rsp_ready (mcif2sdp_e_rd_rsp_ready)
  ,.mcif2sdp_e_rd_rsp_pd (mcif2sdp_e_rd_rsp_pd[257 -1:0])
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd[79 -1:0])
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd[257 -1:0])
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd[79 -1:0])
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd[257 -1:0])
  ,.sdp_brdma2dp_alu_valid (sdp_brdma2dp_alu_valid)
  ,.sdp_brdma2dp_alu_ready (sdp_brdma2dp_alu_ready)
  ,.sdp_brdma2dp_alu_pd (sdp_brdma2dp_alu_pd[32*16:0])
  ,.sdp_brdma2dp_mul_valid (sdp_brdma2dp_mul_valid)
  ,.sdp_brdma2dp_mul_ready (sdp_brdma2dp_mul_ready)
  ,.sdp_brdma2dp_mul_pd (sdp_brdma2dp_mul_pd[32*16:0])
  ,.sdp_erdma2dp_alu_valid (sdp_erdma2dp_alu_valid)
  ,.sdp_erdma2dp_alu_ready (sdp_erdma2dp_alu_ready)
  ,.sdp_erdma2dp_alu_pd (sdp_erdma2dp_alu_pd[32*16:0])
  ,.sdp_erdma2dp_mul_valid (sdp_erdma2dp_mul_valid)
  ,.sdp_erdma2dp_mul_ready (sdp_erdma2dp_mul_ready)
  ,.sdp_erdma2dp_mul_pd (sdp_erdma2dp_mul_pd[32*16:0])
  ,.sdp_nrdma2dp_alu_valid (sdp_nrdma2dp_alu_valid)
  ,.sdp_nrdma2dp_alu_ready (sdp_nrdma2dp_alu_ready)
  ,.sdp_nrdma2dp_alu_pd (sdp_nrdma2dp_alu_pd[32*16:0])
  ,.sdp_nrdma2dp_mul_valid (sdp_nrdma2dp_mul_valid)
  ,.sdp_nrdma2dp_mul_ready (sdp_nrdma2dp_mul_ready)
  ,.sdp_nrdma2dp_mul_pd (sdp_nrdma2dp_mul_pd[32*16:0])
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  );
NV_NVDLA_SDP_wdma u_wdma (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.sdp2cvif_wr_req_valid (sdp2cvif_wr_req_valid)
  ,.sdp2cvif_wr_req_ready (sdp2cvif_wr_req_ready)
  ,.sdp2cvif_wr_req_pd (sdp2cvif_wr_req_pd[258 -1:0])
  ,.cvif2sdp_wr_rsp_complete (cvif2sdp_wr_rsp_complete)
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd[1:0])
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd[258 -1:0])
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.sdp_dp2wdma_valid (sdp_dp2wdma_valid)
  ,.sdp_dp2wdma_ready (sdp_dp2wdma_ready)
  ,.sdp_dp2wdma_pd (sdp_dp2wdma_pd[32*8 -1:0])
  ,.reg2dp_ew_alu_algo (reg2dp_ew_alu_algo[1:0])
  ,.reg2dp_ew_alu_bypass (reg2dp_ew_alu_bypass)
  ,.reg2dp_ew_bypass (reg2dp_ew_bypass)
  ,.reg2dp_op_en (reg2dp_op_en)
  ,.reg2dp_wdma_slcg_op_en (reg2dp_wdma_slcg_op_en)
  ,.reg2dp_output_dst (reg2dp_output_dst)
  ,.reg2dp_batch_number (reg2dp_batch_number[4:0])
  ,.reg2dp_winograd (reg2dp_winograd)
  ,.reg2dp_channel (reg2dp_channel[12:0])
  ,.reg2dp_height (reg2dp_height[12:0])
  ,.reg2dp_width (reg2dp_width[12:0])
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0])
  ,.reg2dp_out_precision (reg2dp_out_precision[1:0])
  ,.reg2dp_dst_ram_type (reg2dp_dst_ram_type)
  ,.reg2dp_dst_base_addr_high (reg2dp_dst_base_addr_high[31:0])
  ,.reg2dp_dst_base_addr_low (reg2dp_dst_base_addr_low[31:5])
  ,.reg2dp_dst_batch_stride (reg2dp_dst_batch_stride[31:5])
  ,.reg2dp_dst_line_stride (reg2dp_dst_line_stride[31:5])
  ,.reg2dp_dst_surface_stride (reg2dp_dst_surface_stride[31:5])
  ,.reg2dp_interrupt_ptr (reg2dp_interrupt_ptr)
  ,.reg2dp_perf_dma_en (reg2dp_perf_dma_en)
  ,.dp2reg_done (dp2reg_done)
  ,.dp2reg_status_nan_output_num (dp2reg_status_nan_output_num[31:0])
  ,.dp2reg_status_unequal (dp2reg_status_unequal)
  ,.dp2reg_wdma_stall (dp2reg_wdma_stall[31:0])
  );
//==========================================================
// CACC2SDP adapter
//==========================================================
NV_NVDLA_SDP_CACC2SDP_adapter u_output_adapter(
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd) //|< i
  ,.op_load (1'b0) //|< i
  ,.reg2dp_batch_number (reg2dp_batch_number) //|< i
  ,.reg2dp_channel (reg2dp_channel) //|< i
  ,.reg2dp_height (reg2dp_height) //|< i
  ,.reg2dp_width (reg2dp_width) //|< i
  ,.reg2dp_proc_precision (reg2dp_proc_precision) //|< i
  ,.in_pvld (cacc2sdp_valid) //|> i
  ,.in_prdy (cacc2sdp_ready) //|< o
  ,.in_pd (cacc2sdp_pd) //|> i
  ,.out_pvld (cacc2sdp_adpt_valid) //|> o
  ,.out_prdy (cacc2sdp_adpt_ready) //|< i
  ,.out_pd (cacc2sdp_adpt_pd) //|> o
  );
//========================================
//SDP core instance
//----------------------------------------
NV_NVDLA_SDP_core u_core (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.cacc2sdp_valid (cacc2sdp_adpt_valid)
  ,.cacc2sdp_ready (cacc2sdp_adpt_ready)
  ,.cacc2sdp_pd (cacc2sdp_adpt_pd[32*16 +1:0])
  ,.sdp_mrdma2cmux_valid (sdp_mrdma2cmux_valid)
  ,.sdp_mrdma2cmux_ready (sdp_mrdma2cmux_ready)
  ,.sdp_mrdma2cmux_pd (sdp_mrdma2cmux_pd[32*32 +1:0])
  ,.sdp_brdma2dp_mul_valid (sdp_brdma2dp_mul_valid)
  ,.sdp_brdma2dp_mul_ready (sdp_brdma2dp_mul_ready)
  ,.sdp_brdma2dp_mul_pd (sdp_brdma2dp_mul_pd[32*16:0])
  ,.sdp_brdma2dp_alu_valid (sdp_brdma2dp_alu_valid)
  ,.sdp_brdma2dp_alu_ready (sdp_brdma2dp_alu_ready)
  ,.sdp_brdma2dp_alu_pd (sdp_brdma2dp_alu_pd[32*16:0])
  ,.sdp_nrdma2dp_mul_valid (sdp_nrdma2dp_mul_valid)
  ,.sdp_nrdma2dp_mul_ready (sdp_nrdma2dp_mul_ready)
  ,.sdp_nrdma2dp_mul_pd (sdp_nrdma2dp_mul_pd[32*16:0])
  ,.sdp_nrdma2dp_alu_valid (sdp_nrdma2dp_alu_valid)
  ,.sdp_nrdma2dp_alu_ready (sdp_nrdma2dp_alu_ready)
  ,.sdp_nrdma2dp_alu_pd (sdp_nrdma2dp_alu_pd[32*16:0])
  ,.sdp_erdma2dp_mul_valid (sdp_erdma2dp_mul_valid)
  ,.sdp_erdma2dp_mul_ready (sdp_erdma2dp_mul_ready)
  ,.sdp_erdma2dp_mul_pd (sdp_erdma2dp_mul_pd[32*16:0])
  ,.sdp_erdma2dp_alu_valid (sdp_erdma2dp_alu_valid)
  ,.sdp_erdma2dp_alu_ready (sdp_erdma2dp_alu_ready)
  ,.sdp_erdma2dp_alu_pd (sdp_erdma2dp_alu_pd[32*16:0])
  ,.sdp_dp2wdma_valid (sdp_dp2wdma_valid)
  ,.sdp_dp2wdma_ready (sdp_dp2wdma_ready)
  ,.sdp_dp2wdma_pd (sdp_dp2wdma_pd[32*8 -1:0])
  ,.sdp2pdp_valid (sdp2pdp_valid)
  ,.sdp2pdp_ready (sdp2pdp_ready)
  ,.sdp2pdp_pd (sdp2pdp_pd[8*16 -1:0])
  ,.reg2dp_ncore_slcg_op_en (reg2dp_ncore_slcg_op_en)
  ,.reg2dp_bn_alu_algo (reg2dp_bn_alu_algo[1:0])
  ,.reg2dp_bn_alu_bypass (reg2dp_bn_alu_bypass)
  ,.reg2dp_bn_alu_operand (reg2dp_bn_alu_operand[15:0])
  ,.reg2dp_bn_alu_shift_value (reg2dp_bn_alu_shift_value[5:0])
  ,.reg2dp_bn_alu_src (reg2dp_bn_alu_src)
  ,.reg2dp_bn_bypass (reg2dp_bn_bypass)
  ,.reg2dp_bn_mul_bypass (reg2dp_bn_mul_bypass)
  ,.reg2dp_bn_mul_operand (reg2dp_bn_mul_operand[15:0])
  ,.reg2dp_bn_mul_prelu (reg2dp_bn_mul_prelu)
  ,.reg2dp_bn_mul_shift_value (reg2dp_bn_mul_shift_value[7:0])
  ,.reg2dp_bn_mul_src (reg2dp_bn_mul_src)
  ,.reg2dp_bn_relu_bypass (reg2dp_bn_relu_bypass)
  ,.reg2dp_bcore_slcg_op_en (reg2dp_bcore_slcg_op_en)
  ,.reg2dp_bs_alu_algo (reg2dp_bs_alu_algo[1:0])
  ,.reg2dp_bs_alu_bypass (reg2dp_bs_alu_bypass)
  ,.reg2dp_bs_alu_operand (reg2dp_bs_alu_operand[15:0])
  ,.reg2dp_bs_alu_shift_value (reg2dp_bs_alu_shift_value[5:0])
  ,.reg2dp_bs_alu_src (reg2dp_bs_alu_src)
  ,.reg2dp_bs_bypass (reg2dp_bs_bypass)
  ,.reg2dp_bs_mul_bypass (reg2dp_bs_mul_bypass)
  ,.reg2dp_bs_mul_operand (reg2dp_bs_mul_operand[15:0])
  ,.reg2dp_bs_mul_prelu (reg2dp_bs_mul_prelu)
  ,.reg2dp_bs_mul_shift_value (reg2dp_bs_mul_shift_value[7:0])
  ,.reg2dp_bs_mul_src (reg2dp_bs_mul_src)
  ,.reg2dp_bs_relu_bypass (reg2dp_bs_relu_bypass)
  ,.reg2dp_ecore_slcg_op_en (reg2dp_ecore_slcg_op_en)
  ,.reg2dp_ew_alu_algo (reg2dp_ew_alu_algo[1:0])
  ,.reg2dp_ew_alu_bypass (reg2dp_ew_alu_bypass)
  ,.reg2dp_ew_alu_cvt_bypass (reg2dp_ew_alu_cvt_bypass)
  ,.reg2dp_ew_alu_cvt_offset (reg2dp_ew_alu_cvt_offset[31:0])
  ,.reg2dp_ew_alu_cvt_scale (reg2dp_ew_alu_cvt_scale[15:0])
  ,.reg2dp_ew_alu_cvt_truncate (reg2dp_ew_alu_cvt_truncate[5:0])
  ,.reg2dp_ew_alu_operand (reg2dp_ew_alu_operand[31:0])
  ,.reg2dp_ew_alu_src (reg2dp_ew_alu_src)
  ,.reg2dp_ew_bypass (reg2dp_ew_bypass)
  ,.reg2dp_ew_lut_bypass (reg2dp_ew_lut_bypass)
  ,.reg2dp_ew_mul_bypass (reg2dp_ew_mul_bypass)
  ,.reg2dp_ew_mul_cvt_bypass (reg2dp_ew_mul_cvt_bypass)
  ,.reg2dp_ew_mul_cvt_offset (reg2dp_ew_mul_cvt_offset[31:0])
  ,.reg2dp_ew_mul_cvt_scale (reg2dp_ew_mul_cvt_scale[15:0])
  ,.reg2dp_ew_mul_cvt_truncate (reg2dp_ew_mul_cvt_truncate[5:0])
  ,.reg2dp_ew_mul_operand (reg2dp_ew_mul_operand[31:0])
  ,.reg2dp_ew_mul_prelu (reg2dp_ew_mul_prelu)
  ,.reg2dp_ew_mul_src (reg2dp_ew_mul_src)
  ,.reg2dp_ew_truncate (reg2dp_ew_truncate[9:0])
  ,.reg2dp_lut_hybrid_priority (reg2dp_lut_hybrid_priority)
  ,.reg2dp_lut_int_access_type (reg2dp_lut_int_access_type)
  ,.reg2dp_lut_int_addr (reg2dp_lut_int_addr[9:0])
  ,.reg2dp_lut_int_data (reg2dp_lut_int_data[15:0])
  ,.reg2dp_lut_int_data_wr (reg2dp_lut_int_data_wr)
  ,.reg2dp_lut_int_table_id (reg2dp_lut_int_table_id)
  ,.reg2dp_lut_le_end (reg2dp_lut_le_end[31:0])
  ,.reg2dp_lut_le_function (reg2dp_lut_le_function)
  ,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
  ,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
  ,.reg2dp_lut_le_slope_oflow_scale (reg2dp_lut_le_slope_oflow_scale[15:0])
  ,.reg2dp_lut_le_slope_oflow_shift (reg2dp_lut_le_slope_oflow_shift[4:0])
  ,.reg2dp_lut_le_slope_uflow_scale (reg2dp_lut_le_slope_uflow_scale[15:0])
  ,.reg2dp_lut_le_slope_uflow_shift (reg2dp_lut_le_slope_uflow_shift[4:0])
  ,.reg2dp_lut_le_start (reg2dp_lut_le_start[31:0])
  ,.reg2dp_lut_lo_end (reg2dp_lut_lo_end[31:0])
  ,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
  ,.reg2dp_lut_lo_slope_oflow_scale (reg2dp_lut_lo_slope_oflow_scale[15:0])
  ,.reg2dp_lut_lo_slope_oflow_shift (reg2dp_lut_lo_slope_oflow_shift[4:0])
  ,.reg2dp_lut_lo_slope_uflow_scale (reg2dp_lut_lo_slope_uflow_scale[15:0])
  ,.reg2dp_lut_lo_slope_uflow_shift (reg2dp_lut_lo_slope_uflow_shift[4:0])
  ,.reg2dp_lut_lo_start (reg2dp_lut_lo_start[31:0])
  ,.reg2dp_lut_oflow_priority (reg2dp_lut_oflow_priority)
  ,.reg2dp_lut_slcg_en (reg2dp_lut_slcg_en)
  ,.reg2dp_lut_uflow_priority (reg2dp_lut_uflow_priority)
  ,.dp2reg_lut_hybrid (dp2reg_lut_hybrid[31:0])
  ,.dp2reg_lut_int_data (dp2reg_lut_int_data[15:0])
  ,.dp2reg_lut_le_hit (dp2reg_lut_le_hit[31:0])
  ,.dp2reg_lut_lo_hit (dp2reg_lut_lo_hit[31:0])
  ,.dp2reg_lut_oflow (dp2reg_lut_oflow[31:0])
  ,.dp2reg_lut_uflow (dp2reg_lut_uflow[31:0])
  ,.reg2dp_cvt_offset (reg2dp_cvt_offset[31:0])
  ,.reg2dp_cvt_scale (reg2dp_cvt_scale[15:0])
  ,.reg2dp_cvt_shift (reg2dp_cvt_shift[5:0])
  ,.reg2dp_op_en (reg2dp_op_en)
  ,.reg2dp_flying_mode (reg2dp_flying_mode)
  ,.reg2dp_output_dst (reg2dp_output_dst)
  ,.reg2dp_nan_to_zero (reg2dp_nan_to_zero)
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0])
  ,.reg2dp_out_precision (reg2dp_out_precision[1:0])
  ,.reg2dp_perf_lut_en (reg2dp_perf_lut_en)
  ,.reg2dp_perf_sat_en (reg2dp_perf_sat_en)
  ,.dp2reg_done (dp2reg_done)
  ,.dp2reg_out_saturation (dp2reg_out_saturation[31:0])
  );
//=======================================
//CONFIG instance
//rdma has seperate config register, while wdma share with core
//---------------------------------------
NV_NVDLA_SDP_reg u_reg (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.csb2sdp_req_pd (csb2sdp_req_pd[62:0])
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd[33:0])
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.dp2reg_done (dp2reg_done)
  ,.dp2reg_out_saturation (dp2reg_out_saturation[31:0])
  ,.dp2reg_status_inf_input_num ({32{1'b0}})
  ,.dp2reg_status_nan_input_num ({32{1'b0}})
  ,.dp2reg_status_nan_output_num (dp2reg_status_nan_output_num[31:0])
  ,.dp2reg_status_unequal (dp2reg_status_unequal[0])
  ,.dp2reg_wdma_stall (dp2reg_wdma_stall[31:0])
  ,.reg2dp_ncore_slcg_op_en (reg2dp_ncore_slcg_op_en)
  ,.reg2dp_bn_alu_algo (reg2dp_bn_alu_algo[1:0])
  ,.reg2dp_bn_alu_bypass (reg2dp_bn_alu_bypass)
  ,.reg2dp_bn_alu_operand (reg2dp_bn_alu_operand[15:0])
  ,.reg2dp_bn_alu_shift_value (reg2dp_bn_alu_shift_value[5:0])
  ,.reg2dp_bn_alu_src (reg2dp_bn_alu_src)
  ,.reg2dp_bn_bypass (reg2dp_bn_bypass)
  ,.reg2dp_bn_mul_bypass (reg2dp_bn_mul_bypass)
  ,.reg2dp_bn_mul_operand (reg2dp_bn_mul_operand[15:0])
  ,.reg2dp_bn_mul_prelu (reg2dp_bn_mul_prelu)
  ,.reg2dp_bn_mul_shift_value (reg2dp_bn_mul_shift_value[7:0])
  ,.reg2dp_bn_mul_src (reg2dp_bn_mul_src)
  ,.reg2dp_bn_relu_bypass (reg2dp_bn_relu_bypass)
  ,.reg2dp_bcore_slcg_op_en (reg2dp_bcore_slcg_op_en)
  ,.reg2dp_bs_alu_algo (reg2dp_bs_alu_algo[1:0])
  ,.reg2dp_bs_alu_bypass (reg2dp_bs_alu_bypass)
  ,.reg2dp_bs_alu_operand (reg2dp_bs_alu_operand[15:0])
  ,.reg2dp_bs_alu_shift_value (reg2dp_bs_alu_shift_value[5:0])
  ,.reg2dp_bs_alu_src (reg2dp_bs_alu_src)
  ,.reg2dp_bs_bypass (reg2dp_bs_bypass)
  ,.reg2dp_bs_mul_bypass (reg2dp_bs_mul_bypass)
  ,.reg2dp_bs_mul_operand (reg2dp_bs_mul_operand[15:0])
  ,.reg2dp_bs_mul_prelu (reg2dp_bs_mul_prelu)
  ,.reg2dp_bs_mul_shift_value (reg2dp_bs_mul_shift_value[7:0])
  ,.reg2dp_bs_mul_src (reg2dp_bs_mul_src)
  ,.reg2dp_bs_relu_bypass (reg2dp_bs_relu_bypass)
  ,.reg2dp_ecore_slcg_op_en (reg2dp_ecore_slcg_op_en)
  ,.reg2dp_ew_alu_algo (reg2dp_ew_alu_algo[1:0])
  ,.reg2dp_ew_alu_bypass (reg2dp_ew_alu_bypass)
  ,.reg2dp_ew_alu_cvt_bypass (reg2dp_ew_alu_cvt_bypass)
  ,.reg2dp_ew_alu_cvt_offset (reg2dp_ew_alu_cvt_offset[31:0])
  ,.reg2dp_ew_alu_cvt_scale (reg2dp_ew_alu_cvt_scale[15:0])
  ,.reg2dp_ew_alu_cvt_truncate (reg2dp_ew_alu_cvt_truncate[5:0])
  ,.reg2dp_ew_alu_operand (reg2dp_ew_alu_operand[31:0])
  ,.reg2dp_ew_alu_src (reg2dp_ew_alu_src)
  ,.reg2dp_ew_bypass (reg2dp_ew_bypass)
  ,.reg2dp_ew_lut_bypass (reg2dp_ew_lut_bypass)
  ,.reg2dp_ew_mul_bypass (reg2dp_ew_mul_bypass)
  ,.reg2dp_ew_mul_cvt_bypass (reg2dp_ew_mul_cvt_bypass)
  ,.reg2dp_ew_mul_cvt_offset (reg2dp_ew_mul_cvt_offset[31:0])
  ,.reg2dp_ew_mul_cvt_scale (reg2dp_ew_mul_cvt_scale[15:0])
  ,.reg2dp_ew_mul_cvt_truncate (reg2dp_ew_mul_cvt_truncate[5:0])
  ,.reg2dp_ew_mul_operand (reg2dp_ew_mul_operand[31:0])
  ,.reg2dp_ew_mul_prelu (reg2dp_ew_mul_prelu)
  ,.reg2dp_ew_mul_src (reg2dp_ew_mul_src)
  ,.reg2dp_ew_truncate (reg2dp_ew_truncate[9:0])
  ,.reg2dp_lut_hybrid_priority (reg2dp_lut_hybrid_priority)
  ,.reg2dp_lut_int_access_type (reg2dp_lut_int_access_type)
  ,.reg2dp_lut_int_addr (reg2dp_lut_int_addr[9:0])
  ,.reg2dp_lut_int_data (reg2dp_lut_int_data[15:0])
  ,.reg2dp_lut_int_data_wr (reg2dp_lut_int_data_wr)
  ,.reg2dp_lut_int_table_id (reg2dp_lut_int_table_id)
  ,.reg2dp_lut_le_end (reg2dp_lut_le_end[31:0])
  ,.reg2dp_lut_le_function (reg2dp_lut_le_function)
  ,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
  ,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
  ,.reg2dp_lut_le_slope_oflow_scale (reg2dp_lut_le_slope_oflow_scale[15:0])
  ,.reg2dp_lut_le_slope_oflow_shift (reg2dp_lut_le_slope_oflow_shift[4:0])
  ,.reg2dp_lut_le_slope_uflow_scale (reg2dp_lut_le_slope_uflow_scale[15:0])
  ,.reg2dp_lut_le_slope_uflow_shift (reg2dp_lut_le_slope_uflow_shift[4:0])
  ,.reg2dp_lut_le_start (reg2dp_lut_le_start[31:0])
  ,.reg2dp_lut_lo_end (reg2dp_lut_lo_end[31:0])
  ,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
  ,.reg2dp_lut_lo_slope_oflow_scale (reg2dp_lut_lo_slope_oflow_scale[15:0])
  ,.reg2dp_lut_lo_slope_oflow_shift (reg2dp_lut_lo_slope_oflow_shift[4:0])
  ,.reg2dp_lut_lo_slope_uflow_scale (reg2dp_lut_lo_slope_uflow_scale[15:0])
  ,.reg2dp_lut_lo_slope_uflow_shift (reg2dp_lut_lo_slope_uflow_shift[4:0])
  ,.reg2dp_lut_lo_start (reg2dp_lut_lo_start[31:0])
  ,.reg2dp_lut_oflow_priority (reg2dp_lut_oflow_priority)
  ,.reg2dp_lut_slcg_en (reg2dp_lut_slcg_en)
  ,.reg2dp_lut_uflow_priority (reg2dp_lut_uflow_priority)
  ,.dp2reg_lut_hybrid (dp2reg_lut_hybrid[31:0])
  ,.dp2reg_lut_int_data (dp2reg_lut_int_data[15:0])
  ,.dp2reg_lut_le_hit (dp2reg_lut_le_hit[31:0])
  ,.dp2reg_lut_lo_hit (dp2reg_lut_lo_hit[31:0])
  ,.dp2reg_lut_oflow (dp2reg_lut_oflow[31:0])
  ,.dp2reg_lut_uflow (dp2reg_lut_uflow[31:0])
  ,.reg2dp_cvt_offset (reg2dp_cvt_offset[31:0])
  ,.reg2dp_cvt_scale (reg2dp_cvt_scale[15:0])
  ,.reg2dp_cvt_shift (reg2dp_cvt_shift[5:0])
  ,.reg2dp_wdma_slcg_op_en (reg2dp_wdma_slcg_op_en)
  ,.reg2dp_op_en (reg2dp_op_en)
  ,.reg2dp_flying_mode (reg2dp_flying_mode)
  ,.reg2dp_output_dst (reg2dp_output_dst)
  ,.reg2dp_batch_number (reg2dp_batch_number[4:0])
  ,.reg2dp_winograd (reg2dp_winograd)
  ,.reg2dp_channel (reg2dp_channel[12:0])
  ,.reg2dp_height (reg2dp_height[12:0])
  ,.reg2dp_width (reg2dp_width[12:0])
  ,.reg2dp_dst_ram_type (reg2dp_dst_ram_type)
  ,.reg2dp_dst_base_addr_high (reg2dp_dst_base_addr_high[31:0])
  ,.reg2dp_dst_base_addr_low (reg2dp_dst_base_addr_low[31:0])
  ,.reg2dp_dst_batch_stride (reg2dp_dst_batch_stride[31:0])
  ,.reg2dp_dst_line_stride (reg2dp_dst_line_stride[31:0])
  ,.reg2dp_dst_surface_stride (reg2dp_dst_surface_stride[31:0])
  ,.reg2dp_nan_to_zero (reg2dp_nan_to_zero)
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0])
  ,.reg2dp_out_precision (reg2dp_out_precision[1:0])
  ,.reg2dp_interrupt_ptr (reg2dp_interrupt_ptr)
  ,.reg2dp_perf_dma_en (reg2dp_perf_dma_en)
  ,.reg2dp_perf_lut_en (reg2dp_perf_lut_en)
  ,.reg2dp_perf_nan_inf_count_en ()
  ,.reg2dp_perf_sat_en (reg2dp_perf_sat_en)
  );
endmodule // NV_NVDLA_sdp


// Definition of NV_NVDLA_SDP_CACC2SDP_adapter
//==========================================================
module NV_NVDLA_SDP_CACC2SDP_adapter (
   nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,op_load //|< i
  ,reg2dp_batch_number //|< i
  ,reg2dp_channel //|< i
  ,reg2dp_height //|< i
  ,reg2dp_width //|< i
  ,reg2dp_proc_precision //|< i
  ,in_pvld //|> i
  ,in_prdy //|< o
  ,in_pd //|> i
  ,out_pvld //|> o
  ,out_prdy //|< i
  ,out_pd //|> o
  );
//
//
// NV_NVDLA_SDP_CACC2SDP_adapter.v
//
//
////////input and output declaration////////////
input                    nvdla_core_clk;
input                    nvdla_core_rstn;
input  [31:0]            pwrbus_ram_pd;
input                    op_load;

input  [4:0]             reg2dp_batch_number;
input  [12:0]            reg2dp_channel;
input  [12:0]            reg2dp_height;
input  [12:0]            reg2dp_width;
input  [1:0]             reg2dp_proc_precision;

input                    in_pvld;
output                   in_prdy;
input  [32*16 +2 -1:0]   in_pd;

output                   out_pvld;
input                    out_prdy;
output [32*16 +2 -1:0]   out_pd;
////////////////////////////////////////////////


////////////wire and reg declaration////////////
wire                     cfg_mode_batch;
wire                     cfg_mode_winog;
wire                     cfg_di_int8;
wire                     cfg_di_int16;
wire                     cfg_mode_8to16;
wire                     cfg_mode_norml;
wire                     cfg_mode_1x1_pack;
wire                     cfg_mode_1x1_nbatch;
wire   [4:0]             size_of_batch;
wire   [13:0]            size_of_width;
wire   [12:0]            size_of_height;
wire                     in_burst_end;
wire   [13:0]            in_burst_len;
wire                     in_last_batch;
wire                     in_last_wg;
wire                     in_winog_end;
wire                     in_ftrans;
wire                     in_ltrans;
wire                     in_last_w;
wire                     in_last_e;
wire                     in_elem_end;
wire                     in_line_end;
wire                     in_last_h;
wire                     in_surf_end;
wire                     in_last_c;
wire                     in_cube_end;
wire                     batch0_fifo_in_en;
wire                     batch1_fifo_in_en;
wire                     batch2_fifo_in_en;
wire                     batch3_fifo_in_en;
wire                     batch4_fifo_in_en;
wire                     batch5_fifo_in_en;
wire                     batch6_fifo_in_en;
wire                     batch7_fifo_in_en;
wire                     batch0_fifo_in_vld;
wire                     batch1_fifo_in_vld;
wire                     batch2_fifo_in_vld;
wire                     batch3_fifo_in_vld;
wire                     batch4_fifo_in_vld;
wire                     batch5_fifo_in_vld;
wire                     batch6_fifo_in_vld;
wire                     batch7_fifo_in_vld;
wire                     batch0_fifo_in_rdy;
wire                     batch1_fifo_in_rdy;
wire                     batch2_fifo_in_rdy;
wire                     batch3_fifo_in_rdy;
wire                     batch4_fifo_in_rdy;
wire                     batch5_fifo_in_rdy;
wire                     batch6_fifo_in_rdy;
wire                     batch7_fifo_in_rdy;
wire                     batch0_fifo_out_vld;
wire                     batch1_fifo_out_vld;
wire                     batch2_fifo_out_vld;
wire                     batch3_fifo_out_vld;
wire                     batch4_fifo_out_vld;
wire                     batch5_fifo_out_vld;
wire                     batch6_fifo_out_vld;
wire                     batch7_fifo_out_vld;
wire                     batch0_fifo_out_rdy;
wire                     batch1_fifo_out_rdy;
wire                     batch2_fifo_out_rdy;
wire                     batch3_fifo_out_rdy;
wire                     batch4_fifo_out_rdy;
wire                     batch5_fifo_out_rdy;
wire                     batch6_fifo_out_rdy;
wire                     batch7_fifo_out_rdy;
wire   [32*16 +2 -1:0]   batch0_fifo_out_pd;
wire   [32*16 +2 -1:0]   batch1_fifo_out_pd;
wire   [32*16 +2 -1:0]   batch2_fifo_out_pd;
wire   [32*16 +2 -1:0]   batch3_fifo_out_pd;
wire   [32*16 +2 -1:0]   batch4_fifo_out_pd;
wire   [32*16 +2 -1:0]   batch5_fifo_out_pd;
wire   [32*16 +2 -1:0]   batch6_fifo_out_pd;
wire   [32*16 +2 -1:0]   batch7_fifo_out_pd;
wire                     batch0_fifo_out_en;
wire                     batch1_fifo_out_en;
wire                     batch2_fifo_out_en;
wire                     batch3_fifo_out_en;
wire                     batch4_fifo_out_en;
wire                     batch5_fifo_out_en;
wire                     batch6_fifo_out_en;
wire                     batch7_fifo_out_en;
wire                     out_burst_end;
wire   [13:0]            out_burst_len;
wire   [13:0]            out_line_left;
wire                     out_last_batch;
wire                     out_last_wg;
wire                     out_winog_end;
wire                     out_ftrans;
wire                     out_ltrans;
wire                     out_last_w;
wire                     out_last_e;
wire                     out_elem_end;
wire                     out_line_end;
wire                     out_last_h;
wire                     out_surf_end;
wire                     out_last_c;
wire                     out_cube_end;

reg    [13-5:0]          size_of_surf;
reg    [13:0]            in_count_burst;
reg    [4:0]             in_count_batch;
reg    [13:0]            in_count_w;
reg    [12:0]            in_count_h;
reg    [13-5:0]          in_count_c;
reg    [13:0]            out_count_burst;
reg    [4:0]             out_count_batch;
reg    [13:0]            out_count_w;
reg    [12:0]            out_count_h;
reg    [13-5:0]          out_count_c;
////////////////////////////////////////////////


////////cfg reg////////////
assign cfg_mode_batch      = (reg2dp_batch_number!=0);
assign cfg_mode_winog      = 1'b0 ;
assign cfg_di_int8         = reg2dp_proc_precision == 0 ;
assign cfg_di_int16        = reg2dp_proc_precision == 1 ;
assign cfg_mode_8to16      = 1'b0;
assign cfg_mode_norml      = !(cfg_mode_batch | cfg_mode_winog | cfg_mode_8to16);
assign cfg_mode_1x1_pack   = (reg2dp_width==0) & (reg2dp_height==0);
assign cfg_mode_1x1_nbatch = cfg_mode_1x1_pack & !cfg_mode_batch ;
///////////////////////////
//
// Cube Shape
//=================================================
assign size_of_batch  = reg2dp_batch_number;
assign size_of_width  = {1'b0, reg2dp_width};
assign size_of_height = reg2dp_height;

//Surf is always in unit of ATOMIC (1x1x32B)
always @(
     cfg_di_int8
  or cfg_di_int16
  or reg2dp_channel
  ) begin
    if (cfg_di_int8) begin
        size_of_surf = {1'b0,reg2dp_channel[12:5]};
    end else if (cfg_di_int16) begin
        size_of_surf = reg2dp_channel[12:5 -1];
    end else begin
        size_of_surf = reg2dp_channel[12:5 -1];
    end
end
//=================================================
//
//input data count
//=================================================
//==============
// BURST Count:
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        in_count_burst <= {14{1'b0}};
    end else begin
        if (in_pvld & in_prdy) begin
            if (in_burst_end) begin
                in_count_burst <= 0;
            end else begin
                in_count_burst <= in_count_burst + 1'b1;
            end
        end
    end
end

//assign in_burst_len     = ((size_of_width - in_count_w) >= BURST_LEN) ? BURST_LEN : (size_of_width - in_count_w);
//assign in_burst_len     = ((size_of_width + 1 - in_count_w) >= 2) ? 2 : (size_of_width + 1 - in_count_w);
assign in_burst_len     = 2;
assign in_burst_end     = (in_count_burst == in_burst_len-1);
//==============
// BATCH Count:
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        in_count_batch <= {5{1'b0}};
    end else begin
        if (cfg_mode_batch) begin // this to gate in_count_batch in batch mode
            if (in_pvld & in_prdy) begin
                if (in_last_batch) begin
                    in_count_batch <= 0;
                end else if(in_burst_end) begin
                    in_count_batch <= in_count_batch + 1;
                end
            end
        end
    end
end

assign in_last_batch = (in_count_batch==size_of_batch) & in_burst_end;
//==============
// WIDTH Count:
//==============
assign in_last_wg   = 1'b1;
assign in_winog_end = in_last_wg;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    in_count_w <= {14{1'b0}};
  end else begin
    if (in_pvld & in_prdy) begin
        if (in_line_end) begin
            in_count_w <= 0;
        end else if (in_last_batch & in_winog_end) begin
            in_count_w <= in_count_w + 1'b1;
        end
    end
  end
end

assign in_ftrans   = (in_count_w==0);
assign in_ltrans   = (in_count_w==size_of_width);
assign in_last_w   = in_ltrans;
assign in_last_e   = 1'b1;
assign in_elem_end = cfg_mode_1x1_nbatch | in_last_e;
assign in_line_end = cfg_mode_1x1_nbatch | cfg_mode_norml | (in_last_batch & in_elem_end & in_last_w & in_winog_end);
//==============
// HEIGHT Count:
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        in_count_h <= {13{1'b0}};
    end else begin
        if (in_pvld & in_prdy) begin
            if (in_last_batch) begin
                if (in_surf_end) begin
                    in_count_h <= 0;
                end else if (in_line_end) begin
                    in_count_h <= in_count_h + 1;
                end
            end
        end
    end
end

assign in_last_h   = (in_count_h==size_of_height);
assign in_surf_end = cfg_mode_1x1_nbatch | in_line_end & in_last_h;
//==============
// CHANNEL Count
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        in_count_c <= {9{1'b0}};
    end else begin
        if (in_pvld & in_prdy) begin
            if (in_last_batch) begin
                if (in_cube_end) begin
                    in_count_c <= 0;
                end else if (in_surf_end) begin
                    in_count_c <= in_count_c + 1;
                end
            end
        end
    end
end

assign in_last_c   = (in_count_c==size_of_surf);
assign in_cube_end = cfg_mode_1x1_nbatch | in_surf_end & in_last_c;
//=================================================
//
assign batch0_fifo_in_en  = (in_count_batch == 5'd0);
assign batch1_fifo_in_en  = (in_count_batch == 5'd1);
assign batch2_fifo_in_en  = (in_count_batch == 5'd2);
assign batch3_fifo_in_en  = (in_count_batch == 5'd3);
assign batch4_fifo_in_en  = (in_count_batch == 5'd4);
assign batch5_fifo_in_en  = (in_count_batch == 5'd5);
assign batch6_fifo_in_en  = (in_count_batch == 5'd6);
assign batch7_fifo_in_en  = (in_count_batch == 5'd7);

assign batch0_fifo_in_vld = in_pvld & batch0_fifo_in_en;
assign batch1_fifo_in_vld = in_pvld & batch1_fifo_in_en;
assign batch2_fifo_in_vld = in_pvld & batch2_fifo_in_en;
assign batch3_fifo_in_vld = in_pvld & batch3_fifo_in_en;
assign batch4_fifo_in_vld = in_pvld & batch4_fifo_in_en;
assign batch5_fifo_in_vld = in_pvld & batch5_fifo_in_en;
assign batch6_fifo_in_vld = in_pvld & batch6_fifo_in_en;
assign batch7_fifo_in_vld = in_pvld & batch7_fifo_in_en;

assign in_prdy            = cfg_mode_batch ?
                           (batch0_fifo_in_en ? batch0_fifo_in_rdy :
                            batch1_fifo_in_en ? batch1_fifo_in_rdy :
                            batch2_fifo_in_en ? batch2_fifo_in_rdy :
                            batch3_fifo_in_en ? batch3_fifo_in_rdy :
                            batch4_fifo_in_en ? batch4_fifo_in_rdy :
                            batch5_fifo_in_en ? batch5_fifo_in_rdy :
                            batch6_fifo_in_en ? batch6_fifo_in_rdy :
                                                batch7_fifo_in_rdy ) :
                            out_prdy;


// CACC OUTPUT FIFO
//=================================================
NV_NVDLA_SDP_CACC2SDP_fifo u_batch0_fifo (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd   (pwrbus_ram_pd[31:0])
  ,.in_fifo_pvld    (batch0_fifo_in_vld)
  ,.in_fifo_prdy    (batch0_fifo_in_rdy)
  ,.in_fifo_pd      (in_pd[32*16 +2 -1:0])
  ,.out_fifo_pvld   (batch0_fifo_out_vld)
  ,.out_fifo_prdy   (batch0_fifo_out_rdy)
  ,.out_fifo_pd     (batch0_fifo_out_pd[32*16 +2 -1:0])
  );

NV_NVDLA_SDP_CACC2SDP_fifo u_batch1_fifo (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd   (pwrbus_ram_pd[31:0])
  ,.in_fifo_pvld    (batch1_fifo_in_vld)
  ,.in_fifo_prdy    (batch1_fifo_in_rdy)
  ,.in_fifo_pd      (in_pd[32*16 +2 -1:0])
  ,.out_fifo_pvld   (batch1_fifo_out_vld)
  ,.out_fifo_prdy   (batch1_fifo_out_rdy)
  ,.out_fifo_pd     (batch1_fifo_out_pd[32*16 +2 -1:0])
  );

NV_NVDLA_SDP_CACC2SDP_fifo u_batch2_fifo (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd   (pwrbus_ram_pd[31:0])
  ,.in_fifo_pvld    (batch2_fifo_in_vld)
  ,.in_fifo_prdy    (batch2_fifo_in_rdy)
  ,.in_fifo_pd      (in_pd[32*16 +2 -1:0])
  ,.out_fifo_pvld   (batch2_fifo_out_vld)
  ,.out_fifo_prdy   (batch2_fifo_out_rdy)
  ,.out_fifo_pd     (batch2_fifo_out_pd[32*16 +2 -1:0])
  );

NV_NVDLA_SDP_CACC2SDP_fifo u_batch3_fifo (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd   (pwrbus_ram_pd[31:0])
  ,.in_fifo_pvld    (batch3_fifo_in_vld)
  ,.in_fifo_prdy    (batch3_fifo_in_rdy)
  ,.in_fifo_pd      (in_pd[32*16 +2 -1:0])
  ,.out_fifo_pvld   (batch3_fifo_out_vld)
  ,.out_fifo_prdy   (batch3_fifo_out_rdy)
  ,.out_fifo_pd     (batch3_fifo_out_pd[32*16 +2 -1:0])
  );

NV_NVDLA_SDP_CACC2SDP_fifo u_batch4_fifo (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd   (pwrbus_ram_pd[31:0])
  ,.in_fifo_pvld    (batch4_fifo_in_vld)
  ,.in_fifo_prdy    (batch4_fifo_in_rdy)
  ,.in_fifo_pd      (in_pd[32*16 +2 -1:0])
  ,.out_fifo_pvld   (batch4_fifo_out_vld)
  ,.out_fifo_prdy   (batch4_fifo_out_rdy)
  ,.out_fifo_pd     (batch4_fifo_out_pd[32*16 +2 -1:0])
  );

NV_NVDLA_SDP_CACC2SDP_fifo u_batch5_fifo (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd   (pwrbus_ram_pd[31:0])
  ,.in_fifo_pvld    (batch5_fifo_in_vld)
  ,.in_fifo_prdy    (batch5_fifo_in_rdy)
  ,.in_fifo_pd      (in_pd[32*16 +2 -1:0])
  ,.out_fifo_pvld   (batch5_fifo_out_vld)
  ,.out_fifo_prdy   (batch5_fifo_out_rdy)
  ,.out_fifo_pd     (batch5_fifo_out_pd[32*16 +2 -1:0])
  );

NV_NVDLA_SDP_CACC2SDP_fifo u_batch6_fifo (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd   (pwrbus_ram_pd[31:0])
  ,.in_fifo_pvld    (batch6_fifo_in_vld)
  ,.in_fifo_prdy    (batch6_fifo_in_rdy)
  ,.in_fifo_pd      (in_pd[32*16 +2 -1:0])
  ,.out_fifo_pvld   (batch6_fifo_out_vld)
  ,.out_fifo_prdy   (batch6_fifo_out_rdy)
  ,.out_fifo_pd     (batch6_fifo_out_pd[32*16 +2 -1:0])
  );

NV_NVDLA_SDP_CACC2SDP_fifo u_batch7_fifo (
   .nvdla_core_clk  (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.pwrbus_ram_pd   (pwrbus_ram_pd[31:0])
  ,.in_fifo_pvld    (batch7_fifo_in_vld)
  ,.in_fifo_prdy    (batch7_fifo_in_rdy)
  ,.in_fifo_pd      (in_pd[32*16 +2 -1:0])
  ,.out_fifo_pvld   (batch7_fifo_out_vld)
  ,.out_fifo_prdy   (batch7_fifo_out_rdy)
  ,.out_fifo_pd     (batch7_fifo_out_pd[32*16 +2 -1:0])
  );
//=================================================
//
assign batch0_fifo_out_en  = (out_count_batch == 5'd0);
assign batch1_fifo_out_en  = (out_count_batch == 5'd1);
assign batch2_fifo_out_en  = (out_count_batch == 5'd2);
assign batch3_fifo_out_en  = (out_count_batch == 5'd3);
assign batch4_fifo_out_en  = (out_count_batch == 5'd4);
assign batch5_fifo_out_en  = (out_count_batch == 5'd5);
assign batch6_fifo_out_en  = (out_count_batch == 5'd6);
assign batch7_fifo_out_en  = (out_count_batch == 5'd7);

assign batch0_fifo_out_rdy = out_prdy & batch0_fifo_out_en;
assign batch1_fifo_out_rdy = out_prdy & batch1_fifo_out_en;
assign batch2_fifo_out_rdy = out_prdy & batch2_fifo_out_en;
assign batch3_fifo_out_rdy = out_prdy & batch3_fifo_out_en;
assign batch4_fifo_out_rdy = out_prdy & batch4_fifo_out_en;
assign batch5_fifo_out_rdy = out_prdy & batch5_fifo_out_en;
assign batch6_fifo_out_rdy = out_prdy & batch6_fifo_out_en;
assign batch7_fifo_out_rdy = out_prdy & batch7_fifo_out_en;

assign out_pvld            = cfg_mode_batch ?
                            (batch0_fifo_out_en ? batch0_fifo_out_vld :
                             batch1_fifo_out_en ? batch1_fifo_out_vld :
                             batch2_fifo_out_en ? batch2_fifo_out_vld :
                             batch3_fifo_out_en ? batch3_fifo_out_vld :
                             batch4_fifo_out_en ? batch4_fifo_out_vld :
                             batch5_fifo_out_en ? batch5_fifo_out_vld :
                             batch6_fifo_out_en ? batch6_fifo_out_vld :
                                                  batch7_fifo_out_vld ) :
                             in_pvld;
assign out_pd              = cfg_mode_batch ?
                            (batch0_fifo_out_en ? batch0_fifo_out_pd :
                             batch1_fifo_out_en ? batch1_fifo_out_pd :
                             batch2_fifo_out_en ? batch2_fifo_out_pd :
                             batch3_fifo_out_en ? batch3_fifo_out_pd :
                             batch4_fifo_out_en ? batch4_fifo_out_pd :
                             batch5_fifo_out_en ? batch5_fifo_out_pd :
                             batch6_fifo_out_en ? batch6_fifo_out_pd :
                                                  batch7_fifo_out_pd ) :
                             in_pd;
//output data count
//=================================================
//==============
// BURST Count:
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        out_count_burst <= {14{1'b0}};
    end else begin
        if (out_pvld & out_prdy) begin
            if (out_burst_end) begin
                out_count_burst <= 0;
            end else begin
                out_count_burst <= out_count_burst + 1'b1;
            end
        end
    end
end

//assign out_burst_len     = ((size_of_width - out_count_w) >= BURST_LEN) ? BURST_LEN : (size_of_width - out_count_w);
//assign out_burst_len = ((size_of_width + 1 - out_count_w) >= 4) ? 4 : (size_of_width + 1 - out_count_w);
assign out_line_left = size_of_width + 1 - out_count_w;
assign out_burst_len = (out_line_left >= 14'd2) ? 14'd4 : {out_line_left,1'b0};
assign out_burst_end = (out_count_burst == out_burst_len-1);
//==============
// BATCH Count:
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        out_count_batch <= {5{1'b0}};
    end else begin
        if (cfg_mode_batch) begin // this to gate out_count_batch in batch mode
            if (out_pvld & out_prdy) begin
                if (out_last_batch) begin
                    out_count_batch <= 0;
                end else if(out_burst_end) begin
                    out_count_batch <= out_count_batch + 1;
                end
            end
        end
    end
end

assign out_last_batch = (out_count_batch==size_of_batch) & out_burst_end;
//==============
// WIDTH Count:
//==============
assign out_last_wg   = 1'b1;
assign out_winog_end = out_last_wg;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    out_count_w <= {14{1'b0}};
  end else begin
    if (out_pvld & out_prdy) begin
        if (out_line_end) begin
            out_count_w <= 0;
        end else if (out_last_batch & out_winog_end) begin
            out_count_w <= out_count_w + out_burst_len[13:1];
        end
    end
  end
end

assign out_ftrans   = (out_count_w==0);
assign out_ltrans   = (out_count_w+out_burst_len[13:1]==size_of_width+1);
assign out_last_w   = out_ltrans;
assign out_last_e   = 1'b1;
assign out_elem_end = cfg_mode_1x1_nbatch | out_last_e;
assign out_line_end = cfg_mode_1x1_nbatch | cfg_mode_norml | (out_last_batch & out_elem_end & out_last_w & out_winog_end);
//==============
// HEIGHT Count:
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        out_count_h <= {13{1'b0}};
    end else begin
        if (out_pvld & out_prdy) begin
            if (out_last_batch) begin
                if (out_surf_end) begin
                    out_count_h <= 0;
                end else if (out_line_end) begin
                    out_count_h <= out_count_h + 1;
                end
            end
        end
    end
end

assign out_last_h   = (out_count_h==size_of_height);
assign out_surf_end = cfg_mode_1x1_nbatch | out_line_end & out_last_h;
//==============
// CHANNEL Count
//==============
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        out_count_c <= {9{1'b0}};
    end else begin
        if (out_pvld & out_prdy) begin
            if (out_last_batch) begin
                if (out_cube_end) begin
                    out_count_c <= 0;
                end else if (out_surf_end) begin
                    out_count_c <= out_count_c + 1;
                end
            end
        end
    end
end

assign out_last_c   = (out_count_c==size_of_surf);
assign out_cube_end = cfg_mode_1x1_nbatch | out_surf_end & out_last_c;
//=================================================


endmodule // NV_NVDLA_SDP_CACC2SDP_adapter
//==========================================================


//Definition of NV_NVDLA_SDP_CACC2SDP_fifo
//==========================================================
`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
`include "simulate_x_tick.vh"
module NV_NVDLA_SDP_CACC2SDP_fifo (
      nvdla_core_clk
    , nvdla_core_rstn
    , pwrbus_ram_pd
    , in_fifo_pvld
    , in_fifo_prdy
    , in_fifo_pd
    , out_fifo_pvld
    , out_fifo_prdy
    , out_fifo_pd
    );
// spyglass disable_block W401 -- clock is not input to module
input nvdla_core_clk;
input nvdla_core_rstn;
output in_fifo_prdy;
input in_fifo_pvld;
input [513:0] in_fifo_pd;
input out_fifo_prdy;
output out_fifo_pvld;
output [513:0] out_fifo_pd;
input [31:0] pwrbus_ram_pd;
// Master Clock Gating (SLCG)
//
// We gate the clock(s) when idle or stalled.
// This allows us to turn off numerous miscellaneous flops
// that don't get gated during synthesis for one reason or another.
//
// We gate write side and read side separately.
// If the fifo is synchronous, we also gate the ram separately, but if
// -master_clk_gated_unified or -status_reg/-status_logic_reg is specified,
// then we use one clk gate for write, ram, and read.
//
wire nvdla_core_clk_mgated_enable; // assigned by code at end of this module
wire nvdla_core_clk_mgated; // used only in synchronous fifos
NV_CLK_gate_power nvdla_core_clk_mgate( .clk(nvdla_core_clk), .reset_(nvdla_core_rstn), .clk_en(nvdla_core_clk_mgated_enable), .clk_gated(nvdla_core_clk_mgated) );
//
// WRITE SIDE
//
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
wire wr_pause_rand; // random stalling
`endif
`endif
// synopsys translate_on
wire wr_reserving;
reg in_fifo_busy_int; // copy for internal use
assign in_fifo_prdy = !in_fifo_busy_int;
assign wr_reserving = in_fifo_pvld && !in_fifo_busy_int; // reserving write space?
reg wr_popping; // fwd: write side sees pop?
reg [3:0] in_fifo_count; // write-side count
wire [3:0] wr_count_next_wr_popping = wr_reserving ? in_fifo_count : (in_fifo_count - 1'd1); // spyglass disable W164a W484
wire [3:0] wr_count_next_no_wr_popping = wr_reserving ? (in_fifo_count + 1'd1) : in_fifo_count; // spyglass disable W164a W484
wire [3:0] wr_count_next = wr_popping ? wr_count_next_wr_popping :
                                               wr_count_next_no_wr_popping;
wire wr_count_next_no_wr_popping_is_8 = ( wr_count_next_no_wr_popping == 4'd8 );
wire wr_count_next_is_8 = wr_popping ? 1'b0 :
                                          wr_count_next_no_wr_popping_is_8;
wire [3:0] wr_limit_muxed; // muxed with simulation/emulation overrides
wire [3:0] wr_limit_reg = wr_limit_muxed;
`ifdef FV_RAND_WR_PAUSE
// VCS coverage off
wire in_fifo_busy_next = wr_count_next_is_8 || // busy next cycle?
                          (wr_limit_reg != 4'd0 && // check in_fifo_limit if != 0
                           wr_count_next >= wr_limit_reg) ;
// VCS coverage on
`else
// VCS coverage off
wire in_fifo_busy_next = wr_count_next_is_8 || // busy next cycle?
                          (wr_limit_reg != 4'd0 && // check in_fifo_limit if != 0
                           wr_count_next >= wr_limit_reg)
// synopsys translate_off
  `ifndef SYNTH_LEVEL1_COMPILE
  `ifndef SYNTHESIS
 || wr_pause_rand
  `endif
  `endif
// synopsys translate_on
;
// VCS coverage on
`endif
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        in_fifo_busy_int <= 1'b0;
        in_fifo_count <= 4'd0;
    end else begin
 in_fifo_busy_int <= in_fifo_busy_next;
 if ( wr_reserving ^ wr_popping ) begin
     in_fifo_count <= wr_count_next;
        end
//synopsys translate_off
            else if ( !(wr_reserving ^ wr_popping) ) begin
        end else begin
            in_fifo_count <= {4{`x_or_0}};
        end
//synopsys translate_on
    end
end
wire wr_pushing = wr_reserving; // data pushed same cycle as in_fifo_pvld
//
// RAM
//
reg [2:0] in_fifo_adr; // current write address
wire [2:0] out_fifo_adr_p; // read address to use for ram
wire [513:0] out_fifo_pd_p; // read data directly out of ram
wire rd_enable;
wire ore;
wire [31 : 0] pwrbus_ram_pd;
// Adding parameter for fifogen to disable wr/rd contention assertion in ramgen.
// Fifogen handles this by ignoring the data on the ram data out for that cycle.
nv_ram_rwsp_8x514 #(`FORCE_CONTENTION_ASSERTION_RESET_ACTIVE) ram (
      .clk ( nvdla_core_clk )
    , .pwrbus_ram_pd ( pwrbus_ram_pd )
    , .wa ( in_fifo_adr )
    , .we ( wr_pushing )
    , .di ( in_fifo_pd )
    , .ra ( out_fifo_adr_p )
    , .re ( rd_enable )
    , .dout ( out_fifo_pd_p )
    , .ore ( ore )
    );
// next in_fifo_adr if wr_pushing=1
wire [2:0] wr_adr_next = in_fifo_adr + 1'd1; // spyglass disable W484
// spyglass disable_block W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        in_fifo_adr <= 3'd0;
    end else begin
        if ( wr_pushing ) begin
            in_fifo_adr <= wr_adr_next;
        end
//synopsys translate_off
            else if ( !(wr_pushing) ) begin
        end else begin
            in_fifo_adr <= {3{`x_or_0}};
        end
//synopsys translate_on
    end
end
// spyglass enable_block W484
wire rd_popping; // read side doing pop this cycle?
reg [2:0] out_fifo_adr; // current read address
// next read address
wire [2:0] rd_adr_next = out_fifo_adr + 1'd1; // spyglass disable W484
assign out_fifo_adr_p = rd_popping ? rd_adr_next : out_fifo_adr; // for ram
// spyglass disable_block W484
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        out_fifo_adr <= 3'd0;
    end else begin
        if ( rd_popping ) begin
     out_fifo_adr <= rd_adr_next;
        end
//synopsys translate_off
            else if ( !rd_popping ) begin
        end else begin
            out_fifo_adr <= {3{`x_or_0}};
        end
//synopsys translate_on
    end
end
// spyglass enable_block W484
//
// SYNCHRONOUS BOUNDARY
//
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        wr_popping <= 1'b0;
    end else begin
 wr_popping <= rd_popping;
    end
end
reg rd_pushing;
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        rd_pushing <= 1'b0;
    end else begin
 rd_pushing <= wr_pushing; // let data go into ram first
    end
end
//
// READ SIDE
//
reg out_fifo_pvld_p; // data out of fifo is valid
reg out_fifo_pvld_int; // internal copy of out_fifo_pvld
assign out_fifo_pvld = out_fifo_pvld_int;
assign rd_popping = out_fifo_pvld_p && !(out_fifo_pvld_int && !out_fifo_prdy);
reg [3:0] out_fifo_count_p; // read-side fifo count
// spyglass disable_block W164a W484
wire [3:0] rd_count_p_next_rd_popping = rd_pushing ? out_fifo_count_p :
                                                                (out_fifo_count_p - 1'd1);
wire [3:0] rd_count_p_next_no_rd_popping = rd_pushing ? (out_fifo_count_p + 1'd1) :
                                                                    out_fifo_count_p;
// spyglass enable_block W164a W484
wire [3:0] rd_count_p_next = rd_popping ? rd_count_p_next_rd_popping :
                                                     rd_count_p_next_no_rd_popping;
wire rd_count_p_next_rd_popping_not_0 = rd_count_p_next_rd_popping != 0;
wire rd_count_p_next_no_rd_popping_not_0 = rd_count_p_next_no_rd_popping != 0;
wire rd_count_p_next_not_0 = rd_popping ? rd_count_p_next_rd_popping_not_0 :
                                              rd_count_p_next_no_rd_popping_not_0;
assign rd_enable = ((rd_count_p_next_not_0) && ((~out_fifo_pvld_p) || rd_popping)); // anytime data's there and not stalled
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        out_fifo_count_p <= 4'd0;
        out_fifo_pvld_p <= 1'b0;
    end else begin
        if ( rd_pushing || rd_popping ) begin
     out_fifo_count_p <= rd_count_p_next;
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            out_fifo_count_p <= {4{`x_or_0}};
        end
//synopsys translate_on
        if ( rd_pushing || rd_popping ) begin
     out_fifo_pvld_p <= (rd_count_p_next_not_0);
        end
//synopsys translate_off
            else if ( !(rd_pushing || rd_popping ) ) begin
        end else begin
            out_fifo_pvld_p <= `x_or_0;
        end
//synopsys translate_on
    end
end
wire rd_req_next = (out_fifo_pvld_p || (out_fifo_pvld_int && !out_fifo_prdy)) ;
always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        out_fifo_pvld_int <= 1'b0;
    end else begin
        out_fifo_pvld_int <= rd_req_next;
    end
end
assign out_fifo_pd = out_fifo_pd_p;
assign ore = rd_popping;
// Master Clock Gating (SLCG) Enables
//
// plusarg for disabling this stuff:
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg master_clk_gating_disabled; initial master_clk_gating_disabled = $test$plusargs( "fifogen_disable_master_clk_gating" ) != 0;
`endif
`endif
// synopsys translate_on
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
reg wr_pause_rand_dly;
always @( posedge nvdla_core_clk or negedge nvdla_core_rstn ) begin
    if ( !nvdla_core_rstn ) begin
        wr_pause_rand_dly <= 1'b0;
    end else begin
        wr_pause_rand_dly <= wr_pause_rand;
    end
end
`endif
`endif
// synopsys translate_on
assign nvdla_core_clk_mgated_enable = ((wr_reserving || wr_pushing || rd_popping || wr_popping || (in_fifo_pvld && !in_fifo_busy_int) || (in_fifo_busy_int != in_fifo_busy_next)) || (rd_pushing || rd_popping || (out_fifo_pvld_int && out_fifo_prdy) || wr_pushing))
                               `ifdef FIFOGEN_MASTER_CLK_GATING_DISABLED
                               || 1'b1
                               `endif
// synopsys translate_off
          `ifndef SYNTH_LEVEL1_COMPILE
          `ifndef SYNTHESIS
                               || master_clk_gating_disabled || (wr_pause_rand != wr_pause_rand_dly)
          `endif
          `endif
// synopsys translate_on
                               ;
// Simulation and Emulation Overrides of wr_limit(s)
//
`ifdef EMU
`ifdef EMU_FIFO_CFG
// Emulation Global Config Override
//
assign wr_limit_muxed = `EMU_FIFO_CFG.NV_NVDLA_SDP_CACC2SDP_fifo_wr_limit_override ? `EMU_FIFO_CFG.NV_NVDLA_SDP_CACC2SDP_fifo_wr_limit : 4'd0;
`else
// No Global Override for Emulation
//
assign wr_limit_muxed = 4'd0;
`endif // EMU_FIFO_CFG
`else // !EMU
`ifdef SYNTH_LEVEL1_COMPILE
// No Override for GCS Compiles
//
assign wr_limit_muxed = 4'd0;
`else
`ifdef SYNTHESIS
// No Override for RTL Synthesis
//
assign wr_limit_muxed = 4'd0;
`else
// RTL Simulation Plusarg Override
// VCS coverage off
reg wr_limit_override;
reg [3:0] wr_limit_override_value;
assign wr_limit_muxed = wr_limit_override ? wr_limit_override_value : 4'd0;
`ifdef NV_ARCHPRO
event reinit;
initial begin
    $display("fifogen reinit initial block %m");
    -> reinit;
end
`endif
`ifdef NV_ARCHPRO
always @( reinit ) begin
`else
initial begin
`endif
    wr_limit_override = 0;
    wr_limit_override_value = 0; // to keep viva happy with dangles
    if ( $test$plusargs( "NV_NVDLA_SDP_CACC2SDP_fifo_wr_limit" ) ) begin
        wr_limit_override = 1;
        $value$plusargs( "NV_NVDLA_SDP_CACC2SDP_fifo_wr_limit=%d", wr_limit_override_value);
    end
end
// VCS coverage on
`endif
`endif
`endif
// VCS coverage on
//
// Histogram of fifo depth (from write side's perspective)
//
// NOTE: it will reference `SIMTOP.perfmon_enabled, so that
// has to at least be defined, though not initialized.
// tbgen testbenches have it already and various
// ways to turn it on and off.
//
`ifdef PERFMON_HISTOGRAM
// synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
perfmon_histogram perfmon (
      .clk ( nvdla_core_clk )
    , .max ( {28'd0, (wr_limit_reg == 4'd0) ? 4'd8 : wr_limit_reg} )
    , .curr ( {28'd0, in_fifo_count} )
    );
`endif
`endif
// synopsys translate_on
`endif
// spyglass disable_block W164a W164b W116 W484 W504
`ifdef SPYGLASS
`else
`ifdef FV_ASSERT_ON
`else
// synopsys translate_off
`endif
`ifdef ASSERT_ON
`ifdef SPYGLASS
wire disable_assert_plusarg = 1'b0;
`else
`ifdef FV_ASSERT_ON
wire disable_assert_plusarg = 1'b0;
`else
wire disable_assert_plusarg = $test$plusargs("DISABLE_NESS_FLOW_ASSERTIONS");
`endif
`endif
wire assert_enabled = 1'b1 && !disable_assert_plusarg;
`endif
`ifdef FV_ASSERT_ON
`else
// synopsys translate_on
`endif
`ifdef ASSERT_ON
//synopsys translate_off
`ifndef SYNTH_LEVEL1_COMPILE
`ifndef SYNTHESIS
always @(assert_enabled) begin
    if ( assert_enabled === 1'b0 ) begin
        $display("Asserts are disabled for %m");
    end
end
`endif
`endif
//synopsys translate_on
`endif
`endif
// spyglass enable_block W164a W164b W116 W484 W504
//The NV_BLKBOX_SRC0 module is only present when the FIFOGEN_MODULE_SEARCH
// define is set. This is to aid fifogen team search for fifogen fifo
// instance and module names in a given design.
`ifdef FIFOGEN_MODULE_SEARCH
NV_BLKBOX_SRC0 dummy_breadcrumb_fifogen_blkbox (.Y());
`endif
// spyglass enable_block W401 -- clock is not input to module
// synopsys dc_script_begin
// set_boundary_optimization find(design, "NV_NVDLA_SDP_CACC2SDP_fifo") true
// synopsys dc_script_end
//| &Attachment -no_warn EndModulePrepend;
endmodule // NV_NVDLA_SDP_CACC2SDP_fifo
//==========================================================
//
//
//
//Definition of nv_ram_rwsp_8x514
//==========================================================
module nv_ram_rwsp_8x514 (
  clk,
  ra,
  re,
  ore,
  dout,
  wa,
  we,
  di,
  pwrbus_ram_pd
);
parameter FORCE_CONTENTION_ASSERTION_RESET_ACTIVE=1'b0;
// port list
input clk;
input [2:0] ra;
input re;
input ore;
output [513:0] dout;
input [2:0] wa;
input we;
input [513:0] di;
input [31:0] pwrbus_ram_pd;
//reg and wire list
reg [2:0] ra_d;
wire [513:0] dout;
reg [513:0] M [7:0];
always @( posedge clk ) begin
    if (we)
       M[wa] <= di;
end
always @( posedge clk ) begin
    if (re)
       ra_d <= ra;
end
wire [513:0] dout_ram = M[ra_d];
reg [513:0] dout_r;
always @( posedge clk ) begin
   if (ore)
       dout_r <= dout_ram;
end
assign dout = dout_r;
endmodule
//==========================================================





//`define FORCE_CONTENTION_ASSERTION_RESET_ACTIVE 1'b1
//`include "simulate_x_tick.vh"
//module NV_NVDLA_SDP_CACC2SDP_fifo (
//      nvdla_core_clk
//    , nvdla_core_rstn
//    , pwrbus_ram_pd
//    , in_fifo_pvld
//    , in_fifo_prdy
//    , in_fifo_pd
//    , out_fifo_pvld
//    , out_fifo_prdy
//    , out_fifo_pd
//    );
//// spyglass disable_block W401 -- clock is not input to module
//input nvdla_core_clk;
//input nvdla_core_rstn;
//input [31:0] pwrbus_ram_pd;
//
//input in_fifo_pvld;
//output in_fifo_prdy;
//input [513:0] in_fifo_pd;
//
//output out_fifo_pvld;
//input out_fifo_prdy;
//output [513:0] out_fifo_pd;
//// Master Clock Gating (SLCG)
////
//// We gate the clock(s) when idle or stalled.
//// This allows us to turn off numerous miscellaneous flops
//// that don't get gated during synthesis for one reason or another.
////
//// We gate write side and read side separately.
//// If the fifo is synchronous, we also gate the ram separately, but if
//// -master_clk_gated_unified or -status_reg/-status_logic_reg is specified,
//// then we use one clk gate for write, ram, and read.
////
//wire nvdla_core_clk_mgated_enable; // assigned by code at end of this module
//wire nvdla_core_clk_mgated; // used only in synchronous fifos
//NV_CLK_gate_power nvdla_core_clk_mgate( .clk(nvdla_core_clk), .reset_(nvdla_core_rstn), .clk_en(nvdla_core_clk_mgated_enable), .clk_gated(nvdla_core_clk_mgated) );
////
//// WRITE SIDE
////
//wire wr_reserving;
//reg fifo_wr_busy_int; // copy for internal use
//assign in_fifo_prdy = !fifo_wr_busy_int;
//assign wr_reserving = in_fifo_pvld && !fifo_wr_busy_int; // reserving write space?
//wire wr_popping; // fwd: write side sees pop?
//reg [3:0] fifo_wr_count; // write-side count
//wire [3:0] wr_count_next_wr_popping = wr_reserving ? fifo_wr_count : (fifo_wr_count - 1'd1); // spyglass disable W164a W484
//wire [3:0] wr_count_next_no_wr_popping = wr_reserving ? (fifo_wr_count + 1'd1) : fifo_wr_count; // spyglass disable W164a W484
//wire [3:0] wr_count_next = wr_popping ? wr_count_next_wr_popping :
//                                               wr_count_next_no_wr_popping;
//wire wr_count_next_no_wr_popping_is_8 = ( wr_count_next_no_wr_popping == 4'd8 );
//wire wr_count_next_is_8 = wr_popping ? 1'b0 :
//                                          wr_count_next_no_wr_popping_is_8;
//wire [3:0] wr_limit_muxed; // muxed with simulation/emulation overrides
//wire [3:0] wr_limit_reg = wr_limit_muxed;
//// VCS coverage off
//wire fifo_wr_busy_next = wr_count_next_is_8 || // busy next cycle?
//                          (wr_limit_reg != 4'd0 && // check ro_wr_limit if != 0
//                           wr_count_next >= wr_limit_reg) ;
//// VCS coverage on
//always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
//    if ( !nvdla_core_rstn ) begin
//        fifo_wr_busy_int <= 1'b0;
//        fifo_wr_count <= 4'd0;
//    end else begin
// fifo_wr_busy_int <= fifo_wr_busy_next;
// if ( wr_reserving ^ wr_popping ) begin
//     fifo_wr_count <= wr_count_next;
//        end
////synopsys translate_off
//            else if ( !(wr_reserving ^ wr_popping) ) begin
//        end else begin
//            fifo_wr_count <= {4{`x_or_0}};
//        end
////synopsys translate_on
//    end
//end
//wire wr_pushing = wr_reserving; // data pushed same cycle as in_fifo_pvld
////
//// RAM
////
//reg [2:0] fifo_wr_adr; // current write address
//// spyglass disable_block W484
//always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
//    if ( !nvdla_core_rstn ) begin
//        fifo_wr_adr <= 3'd0;
//    end else begin
//        if ( wr_pushing ) begin
//     fifo_wr_adr <= fifo_wr_adr + 1'd1;
//        end
//    end
//end
//// spyglass enable_block W484
//wire rd_popping;
//reg [2:0] fifo_rd_adr; // read address this cycle
//wire ram_we = wr_pushing && (fifo_wr_count > 4'd0 || !rd_popping); // note: write occurs next cycle
//wire [513:0] fifo_rd_pd_p; // read data out of ram
//wire [31 : 0] pwrbus_ram_pd;
//// Adding parameter for fifogen to disable wr/rd contention assertion in ramgen.
//// Fifogen handles this by ignoring the data on the ram data out for that cycle.
//NV_NVDLA_SDP_CACC2SDP_fifo_flopram_rwsa_8x514 ram (
//      .clk( nvdla_core_clk_mgated )
//    , .pwrbus_ram_pd ( pwrbus_ram_pd )
//    , .di ( in_fifo_pd )
//    , .we ( ram_we )
//    , .wa ( fifo_wr_adr )
//    , .ra ( (fifo_wr_count == 0) ? 4'd8 : {1'b0,fifo_rd_adr} )
//    , .dout ( fifo_rd_pd_p )
//    );
//wire [2:0] rd_adr_next_popping = fifo_rd_adr + 1'd1; // spyglass disable W484
//always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
//    if ( !nvdla_core_rstn ) begin
//        fifo_rd_adr <= 3'd0;
//    end else begin
//        if ( rd_popping ) begin
//     fifo_rd_adr <= rd_adr_next_popping;
//        end
////synopsys translate_off
//            else if ( !rd_popping ) begin
//        end else begin
//            fifo_rd_adr <= {3{`x_or_0}};
//        end
////synopsys translate_on
//    end
//end
////
//// SYNCHRONOUS BOUNDARY
////
//assign wr_popping = rd_popping; // let it be seen immediately
//wire rd_pushing = wr_pushing; // let it be seen immediately
////
//// READ SIDE
////
//wire fifo_rd_pvld_p; // data out of fifo is valid
//reg fifo_rd_pvld_int; // internal copy of out_fifo_pvld
//assign out_fifo_pvld = fifo_rd_pvld_int;
//assign rd_popping = fifo_rd_pvld_p && !(fifo_rd_pvld_int && !out_fifo_prdy);
//reg [3:0] fifo_rd_count_p; // read-side fifo count
//// spyglass disable_block W164a W484
//wire [3:0] rd_count_p_next_rd_popping = rd_pushing ? fifo_rd_count_p :
//                                                                (fifo_rd_count_p - 1'd1);
//wire [3:0] rd_count_p_next_no_rd_popping = rd_pushing ? (fifo_rd_count_p + 1'd1) :
//                                                                    fifo_rd_count_p;
//// spyglass enable_block W164a W484
//wire [3:0] rd_count_p_next = rd_popping ? rd_count_p_next_rd_popping :
//                                                     rd_count_p_next_no_rd_popping;
//assign fifo_rd_pvld_p = fifo_rd_count_p != 0 || rd_pushing;
//always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
//    if ( !nvdla_core_rstn ) begin
//        fifo_rd_count_p <= 4'd0;
//    end else begin
//        if ( rd_pushing || rd_popping ) begin
//     fifo_rd_count_p <= rd_count_p_next;
//        end
////synopsys translate_off
//            else if ( !(rd_pushing || rd_popping ) ) begin
//        end else begin
//            fifo_rd_count_p <= {4{`x_or_0}};
//        end
////synopsys translate_on
//    end
//end
//reg [513:0] out_fifo_pd; // output data register
//wire rd_req_next = (fifo_rd_pvld_p || (fifo_rd_pvld_int && !out_fifo_prdy)) ;
//always @( posedge nvdla_core_clk_mgated or negedge nvdla_core_rstn ) begin
//    if ( !nvdla_core_rstn ) begin
//        fifo_rd_pvld_int <= 1'b0;
//    end else begin
//        fifo_rd_pvld_int <= rd_req_next;
//    end
//end
//always @( posedge nvdla_core_clk_mgated ) begin
//    if ( (rd_popping) ) begin
//        out_fifo_pd <= fifo_rd_pd_p;
//    end
////synopsys translate_off
//        else if ( !((rd_popping)) ) begin
//    end else begin
//        out_fifo_pd <= {514{`x_or_0}};
//    end
////synopsys translate_on
//end
//// Master Clock Gating (SLCG) Enables
////
//// plusarg for disabling this stuff:
//// synopsys translate_off
//`ifndef SYNTH_LEVEL1_COMPILE
//`ifndef SYNTHESIS
//reg master_clk_gating_disabled; initial master_clk_gating_disabled = $test$plusargs( "fifogen_disable_master_clk_gating" ) != 0;
//`endif
//`endif
//// synopsys translate_on
//assign nvdla_core_clk_mgated_enable = ((wr_reserving || wr_pushing || wr_popping || (in_fifo_pvld && !fifo_wr_busy_int) || (fifo_wr_busy_int != fifo_wr_busy_next)) || (rd_pushing || rd_popping || (fifo_rd_pvld_int && out_fifo_prdy)) || (wr_pushing))
//                               `ifdef FIFOGEN_MASTER_CLK_GATING_DISABLED
//                               || 1'b1
//                               `endif
//// synopsys translate_off
//          `ifndef SYNTH_LEVEL1_COMPILE
//          `ifndef SYNTHESIS
//                               || master_clk_gating_disabled
//          `endif
//          `endif
//// synopsys translate_on
//                               ;
//// Simulation and Emulation Overrides of wr_limit(s)
////
//`ifdef EMU
//`ifdef EMU_FIFO_CFG
//// Emulation Global Config Override
////
//assign wr_limit_muxed = `EMU_FIFO_CFG.NV_NVDLA_CDP_RDMA_ro_fifo_8x514_wr_limit_override ? `EMU_FIFO_CFG.NV_NVDLA_CDP_RDMA_ro_fifo_8x514_wr_limit : 4'd0;
//`else
//// No Global Override for Emulation
////
//assign wr_limit_muxed = 4'd0;
//`endif // EMU_FIFO_CFG
//`else // !EMU
//`ifdef SYNTH_LEVEL1_COMPILE
//// No Override for GCS Compiles
////
//assign wr_limit_muxed = 4'd0;
//`else
//`ifdef SYNTHESIS
//// No Override for RTL Synthesis
////
//assign wr_limit_muxed = 4'd0;
//`else
//// RTL Simulation Plusarg Override
//// VCS coverage off
//reg wr_limit_override;
//reg [3:0] wr_limit_override_value;
//assign wr_limit_muxed = wr_limit_override ? wr_limit_override_value : 4'd0;
//`ifdef NV_ARCHPRO
//event reinit;
//initial begin
//    $display("fifogen reinit initial block %m");
//    -> reinit;
//end
//`endif
//`ifdef NV_ARCHPRO
//always @( reinit ) begin
//`else
//initial begin
//`endif
//    wr_limit_override = 0;
//    wr_limit_override_value = 0; // to keep viva happy with dangles
//    if ( $test$plusargs( "NV_NVDLA_CDP_RDMA_ro_fifo_8x514_wr_limit" ) ) begin
//        wr_limit_override = 1;
//        $value$plusargs( "NV_NVDLA_CDP_RDMA_ro_fifo_8x514_wr_limit=%d", wr_limit_override_value);
//    end
//end
//// VCS coverage on
//`endif
//`endif
//`endif
////
//// Histogram of fifo depth (from write side's perspective)
////
//// NOTE: it will reference `SIMTOP.perfmon_enabled, so that
//// has to at least be defined, though not initialized.
//// tbgen testbenches have it already and various
//// ways to turn it on and off.
////
//`ifdef PERFMON_HISTOGRAM
//// synopsys translate_off
//`ifndef SYNTH_LEVEL1_COMPILE
//`ifndef SYNTHESIS
//perfmon_histogram perfmon (
//      .clk ( nvdla_core_clk )
//    , .max ( {28'd0, (wr_limit_reg == 4'd0) ? 4'd8 : wr_limit_reg} )
//    , .curr ( {28'd0, fifo_wr_count} )
//    );
//`endif
//`endif
//// synopsys translate_on
//`endif
//// spyglass disable_block W164a W164b W116 W484 W504
//`ifdef SPYGLASS
//`else
//`ifdef FV_ASSERT_ON
//`else
//// synopsys translate_off
//`endif
//`ifdef ASSERT_ON
//`ifdef SPYGLASS
//wire disable_assert_plusarg = 1'b0;
//`else
//`ifdef FV_ASSERT_ON
//wire disable_assert_plusarg = 1'b0;
//`else
//wire disable_assert_plusarg = $test$plusargs("DISABLE_NESS_FLOW_ASSERTIONS");
//`endif
//`endif
//wire assert_enabled = 1'b1 && !disable_assert_plusarg;
//`endif
//`ifdef FV_ASSERT_ON
//`else
//// synopsys translate_on
//`endif
//`ifdef ASSERT_ON
////synopsys translate_off
//`ifndef SYNTH_LEVEL1_COMPILE
//`ifndef SYNTHESIS
//always @(assert_enabled) begin
//    if ( assert_enabled === 1'b0 ) begin
//        $display("Asserts are disabled for %m");
//    end
//end
//`endif
//`endif
////synopsys translate_on
//`endif
//`endif
//// spyglass enable_block W164a W164b W116 W484 W504
////The NV_BLKBOX_SRC0 module is only present when the FIFOGEN_MODULE_SEARCH
//// define is set. This is to aid fifogen team search for fifogen fifo
//// instance and module names in a given design.
//`ifdef FIFOGEN_MODULE_SEARCH
//NV_BLKBOX_SRC0 dummy_breadcrumb_fifogen_blkbox (.Y());
//`endif
//// spyglass enable_block W401 -- clock is not input to module
//// synopsys dc_script_begin
//// set_boundary_optimization find(design, "NV_NVDLA_CDP_RDMA_ro_fifo_8x514") true
//// synopsys dc_script_end
////| &Attachment -no_warn EndModulePrepend;
//endmodule // NV_NVDLA_SDP_CACC2SDP_fifo
////==========================================================
////
////
//// Flop-Based RAM
////==========================================================
//module NV_NVDLA_SDP_CACC2SDP_fifo_flopram_rwsa_8x514 (
//      clk
//    , pwrbus_ram_pd
//    , di
//    , we
//    , wa
//    , ra
//    , dout
//    );
//input clk; // write clock
//input [31 : 0] pwrbus_ram_pd;
//input [513:0] di;
//input we;
//input [2:0] wa;
//input [3:0] ra;
//output [513:0] dout;
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_0 (.A(pwrbus_ram_pd[0]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_1 (.A(pwrbus_ram_pd[1]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_2 (.A(pwrbus_ram_pd[2]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_3 (.A(pwrbus_ram_pd[3]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_4 (.A(pwrbus_ram_pd[4]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_5 (.A(pwrbus_ram_pd[5]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_6 (.A(pwrbus_ram_pd[6]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_7 (.A(pwrbus_ram_pd[7]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_8 (.A(pwrbus_ram_pd[8]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_9 (.A(pwrbus_ram_pd[9]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_10 (.A(pwrbus_ram_pd[10]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_11 (.A(pwrbus_ram_pd[11]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_12 (.A(pwrbus_ram_pd[12]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_13 (.A(pwrbus_ram_pd[13]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_14 (.A(pwrbus_ram_pd[14]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_15 (.A(pwrbus_ram_pd[15]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_16 (.A(pwrbus_ram_pd[16]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_17 (.A(pwrbus_ram_pd[17]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_18 (.A(pwrbus_ram_pd[18]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_19 (.A(pwrbus_ram_pd[19]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_20 (.A(pwrbus_ram_pd[20]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_21 (.A(pwrbus_ram_pd[21]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_22 (.A(pwrbus_ram_pd[22]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_23 (.A(pwrbus_ram_pd[23]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_24 (.A(pwrbus_ram_pd[24]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_25 (.A(pwrbus_ram_pd[25]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_26 (.A(pwrbus_ram_pd[26]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_27 (.A(pwrbus_ram_pd[27]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_28 (.A(pwrbus_ram_pd[28]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_29 (.A(pwrbus_ram_pd[29]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_30 (.A(pwrbus_ram_pd[30]));
//NV_BLKBOX_SINK UJ_BBOX2UNIT_UNUSED_pwrbus_31 (.A(pwrbus_ram_pd[31]));
//`ifdef EMU
//wire [513:0] dout_p;
//// we use an emulation ram here to save flops on the emulation board
//// so that the monstrous chip can fit :-)
////
//reg [2:0] Wa0_vmw;
//reg we0_vmw;
//reg [513:0] Di0_vmw;
//always @( posedge clk ) begin
//    Wa0_vmw <= wa;
//    we0_vmw <= we;
//    Di0_vmw <= di;
//end
//vmw_NV_NVDLA_SDP_CACC2SDP_fifo_flopram_rwsa_8x514 emu_ram (
//     .Wa0( Wa0_vmw )
//   , .we0( we0_vmw )
//   , .Di0( Di0_vmw )
//   , .Ra0( ra[2:0] )
//   , .Do0( dout_p )
//   );
//assign dout = (ra == 8) ? di : dout_p;
//`else
//reg [513:0] ram_ff0;
//reg [513:0] ram_ff1;
//reg [513:0] ram_ff2;
//reg [513:0] ram_ff3;
//reg [513:0] ram_ff4;
//reg [513:0] ram_ff5;
//reg [513:0] ram_ff6;
//reg [513:0] ram_ff7;
//always @( posedge clk ) begin
//    if ( we && wa == 5'd0 ) begin
// ram_ff0 <= di;
//    end
//    if ( we && wa == 5'd1 ) begin
// ram_ff1 <= di;
//    end
//    if ( we && wa == 5'd2 ) begin
// ram_ff2 <= di;
//    end
//    if ( we && wa == 5'd3 ) begin
// ram_ff3 <= di;
//    end
//    if ( we && wa == 5'd4 ) begin
// ram_ff4 <= di;
//    end
//    if ( we && wa == 5'd5 ) begin
// ram_ff5 <= di;
//    end
//    if ( we && wa == 5'd6 ) begin
// ram_ff6 <= di;
//    end
//    if ( we && wa == 5'd7 ) begin
// ram_ff7 <= di;
//    end
//end
//reg [513:0] dout;
//always @(*) begin
//    case( ra )
//    4'd0: dout = ram_ff0;
//    4'd1: dout = ram_ff1;
//    4'd2: dout = ram_ff2;
//    4'd3: dout = ram_ff3;
//    4'd4: dout = ram_ff4;
//    4'd5: dout = ram_ff5;
//    4'd6: dout = ram_ff6;
//    4'd7: dout = ram_ff7;
//    4'd8: dout = di;
////VCS coverage off
//    default: dout = {514{`x_or_0}};
////VCS coverage on
//    endcase
//end
//`endif // EMU
//endmodule // NV_NVDLA_SDP_CACC2SDP_fifo_flopram_rwsa_8x514
////==========================================================
////
////
//// emulation model of flopram guts
////==========================================================
//`ifdef EMU
//module vmw_NV_NVDLA_SDP_CACC2SDP_fifo_flopram_rwsa_8x514 (
//   Wa0, we0, Di0,
//   Ra0, Do0
//   );
//input [2:0] Wa0;
//input we0;
//input [513:0] Di0;
//input [2:0] Ra0;
//output [513:0] Do0;
//// Only visible during Spyglass to avoid blackboxes.
//`ifdef SPYGLASS_FLOPRAM
//assign Do0 = 514'd0;
//wire dummy = 1'b0 | (|Wa0) | (|we0) | (|Di0) | (|Ra0);
//`endif
//// synopsys translate_off
//`ifndef SYNTH_LEVEL1_COMPILE
//`ifndef SYNTHESIS
//reg [513:0] mem[7:0];
//// expand mem for debug ease
//`ifdef EMU_EXPAND_FLOPRAM_MEM
//wire [513:0] Q0 = mem[0];
//wire [513:0] Q1 = mem[1];
//wire [513:0] Q2 = mem[2];
//wire [513:0] Q3 = mem[3];
//wire [513:0] Q4 = mem[4];
//wire [513:0] Q5 = mem[5];
//wire [513:0] Q6 = mem[6];
//wire [513:0] Q7 = mem[7];
//`endif
//// asynchronous ram writes
//always @(*) begin
//  if ( we0 == 1'b1 ) begin
//    #0.1;
//    mem[Wa0] = Di0;
//  end
//end
//assign Do0 = mem[Ra0];
//`endif
//`endif
//// synopsys translate_on
//// synopsys dc_script_begin
//// set_dont_touch { find (design, vmw_NV_NVDLA_CDP_RDMA_ro_fifo_8x514_flopram_rwsa_8x514) }
//// set_attribute { find (design, vmw_NV_NVDLA_CDP_RDMA_ro_fifo_8x514_flopram_rwsa_8x514) } require_dont_touch true -type boolean
//// synopsys dc_script_end
//// g2c if { [find / -null_ok -subdesign vmw_NV_NVDLA_CDP_RDMA_ro_fifo_8x514_flopram_rwsa_8x514] != {} } { set_attr preserve 1 [find / -subdesign vmw_NV_NVDLA_CDP_RDMA_ro_fifo_8x514_flopram_rwsa_8x514] }
//endmodule // vmw_NV_NVDLA_SDP_CACC2SDP_fifo_flopram_rwsa_8x514
////vmw: Memory vmw_NV_NVDLA_SDP_CACC2SDP_fifo_flopram_rwsa_8x514
////vmw: Address-size 5
////vmw: Data-size 514
////vmw: Sensitivity level 1
////vmw: Ports W R
////vmw: terminal we0 WriteEnable0
////vmw: terminal Wa0 address0
////vmw: terminal Di0[513:0] data0[513:0]
////vmw:
////vmw: terminal Ra0 address1
////vmw: terminal Do0[513:0] data1[513:0]
////vmw:
////qt: CELL vmw_NV_NVDLA_CDP_RDMA_ro_fifo_8x514_flopram_rwsa_8x514
////qt: TERMINAL we0 TYPE=WE POLARITY=H PORT=1
////qt: TERMINAL Wa0[%d] TYPE=ADDRESS DIR=W BIT=%1 PORT=1
////qt: TERMINAL Di0[%d] TYPE=DATA DIR=I BIT=%1 PORT=1
////qt:
////qt: TERMINAL Ra0[%d] TYPE=ADDRESS DIR=R BIT=%1 PORT=1
////qt: TERMINAL Do0[%d] TYPE=DATA DIR=O BIT=%1 PORT=1
////qt:
//`endif // EMU
//==========================================================
