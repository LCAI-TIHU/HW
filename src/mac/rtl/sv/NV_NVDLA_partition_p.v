// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_partition_p.v
// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_define.h
///////////////////////////////////////////////////
//
//#if ( NVDLA_PRIMARY_MEMIF_WIDTH  ==  512 )
//    #define LARGE_MEMBUS
//#endif
//#if ( NVDLA_PRIMARY_MEMIF_WIDTH  ==  64 )
//    #define LARGE_MEMBUS
//#endif
// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_CMAC.h
`define DESIGNWARE_NOEXIST 1
`include "NV_HWACC_NVDLA_tick_defines.vh"
module NV_NVDLA_partition_p (
   cacc2sdp_pd //|< i
  ,cacc2sdp_valid //|< i
  ,csb2sdp_rdma_req_pd //|< i
  ,csb2sdp_rdma_req_pvld //|< i
  ,csb2sdp_req_pd //|< i
  ,csb2sdp_req_pvld //|< i
  ,direct_reset_ //|< i
  ,dla_reset_rstn //|< i
  ,global_clk_ovr_on //|< i
  ,nvdla_clk_ovr_on //|< i
  ,nvdla_core_clk //|< i
  ,pwrbus_ram_pd //|< i
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
  ,cvif2sdp_rd_rsp_pd //|< i
  ,cvif2sdp_rd_rsp_valid //|< i
  ,cvif2sdp_rd_rsp_ready //|> o
  ,sdp2cvif_rd_cdt_lat_fifo_pop //|> o
  ,sdp2cvif_rd_req_pd //|> o
  ,sdp2cvif_rd_req_valid //|> o
  ,sdp2cvif_rd_req_ready //|< i
  ,sdp2cvif_wr_req_pd //|> o
  ,sdp2cvif_wr_req_valid //|> o
  ,sdp2cvif_wr_req_ready //|< i
  ,cvif2sdp_wr_rsp_complete //|< i
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
  ,mcif2sdp_rd_rsp_pd //|< i
  ,mcif2sdp_rd_rsp_valid //|< i
  ,mcif2sdp_wr_rsp_complete //|< i
  ,sdp2mcif_rd_req_ready //|< i
  ,sdp2mcif_wr_req_ready //|< i
  ,mcif2sdp_rd_rsp_ready //|> o
  ,sdp2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp2mcif_rd_req_pd //|> o
  ,sdp2mcif_rd_req_valid //|> o
  ,sdp2mcif_wr_req_pd //|> o
  ,sdp2mcif_wr_req_valid //|> o
  ,sdp2pdp_ready //|< i
  ,test_mode //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,cacc2sdp_ready //|> o
  ,csb2sdp_rdma_req_prdy //|> o
  ,csb2sdp_req_prdy //|> o
  ,sdp2csb_resp_pd //|> o
  ,sdp2csb_resp_valid //|> o
  ,sdp2glb_done_intr_pd //|> o
  ,sdp2pdp_pd //|> o
  ,sdp2pdp_valid //|> o
  ,sdp_rdma2csb_resp_pd //|> o
  ,sdp_rdma2csb_resp_valid //|> o
  ,cacc2sdp_adpt_valid
  ,cacc2sdp_adpt_ready
  ,cacc2sdp_adpt_pd
  ,sdp_dp2wdma_valid
  ,sdp_dp2wdma_ready
  ,sdp_dp2wdma_pd
  );
//
// NV_NVDLA_partition_p_io.v
//
input test_mode;
input direct_reset_;
input global_clk_ovr_on;
input tmc2slcg_disable_clock_gating;
input cacc2sdp_valid; /* data valid */
output cacc2sdp_ready; /* data return handshake */
input [16*32+2-1:0] cacc2sdp_pd;
input csb2sdp_rdma_req_pvld; /* data valid */
output csb2sdp_rdma_req_prdy; /* data return handshake */
input [62:0] csb2sdp_rdma_req_pd;
input csb2sdp_req_pvld; /* data valid */
output csb2sdp_req_prdy; /* data return handshake */
input [62:0] csb2sdp_req_pd;
input [31:0] pwrbus_ram_pd;
output sdp2csb_resp_valid; /* data valid */
output [33:0] sdp2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output sdp_b2cvif_rd_cdt_lat_fifo_pop;
output sdp_b2cvif_rd_req_valid; /* data valid */
input sdp_b2cvif_rd_req_ready; /* data return handshake */
output [64 +14:0] sdp_b2cvif_rd_req_pd;
input cvif2sdp_b_rd_rsp_valid; /* data valid */
output cvif2sdp_b_rd_rsp_ready; /* data return handshake */
input [256 +(256/8/32)-1:0] cvif2sdp_b_rd_rsp_pd;
output sdp_e2cvif_rd_cdt_lat_fifo_pop;
output sdp_e2cvif_rd_req_valid; /* data valid */
input sdp_e2cvif_rd_req_ready; /* data return handshake */
output [64 +14:0] sdp_e2cvif_rd_req_pd;
input cvif2sdp_e_rd_rsp_valid; /* data valid */
output cvif2sdp_e_rd_rsp_ready; /* data return handshake */
input [256 +(256/8/32)-1:0] cvif2sdp_e_rd_rsp_pd;
output sdp_n2cvif_rd_cdt_lat_fifo_pop;
output sdp_n2cvif_rd_req_valid; /* data valid */
input sdp_n2cvif_rd_req_ready; /* data return handshake */
output [64 +14:0] sdp_n2cvif_rd_req_pd;
input cvif2sdp_n_rd_rsp_valid; /* data valid */
output cvif2sdp_n_rd_rsp_ready; /* data return handshake */
input [256 +(256/8/32)-1:0] cvif2sdp_n_rd_rsp_pd;
input cvif2sdp_rd_rsp_valid; /* data valid */
output cvif2sdp_rd_rsp_ready; /* data return handshake */
input [256 +(256/8/32)-1:0] cvif2sdp_rd_rsp_pd;
output sdp2cvif_rd_cdt_lat_fifo_pop;
output sdp2cvif_rd_req_valid; /* data valid */
input sdp2cvif_rd_req_ready; /* data return handshake */
output [64 +14:0] sdp2cvif_rd_req_pd;
output sdp2cvif_wr_req_valid; /* data valid */
input sdp2cvif_wr_req_ready; /* data return handshake */
output [256 +(256/8/32):0] sdp2cvif_wr_req_pd; /* pkt_id_width=1 pkt_widths=78,514  */
input cvif2sdp_wr_rsp_complete;
output [1:0] sdp2glb_done_intr_pd;
output sdp_b2mcif_rd_cdt_lat_fifo_pop;
output sdp_b2mcif_rd_req_valid; /* data valid */
input sdp_b2mcif_rd_req_ready; /* data return handshake */
output [64 +14:0] sdp_b2mcif_rd_req_pd;
input mcif2sdp_b_rd_rsp_valid; /* data valid */
output mcif2sdp_b_rd_rsp_ready; /* data return handshake */
input [256 +(256/8/32)-1:0] mcif2sdp_b_rd_rsp_pd;
output sdp_e2mcif_rd_cdt_lat_fifo_pop;
output sdp_e2mcif_rd_req_valid; /* data valid */
input sdp_e2mcif_rd_req_ready; /* data return handshake */
output [64 +14:0] sdp_e2mcif_rd_req_pd;
input mcif2sdp_e_rd_rsp_valid; /* data valid */
output mcif2sdp_e_rd_rsp_ready; /* data return handshake */
input [256 +(256/8/32)-1:0] mcif2sdp_e_rd_rsp_pd;
output sdp_n2mcif_rd_cdt_lat_fifo_pop;
output sdp_n2mcif_rd_req_valid; /* data valid */
input sdp_n2mcif_rd_req_ready; /* data return handshake */
output [64 +14:0] sdp_n2mcif_rd_req_pd;
input mcif2sdp_n_rd_rsp_valid; /* data valid */
output mcif2sdp_n_rd_rsp_ready; /* data return handshake */
input [256 +(256/8/32)-1:0] mcif2sdp_n_rd_rsp_pd;
output sdp2mcif_rd_cdt_lat_fifo_pop;
input mcif2sdp_rd_rsp_valid;
output mcif2sdp_rd_rsp_ready;
input [256 +(256/8/32)-1:0] mcif2sdp_rd_rsp_pd;
output sdp2mcif_rd_req_valid;
input sdp2mcif_rd_req_ready;
output [64 +14:0] sdp2mcif_rd_req_pd;
output sdp2mcif_wr_req_valid;
input sdp2mcif_wr_req_ready;
output [256 +(256/8/32):0] sdp2mcif_wr_req_pd;
input mcif2sdp_wr_rsp_complete;
output sdp2pdp_valid;
input sdp2pdp_ready;
output [16*8 -1:0] sdp2pdp_pd;
output sdp_rdma2csb_resp_valid;
output [33:0] sdp_rdma2csb_resp_pd;
//input la_r_clk;
//input larstn;
input nvdla_core_clk;
input dla_reset_rstn;
input nvdla_clk_ovr_on;
//for debug
/////////////////////////////////////////////
output                   cacc2sdp_adpt_valid;
output                   cacc2sdp_adpt_ready;
output [32*16 +1:0]      cacc2sdp_adpt_pd;

output                   sdp_dp2wdma_valid;
output                   sdp_dp2wdma_ready;
output [32*8 -1:0]       sdp_dp2wdma_pd;
/////////////////////////////////////////////
wire dla_clk_ovr_on_sync;
wire global_clk_ovr_on_sync;
wire nvdla_core_rstn;
////////////////////////////////////////////////////////////////////////
// NVDLA Partition P: Reset Syncer //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_reset u_partition_p_reset (
   .dla_reset_rstn (dla_reset_rstn)
  ,.direct_reset_ (direct_reset_)
  ,.test_mode (test_mode)
  ,.synced_rstn (nvdla_core_rstn)
  ,.nvdla_clk (nvdla_core_clk)
  );
////////////////////////////////////////////////////////////////////////
// Sync for SLCG
////////////////////////////////////////////////////////////////////////
NV_NVDLA_sync3d u_dla_clk_ovr_on_sync (
   .clk (nvdla_core_clk)
  ,.sync_i (nvdla_clk_ovr_on)
  ,.sync_o (dla_clk_ovr_on_sync)
  );
NV_NVDLA_sync3d_s u_global_clk_ovr_on_sync (
   .clk (nvdla_core_clk)
  ,.prst (nvdla_core_rstn)
  ,.sync_i (global_clk_ovr_on)
  ,.sync_o (global_clk_ovr_on_sync)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition P: Single Data Processor //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_sdp u_NV_NVDLA_sdp (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd)
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd)
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.csb2sdp_req_pd (csb2sdp_req_pd)
  ,.sdp_b2cvif_rd_cdt_lat_fifo_pop (sdp_b2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2cvif_rd_req_valid (sdp_b2cvif_rd_req_valid)
  ,.sdp_b2cvif_rd_req_ready (sdp_b2cvif_rd_req_ready)
  ,.sdp_b2cvif_rd_req_pd (sdp_b2cvif_rd_req_pd )
  ,.cvif2sdp_b_rd_rsp_valid (cvif2sdp_b_rd_rsp_valid)
  ,.cvif2sdp_b_rd_rsp_ready (cvif2sdp_b_rd_rsp_ready)
  ,.cvif2sdp_b_rd_rsp_pd (cvif2sdp_b_rd_rsp_pd )
  ,.sdp_e2cvif_rd_cdt_lat_fifo_pop (sdp_e2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_e2cvif_rd_req_valid (sdp_e2cvif_rd_req_valid)
  ,.sdp_e2cvif_rd_req_ready (sdp_e2cvif_rd_req_ready)
  ,.sdp_e2cvif_rd_req_pd (sdp_e2cvif_rd_req_pd )
  ,.cvif2sdp_e_rd_rsp_valid (cvif2sdp_e_rd_rsp_valid)
  ,.cvif2sdp_e_rd_rsp_ready (cvif2sdp_e_rd_rsp_ready)
  ,.cvif2sdp_e_rd_rsp_pd (cvif2sdp_e_rd_rsp_pd )
  ,.sdp_n2cvif_rd_cdt_lat_fifo_pop (sdp_n2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2cvif_rd_req_valid (sdp_n2cvif_rd_req_valid)
  ,.sdp_n2cvif_rd_req_ready (sdp_n2cvif_rd_req_ready)
  ,.sdp_n2cvif_rd_req_pd (sdp_n2cvif_rd_req_pd )
  ,.cvif2sdp_n_rd_rsp_valid (cvif2sdp_n_rd_rsp_valid)
  ,.cvif2sdp_n_rd_rsp_ready (cvif2sdp_n_rd_rsp_ready)
  ,.cvif2sdp_n_rd_rsp_pd (cvif2sdp_n_rd_rsp_pd )
  ,.cvif2sdp_rd_rsp_valid (cvif2sdp_rd_rsp_valid)
  ,.cvif2sdp_rd_rsp_ready (cvif2sdp_rd_rsp_ready)
  ,.cvif2sdp_rd_rsp_pd (cvif2sdp_rd_rsp_pd )
  ,.sdp2cvif_rd_cdt_lat_fifo_pop (sdp2cvif_rd_cdt_lat_fifo_pop)
  ,.sdp2cvif_rd_req_valid (sdp2cvif_rd_req_valid)
  ,.sdp2cvif_rd_req_ready (sdp2cvif_rd_req_ready)
  ,.sdp2cvif_rd_req_pd (sdp2cvif_rd_req_pd )
  ,.sdp2cvif_wr_req_valid (sdp2cvif_wr_req_valid)
  ,.sdp2cvif_wr_req_ready (sdp2cvif_wr_req_ready)
  ,.sdp2cvif_wr_req_pd (sdp2cvif_wr_req_pd )
  ,.cvif2sdp_wr_rsp_complete (cvif2sdp_wr_rsp_complete)
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd)
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd)
  ,.sdp_e2mcif_rd_cdt_lat_fifo_pop (sdp_e2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_e2mcif_rd_req_valid (sdp_e2mcif_rd_req_valid)
  ,.sdp_e2mcif_rd_req_ready (sdp_e2mcif_rd_req_ready)
  ,.sdp_e2mcif_rd_req_pd (sdp_e2mcif_rd_req_pd)
  ,.mcif2sdp_e_rd_rsp_valid (mcif2sdp_e_rd_rsp_valid)
  ,.mcif2sdp_e_rd_rsp_ready (mcif2sdp_e_rd_rsp_ready)
  ,.mcif2sdp_e_rd_rsp_pd (mcif2sdp_e_rd_rsp_pd)
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd)
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd)
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd)
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.pwrbus_ram_pd (pwrbus_ram_pd)
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd)
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd)
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd)
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd)
  ,.sdp2pdp_valid (sdp2pdp_valid)
  ,.sdp2pdp_ready (sdp2pdp_ready)
  ,.sdp2pdp_pd (sdp2pdp_pd)
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd)
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.cacc2sdp_adpt_valid(cacc2sdp_adpt_valid)
  ,.cacc2sdp_adpt_ready(cacc2sdp_adpt_ready)
  ,.cacc2sdp_adpt_pd   (cacc2sdp_adpt_pd)
  ,.sdp_dp2wdma_ready  (sdp_dp2wdma_ready)
  ,.sdp_dp2wdma_valid  (sdp_dp2wdma_valid)
  ,.sdp_dp2wdma_pd     (sdp_dp2wdma_pd)
  );
////////////////////////////////////////////////////////////////////////
// Dangles/Contenders report //
////////////////////////////////////////////////////////////////////////
endmodule // NV_NVDLA_partition_p
