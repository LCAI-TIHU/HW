// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_pdp.v
// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_PDP_define.h
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//
`define SYNTHESIS
//
//#ifdef NVDLA_FEATURE_DATA_TYPE_INT8
//#if ( NVDLA_PDP_THROUGHPUT  ==  8 )
//    #define LARGE_FIFO_RAM
//#endif
//#if ( NVDLA_PDP_THROUGHPUT == 1 )
//    #define SMALL_FIFO_RAM
//#endif
//#endif
module NV_NVDLA_pdp (
   dla_clk_ovr_on_sync //|< i
  ,global_clk_ovr_on_sync //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,nvdla_core_clk //|< i
  ,nvdla_core_rstn //|< i
  ,csb2pdp_rdma_req_pvld //|< i
  ,csb2pdp_rdma_req_prdy //|> o
  ,csb2pdp_rdma_req_pd //|< i
  ,csb2pdp_req_pvld //|< i
  ,csb2pdp_req_prdy //|> o
  ,csb2pdp_req_pd //|< i
  ,cvif2pdp_rd_rsp_valid //|< i
  ,cvif2pdp_rd_rsp_ready //|> o
  ,cvif2pdp_rd_rsp_pd //|< i
  ,cvif2pdp_wr_rsp_complete //|< i
  ,pdp2cvif_rd_cdt_lat_fifo_pop //|> o
  ,pdp2cvif_rd_req_valid //|> o
  ,pdp2cvif_rd_req_ready //|< i
  ,pdp2cvif_rd_req_pd //|> o
  ,pdp2cvif_wr_req_valid //|> o
  ,pdp2cvif_wr_req_ready //|< i
  ,pdp2cvif_wr_req_pd //|> o
  ,mcif2pdp_rd_rsp_valid //|< i
  ,mcif2pdp_rd_rsp_ready //|> o
  ,mcif2pdp_rd_rsp_pd //|< i
  ,mcif2pdp_wr_rsp_complete //|< i
  ,pdp2csb_resp_valid //|> o
  ,pdp2csb_resp_pd //|> o
  ,pdp2glb_done_intr_pd //|> o
  ,pdp2mcif_rd_cdt_lat_fifo_pop //|> o
  ,pdp2mcif_rd_req_valid //|> o
  ,pdp2mcif_rd_req_ready //|< i
  ,pdp2mcif_rd_req_pd //|> o
  ,pdp2mcif_wr_req_valid //|> o
  ,pdp2mcif_wr_req_ready //|< i
  ,pdp2mcif_wr_req_pd //|> o
  ,pdp_rdma2csb_resp_valid //|> o
  ,pdp_rdma2csb_resp_pd //|> o
  ,pwrbus_ram_pd //|< i
  ,sdp2pdp_valid //|< i
  ,sdp2pdp_ready //|> o
  ,sdp2pdp_pd //|< i
  );
///////////////////////////////////////////////////////////////////////
input dla_clk_ovr_on_sync;
input global_clk_ovr_on_sync;
input tmc2slcg_disable_clock_gating;
 input nvdla_core_clk;
 input nvdla_core_rstn;
 input csb2pdp_rdma_req_pvld;
 output csb2pdp_rdma_req_prdy;
 input [62:0] csb2pdp_rdma_req_pd;
 input csb2pdp_req_pvld;
 output csb2pdp_req_prdy;
 input [62:0] csb2pdp_req_pd;
 input cvif2pdp_rd_rsp_valid;
 output cvif2pdp_rd_rsp_ready;
 input [( 256 + (256/8/32) )-1:0] cvif2pdp_rd_rsp_pd;
 input cvif2pdp_wr_rsp_complete;
 output pdp2cvif_rd_cdt_lat_fifo_pop;
 output pdp2cvif_rd_req_valid;
 input pdp2cvif_rd_req_ready;
 output [64 +14:0] pdp2cvif_rd_req_pd;
 output pdp2cvif_wr_req_valid;
 input pdp2cvif_wr_req_ready;
 output [( 256 + (256/8/32) + 1 )-1:0] pdp2cvif_wr_req_pd;
 input mcif2pdp_rd_rsp_valid;
 output mcif2pdp_rd_rsp_ready;
 input [( 256 + (256/8/32) )-1:0] mcif2pdp_rd_rsp_pd;
 input mcif2pdp_wr_rsp_complete;
 output pdp2csb_resp_valid;
 output [33:0] pdp2csb_resp_pd;
 output [1:0] pdp2glb_done_intr_pd;
 output pdp2mcif_rd_cdt_lat_fifo_pop;
 output pdp2mcif_rd_req_valid;
 input pdp2mcif_rd_req_ready;
 output [64 +14:0] pdp2mcif_rd_req_pd;
 output pdp2mcif_wr_req_valid;
 input pdp2mcif_wr_req_ready;
 output [( 256 + (256/8/32) + 1 )-1:0] pdp2mcif_wr_req_pd;
 output pdp_rdma2csb_resp_valid;
 output [33:0] pdp_rdma2csb_resp_pd;
 input [31:0] pwrbus_ram_pd;
 input sdp2pdp_valid;
 output sdp2pdp_ready;
 input [8*16 -1:0] sdp2pdp_pd;
//
///////////////////////////////////////////////////////////////////////
assign csb2pdp_req_prdy             =   1'b1;
assign pdp2csb_resp_valid           =   1'b0;
assign pdp2csb_resp_pd              =  34'd0;

assign csb2pdp_rdma_req_prdy        =   1'b1;
assign pdp_rdma2csb_resp_valid      =   1'b0;
assign pdp_rdma2csb_resp_pd         =  34'd0;

assign sdp2pdp_ready                =   1'b1;

assign cvif2pdp_rd_rsp_ready        =   1'b1;
assign pdp2cvif_rd_cdt_lat_fifo_pop =   1'b0;
assign pdp2cvif_rd_req_valid        =   1'b0;
assign pdp2cvif_rd_req_pd           =  79'd0;
assign pdp2cvif_wr_req_valid        =   1'b0;
assign pdp2cvif_wr_req_pd           = 258'd0;

assign mcif2pdp_rd_rsp_ready        =   1'b1;
assign pdp2mcif_rd_cdt_lat_fifo_pop =   1'b0;
assign pdp2mcif_rd_req_valid        =   1'b0;
assign pdp2mcif_rd_req_pd           =  79'd0;
assign pdp2mcif_wr_req_valid        =   1'b0;
assign pdp2mcif_wr_req_pd           = 258'd0;

assign pdp2glb_done_intr_pd         =   2'd0;
///////////////////////////////////////////////////////////////////////
//
endmodule // NV_NVDLA_pdp
