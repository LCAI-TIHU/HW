// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_partition_o.v
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
// File Name: NV_NVDLA_CSC.h
    //entry bits
    //atomC
    //in bytes, entry/8
    //CSC_ENTRY_HEX/2
    //CSC_ENTRY_HEX/4
    //CSC_ENTRY_HEX-1
    //atomK
    //atomK
    //atomK*2
//notice, for image case, first atom OP within one strip OP must fetch from entry align place, in the middle of an entry is not supported.
//thus, when atomC/atomK=4, stripe=4*atomK, feature data still keeps atomK*2
    `define CC_ATOMC_DIV_ATOMK_EQUAL_2
//batch keep 1
module NV_NVDLA_partition_o (
   test_mode
  ,direct_reset_
  ,global_clk_ovr_on
  ,tmc2slcg_disable_clock_gating
  ,cdma2csb_resp_valid
  ,cdma2csb_resp_pd
  ,cdma_dat2glb_done_intr_pd
  ,cdma_dat2mcif_rd_req_valid
  ,cdma_dat2mcif_rd_req_ready
  ,cdma_dat2mcif_rd_req_pd
  ,cdma_wt2glb_done_intr_pd
  ,cdma_wt2mcif_rd_req_valid
  ,cdma_wt2mcif_rd_req_ready
  ,cdma_wt2mcif_rd_req_pd
  ,cmac_a2csb_resp_valid
  ,cmac_a2csb_resp_pd
  ,csb2cmac_a_req_pvld
  ,csb2cmac_a_req_prdy
  ,csb2cmac_a_req_pd
  ,cmac_b2csb_resp_valid
  ,cmac_b2csb_resp_pd
  ,csb2cmac_b_req_pvld
  ,csb2cmac_b_req_prdy
  ,csb2cmac_b_req_pd
  ,cacc2csb_resp_valid
  ,cacc2csb_resp_pd
  ,cacc2glb_done_intr_pd
  ,csb2cacc_req_pvld
  ,csb2cacc_req_prdy
  ,csb2cacc_req_pd
  ,csb2cdma_req_pvld
  ,csb2cdma_req_prdy
  ,csb2cdma_req_pd
  ,csb2csc_req_pvld
  ,csb2csc_req_prdy
  ,csb2csc_req_pd
  ,csb2nvdla_valid
  ,csb2nvdla_ready
  ,csb2nvdla_addr
  ,csb2nvdla_wdat
  ,csb2nvdla_write
  ,csb2nvdla_nposted
  ,csb2sdp_rdma_req_pvld
  ,csb2sdp_rdma_req_prdy
  ,csb2sdp_rdma_req_pd
  ,csb2sdp_req_pvld
  ,csb2sdp_req_prdy
  ,csb2sdp_req_pd
  ,csc2csb_resp_valid
  ,csc2csb_resp_pd
  ,mcif2cdma_dat_rd_rsp_valid
  ,mcif2cdma_dat_rd_rsp_ready
  ,mcif2cdma_dat_rd_rsp_pd
  ,mcif2cdma_wt_rd_rsp_valid
  ,mcif2cdma_wt_rd_rsp_ready
  ,mcif2cdma_wt_rd_rsp_pd
  ,mcif2noc_axi_ar_arvalid
  ,mcif2noc_axi_ar_arready
  ,mcif2noc_axi_ar_arid
  ,mcif2noc_axi_ar_arlen
  ,mcif2noc_axi_ar_araddr
  ,mcif2noc_axi_aw_awvalid
  ,mcif2noc_axi_aw_awready
  ,mcif2noc_axi_aw_awid
  ,mcif2noc_axi_aw_awlen
  ,mcif2noc_axi_aw_awaddr
  ,mcif2noc_axi_w_wvalid
  ,mcif2noc_axi_w_wready
  ,mcif2noc_axi_w_wdata
  ,mcif2noc_axi_w_wstrb
  ,mcif2noc_axi_w_wlast
  ,mcif2sdp_b_rd_rsp_valid
  ,mcif2sdp_b_rd_rsp_ready
  ,mcif2sdp_b_rd_rsp_pd
  ,sdp_b2mcif_rd_cdt_lat_fifo_pop
  ,sdp_b2mcif_rd_req_valid
  ,sdp_b2mcif_rd_req_ready
  ,sdp_b2mcif_rd_req_pd
  ,mcif2sdp_e_rd_rsp_valid
  ,mcif2sdp_e_rd_rsp_ready
  ,mcif2sdp_e_rd_rsp_pd
  ,sdp_e2mcif_rd_cdt_lat_fifo_pop
  ,sdp_e2mcif_rd_req_valid
  ,sdp_e2mcif_rd_req_ready
  ,sdp_e2mcif_rd_req_pd
  ,mcif2sdp_n_rd_rsp_valid
  ,mcif2sdp_n_rd_rsp_ready
  ,mcif2sdp_n_rd_rsp_pd
  ,sdp_n2mcif_rd_cdt_lat_fifo_pop
  ,sdp_n2mcif_rd_req_valid
  ,sdp_n2mcif_rd_req_ready
  ,sdp_n2mcif_rd_req_pd
  ,mcif2sdp_rd_rsp_valid
  ,mcif2sdp_rd_rsp_ready
  ,mcif2sdp_rd_rsp_pd
  ,mcif2sdp_wr_rsp_complete
  ,cdma_dat2cvif_rd_req_valid
  ,cdma_dat2cvif_rd_req_ready
  ,cdma_dat2cvif_rd_req_pd
  ,cdma_wt2cvif_rd_req_valid
  ,cdma_wt2cvif_rd_req_ready
  ,cdma_wt2cvif_rd_req_pd
  ,cvif2cdma_dat_rd_rsp_valid
  ,cvif2cdma_dat_rd_rsp_ready
  ,cvif2cdma_dat_rd_rsp_pd
  ,cvif2cdma_wt_rd_rsp_valid
  ,cvif2cdma_wt_rd_rsp_ready
  ,cvif2cdma_wt_rd_rsp_pd
  ,cvif2noc_axi_ar_arvalid
  ,cvif2noc_axi_ar_arready
  ,cvif2noc_axi_ar_arid
  ,cvif2noc_axi_ar_arlen
  ,cvif2noc_axi_ar_araddr
  ,cvif2noc_axi_aw_awvalid
  ,cvif2noc_axi_aw_awready
  ,cvif2noc_axi_aw_awid
  ,cvif2noc_axi_aw_awlen
  ,cvif2noc_axi_aw_awaddr
  ,cvif2noc_axi_w_wvalid
  ,cvif2noc_axi_w_wready
  ,cvif2noc_axi_w_wdata
  ,cvif2noc_axi_w_wstrb
  ,cvif2noc_axi_w_wlast
  ,cvif2sdp_b_rd_rsp_valid
  ,cvif2sdp_b_rd_rsp_ready
  ,cvif2sdp_b_rd_rsp_pd
  ,cvif2sdp_e_rd_rsp_valid
  ,cvif2sdp_e_rd_rsp_ready
  ,cvif2sdp_e_rd_rsp_pd
  ,cvif2sdp_n_rd_rsp_valid
  ,cvif2sdp_n_rd_rsp_ready
  ,cvif2sdp_n_rd_rsp_pd
  ,cvif2sdp_rd_rsp_valid
  ,cvif2sdp_rd_rsp_ready
  ,cvif2sdp_rd_rsp_pd
  ,cvif2sdp_wr_rsp_complete
  ,noc2cvif_axi_b_bvalid
  ,noc2cvif_axi_b_bready
  ,noc2cvif_axi_b_bid
  ,noc2cvif_axi_r_rvalid
  ,noc2cvif_axi_r_rready
  ,noc2cvif_axi_r_rid
  ,noc2cvif_axi_r_rlast
  ,noc2cvif_axi_r_rdata
  ,sdp2cvif_rd_cdt_lat_fifo_pop
  ,sdp2cvif_rd_req_valid
  ,sdp2cvif_rd_req_ready
  ,sdp2cvif_rd_req_pd
  ,sdp2cvif_wr_req_valid
  ,sdp2cvif_wr_req_ready
  ,sdp2cvif_wr_req_pd
  ,sdp_b2cvif_rd_cdt_lat_fifo_pop
  ,sdp_b2cvif_rd_req_valid
  ,sdp_b2cvif_rd_req_ready
  ,sdp_b2cvif_rd_req_pd
  ,sdp_e2cvif_rd_cdt_lat_fifo_pop
  ,sdp_e2cvif_rd_req_valid
  ,sdp_e2cvif_rd_req_ready
  ,sdp_e2cvif_rd_req_pd
  ,sdp_n2cvif_rd_cdt_lat_fifo_pop
  ,sdp_n2cvif_rd_req_valid
  ,sdp_n2cvif_rd_req_ready
  ,sdp_n2cvif_rd_req_pd
  ,noc2mcif_axi_b_bvalid
  ,noc2mcif_axi_b_bready
  ,noc2mcif_axi_b_bid
  ,noc2mcif_axi_r_rvalid
  ,noc2mcif_axi_r_rready
  ,noc2mcif_axi_r_rid
  ,noc2mcif_axi_r_rlast
  ,noc2mcif_axi_r_rdata
  ,nvdla2csb_valid
  ,nvdla2csb_data
  ,nvdla2csb_wr_complete
  ,core_intr
  ,pwrbus_ram_pd
  ,sdp2csb_resp_valid
  ,sdp2csb_resp_pd
  ,sdp2glb_done_intr_pd
  ,sdp2mcif_rd_cdt_lat_fifo_pop
  ,sdp2mcif_rd_req_valid
  ,sdp2mcif_rd_req_ready
  ,sdp2mcif_rd_req_pd
  ,sdp2mcif_wr_req_valid
  ,sdp2mcif_wr_req_ready
  ,sdp2mcif_wr_req_pd
  ,sdp2pdp_valid
  ,sdp2pdp_ready
  ,sdp2pdp_pd
  ,sdp_rdma2csb_resp_valid
  ,sdp_rdma2csb_resp_pd
  ,nvdla_core_clk
  ,dla_reset_rstn
  ,nvdla_core_rstn
  ,nvdla_falcon_clk
  ,nvdla_clk_ovr_on
  ,cdma_wt_done_status0
  ,cdma_wt_done_status1
  ,cdma_dat_done_status0
  ,cdma_dat_done_status1
  ,cacc_done_status0
  ,cacc_done_status1
  ,sdp_done_status0
  ,sdp_done_status1
  ,pdp_done_status0
  ,pdp_done_status1
  ,cdp_done_status0
  ,cdp_done_status1
  ,bdma_done_status0
  ,bdma_done_status1
  ,cdma_wt_done_0_counter
  ,cdma_wt_done_1_counter
  ,cdma_dat_done_0_counter
  ,cdma_dat_done_1_counter
  ,cacc_done_0_counter
  ,cacc_done_1_counter
  ,sdp_done_0_counter
  ,sdp_done_1_counter
  ,pdp_done_0_counter
  ,pdp_done_1_counter
  ,cdp_done_0_counter
  ,cdp_done_1_counter
  ,bdma_done_0_counter
  ,bdma_done_1_counter
  );
//
// NV_NVDLA_partition_o_io.v
//
////////////////////////////////////////////////////////////////////
input test_mode;
input direct_reset_;
input global_clk_ovr_on;
input tmc2slcg_disable_clock_gating;
input cdma2csb_resp_valid; /* data valid */
input [33:0] cdma2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
input [1:0] cdma_dat2glb_done_intr_pd;
input [1:0] cdma_wt2glb_done_intr_pd;
input cmac_a2csb_resp_valid; /* data valid */
input [33:0] cmac_a2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2cmac_a_req_pvld; /* data valid */
input csb2cmac_a_req_prdy; /* data return handshake */
output [62:0] csb2cmac_a_req_pd;
input cmac_b2csb_resp_valid; /* data valid */
input [33:0] cmac_b2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2cmac_b_req_pvld; /* data valid */
input csb2cmac_b_req_prdy; /* data return handshake */
output [62:0] csb2cmac_b_req_pd;
input cacc2csb_resp_valid; /* data valid */
input [33:0] cacc2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
input [1:0] cacc2glb_done_intr_pd;
output csb2cacc_req_pvld; /* data valid */
input csb2cacc_req_prdy; /* data return handshake */
output [62:0] csb2cacc_req_pd;
output csb2cdma_req_pvld; /* data valid */
input csb2cdma_req_prdy; /* data return handshake */
output [62:0] csb2cdma_req_pd;
output csb2csc_req_pvld; /* data valid */
input csb2csc_req_prdy; /* data return handshake */
output [62:0] csb2csc_req_pd;
input csc2csb_resp_valid; /* data valid */
input [33:0] csc2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
input csb2nvdla_valid; /* data valid */
output csb2nvdla_ready; /* data return handshake */
input [15:0] csb2nvdla_addr;
input [31:0] csb2nvdla_wdat;
input csb2nvdla_write;
input csb2nvdla_nposted;
output csb2sdp_rdma_req_pvld; /* data valid */
input csb2sdp_rdma_req_prdy; /* data return handshake */
output [62:0] csb2sdp_rdma_req_pd;
output csb2sdp_req_pvld; /* data valid */
input csb2sdp_req_prdy; /* data return handshake */
output [62:0] csb2sdp_req_pd;
input cdma_dat2cvif_rd_req_valid;
output cdma_dat2cvif_rd_req_ready;
input [64 +14:0] cdma_dat2cvif_rd_req_pd;
output cvif2cdma_dat_rd_rsp_valid;
input cvif2cdma_dat_rd_rsp_ready;
output [256 +(256/8/32)-1:0] cvif2cdma_dat_rd_rsp_pd;
input cdma_wt2cvif_rd_req_valid;
output cdma_wt2cvif_rd_req_ready;
input [64 +14:0] cdma_wt2cvif_rd_req_pd;
output cvif2cdma_wt_rd_rsp_valid;
input cvif2cdma_wt_rd_rsp_ready;
output [256 +(256/8/32)-1:0] cvif2cdma_wt_rd_rsp_pd;
output cvif2sdp_wr_rsp_complete;
input sdp2cvif_rd_cdt_lat_fifo_pop;
input sdp2cvif_rd_req_valid;
output sdp2cvif_rd_req_ready;
input [64 +14:0] sdp2cvif_rd_req_pd;
output cvif2sdp_rd_rsp_valid;
input cvif2sdp_rd_rsp_ready;
output [256 +(256/8/32)-1:0] cvif2sdp_rd_rsp_pd;
input sdp2cvif_wr_req_valid;
output sdp2cvif_wr_req_ready;
input [256 +(256/8/32):0] sdp2cvif_wr_req_pd;
output cvif2sdp_b_rd_rsp_valid;
input cvif2sdp_b_rd_rsp_ready;
output [256 +(256/8/32)-1:0] cvif2sdp_b_rd_rsp_pd;
input sdp_b2cvif_rd_cdt_lat_fifo_pop;
input sdp_b2cvif_rd_req_valid;
output sdp_b2cvif_rd_req_ready;
input [64 +14:0] sdp_b2cvif_rd_req_pd;
output cvif2sdp_e_rd_rsp_valid;
input cvif2sdp_e_rd_rsp_ready;
output [256 +(256/8/32)-1:0] cvif2sdp_e_rd_rsp_pd;
input sdp_e2cvif_rd_cdt_lat_fifo_pop;
input sdp_e2cvif_rd_req_valid;
output sdp_e2cvif_rd_req_ready;
input [64 +14:0] sdp_e2cvif_rd_req_pd;
output cvif2sdp_n_rd_rsp_valid;
input cvif2sdp_n_rd_rsp_ready;
output [256 +(256/8/32)-1:0] cvif2sdp_n_rd_rsp_pd;
input sdp_n2cvif_rd_cdt_lat_fifo_pop;
input sdp_n2cvif_rd_req_valid;
output sdp_n2cvif_rd_req_ready;
input [64 +14:0] sdp_n2cvif_rd_req_pd;
output cvif2noc_axi_ar_arvalid;
input cvif2noc_axi_ar_arready;
output [7:0] cvif2noc_axi_ar_arid;
output [3:0] cvif2noc_axi_ar_arlen;
output [64 -1:0] cvif2noc_axi_ar_araddr;
output cvif2noc_axi_aw_awvalid;
input cvif2noc_axi_aw_awready;
output [7:0] cvif2noc_axi_aw_awid;
output [3:0] cvif2noc_axi_aw_awlen;
output [64 -1:0] cvif2noc_axi_aw_awaddr;
output cvif2noc_axi_w_wvalid;
input cvif2noc_axi_w_wready;
output [256 -1:0] cvif2noc_axi_w_wdata;
output [256/8-1:0] cvif2noc_axi_w_wstrb;
output cvif2noc_axi_w_wlast;
input noc2cvif_axi_b_bvalid;
output noc2cvif_axi_b_bready;
input [7:0] noc2cvif_axi_b_bid;
input noc2cvif_axi_r_rvalid;
output noc2cvif_axi_r_rready;
input [7:0] noc2cvif_axi_r_rid;
input noc2cvif_axi_r_rlast;
input [256 -1:0] noc2cvif_axi_r_rdata;
output mcif2noc_axi_ar_arvalid;
input mcif2noc_axi_ar_arready;
output [7:0] mcif2noc_axi_ar_arid;
output [3:0] mcif2noc_axi_ar_arlen;
output [64 -1:0] mcif2noc_axi_ar_araddr;
output mcif2noc_axi_aw_awvalid;
input mcif2noc_axi_aw_awready;
output [7:0] mcif2noc_axi_aw_awid;
output [3:0] mcif2noc_axi_aw_awlen;
output [64 -1:0] mcif2noc_axi_aw_awaddr;
output mcif2noc_axi_w_wvalid;
input mcif2noc_axi_w_wready;
output [256 -1:0] mcif2noc_axi_w_wdata;
output [256/8-1:0] mcif2noc_axi_w_wstrb;
output mcif2noc_axi_w_wlast;
input noc2mcif_axi_b_bvalid;
output noc2mcif_axi_b_bready;
input [7:0] noc2mcif_axi_b_bid;
input noc2mcif_axi_r_rvalid;
output noc2mcif_axi_r_rready;
input [7:0] noc2mcif_axi_r_rid;
input noc2mcif_axi_r_rlast;
input [256 -1:0] noc2mcif_axi_r_rdata;
input cdma_dat2mcif_rd_req_valid;
output cdma_dat2mcif_rd_req_ready;
input [64 +14:0] cdma_dat2mcif_rd_req_pd;
input cdma_wt2mcif_rd_req_valid;
output cdma_wt2mcif_rd_req_ready;
input [64 +14:0] cdma_wt2mcif_rd_req_pd;
output mcif2cdma_dat_rd_rsp_valid;
input mcif2cdma_dat_rd_rsp_ready;
output [256 +(256/8/32)-1:0] mcif2cdma_dat_rd_rsp_pd;
output mcif2cdma_wt_rd_rsp_valid;
input mcif2cdma_wt_rd_rsp_ready;
output [256 +(256/8/32)-1:0] mcif2cdma_wt_rd_rsp_pd;
output mcif2sdp_b_rd_rsp_valid;
input mcif2sdp_b_rd_rsp_ready;
output [256 +(256/8/32)-1:0] mcif2sdp_b_rd_rsp_pd;
input sdp_b2mcif_rd_cdt_lat_fifo_pop;
input sdp_b2mcif_rd_req_valid;
output sdp_b2mcif_rd_req_ready;
input [64 +14:0] sdp_b2mcif_rd_req_pd;
output mcif2sdp_e_rd_rsp_valid;
input mcif2sdp_e_rd_rsp_ready;
output [256 +(256/8/32)-1:0] mcif2sdp_e_rd_rsp_pd;
input sdp_e2mcif_rd_cdt_lat_fifo_pop;
input sdp_e2mcif_rd_req_valid;
output sdp_e2mcif_rd_req_ready;
input [64 +14:0] sdp_e2mcif_rd_req_pd;
output mcif2sdp_n_rd_rsp_valid;
input mcif2sdp_n_rd_rsp_ready;
output [256 +(256/8/32)-1:0] mcif2sdp_n_rd_rsp_pd;
input sdp_n2mcif_rd_cdt_lat_fifo_pop;
input sdp_n2mcif_rd_req_valid;
output sdp_n2mcif_rd_req_ready;
input [64 +14:0] sdp_n2mcif_rd_req_pd;
input sdp2mcif_rd_cdt_lat_fifo_pop;
input sdp2mcif_rd_req_valid;
output sdp2mcif_rd_req_ready;
input [64 +14:0] sdp2mcif_rd_req_pd;
output mcif2sdp_rd_rsp_valid;
input mcif2sdp_rd_rsp_ready;
output [256 +(256/8/32)-1:0] mcif2sdp_rd_rsp_pd;
output mcif2sdp_wr_rsp_complete;
input sdp2mcif_wr_req_valid;
output sdp2mcif_wr_req_ready;
input [256 +(256/8/32):0] sdp2mcif_wr_req_pd;
output nvdla2csb_valid; /* data valid */
output [31:0] nvdla2csb_data;
output nvdla2csb_wr_complete;
output core_intr;
input [31:0] pwrbus_ram_pd;
input sdp2csb_resp_valid; /* data valid */
input [33:0] sdp2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
input [1:0] sdp2glb_done_intr_pd;
input sdp2pdp_valid;
output sdp2pdp_ready;
input [8*16 -1:0] sdp2pdp_pd;
input sdp_rdma2csb_resp_valid; /* data valid */
input [33:0] sdp_rdma2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
input nvdla_core_clk;
input dla_reset_rstn;
output nvdla_core_rstn;
input nvdla_falcon_clk;
output nvdla_clk_ovr_on;
output cdma_wt_done_status0;
output cdma_wt_done_status1;
output cdma_dat_done_status0;
output cdma_dat_done_status1;
output cacc_done_status0;
output cacc_done_status1;
output sdp_done_status0;
output sdp_done_status1;
output pdp_done_status0;
output pdp_done_status1;
output cdp_done_status0;
output cdp_done_status1;
output bdma_done_status0;
output bdma_done_status1;
output [31:0] cdma_wt_done_0_counter ;
output [31:0] cdma_wt_done_1_counter ;
output [31:0] cdma_dat_done_0_counter;
output [31:0] cdma_dat_done_1_counter;
output [31:0] cacc_done_0_counter    ;
output [31:0] cacc_done_1_counter    ;
output [31:0] sdp_done_0_counter     ;
output [31:0] sdp_done_1_counter     ;
output [31:0] pdp_done_0_counter     ;
output [31:0] pdp_done_1_counter     ;
output [31:0] cdp_done_0_counter     ;
output [31:0] cdp_done_1_counter     ;
output [31:0] bdma_done_0_counter    ;
output [31:0] bdma_done_1_counter    ;
/////////////////////////////////////////////////////////
wire [62:0] csb2cfgrom_req_pd;
wire csb2cfgrom_req_pvld;
wire csb2cfgrom_req_prdy;
wire [33:0] cfgrom2csb_resp_pd;
wire cfgrom2csb_resp_valid;
wire [33:0] bdma2csb_resp_pd;
wire bdma2csb_resp_valid;
wire bdma2cvif_rd_cdt_lat_fifo_pop;
wire cdp2cvif_rd_cdt_lat_fifo_pop;
wire pdp2cvif_rd_cdt_lat_fifo_pop;
wire rbk2cvif_rd_cdt_lat_fifo_pop;
wire sdp2cvif_rd_cdt_lat_fifo_pop;
wire sdp_n2cvif_rd_cdt_lat_fifo_pop;
wire sdp_e2cvif_rd_cdt_lat_fifo_pop;
wire sdp_b2cvif_rd_cdt_lat_fifo_pop;
wire bdma2mcif_rd_cdt_lat_fifo_pop;
wire cdp2mcif_rd_cdt_lat_fifo_pop;
wire pdp2mcif_rd_cdt_lat_fifo_pop;
wire rbk2mcif_rd_cdt_lat_fifo_pop;
wire sdp2mcif_rd_cdt_lat_fifo_pop;
wire sdp_n2mcif_rd_cdt_lat_fifo_pop;
wire sdp_e2mcif_rd_cdt_lat_fifo_pop;
wire sdp_b2mcif_rd_cdt_lat_fifo_pop;
wire cdma_wt2cvif_rd_cdt_lat_fifo_pop;
wire cdma_wt2mcif_rd_cdt_lat_fifo_pop;
wire cdma_dat2cvif_rd_cdt_lat_fifo_pop;
wire cdma_dat2mcif_rd_cdt_lat_fifo_pop;
wire [64 +14:0] bdma2cvif_rd_req_pd;
wire bdma2cvif_rd_req_ready;
wire bdma2cvif_rd_req_valid;
wire [256 +(256/8/32):0] bdma2cvif_wr_req_pd;
wire bdma2cvif_wr_req_ready;
wire bdma2cvif_wr_req_valid;
wire [1:0] bdma2glb_done_intr_pd;
wire [64 +14:0] bdma2mcif_rd_req_pd;
wire bdma2mcif_rd_req_ready;
wire bdma2mcif_rd_req_valid;
wire [256 +(256/8/32):0] bdma2mcif_wr_req_pd;
wire bdma2mcif_wr_req_ready;
wire bdma2mcif_wr_req_valid;
wire [33:0] cdp2csb_resp_pd;
wire cdp2csb_resp_valid;
wire [64 +14:0] cdp2cvif_rd_req_pd;
wire cdp2cvif_rd_req_ready;
wire cdp2cvif_rd_req_valid;
wire [256 +(256/8/32):0] cdp2cvif_wr_req_pd;
wire cdp2cvif_wr_req_ready;
wire cdp2cvif_wr_req_valid;
wire [1:0] cdp2glb_done_intr_pd;
wire [64 +14:0] cdp2mcif_rd_req_pd;
wire cdp2mcif_rd_req_ready;
wire cdp2mcif_rd_req_valid;
wire [256 +(256/8/32):0] cdp2mcif_wr_req_pd;
wire cdp2mcif_wr_req_ready;
wire cdp2mcif_wr_req_valid;
wire [33:0] cdp_rdma2csb_resp_pd;
wire cdp_rdma2csb_resp_valid;
wire [62:0] csb2bdma_req_pd;
wire csb2bdma_req_prdy;
wire csb2bdma_req_pvld;
wire [62:0] csb2cdp_rdma_req_pd;
wire csb2cdp_rdma_req_prdy;
wire csb2cdp_rdma_req_pvld;
wire [62:0] csb2cdp_req_pd;
wire csb2cdp_req_prdy;
wire csb2cdp_req_pvld;
wire [62:0] csb2cvif_req_pd;
wire csb2cvif_req_prdy;
wire csb2cvif_req_pvld;
wire [62:0] csb2glb_req_pd;
wire csb2glb_req_prdy;
wire csb2glb_req_pvld;
wire [62:0] csb2mcif_req_pd;
wire csb2mcif_req_prdy;
wire csb2mcif_req_pvld;
wire [62:0] csb2pdp_rdma_req_pd;
wire csb2pdp_rdma_req_prdy;
wire csb2pdp_rdma_req_pvld;
wire [62:0] csb2pdp_req_pd;
wire csb2pdp_req_prdy;
wire csb2pdp_req_pvld;
wire [62:0] csb2rbk_req_pd;
wire csb2rbk_req_prdy;
wire csb2rbk_req_pvld;
wire [256 +(256/8/32)-1:0] cvif2bdma_rd_rsp_pd;
wire cvif2bdma_rd_rsp_ready;
wire cvif2bdma_rd_rsp_valid;
wire cvif2bdma_wr_rsp_complete;
wire [256 +(256/8/32)-1:0] cvif2cdp_rd_rsp_pd;
wire cvif2cdp_rd_rsp_ready;
wire cvif2cdp_rd_rsp_valid;
wire cvif2cdp_wr_rsp_complete;
wire [33:0] cvif2csb_resp_pd;
wire cvif2csb_resp_valid;
wire [256 +(256/8/32)-1:0] cvif2pdp_rd_rsp_pd;
wire cvif2pdp_rd_rsp_ready;
wire cvif2pdp_rd_rsp_valid;
wire cvif2pdp_wr_rsp_complete;
wire [256 +(256/8/32)-1:0] cvif2rbk_rd_rsp_pd;
wire cvif2rbk_rd_rsp_ready;
wire cvif2rbk_rd_rsp_valid;
wire cvif2rbk_wr_rsp_complete;
wire dla_clk_ovr_on_sync;
wire [33:0] glb2csb_resp_pd;
wire glb2csb_resp_valid;
wire global_clk_ovr_on_sync;
wire [256 +(256/8/32)-1:0] mcif2bdma_rd_rsp_pd;
wire mcif2bdma_rd_rsp_ready;
wire mcif2bdma_rd_rsp_valid;
wire mcif2bdma_wr_rsp_complete;
wire [256 +(256/8/32)-1:0] mcif2cdp_rd_rsp_pd;
wire mcif2cdp_rd_rsp_ready;
wire mcif2cdp_rd_rsp_valid;
wire mcif2cdp_wr_rsp_complete;
wire [33:0] mcif2csb_resp_pd;
wire mcif2csb_resp_valid;
wire [256 +(256/8/32)-1:0] mcif2pdp_rd_rsp_pd;
wire mcif2pdp_rd_rsp_ready;
wire mcif2pdp_rd_rsp_valid;
wire mcif2pdp_wr_rsp_complete;
wire [256 +(256/8/32)-1:0] mcif2rbk_rd_rsp_pd;
wire mcif2rbk_rd_rsp_ready;
wire mcif2rbk_rd_rsp_valid;
wire mcif2rbk_wr_rsp_complete;
wire nvdla_falcon_rstn;
wire [33:0] pdp2csb_resp_pd;
wire pdp2csb_resp_valid;
wire [64 +14:0] pdp2cvif_rd_req_pd;
wire pdp2cvif_rd_req_ready;
wire pdp2cvif_rd_req_valid;
wire [256 +(256/8/32):0] pdp2cvif_wr_req_pd;
wire pdp2cvif_wr_req_ready;
wire pdp2cvif_wr_req_valid;
wire [1:0] pdp2glb_done_intr_pd;
wire [64 +14:0] pdp2mcif_rd_req_pd;
wire pdp2mcif_rd_req_ready;
wire pdp2mcif_rd_req_valid;
wire [256 +(256/8/32):0] pdp2mcif_wr_req_pd;
wire pdp2mcif_wr_req_ready;
wire pdp2mcif_wr_req_valid;
wire [33:0] pdp_rdma2csb_resp_pd;
wire pdp_rdma2csb_resp_valid;
wire [33:0] rbk2csb_resp_pd;
wire rbk2csb_resp_valid;
wire [64 +14:0] rbk2cvif_rd_req_pd;
wire rbk2cvif_rd_req_ready;
wire rbk2cvif_rd_req_valid;
wire [256 +(256/8/32):0] rbk2cvif_wr_req_pd;
wire rbk2cvif_wr_req_ready;
wire rbk2cvif_wr_req_valid;
wire [64 +14:0] rbk2mcif_rd_req_pd;
wire rbk2mcif_rd_req_ready;
wire rbk2mcif_rd_req_valid;
wire [256 +(256/8/32):0] rbk2mcif_wr_req_pd;
wire rbk2mcif_wr_req_ready;
wire rbk2mcif_wr_req_valid;
wire [1:0] rubik2glb_done_intr_pd;
wire cdma_op_en; //modified by jiazhaorong
//
assign nvdla_clk_ovr_on = 0;
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: Reset Syncer for nvdla_core_clk //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_core_reset u_sync_core_reset (
   .dla_reset_rstn (dla_reset_rstn)
  ,.direct_reset_ (direct_reset_)
  ,.test_mode (test_mode)
  ,.synced_rstn (nvdla_core_rstn)
  ,.core_reset_rstn (1'b1)
  ,.nvdla_clk (nvdla_core_clk)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: Reset Syncer for nvdla_falcon_clk //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_reset u_sync_falcon_reset (
   .dla_reset_rstn (nvdla_core_rstn)
  ,.direct_reset_ (direct_reset_)
  ,.test_mode (test_mode)
  ,.synced_rstn (nvdla_falcon_rstn)
  ,.nvdla_clk (nvdla_falcon_clk)
  );
////////////////////////////////////////////////////////////////////////
// SLCG override
////////////////////////////////////////////////////////////////////////
NV_NVDLA_sync3d u_dla_clk_ovr_on_core_sync (
   .clk (nvdla_core_clk)
  ,.sync_i (nvdla_clk_ovr_on)
  ,.sync_o (dla_clk_ovr_on_sync)
  );
NV_NVDLA_sync3d_s u_global_clk_ovr_on_core_sync (
   .clk (nvdla_core_clk)
  ,.prst (nvdla_core_rstn)
  ,.sync_i (global_clk_ovr_on)
  ,.sync_o (global_clk_ovr_on_sync)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: CFGROM //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_cfgrom u_NV_NVDLA_cfgrom(
  .nvdla_core_clk (nvdla_core_clk )
 ,.nvdla_core_rstn (nvdla_core_rstn )
 ,.csb2cfgrom_req_pd (csb2cfgrom_req_pd )
 ,.csb2cfgrom_req_pvld (csb2cfgrom_req_pvld )
 ,.csb2cfgrom_req_prdy (csb2cfgrom_req_prdy )
 ,.cfgrom2csb_resp_pd (cfgrom2csb_resp_pd )
 ,.cfgrom2csb_resp_valid (cfgrom2csb_resp_valid )
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: CSB master //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_csb_master u_NV_NVDLA_csb_master (
   .nvdla_core_clk (nvdla_core_clk)
  ,.nvdla_core_rstn (nvdla_core_rstn)
  ,.nvdla_falcon_clk (nvdla_falcon_clk)
  ,.nvdla_falcon_rstn (nvdla_falcon_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd)
  ,.csb2nvdla_valid (csb2nvdla_valid)
  ,.csb2nvdla_ready (csb2nvdla_ready)
  ,.csb2nvdla_addr (csb2nvdla_addr)
  ,.csb2nvdla_wdat (csb2nvdla_wdat)
  ,.csb2nvdla_write (csb2nvdla_write)
  ,.csb2nvdla_nposted (csb2nvdla_nposted)
  ,.nvdla2csb_valid (nvdla2csb_valid)
  ,.nvdla2csb_data (nvdla2csb_data)
  ,.nvdla2csb_wr_complete (nvdla2csb_wr_complete)
  ,.csb2cfgrom_req_pd (csb2cfgrom_req_pd )
  ,.csb2cfgrom_req_pvld (csb2cfgrom_req_pvld )
  ,.csb2cfgrom_req_prdy (csb2cfgrom_req_prdy )
  ,.cfgrom2csb_resp_pd (cfgrom2csb_resp_pd )
  ,.cfgrom2csb_resp_valid (cfgrom2csb_resp_valid )
  ,.csb2glb_req_pvld (csb2glb_req_pvld)
  ,.csb2glb_req_prdy (csb2glb_req_prdy)
  ,.csb2glb_req_pd (csb2glb_req_pd)
  ,.glb2csb_resp_valid (glb2csb_resp_valid)
  ,.glb2csb_resp_pd (glb2csb_resp_pd)
  ,.csb2mcif_req_pvld (csb2mcif_req_pvld)
  ,.csb2mcif_req_prdy (csb2mcif_req_prdy)
  ,.csb2mcif_req_pd (csb2mcif_req_pd)
  ,.mcif2csb_resp_valid (mcif2csb_resp_valid)
  ,.mcif2csb_resp_pd (mcif2csb_resp_pd)
  ,.csb2cvif_req_pvld (csb2cvif_req_pvld)
  ,.csb2cvif_req_prdy (csb2cvif_req_prdy)
  ,.csb2cvif_req_pd (csb2cvif_req_pd)
  ,.cvif2csb_resp_valid (cvif2csb_resp_valid)
  ,.cvif2csb_resp_pd (cvif2csb_resp_pd)
  ,.csb2bdma_req_pvld (csb2bdma_req_pvld)
  ,.csb2bdma_req_prdy (csb2bdma_req_prdy)
  ,.csb2bdma_req_pd (csb2bdma_req_pd)
  ,.bdma2csb_resp_valid (bdma2csb_resp_valid)
  ,.bdma2csb_resp_pd (bdma2csb_resp_pd)
  ,.csb2cdma_req_pvld (csb2cdma_req_pvld)
  ,.csb2cdma_req_prdy (csb2cdma_req_prdy)
  ,.csb2cdma_req_pd (csb2cdma_req_pd)
  ,.cdma2csb_resp_valid (cdma2csb_resp_valid)
  ,.cdma2csb_resp_pd (cdma2csb_resp_pd)
  ,.csb2csc_req_pvld (csb2csc_req_pvld)
  ,.csb2csc_req_prdy (csb2csc_req_prdy)
  ,.csb2csc_req_pd (csb2csc_req_pd)
  ,.csc2csb_resp_valid (csc2csb_resp_valid)
  ,.csc2csb_resp_pd (csc2csb_resp_pd)
  ,.csb2cmac_a_req_pvld (csb2cmac_a_req_pvld)
  ,.csb2cmac_a_req_prdy (csb2cmac_a_req_prdy)
  ,.csb2cmac_a_req_pd (csb2cmac_a_req_pd)
  ,.cmac_a2csb_resp_valid (cmac_a2csb_resp_valid)
  ,.cmac_a2csb_resp_pd (cmac_a2csb_resp_pd)
  ,.csb2cmac_b_req_pvld (csb2cmac_b_req_pvld)
  ,.csb2cmac_b_req_prdy (csb2cmac_b_req_prdy)
  ,.csb2cmac_b_req_pd (csb2cmac_b_req_pd)
  ,.cmac_b2csb_resp_valid (cmac_b2csb_resp_valid)
  ,.cmac_b2csb_resp_pd (cmac_b2csb_resp_pd)
  ,.csb2cacc_req_pvld (csb2cacc_req_pvld)
  ,.csb2cacc_req_prdy (csb2cacc_req_prdy)
  ,.csb2cacc_req_pd (csb2cacc_req_pd)
  ,.cacc2csb_resp_valid (cacc2csb_resp_valid)
  ,.cacc2csb_resp_pd (cacc2csb_resp_pd)
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd)
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd)
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.csb2sdp_req_pd (csb2sdp_req_pd)
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd)
  ,.csb2pdp_rdma_req_pvld (csb2pdp_rdma_req_pvld)
  ,.csb2pdp_rdma_req_prdy (csb2pdp_rdma_req_prdy)
  ,.csb2pdp_rdma_req_pd (csb2pdp_rdma_req_pd)
  ,.pdp_rdma2csb_resp_valid (pdp_rdma2csb_resp_valid)
  ,.pdp_rdma2csb_resp_pd (pdp_rdma2csb_resp_pd)
  ,.csb2pdp_req_pvld (csb2pdp_req_pvld)
  ,.csb2pdp_req_prdy (csb2pdp_req_prdy)
  ,.csb2pdp_req_pd (csb2pdp_req_pd)
  ,.pdp2csb_resp_valid (pdp2csb_resp_valid)
  ,.pdp2csb_resp_pd (pdp2csb_resp_pd)
  ,.csb2cdp_rdma_req_pvld (csb2cdp_rdma_req_pvld)
  ,.csb2cdp_rdma_req_prdy (csb2cdp_rdma_req_prdy)
  ,.csb2cdp_rdma_req_pd (csb2cdp_rdma_req_pd)
  ,.cdp_rdma2csb_resp_valid (cdp_rdma2csb_resp_valid)
  ,.cdp_rdma2csb_resp_pd (cdp_rdma2csb_resp_pd)
  ,.csb2cdp_req_pvld (csb2cdp_req_pvld)
  ,.csb2cdp_req_prdy (csb2cdp_req_prdy)
  ,.csb2cdp_req_pd (csb2cdp_req_pd)
  ,.cdp2csb_resp_valid (cdp2csb_resp_valid)
  ,.cdp2csb_resp_pd (cdp2csb_resp_pd)
  ,.cdma_op_en(cdma_op_en)
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: ASYNC CROSSING INTERFACE //
////////////////////////////////////////////////////////////////////////
//&Instance NV_NVDLA_async;
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: AXI Interface to MC //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_mcif u_NV_NVDLA_mcif (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< o
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.csb2mcif_req_pvld (csb2mcif_req_pvld) //|< w
  ,.csb2mcif_req_prdy (csb2mcif_req_prdy) //|> w
  ,.csb2mcif_req_pd (csb2mcif_req_pd[62:0]) //|< w
  ,.mcif2csb_resp_valid (mcif2csb_resp_valid) //|> w
  ,.mcif2csb_resp_pd (mcif2csb_resp_pd[33:0]) //|> w
  ,.cdma_dat2mcif_rd_cdt_lat_fifo_pop (1'b0)
  ,.cdma_dat2mcif_rd_req_valid (cdma_dat2mcif_rd_req_valid) //|< i
  ,.cdma_dat2mcif_rd_req_ready (cdma_dat2mcif_rd_req_ready) //|> o
  ,.cdma_dat2mcif_rd_req_pd (cdma_dat2mcif_rd_req_pd ) //|< i
  ,.mcif2cdma_dat_rd_rsp_valid (mcif2cdma_dat_rd_rsp_valid) //|> o
  ,.mcif2cdma_dat_rd_rsp_ready (mcif2cdma_dat_rd_rsp_ready) //|< i
  ,.mcif2cdma_dat_rd_rsp_pd (mcif2cdma_dat_rd_rsp_pd ) //|> o
  ,.cdma_wt2mcif_rd_cdt_lat_fifo_pop (1'b0)
  ,.cdma_wt2mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid) //|< i
  ,.cdma_wt2mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready) //|> o
  ,.cdma_wt2mcif_rd_req_pd (cdma_wt2mcif_rd_req_pd ) //|< i
  ,.mcif2cdma_wt_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid) //|> o
  ,.mcif2cdma_wt_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready) //|< i
  ,.mcif2cdma_wt_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd ) //|> o
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid) //|< i
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready) //|> o
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd ) //|< i
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid) //|> o
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready) //|< i
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd ) //|> o
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid) //|< i
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready) //|> o
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd ) //|< i
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete) //|> o
  ,.cdp2mcif_rd_cdt_lat_fifo_pop (cdp2mcif_rd_cdt_lat_fifo_pop) //|< w
  ,.cdp2mcif_rd_req_valid (cdp2mcif_rd_req_valid) //|< w
  ,.cdp2mcif_rd_req_ready (cdp2mcif_rd_req_ready) //|> w
  ,.cdp2mcif_rd_req_pd (cdp2mcif_rd_req_pd ) //|< w
  ,.cdp2mcif_wr_req_valid (cdp2mcif_wr_req_valid) //|< w
  ,.cdp2mcif_wr_req_ready (cdp2mcif_wr_req_ready) //|> w
  ,.cdp2mcif_wr_req_pd (cdp2mcif_wr_req_pd ) //|< w
  ,.mcif2cdp_rd_rsp_valid (mcif2cdp_rd_rsp_valid) //|> w
  ,.mcif2cdp_rd_rsp_ready (mcif2cdp_rd_rsp_ready) //|< w
  ,.mcif2cdp_rd_rsp_pd (mcif2cdp_rd_rsp_pd ) //|> w
  ,.mcif2cdp_wr_rsp_complete (mcif2cdp_wr_rsp_complete) //|> w
  ,.mcif2pdp_rd_rsp_valid (mcif2pdp_rd_rsp_valid) //|> w
  ,.mcif2pdp_rd_rsp_ready (mcif2pdp_rd_rsp_ready) //|< w
  ,.mcif2pdp_rd_rsp_pd (mcif2pdp_rd_rsp_pd ) //|> w
  ,.mcif2pdp_wr_rsp_complete (mcif2pdp_wr_rsp_complete) //|> w
  ,.pdp2mcif_rd_cdt_lat_fifo_pop (pdp2mcif_rd_cdt_lat_fifo_pop) //|> w
  ,.pdp2mcif_rd_req_valid (pdp2mcif_rd_req_valid) //|> w
  ,.pdp2mcif_rd_req_ready (pdp2mcif_rd_req_ready) //|> w
  ,.pdp2mcif_rd_req_pd (pdp2mcif_rd_req_pd ) //|> w
  ,.pdp2mcif_wr_req_valid (pdp2mcif_wr_req_valid) //|> w
  ,.pdp2mcif_wr_req_ready (pdp2mcif_wr_req_ready) //|> w
  ,.pdp2mcif_wr_req_pd (pdp2mcif_wr_req_pd ) //|> w
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid) //|< i
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready) //|> o
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd ) //|< i
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid) //|> o
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready) //|< i
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd ) //|> o
  ,.sdp_e2mcif_rd_cdt_lat_fifo_pop (sdp_e2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp_e2mcif_rd_req_valid (sdp_e2mcif_rd_req_valid) //|< i
  ,.sdp_e2mcif_rd_req_ready (sdp_e2mcif_rd_req_ready) //|> o
  ,.sdp_e2mcif_rd_req_pd (sdp_e2mcif_rd_req_pd ) //|< i
  ,.mcif2sdp_e_rd_rsp_valid (mcif2sdp_e_rd_rsp_valid) //|> o
  ,.mcif2sdp_e_rd_rsp_ready (mcif2sdp_e_rd_rsp_ready) //|< i
  ,.mcif2sdp_e_rd_rsp_pd (mcif2sdp_e_rd_rsp_pd ) //|> o
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid) //|< i
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready) //|> o
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd ) //|< i
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid) //|> o
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready) //|< i
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd ) //|> o
  ,.bdma2mcif_rd_cdt_lat_fifo_pop (bdma2mcif_rd_cdt_lat_fifo_pop) //|< w
  ,.bdma2mcif_rd_req_valid (bdma2mcif_rd_req_valid) //|< w
  ,.bdma2mcif_rd_req_ready (bdma2mcif_rd_req_ready) //|> w
  ,.bdma2mcif_rd_req_pd (bdma2mcif_rd_req_pd) //|< w
  ,.bdma2mcif_wr_req_valid (bdma2mcif_wr_req_valid) //|< w
  ,.bdma2mcif_wr_req_ready (bdma2mcif_wr_req_ready) //|> w
  ,.bdma2mcif_wr_req_pd (bdma2mcif_wr_req_pd ) //|< w
  ,.mcif2bdma_rd_rsp_valid (mcif2bdma_rd_rsp_valid) //|> w
  ,.mcif2bdma_rd_rsp_ready (mcif2bdma_rd_rsp_ready) //|< w
  ,.mcif2bdma_rd_rsp_pd (mcif2bdma_rd_rsp_pd ) //|> w
  ,.mcif2bdma_wr_rsp_complete (mcif2bdma_wr_rsp_complete) //|> w
  ,.mcif2noc_axi_ar_arvalid (mcif2noc_axi_ar_arvalid) //|> o
  ,.mcif2noc_axi_ar_arready (mcif2noc_axi_ar_arready) //|< i
  ,.mcif2noc_axi_ar_arid (mcif2noc_axi_ar_arid[7:0]) //|> o
  ,.mcif2noc_axi_ar_arlen (mcif2noc_axi_ar_arlen[3:0]) //|> o
  ,.mcif2noc_axi_ar_araddr (mcif2noc_axi_ar_araddr ) //|> o
  ,.noc2mcif_axi_r_rvalid (noc2mcif_axi_r_rvalid) //|< i
  ,.noc2mcif_axi_r_rready (noc2mcif_axi_r_rready) //|> o
  ,.noc2mcif_axi_r_rid (noc2mcif_axi_r_rid[7:0]) //|< i
  ,.noc2mcif_axi_r_rlast (noc2mcif_axi_r_rlast) //|< i
  ,.noc2mcif_axi_r_rdata (noc2mcif_axi_r_rdata ) //|< i
  ,.mcif2noc_axi_aw_awvalid (mcif2noc_axi_aw_awvalid) //|> o
  ,.mcif2noc_axi_aw_awready (mcif2noc_axi_aw_awready) //|< i
  ,.mcif2noc_axi_aw_awid (mcif2noc_axi_aw_awid[7:0]) //|> o
  ,.mcif2noc_axi_aw_awlen (mcif2noc_axi_aw_awlen[3:0]) //|> o
  ,.mcif2noc_axi_aw_awaddr (mcif2noc_axi_aw_awaddr ) //|> o
  ,.mcif2noc_axi_w_wvalid (mcif2noc_axi_w_wvalid) //|> o
  ,.mcif2noc_axi_w_wready (mcif2noc_axi_w_wready) //|< i
  ,.mcif2noc_axi_w_wdata (mcif2noc_axi_w_wdata ) //|> o
  ,.mcif2noc_axi_w_wstrb (mcif2noc_axi_w_wstrb ) //|> o
  ,.mcif2noc_axi_w_wlast (mcif2noc_axi_w_wlast) //|> o
  ,.noc2mcif_axi_b_bvalid (noc2mcif_axi_b_bvalid) //|< i
  ,.noc2mcif_axi_b_bready (noc2mcif_axi_b_bready) //|> o
  ,.noc2mcif_axi_b_bid (noc2mcif_axi_b_bid[7:0]) //|< i
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: AXI Interface to CVSRAM //
////////////////////////////////////////////////////////////////////////
   NV_NVDLA_mcif u_NV_NVDLA_cvif (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< o
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.csb2mcif_req_pvld (csb2cvif_req_pvld) //|< w
  ,.csb2mcif_req_prdy (csb2cvif_req_prdy) //|> w
  ,.csb2mcif_req_pd (csb2cvif_req_pd[62:0]) //|< w
  ,.mcif2csb_resp_valid (cvif2csb_resp_valid) //|> w
  ,.mcif2csb_resp_pd (cvif2csb_resp_pd[33:0]) //|> w
  ,.cdma_dat2mcif_rd_cdt_lat_fifo_pop (1'b0)
  ,.cdma_dat2mcif_rd_req_valid (cdma_dat2cvif_rd_req_valid) //|< i
  ,.cdma_dat2mcif_rd_req_ready (cdma_dat2cvif_rd_req_ready) //|> o
  ,.cdma_dat2mcif_rd_req_pd (cdma_dat2cvif_rd_req_pd ) //|< i
  ,.mcif2cdma_dat_rd_rsp_valid (cvif2cdma_dat_rd_rsp_valid) //|> o
  ,.mcif2cdma_dat_rd_rsp_ready (cvif2cdma_dat_rd_rsp_ready) //|< i
  ,.mcif2cdma_dat_rd_rsp_pd (cvif2cdma_dat_rd_rsp_pd ) //|> o
  ,.cdma_wt2mcif_rd_cdt_lat_fifo_pop (1'b0)
  ,.cdma_wt2mcif_rd_req_valid (cdma_wt2cvif_rd_req_valid) //|< i
  ,.cdma_wt2mcif_rd_req_ready (cdma_wt2cvif_rd_req_ready) //|> o
  ,.cdma_wt2mcif_rd_req_pd (cdma_wt2cvif_rd_req_pd ) //|< i
  ,.mcif2cdma_wt_rd_rsp_valid (cvif2cdma_wt_rd_rsp_valid) //|> o
  ,.mcif2cdma_wt_rd_rsp_ready (cvif2cdma_wt_rd_rsp_ready) //|< i
  ,.mcif2cdma_wt_rd_rsp_pd (cvif2cdma_wt_rd_rsp_pd ) //|> o
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2cvif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp2mcif_rd_req_valid (sdp2cvif_rd_req_valid) //|< i
  ,.sdp2mcif_rd_req_ready (sdp2cvif_rd_req_ready) //|> o
  ,.sdp2mcif_rd_req_pd (sdp2cvif_rd_req_pd ) //|< i
  ,.mcif2sdp_rd_rsp_valid (cvif2sdp_rd_rsp_valid) //|> o
  ,.mcif2sdp_rd_rsp_ready (cvif2sdp_rd_rsp_ready) //|< i
  ,.mcif2sdp_rd_rsp_pd (cvif2sdp_rd_rsp_pd ) //|> o
  ,.sdp2mcif_wr_req_valid (sdp2cvif_wr_req_valid) //|< i
  ,.sdp2mcif_wr_req_ready (sdp2cvif_wr_req_ready) //|> o
  ,.sdp2mcif_wr_req_pd (sdp2cvif_wr_req_pd ) //|< i
  ,.mcif2sdp_wr_rsp_complete (cvif2sdp_wr_rsp_complete) //|> o
  ,.cdp2mcif_rd_cdt_lat_fifo_pop (cdp2cvif_rd_cdt_lat_fifo_pop) //|< w
  ,.cdp2mcif_rd_req_valid (cdp2cvif_rd_req_valid) //|< w
  ,.cdp2mcif_rd_req_ready (cdp2cvif_rd_req_ready) //|> w
  ,.cdp2mcif_rd_req_pd (cdp2cvif_rd_req_pd ) //|< w
  ,.cdp2mcif_wr_req_valid (cdp2cvif_wr_req_valid) //|< w
  ,.cdp2mcif_wr_req_ready (cdp2cvif_wr_req_ready) //|> w
  ,.cdp2mcif_wr_req_pd (cdp2cvif_wr_req_pd ) //|< w
  ,.mcif2cdp_rd_rsp_valid (cvif2cdp_rd_rsp_valid) //|> w
  ,.mcif2cdp_rd_rsp_ready (cvif2cdp_rd_rsp_ready) //|< w
  ,.mcif2cdp_rd_rsp_pd (cvif2cdp_rd_rsp_pd ) //|> w
  ,.mcif2cdp_wr_rsp_complete (cvif2cdp_wr_rsp_complete) //|> w
  ,.mcif2pdp_rd_rsp_valid (cvif2pdp_rd_rsp_valid) //|> w
  ,.mcif2pdp_rd_rsp_ready (cvif2pdp_rd_rsp_ready) //|< w
  ,.mcif2pdp_rd_rsp_pd (cvif2pdp_rd_rsp_pd ) //|> w
  ,.mcif2pdp_wr_rsp_complete (cvif2pdp_wr_rsp_complete) //|> w
  ,.pdp2mcif_rd_cdt_lat_fifo_pop (pdp2cvif_rd_cdt_lat_fifo_pop) //|> w
  ,.pdp2mcif_rd_req_valid (pdp2cvif_rd_req_valid) //|> w
  ,.pdp2mcif_rd_req_ready (pdp2cvif_rd_req_ready) //|> w
  ,.pdp2mcif_rd_req_pd (pdp2cvif_rd_req_pd ) //|> w
  ,.pdp2mcif_wr_req_valid (pdp2cvif_wr_req_valid) //|> w
  ,.pdp2mcif_wr_req_ready (pdp2cvif_wr_req_ready) //|> w
  ,.pdp2mcif_wr_req_pd (pdp2cvif_wr_req_pd ) //|> w
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2cvif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp_b2mcif_rd_req_valid (sdp_b2cvif_rd_req_valid) //|< i
  ,.sdp_b2mcif_rd_req_ready (sdp_b2cvif_rd_req_ready) //|> o
  ,.sdp_b2mcif_rd_req_pd (sdp_b2cvif_rd_req_pd ) //|< i
  ,.mcif2sdp_b_rd_rsp_valid (cvif2sdp_b_rd_rsp_valid) //|> o
  ,.mcif2sdp_b_rd_rsp_ready (cvif2sdp_b_rd_rsp_ready) //|< i
  ,.mcif2sdp_b_rd_rsp_pd (cvif2sdp_b_rd_rsp_pd ) //|> o
  ,.sdp_e2mcif_rd_cdt_lat_fifo_pop (sdp_e2cvif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp_e2mcif_rd_req_valid (sdp_e2cvif_rd_req_valid) //|< i
  ,.sdp_e2mcif_rd_req_ready (sdp_e2cvif_rd_req_ready) //|> o
  ,.sdp_e2mcif_rd_req_pd (sdp_e2cvif_rd_req_pd ) //|< i
  ,.mcif2sdp_e_rd_rsp_valid (cvif2sdp_e_rd_rsp_valid) //|> o
  ,.mcif2sdp_e_rd_rsp_ready (cvif2sdp_e_rd_rsp_ready) //|< i
  ,.mcif2sdp_e_rd_rsp_pd (cvif2sdp_e_rd_rsp_pd ) //|> o
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2cvif_rd_cdt_lat_fifo_pop) //|< i
  ,.sdp_n2mcif_rd_req_valid (sdp_n2cvif_rd_req_valid) //|< i
  ,.sdp_n2mcif_rd_req_ready (sdp_n2cvif_rd_req_ready) //|> o
  ,.sdp_n2mcif_rd_req_pd (sdp_n2cvif_rd_req_pd ) //|< i
  ,.mcif2sdp_n_rd_rsp_valid (cvif2sdp_n_rd_rsp_valid) //|> o
  ,.mcif2sdp_n_rd_rsp_ready (cvif2sdp_n_rd_rsp_ready) //|< i
  ,.mcif2sdp_n_rd_rsp_pd (cvif2sdp_n_rd_rsp_pd ) //|> o
  ,.bdma2mcif_rd_cdt_lat_fifo_pop (bdma2cvif_rd_cdt_lat_fifo_pop) //|< w
  ,.bdma2mcif_rd_req_valid (bdma2cvif_rd_req_valid) //|< w
  ,.bdma2mcif_rd_req_ready (bdma2cvif_rd_req_ready) //|> w
  ,.bdma2mcif_rd_req_pd (bdma2cvif_rd_req_pd) //|< w
  ,.bdma2mcif_wr_req_valid (bdma2cvif_wr_req_valid) //|< w
  ,.bdma2mcif_wr_req_ready (bdma2cvif_wr_req_ready) //|> w
  ,.bdma2mcif_wr_req_pd (bdma2cvif_wr_req_pd ) //|< w
  ,.mcif2bdma_rd_rsp_valid (cvif2bdma_rd_rsp_valid) //|> w
  ,.mcif2bdma_rd_rsp_ready (cvif2bdma_rd_rsp_ready) //|< w
  ,.mcif2bdma_rd_rsp_pd (cvif2bdma_rd_rsp_pd ) //|> w
  ,.mcif2bdma_wr_rsp_complete (cvif2bdma_wr_rsp_complete) //|> w
  ,.mcif2noc_axi_ar_arvalid (cvif2noc_axi_ar_arvalid) //|> o
  ,.mcif2noc_axi_ar_arready (cvif2noc_axi_ar_arready) //|< i
  ,.mcif2noc_axi_ar_arid (cvif2noc_axi_ar_arid[7:0]) //|> o
  ,.mcif2noc_axi_ar_arlen (cvif2noc_axi_ar_arlen[3:0]) //|> o
  ,.mcif2noc_axi_ar_araddr (cvif2noc_axi_ar_araddr ) //|> o
  ,.noc2mcif_axi_r_rvalid (noc2cvif_axi_r_rvalid) //|< i
  ,.noc2mcif_axi_r_rready (noc2cvif_axi_r_rready) //|> o
  ,.noc2mcif_axi_r_rid (noc2cvif_axi_r_rid[7:0]) //|< i
  ,.noc2mcif_axi_r_rlast (noc2cvif_axi_r_rlast) //|< i
  ,.noc2mcif_axi_r_rdata (noc2cvif_axi_r_rdata ) //|< i
  ,.mcif2noc_axi_aw_awvalid (cvif2noc_axi_aw_awvalid) //|> o
  ,.mcif2noc_axi_aw_awready (cvif2noc_axi_aw_awready) //|< i
  ,.mcif2noc_axi_aw_awid (cvif2noc_axi_aw_awid[7:0]) //|> o
  ,.mcif2noc_axi_aw_awlen (cvif2noc_axi_aw_awlen[3:0]) //|> o
  ,.mcif2noc_axi_aw_awaddr (cvif2noc_axi_aw_awaddr ) //|> o
  ,.mcif2noc_axi_w_wvalid (cvif2noc_axi_w_wvalid) //|> o
  ,.mcif2noc_axi_w_wready (cvif2noc_axi_w_wready) //|< i
  ,.mcif2noc_axi_w_wdata (cvif2noc_axi_w_wdata ) //|> o
  ,.mcif2noc_axi_w_wstrb (cvif2noc_axi_w_wstrb ) //|> o
  ,.mcif2noc_axi_w_wlast (cvif2noc_axi_w_wlast) //|> o
  ,.noc2mcif_axi_b_bvalid (noc2cvif_axi_b_bvalid) //|< i
  ,.noc2mcif_axi_b_bready (noc2cvif_axi_b_bready) //|> o
  ,.noc2mcif_axi_b_bid (noc2cvif_axi_b_bid[7:0]) //|< i
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: Bridge DMA //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_bdma u_NV_NVDLA_bdma (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< o
  ,.bdma2csb_resp_valid (bdma2csb_resp_valid) //|> w
  ,.bdma2csb_resp_pd (bdma2csb_resp_pd[33:0]) //|> w
  ,.bdma2cvif_rd_cdt_lat_fifo_pop (bdma2cvif_rd_cdt_lat_fifo_pop) //|> w
  ,.bdma2cvif_rd_req_valid (bdma2cvif_rd_req_valid) //|> w
  ,.bdma2cvif_rd_req_ready (bdma2cvif_rd_req_ready) //|< w
  ,.bdma2cvif_rd_req_pd (bdma2cvif_rd_req_pd ) //|> w
  ,.bdma2cvif_wr_req_valid (bdma2cvif_wr_req_valid) //|> w
  ,.bdma2cvif_wr_req_ready (bdma2cvif_wr_req_ready) //|< w
  ,.bdma2cvif_wr_req_pd (bdma2cvif_wr_req_pd ) //|> w
  ,.bdma2glb_done_intr_pd (bdma2glb_done_intr_pd[1:0]) //|> w
  ,.bdma2mcif_rd_cdt_lat_fifo_pop (bdma2mcif_rd_cdt_lat_fifo_pop) //|> w
  ,.bdma2mcif_rd_req_valid (bdma2mcif_rd_req_valid) //|> w
  ,.bdma2mcif_rd_req_ready (bdma2mcif_rd_req_ready) //|< w
  ,.bdma2mcif_rd_req_pd (bdma2mcif_rd_req_pd ) //|> w
  ,.bdma2mcif_wr_req_valid (bdma2mcif_wr_req_valid) //|> w
  ,.bdma2mcif_wr_req_ready (bdma2mcif_wr_req_ready) //|< w
  ,.bdma2mcif_wr_req_pd (bdma2mcif_wr_req_pd ) //|> w
  ,.csb2bdma_req_pvld (csb2bdma_req_pvld) //|< w
  ,.csb2bdma_req_prdy (csb2bdma_req_prdy) //|> w
  ,.csb2bdma_req_pd (csb2bdma_req_pd[62:0]) //|< w
  ,.cvif2bdma_rd_rsp_valid (cvif2bdma_rd_rsp_valid) //|< w
  ,.cvif2bdma_rd_rsp_ready (cvif2bdma_rd_rsp_ready) //|> w
  ,.cvif2bdma_rd_rsp_pd (cvif2bdma_rd_rsp_pd ) //|< w
  ,.cvif2bdma_wr_rsp_complete (cvif2bdma_wr_rsp_complete) //|< w
  ,.mcif2bdma_rd_rsp_valid (mcif2bdma_rd_rsp_valid) //|< w
  ,.mcif2bdma_rd_rsp_ready (mcif2bdma_rd_rsp_ready) //|> w
  ,.mcif2bdma_rd_rsp_pd (mcif2bdma_rd_rsp_pd ) //|< w
  ,.mcif2bdma_wr_rsp_complete (mcif2bdma_wr_rsp_complete) //|< w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< w
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< w
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: Rubik engine //
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: Cross-Channel Data Processor //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_cdp u_NV_NVDLA_cdp (
   .dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< w
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< w
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< o
  ,.cdp2csb_resp_valid (cdp2csb_resp_valid) //|> w
  ,.cdp2csb_resp_pd (cdp2csb_resp_pd[33:0]) //|> w
  ,.cdp2cvif_rd_cdt_lat_fifo_pop (cdp2cvif_rd_cdt_lat_fifo_pop) //|> w
  ,.cdp2cvif_rd_req_valid (cdp2cvif_rd_req_valid) //|> w
  ,.cdp2cvif_rd_req_ready (cdp2cvif_rd_req_ready) //|< w
  ,.cdp2cvif_rd_req_pd (cdp2cvif_rd_req_pd ) //|> w
  ,.cdp2cvif_wr_req_valid (cdp2cvif_wr_req_valid) //|> w
  ,.cdp2cvif_wr_req_ready (cdp2cvif_wr_req_ready) //|< w
  ,.cdp2cvif_wr_req_pd (cdp2cvif_wr_req_pd ) //|> w
  ,.cdp2glb_done_intr_pd (cdp2glb_done_intr_pd[1:0]) //|> w
  ,.cdp2mcif_rd_cdt_lat_fifo_pop (cdp2mcif_rd_cdt_lat_fifo_pop) //|> w
  ,.cdp2mcif_rd_req_valid (cdp2mcif_rd_req_valid) //|> w
  ,.cdp2mcif_rd_req_ready (cdp2mcif_rd_req_ready) //|< w
  ,.cdp2mcif_rd_req_pd (cdp2mcif_rd_req_pd ) //|> w
  ,.cdp2mcif_wr_req_valid (cdp2mcif_wr_req_valid) //|> w
  ,.cdp2mcif_wr_req_ready (cdp2mcif_wr_req_ready) //|< w
  ,.cdp2mcif_wr_req_pd (cdp2mcif_wr_req_pd ) //|> w
  ,.cdp_rdma2csb_resp_valid (cdp_rdma2csb_resp_valid) //|> w
  ,.cdp_rdma2csb_resp_pd (cdp_rdma2csb_resp_pd[33:0]) //|> w
  ,.csb2cdp_rdma_req_pvld (csb2cdp_rdma_req_pvld) //|< w
  ,.csb2cdp_rdma_req_prdy (csb2cdp_rdma_req_prdy) //|> w
  ,.csb2cdp_rdma_req_pd (csb2cdp_rdma_req_pd[62:0]) //|< w
  ,.csb2cdp_req_pvld (csb2cdp_req_pvld) //|< w
  ,.csb2cdp_req_prdy (csb2cdp_req_prdy) //|> w
  ,.csb2cdp_req_pd (csb2cdp_req_pd[62:0]) //|< w
  ,.cvif2cdp_rd_rsp_valid (cvif2cdp_rd_rsp_valid) //|< w
  ,.cvif2cdp_rd_rsp_ready (cvif2cdp_rd_rsp_ready) //|> w
  ,.cvif2cdp_rd_rsp_pd (cvif2cdp_rd_rsp_pd ) //|< w
  ,.cvif2cdp_wr_rsp_complete (cvif2cdp_wr_rsp_complete) //|< w
  ,.mcif2cdp_rd_rsp_valid (mcif2cdp_rd_rsp_valid) //|< w
  ,.mcif2cdp_rd_rsp_ready (mcif2cdp_rd_rsp_ready) //|> w
  ,.mcif2cdp_rd_rsp_pd (mcif2cdp_rd_rsp_pd ) //|< w
  ,.mcif2cdp_wr_rsp_complete (mcif2cdp_wr_rsp_complete) //|< w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: Planar Data Processor //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_pdp u_NV_NVDLA_pdp (
   .dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< w
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< w
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< o
  ,.csb2pdp_rdma_req_pvld (csb2pdp_rdma_req_pvld) //|< w
  ,.csb2pdp_rdma_req_prdy (csb2pdp_rdma_req_prdy) //|> w
  ,.csb2pdp_rdma_req_pd (csb2pdp_rdma_req_pd[62:0]) //|< w
  ,.csb2pdp_req_pvld (csb2pdp_req_pvld) //|< w
  ,.csb2pdp_req_prdy (csb2pdp_req_prdy) //|> w
  ,.csb2pdp_req_pd (csb2pdp_req_pd[62:0]) //|< w
  ,.cvif2pdp_rd_rsp_valid (cvif2pdp_rd_rsp_valid) //|< w
  ,.cvif2pdp_rd_rsp_ready (cvif2pdp_rd_rsp_ready) //|> w
  ,.cvif2pdp_rd_rsp_pd (cvif2pdp_rd_rsp_pd ) //|< w
  ,.cvif2pdp_wr_rsp_complete (cvif2pdp_wr_rsp_complete) //|< w
  ,.mcif2pdp_rd_rsp_valid (mcif2pdp_rd_rsp_valid) //|< w
  ,.mcif2pdp_rd_rsp_ready (mcif2pdp_rd_rsp_ready) //|> w
  ,.mcif2pdp_rd_rsp_pd (mcif2pdp_rd_rsp_pd ) //|< w
  ,.mcif2pdp_wr_rsp_complete (mcif2pdp_wr_rsp_complete) //|< w
  ,.pdp2csb_resp_valid (pdp2csb_resp_valid) //|> w
  ,.pdp2csb_resp_pd (pdp2csb_resp_pd[33:0]) //|> w
  ,.pdp2cvif_rd_cdt_lat_fifo_pop (pdp2cvif_rd_cdt_lat_fifo_pop) //|> w
  ,.pdp2cvif_rd_req_valid (pdp2cvif_rd_req_valid) //|> w
  ,.pdp2cvif_rd_req_ready (pdp2cvif_rd_req_ready) //|< w
  ,.pdp2cvif_rd_req_pd (pdp2cvif_rd_req_pd ) //|> w
  ,.pdp2cvif_wr_req_valid (pdp2cvif_wr_req_valid) //|> w
  ,.pdp2cvif_wr_req_ready (pdp2cvif_wr_req_ready) //|< w
  ,.pdp2cvif_wr_req_pd (pdp2cvif_wr_req_pd ) //|> w
  ,.pdp2glb_done_intr_pd (pdp2glb_done_intr_pd[1:0]) //|> w
  ,.pdp2mcif_rd_cdt_lat_fifo_pop (pdp2mcif_rd_cdt_lat_fifo_pop) //|> w
  ,.pdp2mcif_rd_req_valid (pdp2mcif_rd_req_valid) //|> w
  ,.pdp2mcif_rd_req_ready (pdp2mcif_rd_req_ready) //|< w
  ,.pdp2mcif_rd_req_pd (pdp2mcif_rd_req_pd ) //|> w
  ,.pdp2mcif_wr_req_valid (pdp2mcif_wr_req_valid) //|> w
  ,.pdp2mcif_wr_req_ready (pdp2mcif_wr_req_ready) //|< w
  ,.pdp2mcif_wr_req_pd (pdp2mcif_wr_req_pd ) //|> w
  ,.pdp_rdma2csb_resp_valid (pdp_rdma2csb_resp_valid) //|> w
  ,.pdp_rdma2csb_resp_pd (pdp_rdma2csb_resp_pd[33:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.sdp2pdp_valid (sdp2pdp_valid) //|< i
  ,.sdp2pdp_ready (sdp2pdp_ready) //|> o
  ,.sdp2pdp_pd (sdp2pdp_pd ) //|< i
  );
////////////////////////////////////////////////////////////////////////
// NVDLA Partition O: Global Unit //
////////////////////////////////////////////////////////////////////////
NV_NVDLA_glb u_NV_NVDLA_glb (
   .csb2glb_req_pvld (csb2glb_req_pvld) //|< w
  ,.csb2glb_req_prdy (csb2glb_req_prdy) //|> w
  ,.csb2glb_req_pd (csb2glb_req_pd[62:0]) //|< w
  ,.glb2csb_resp_valid (glb2csb_resp_valid) //|> w
  ,.glb2csb_resp_pd (glb2csb_resp_pd[33:0]) //|> w
  ,.core_intr (core_intr) //|> o
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd[1:0]) //|< i
  ,.cdp2glb_done_intr_pd (cdp2glb_done_intr_pd[1:0]) //|< w
  ,.pdp2glb_done_intr_pd (pdp2glb_done_intr_pd[1:0]) //|< w
  ,.bdma2glb_done_intr_pd (bdma2glb_done_intr_pd[1:0]) //|< w
  ,.cdma_wt2glb_done_intr_pd (cdma_wt2glb_done_intr_pd[1:0]) //|< i
  ,.cdma_dat2glb_done_intr_pd (cdma_dat2glb_done_intr_pd[1:0]) //|< i
  ,.cacc2glb_done_intr_pd (cacc2glb_done_intr_pd[1:0]) //|< i
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_falcon_clk (nvdla_falcon_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< o
  ,.nvdla_falcon_rstn (nvdla_falcon_rstn) //|< w
  ,.test_mode (test_mode) //|< i
  ,.direct_reset_ (direct_reset_) //|< i
  ,.csb2nvdla_write(csb2nvdla_write)
  ,.cdma_wt_done_status0 (cdma_wt_done_status0 )
  ,.cdma_wt_done_status1 (cdma_wt_done_status1 )
  ,.cdma_dat_done_status0(cdma_dat_done_status0)
  ,.cdma_dat_done_status1(cdma_dat_done_status1)
  ,.cacc_done_status0    (cacc_done_status0    )
  ,.cacc_done_status1    (cacc_done_status1    )
  ,.sdp_done_status0     (sdp_done_status0     )
  ,.sdp_done_status1     (sdp_done_status1     )
  ,.pdp_done_status0     (pdp_done_status0     )
  ,.pdp_done_status1     (pdp_done_status1     )
  ,.cdp_done_status0     (cdp_done_status0     )
  ,.cdp_done_status1     (cdp_done_status1     )
  ,.bdma_done_status0    (bdma_done_status0    )
  ,.bdma_done_status1    (bdma_done_status1    )
  ,.cdma_op_en			 (cdma_op_en)
  );
////////////////////////////////////////////////////////////////////////
// Dangles/Contenders report //
////////////////////////////////////////////////////////////////////////
//done counter
////////////////////////////////////////////////////////////////////////
//reg [1:0] cdma_dat2glb_done_intr_pd_d1;
//reg [1:0] cdma_wt2glb_done_intr_pd_d1;
//reg [1:0] cacc2glb_done_intr_pd_d1;
//reg [1:0] sdp2glb_done_intr_pd_d1;
//reg [1:0] bdma2glb_done_intr_pd_d1;
//reg [1:0] cdp2glb_done_intr_pd_d1;
//reg [1:0] pdp2glb_done_intr_pd_d1;
//
//
//always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
//    if(!nvdla_Core_rstn) begin
//        cdma_dat2glb_done_intr_pd_d1 <= 2'd0;
//        cdma_wt2glb_done_intr_pd_d1  <= 2'd0;
//        cacc2glb_done_intr_pd_d1     <= 2'd0;
//        sdp2glb_done_intr_pd_d1      <= 2'd0;
//        bdma2glb_done_intr_pd_d1     <= 2'd0;
//        cdp2glb_done_intr_pd_d1      <= 2'd0;
//        pdp2glb_done_intr_pd_d1      <= 2'd0;
//    end
//    else begin
//        cdma_dat2glb_done_intr_pd_d1 <= cdma_dat2glb_done_intr_pd;
//        cdma_wt2glb_done_intr_pd_d1  <= cdma_wt2glb_done_intr_pd ;
//        cacc2glb_done_intr_pd_d1     <= cacc2glb_done_intr_pd    ;
//        sdp2glb_done_intr_pd_d1      <= sdp2glb_done_intr_pd     ;
//        bdma2glb_done_intr_pd_d1     <= bdma2glb_done_intr_pd    ;
//        cdp2glb_done_intr_pd_d1      <= cdp2glb_done_intr_pd     ;
//        pdp2glb_done_intr_pd_d1      <= pdp2glb_done_intr_pd     ;
//    end
//end


reg cdma_wt_done_status0_d1 ;
reg cdma_wt_done_status1_d1 ;
reg cdma_dat_done_status0_d1;
reg cdma_dat_done_status1_d1;
reg cacc_done_status0_d1    ;
reg cacc_done_status1_d1    ;
reg sdp_done_status0_d1     ;
reg sdp_done_status1_d1     ;
reg pdp_done_status0_d1     ;
reg pdp_done_status1_d1     ;
reg cdp_done_status0_d1     ;
reg cdp_done_status1_d1     ;
reg bdma_done_status0_d1    ;
reg bdma_done_status1_d1    ;

reg [31:0] cdma_wt_done_0_counter ;
reg [31:0] cdma_wt_done_1_counter ;
reg [31:0] cdma_dat_done_0_counter;
reg [31:0] cdma_dat_done_1_counter;
reg [31:0] cacc_done_0_counter    ;
reg [31:0] cacc_done_1_counter    ;
reg [31:0] sdp_done_0_counter     ;
reg [31:0] sdp_done_1_counter     ;
reg [31:0] pdp_done_0_counter     ;
reg [31:0] pdp_done_1_counter     ;
reg [31:0] cdp_done_0_counter     ;
reg [31:0] cdp_done_1_counter     ;
reg [31:0] bdma_done_0_counter    ;
reg [31:0] bdma_done_1_counter    ;

wire cdma_wt_done_0 ;
wire cdma_wt_done_1 ;
wire cdma_dat_done_0;
wire cdma_dat_done_1;
wire cacc_done_0    ;
wire cacc_done_1    ;
wire sdp_done_0     ;
wire sdp_done_1     ;
wire pdp_done_0     ;
wire pdp_done_1     ;
wire cdp_done_0     ;
wire cdp_done_1     ;
wire bdma_done_0    ;
wire bdma_done_1    ;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cdma_wt_done_status0_d1  <= 1'b0;
        cdma_wt_done_status1_d1  <= 1'b0;
        cdma_dat_done_status0_d1 <= 1'b0;
        cdma_dat_done_status1_d1 <= 1'b0;
        cacc_done_status0_d1     <= 1'b0;
        cacc_done_status1_d1     <= 1'b0;
        sdp_done_status0_d1      <= 1'b0;
        sdp_done_status1_d1      <= 1'b0;
        pdp_done_status0_d1      <= 1'b0;
        pdp_done_status1_d1      <= 1'b0;
        cdp_done_status0_d1      <= 1'b0;
        cdp_done_status1_d1      <= 1'b0;
        bdma_done_status0_d1     <= 1'b0;
        bdma_done_status1_d1     <= 1'b0;
    end
    else begin
        cdma_wt_done_status0_d1  <= cdma_wt_done_status0 ;
        cdma_wt_done_status1_d1  <= cdma_wt_done_status1 ;
        cdma_dat_done_status0_d1 <= cdma_dat_done_status0;
        cdma_dat_done_status1_d1 <= cdma_dat_done_status1;
        cacc_done_status0_d1     <= cacc_done_status0    ;
        cacc_done_status1_d1     <= cacc_done_status1    ;
        sdp_done_status0_d1      <= sdp_done_status0     ;
        sdp_done_status1_d1      <= sdp_done_status1     ;
        pdp_done_status0_d1      <= pdp_done_status0     ;
        pdp_done_status1_d1      <= pdp_done_status1     ;
        cdp_done_status0_d1      <= cdp_done_status0     ;
        cdp_done_status1_d1      <= cdp_done_status1     ;
        bdma_done_status0_d1     <= bdma_done_status0    ;
        bdma_done_status1_d1     <= bdma_done_status1    ;
    end
end

assign cdma_wt_done_0  = (~cdma_wt_done_status0_d1 ) & cdma_wt_done_status0 ;
assign cdma_wt_done_1  = (~cdma_wt_done_status1_d1 ) & cdma_wt_done_status1 ;
assign cdma_dat_done_0 = (~cdma_dat_done_status0_d1) & cdma_dat_done_status0;
assign cdma_dat_done_1 = (~cdma_dat_done_status1_d1) & cdma_dat_done_status1;
assign cacc_done_0     = (~cacc_done_status0_d1    ) & cacc_done_status0    ;
assign cacc_done_1     = (~cacc_done_status1_d1    ) & cacc_done_status1    ;
assign sdp_done_0      = (~sdp_done_status0_d1     ) & sdp_done_status0     ;
assign sdp_done_1      = (~sdp_done_status1_d1     ) & sdp_done_status1     ;
assign pdp_done_0      = (~pdp_done_status0_d1     ) & pdp_done_status0     ;
assign pdp_done_1      = (~pdp_done_status1_d1     ) & pdp_done_status1     ;
assign cdp_done_0      = (~cdp_done_status0_d1     ) & cdp_done_status0     ;
assign cdp_done_1      = (~cdp_done_status1_d1     ) & cdp_done_status1     ;
assign bdma_done_0     = (~bdma_done_status0_d1    ) & bdma_done_status0    ;
assign bdma_done_1     = (~bdma_done_status1_d1    ) & bdma_done_status1    ;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cdma_wt_done_0_counter <= 32'd0;
    end
    else if(cdma_wt_done_0) begin
        cdma_wt_done_0_counter <= cdma_wt_done_0_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cdma_wt_done_1_counter <= 32'd0;
    end
    else if(cdma_wt_done_1) begin
        cdma_wt_done_1_counter <= cdma_wt_done_1_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cdma_dat_done_0_counter <= 32'd0;
    end
    else if(cdma_dat_done_0) begin
        cdma_dat_done_0_counter <= cdma_dat_done_0_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cdma_dat_done_1_counter <= 32'd0;
    end
    else if(cdma_dat_done_1) begin
        cdma_dat_done_1_counter <= cdma_dat_done_1_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cacc_done_0_counter <= 32'd0;
    end
    else if(cacc_done_0) begin
        cacc_done_0_counter <= cacc_done_0_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cacc_done_1_counter <= 32'd0;
    end
    else if(cacc_done_1) begin
        cacc_done_1_counter <= cacc_done_1_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        sdp_done_0_counter <= 32'd0;
    end
    else if(sdp_done_0) begin
        sdp_done_0_counter <= sdp_done_0_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        sdp_done_1_counter <= 32'd0;
    end
    else if(sdp_done_1) begin
        sdp_done_1_counter <= sdp_done_1_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        pdp_done_0_counter <= 32'd0;
    end
    else if(pdp_done_0) begin
        pdp_done_0_counter <= pdp_done_0_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        pdp_done_1_counter <= 32'd0;
    end
    else if(pdp_done_1) begin
        pdp_done_1_counter <= pdp_done_1_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cdp_done_0_counter <= 32'd0;
    end
    else if(cdp_done_0) begin
        cdp_done_0_counter <= cdp_done_0_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        cdp_done_1_counter <= 32'd0;
    end
    else if(cdp_done_1) begin
        cdp_done_1_counter <= cdp_done_1_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        bdma_done_0_counter <= 32'd0;
    end
    else if(bdma_done_0) begin
        bdma_done_0_counter <= bdma_done_0_counter + 1'b1;
    end
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if(!nvdla_core_rstn) begin
        bdma_done_1_counter <= 32'd0;
    end
    else if(bdma_done_1) begin
        bdma_done_1_counter <= bdma_done_1_counter + 1'b1;
    end
end
////////////////////////////////////////////////////////////////////////
endmodule // NV_NVDLA_partition_o
