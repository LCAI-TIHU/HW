// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_cdp.v
//
`define SYNTHESIS
//
module NV_NVDLA_cdp (
   dla_clk_ovr_on_sync //|< i
  ,global_clk_ovr_on_sync //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,cdp2csb_resp_valid //|> o
  ,cdp2csb_resp_pd //|> o
  ,cdp2cvif_rd_cdt_lat_fifo_pop //|> o
  ,cdp2cvif_rd_req_valid //|> o
  ,cdp2cvif_rd_req_ready //|< i
  ,cdp2cvif_rd_req_pd //|> o
  ,cdp2cvif_wr_req_valid //|> o
  ,cdp2cvif_wr_req_ready //|< i
  ,cdp2cvif_wr_req_pd //|> o
  ,cdp2glb_done_intr_pd //|> o
  ,cdp2mcif_rd_cdt_lat_fifo_pop //|> o
  ,cdp2mcif_rd_req_valid //|> o
  ,cdp2mcif_rd_req_ready //|< i
  ,cdp2mcif_rd_req_pd //|> o
  ,cdp2mcif_wr_req_valid //|> o
  ,cdp2mcif_wr_req_ready //|< i
  ,cdp2mcif_wr_req_pd //|> o
  ,cdp_rdma2csb_resp_valid //|> o
  ,cdp_rdma2csb_resp_pd //|> o
  ,csb2cdp_rdma_req_pvld //|< i
  ,csb2cdp_rdma_req_prdy //|> o
  ,csb2cdp_rdma_req_pd //|< i
  ,csb2cdp_req_pvld //|< i
  ,csb2cdp_req_prdy //|> o
  ,csb2cdp_req_pd //|< i
  ,cvif2cdp_rd_rsp_valid //|< i
  ,cvif2cdp_rd_rsp_ready //|> o
  ,cvif2cdp_rd_rsp_pd //|< i
  ,cvif2cdp_wr_rsp_complete //|< i
  ,mcif2cdp_rd_rsp_valid //|< i
  ,mcif2cdp_rd_rsp_ready //|> o
  ,mcif2cdp_rd_rsp_pd //|< i
  ,mcif2cdp_wr_rsp_complete //|< i
  ,pwrbus_ram_pd //|< i
  );
//////////////////////////////////////////////////////////////////
input dla_clk_ovr_on_sync;
input global_clk_ovr_on_sync;
input tmc2slcg_disable_clock_gating;
//
// NV_NVDLA_cdp_ports.v
//
 input nvdla_core_clk;
 input nvdla_core_rstn;
 output cdp2csb_resp_valid; /* data valid */
 output [33:0] cdp2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
 output cdp2cvif_rd_cdt_lat_fifo_pop;
 output cdp2cvif_rd_req_valid; /* data valid */
 input cdp2cvif_rd_req_ready; /* data return handshake */
 output [79 -1:0] cdp2cvif_rd_req_pd;
 output cdp2cvif_wr_req_valid; /* data valid */
 input cdp2cvif_wr_req_ready; /* data return handshake */
 output [258 -1:0] cdp2cvif_wr_req_pd; /* pkt_id_width=1 pkt_widths=78,514  */
 output [1:0] cdp2glb_done_intr_pd;
 output cdp2mcif_rd_cdt_lat_fifo_pop;
 output cdp2mcif_rd_req_valid; /* data valid */
 input cdp2mcif_rd_req_ready; /* data return handshake */
 output [79 -1:0] cdp2mcif_rd_req_pd;
 output cdp2mcif_wr_req_valid; /* data valid */
 input cdp2mcif_wr_req_ready; /* data return handshake */
 output [258 -1:0] cdp2mcif_wr_req_pd; /* pkt_id_width=1 pkt_widths=78,514  */
 output cdp_rdma2csb_resp_valid; /* data valid */
 output [33:0] cdp_rdma2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
 input csb2cdp_rdma_req_pvld; /* data valid */
 output csb2cdp_rdma_req_prdy; /* data return handshake */
 input [62:0] csb2cdp_rdma_req_pd;
 input csb2cdp_req_pvld; /* data valid */
 output csb2cdp_req_prdy; /* data return handshake */
 input [62:0] csb2cdp_req_pd;
 input cvif2cdp_rd_rsp_valid; /* data valid */
 output cvif2cdp_rd_rsp_ready; /* data return handshake */
 input [257 -1:0] cvif2cdp_rd_rsp_pd;
 input cvif2cdp_wr_rsp_complete;
 input mcif2cdp_rd_rsp_valid; /* data valid */
 output mcif2cdp_rd_rsp_ready; /* data return handshake */
 input [257 -1:0] mcif2cdp_rd_rsp_pd;
 input mcif2cdp_wr_rsp_complete;
 input [31:0] pwrbus_ram_pd;
//
//
//////////////////////////////////////////////////////////////////
assign csb2cdp_req_prdy             =   1'b1; /* data return handshake */
assign cdp2csb_resp_valid           =   1'b0; /* data valid */
assign cdp2csb_resp_pd              =  34'd0; /* pkt_id_width=1 pkt_widths=33,33  */

assign csb2cdp_rdma_req_prdy        =   1'b1; /* data return handshake */
assign cdp_rdma2csb_resp_valid      =   1'd0; /* data valid */
assign cdp_rdma2csb_resp_pd         =  34'd0; /* pkt_id_width=1 pkt_widths=33,33  */

assign cvif2cdp_rd_rsp_ready        =   1'b1; /* data return handshake */
assign cdp2cvif_rd_cdt_lat_fifo_pop =   1'b0;
assign cdp2cvif_rd_req_valid        =   1'b0; /* data valid */
assign cdp2cvif_rd_req_pd           =  79'd0;
assign cdp2cvif_wr_req_valid        =   1'd0; /* data valid */
assign cdp2cvif_wr_req_pd           = 258'd0; /* pkt_id_width=1 pkt_widths=78,514  */

assign cdp2glb_done_intr_pd         =   2'd0;

assign mcif2cdp_rd_rsp_ready        =   1'b1; /* data return handshake */
assign cdp2mcif_rd_cdt_lat_fifo_pop =   1'b0;
assign cdp2mcif_rd_req_valid        =   1'd0; /* data valid */
assign cdp2mcif_rd_req_pd           =  79'd0;
assign cdp2mcif_wr_req_valid        =   1'd0; /* data valid */
assign cdp2mcif_wr_req_pd           = 258'd0; /* pkt_id_width=1 pkt_widths=78,514  */
//////////////////////////////////////////////////////////////////
//
//
endmodule // NV_NVDLA_cdp
