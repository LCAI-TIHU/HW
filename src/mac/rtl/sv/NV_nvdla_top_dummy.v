// ================================================================
// NVDLA Open Source Project
// ================================================================
// File Name: NV_nvdla.v
// ================================================================
//
module NV_nvdla_top (
    dla_core_clk,
    dla_csb_clk,
    dla_reset_rstn,
    nvdla_core2dbb_aw_awid,
    nvdla_core2dbb_aw_awaddr,
    nvdla_core2dbb_aw_awlen,
    nvdla_core2dbb_aw_awsize,
    nvdla_core2dbb_aw_awburst,
    nvdla_core2dbb_aw_awlock,
    nvdla_core2dbb_aw_awcache,
    nvdla_core2dbb_aw_awprot,
    nvdla_core2dbb_aw_awqos,
    nvdla_core2dbb_aw_awregion,
    nvdla_core2dbb_aw_awuser,
    nvdla_core2dbb_aw_awvalid,
    nvdla_core2dbb_aw_awready,
    nvdla_core2dbb_w_wid,
    nvdla_core2dbb_w_wdata,
    nvdla_core2dbb_w_wstrb,
    nvdla_core2dbb_w_wlast,
    nvdla_core2dbb_w_wuser,
    nvdla_core2dbb_w_wvalid,
    nvdla_core2dbb_w_wready,
    nvdla_core2dbb_b_bid,
    nvdla_core2dbb_b_bresp,
    nvdla_core2dbb_b_buser,
    nvdla_core2dbb_b_bvalid,
    nvdla_core2dbb_b_bready,
    nvdla_core2dbb_ar_arid,
    nvdla_core2dbb_ar_araddr,
    nvdla_core2dbb_ar_arlen,
    nvdla_core2dbb_ar_arsize,
    nvdla_core2dbb_ar_arburst,
    nvdla_core2dbb_ar_arlock,
    nvdla_core2dbb_ar_arcache,
    nvdla_core2dbb_ar_arprot,
    nvdla_core2dbb_ar_arqos,
    nvdla_core2dbb_ar_arregion,
    nvdla_core2dbb_ar_aruser,
    nvdla_core2dbb_ar_arvalid,
    nvdla_core2dbb_ar_arready,
    nvdla_core2dbb_r_rid,
    nvdla_core2dbb_r_rdata,
    nvdla_core2dbb_r_rresp,
    nvdla_core2dbb_r_rlast,
    nvdla_core2dbb_r_ruser,
    nvdla_core2dbb_r_rvalid,
    nvdla_core2dbb_r_rready,
    nvdla_core2cvsram_aw_awid,
    nvdla_core2cvsram_aw_awaddr,
    nvdla_core2cvsram_aw_awlen,
    nvdla_core2cvsram_aw_awsize,
    nvdla_core2cvsram_aw_awburst,
    nvdla_core2cvsram_aw_awlock,
    nvdla_core2cvsram_aw_awcache,
    nvdla_core2cvsram_aw_awprot,
    nvdla_core2cvsram_aw_awqos,
    nvdla_core2cvsram_aw_awregion,
    nvdla_core2cvsram_aw_awuser,
    nvdla_core2cvsram_aw_awvalid,
    nvdla_core2cvsram_aw_awready,
    nvdla_core2cvsram_w_wid,
    nvdla_core2cvsram_w_wdata,
    nvdla_core2cvsram_w_wstrb,
    nvdla_core2cvsram_w_wlast,
    nvdla_core2cvsram_w_wuser,
    nvdla_core2cvsram_w_wvalid,
    nvdla_core2cvsram_w_wready,
    nvdla_core2cvsram_b_bid,
    nvdla_core2cvsram_b_bresp,
    nvdla_core2cvsram_b_buser,
    nvdla_core2cvsram_b_bvalid,
    nvdla_core2cvsram_b_bready,
    nvdla_core2cvsram_ar_arid,
    nvdla_core2cvsram_ar_araddr,
    nvdla_core2cvsram_ar_arlen,
    nvdla_core2cvsram_ar_arsize,
    nvdla_core2cvsram_ar_arburst,
    nvdla_core2cvsram_ar_arlock,
    nvdla_core2cvsram_ar_arcache,
    nvdla_core2cvsram_ar_arprot,
    nvdla_core2cvsram_ar_arqos,
    nvdla_core2cvsram_ar_arregion,
    nvdla_core2cvsram_ar_aruser,
    nvdla_core2cvsram_ar_arvalid,
    nvdla_core2cvsram_ar_arready,
    nvdla_core2cvsram_r_rid,
    nvdla_core2cvsram_r_rdata,
    nvdla_core2cvsram_r_rresp,
    nvdla_core2cvsram_r_rlast,
    nvdla_core2cvsram_r_ruser,
    nvdla_core2cvsram_r_rvalid,
    nvdla_core2cvsram_r_rready,
    nvdla_intr,
    psel,
    penable,
    pwrite,
    pprot,
    paddr,
    pwdata,
    pstrb,
    prdata,
    pready,
    pslverr
    //cdma_wt_done_status0,
    //cdma_wt_done_status1,
    //cdma_dat_done_status0,
    //cdma_dat_done_status1,
    //cacc_done_status0,
    //cacc_done_status1,
    //sdp_done_status0,
    //sdp_done_status1,
    //pdp_done_status0,
    //pdp_done_status1,
    //cdp_done_status0,
    //cdp_done_status1,
    //bdma_done_status0,
    //bdma_done_status1,
    //cdma_wt_done_0_counter,
    //cdma_wt_done_1_counter,
    //cdma_dat_done_0_counter,
    //cdma_dat_done_1_counter,
    //cacc_done_0_counter,
    //cacc_done_1_counter,
    //sdp_done_0_counter,
    //sdp_done_1_counter,
    //pdp_done_0_counter,
    //pdp_done_1_counter,
    //cdp_done_0_counter,
    //cdp_done_1_counter,
    //bdma_done_0_counter,
    //bdma_done_1_counter,
    //cdma_img_status,
    //cdma_dc_status,
    //cdma_wt_status,
    //upper_limit_w,
    //lower_limit_w,
    //sc2mac_wt_a_pvld,
    //sc2mac_wt_a_sel,
    //sc2mac_wt_a_mask,
    //sc2mac_wt_a_data0,
    //sc2mac_dat_a_pvld,
    //sc2mac_dat_a_mask,
    //sc2mac_dat_a_data0,
    //mac_a2accu_pvld,
    //mac_a2accu_mask,
    //mac_a2accu_data0,
    //sc2mac_wt_b_pvld,
    //sc2mac_wt_b_sel,
    //sc2mac_wt_b_mask,
    //sc2mac_wt_b_data0,
    //sc2mac_dat_b_pvld,
    //sc2mac_dat_b_mask,
    //sc2mac_dat_b_data0,
    //mac_b2accu_pvld,
    //mac_b2accu_mask,
    //mac_b2accu_data0,
    //cacc2sdp_valid,
    //cacc2sdp_ready,
    //cacc2sdp_pd,
    //cacc2sdp_adpt_valid,
    //cacc2sdp_adpt_ready,
    //cacc2sdp_adpt_pd,
    //sdp_dp2wdma_valid,
    //sdp_dp2wdma_ready,
    //sdp_dp2wdma_pd,
    //sdp2pdp_valid,
    //sdp2pdp_ready,
    //sdp2pdp_pd
  );

//input & output ports declaration
////////////////////////////////////////////////////////////////////////
//sys signals
input              dla_core_clk;
input              dla_csb_clk;
input              dla_reset_rstn;

//DBBIF
/*********************************************************************/
//AXI4-AW channel
//output [7:0]       nvdla_core2dbb_aw_awid;
output [3:0]       nvdla_core2dbb_aw_awid;
output [64 -1:0]   nvdla_core2dbb_aw_awaddr;
//output [3:0]       nvdla_core2dbb_aw_awlen;
output [7:0]       nvdla_core2dbb_aw_awlen;
output [2:0]       nvdla_core2dbb_aw_awsize;//new added
output [1:0]       nvdla_core2dbb_aw_awburst;//new added
output             nvdla_core2dbb_aw_awlock;//new added
output [3:0]       nvdla_core2dbb_aw_awcache;//new added
output [2:0]       nvdla_core2dbb_aw_awprot;//new added
output [3:0]       nvdla_core2dbb_aw_awqos;//new added
output [3:0]       nvdla_core2dbb_aw_awregion;//new added
output [31:0]      nvdla_core2dbb_aw_awuser;//new added, not sure about width
output             nvdla_core2dbb_aw_awvalid;
input              nvdla_core2dbb_aw_awready;

//AXI4-W channel
output [7:0]       nvdla_core2dbb_w_wid;
output [256-1:0]   nvdla_core2dbb_w_wdata;
output [256/8-1:0] nvdla_core2dbb_w_wstrb;
output             nvdla_core2dbb_w_wlast;
output [31:0]      nvdla_core2dbb_w_wuser;//new added, not sure about width
output             nvdla_core2dbb_w_wvalid;
input              nvdla_core2dbb_w_wready;

//AXI4-B channel
//input [7:0]        nvdla_core2dbb_b_bid;
input [5:0]        nvdla_core2dbb_b_bid;
input [1:0]        nvdla_core2dbb_b_bresp;//new added
input [31:0]       nvdla_core2dbb_b_buser;//new added, not sure about signal width
input              nvdla_core2dbb_b_bvalid;
output             nvdla_core2dbb_b_bready;

//AXI4-AR channel
//output [7:0]       nvdla_core2dbb_ar_arid;
output [3:0]       nvdla_core2dbb_ar_arid;
output [64 -1:0]   nvdla_core2dbb_ar_araddr;
//output [3:0]       nvdla_core2dbb_ar_arlen;
output [7:0]       nvdla_core2dbb_ar_arlen;
output [2:0]       nvdla_core2dbb_ar_arsize;//new added
output [1:0]       nvdla_core2dbb_ar_arburst;//new added
output             nvdla_core2dbb_ar_arlock;//new added
output [3:0]       nvdla_core2dbb_ar_arcache;//new added
output [2:0]       nvdla_core2dbb_ar_arprot;//new added
output [3:0]       nvdla_core2dbb_ar_arqos;//new added
output [3:0]       nvdla_core2dbb_ar_arregion;//new added
output [31:0]      nvdla_core2dbb_ar_aruser;//new added, not sure about signal width
output             nvdla_core2dbb_ar_arvalid;
input              nvdla_core2dbb_ar_arready;

//AXI4-R channel
//input  [7:0]       nvdla_core2dbb_r_rid;
input  [5:0]       nvdla_core2dbb_r_rid;
input  [256-1:0]   nvdla_core2dbb_r_rdata;
input  [1:0]       nvdla_core2dbb_r_rresp;//new added
input              nvdla_core2dbb_r_rlast;
input  [31:0]      nvdla_core2dbb_r_ruser;//new added, not sure sbout signal width
input              nvdla_core2dbb_r_rvalid;
output             nvdla_core2dbb_r_rready;
/*********************************************************************/

//SRAMIF
/*********************************************************************/
//AXI4-AW channel
//output [7:0]      nvdla_core2cvsram_aw_awid;
output [3:0]      nvdla_core2cvsram_aw_awid;
output [63:0]     nvdla_core2cvsram_aw_awaddr;
//output [3:0]      nvdla_core2cvsram_aw_awlen;
output [7:0]      nvdla_core2cvsram_aw_awlen;
output [2:0]      nvdla_core2cvsram_aw_awsize;//new added
output [1:0]      nvdla_core2cvsram_aw_awburst;//new added
output            nvdla_core2cvsram_aw_awlock;//new added
output [3:0]      nvdla_core2cvsram_aw_awcache;//new added
output [2:0]      nvdla_core2cvsram_aw_awprot;//new added
output [3:0]      nvdla_core2cvsram_aw_awqos;//new added
output [3:0]      nvdla_core2cvsram_aw_awregion;//new added
output [31:0]     nvdla_core2cvsram_aw_awuser;//new added, not sure about width
output            nvdla_core2cvsram_aw_awvalid; /* data valid */
input             nvdla_core2cvsram_aw_awready; /* data return handshake */

//AXI4-W channel
output [7:0]      nvdla_core2cvsram_w_wid;
output [255:0]    nvdla_core2cvsram_w_wdata;
output [31:0]     nvdla_core2cvsram_w_wstrb;
output            nvdla_core2cvsram_w_wlast;
output [31:0]     nvdla_core2cvsram_w_wuser;//new added, not sure about width
output            nvdla_core2cvsram_w_wvalid; /* data valid */
input             nvdla_core2cvsram_w_wready; /* data return handshake */

//AXI4-B channel
//input [7:0]       nvdla_core2cvsram_b_bid;
input [5:0]       nvdla_core2cvsram_b_bid;
input [1:0]       nvdla_core2cvsram_b_bresp;//new added
input [31:0]      nvdla_core2cvsram_b_buser;//new added, not sure about signal width
input             nvdla_core2cvsram_b_bvalid; /* data valid */
output            nvdla_core2cvsram_b_bready; /* data return handshake */

//AXI4-AR channel
//output [7:0]      nvdla_core2cvsram_ar_arid;
output [3:0]      nvdla_core2cvsram_ar_arid;
output [63:0]     nvdla_core2cvsram_ar_araddr;
//output [3:0]      nvdla_core2cvsram_ar_arlen;
output [7:0]      nvdla_core2cvsram_ar_arlen;
output [2:0]      nvdla_core2cvsram_ar_arsize;//new added
output [1:0]      nvdla_core2cvsram_ar_arburst;//new added
output            nvdla_core2cvsram_ar_arlock;//new added
output [3:0]      nvdla_core2cvsram_ar_arcache;//new added
output [2:0]      nvdla_core2cvsram_ar_arprot;//new added
output [3:0]      nvdla_core2cvsram_ar_arqos;//new added
output [3:0]      nvdla_core2cvsram_ar_arregion;//new added
output [31:0]     nvdla_core2cvsram_ar_aruser;//new added, not sure about signal width
output            nvdla_core2cvsram_ar_arvalid; /* data valid */
input             nvdla_core2cvsram_ar_arready; /* data return handshake */

//AXI4-R channel
//input  [7:0]      nvdla_core2cvsram_r_rid;
input  [5:0]      nvdla_core2cvsram_r_rid;
input  [255:0]    nvdla_core2cvsram_r_rdata;
input  [1:0]      nvdla_core2cvsram_r_rresp;//new added
input             nvdla_core2cvsram_r_rlast;
input  [31:0]     nvdla_core2cvsram_r_ruser;//new added, not sure sbout signal width
input             nvdla_core2cvsram_r_rvalid; /* data valid */
output            nvdla_core2cvsram_r_rready; /* data return handshake */
/*********************************************************************/

//NVDLA interrupt
output            nvdla_intr;

//power contrl signals, tied to 0 when connected to NVDLA
//input [31:0] nvdla_pwrbus_ram_c_pd;
//input [31:0] nvdla_pwrbus_ram_ma_pd;
//input [31:0] nvdla_pwrbus_ram_mb_pd;
//input [31:0] nvdla_pwrbus_ram_p_pd;
//input [31:0] nvdla_pwrbus_ram_o_pd;
//input [31:0] nvdla_pwrbus_ram_a_pd;

//APB interface, apb2csb integrated
//input             pclk;
//input             prstn;
input             psel;
input             penable;
input             pwrite;
input             pprot;
input  [31:0]     paddr;
input  [31:0]     pwdata;
input  [3:0]      pstrb;
output [31:0]     prdata;
output            pready;
output            pslverr;
////////////////////////////////////////////////////////////////////////
//
//for debug
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
//
//output assignment
////////////////////////////////////////////////////////////////////////








////////////////////////////////////////////////////////////////////////


assign  pready                           =1'b1;
assign  nvdla_core2dbb_b_bready          =1'b1;
assign  nvdla_core2dbb_r_rready          =1'b1;
assign  nvdla_core2cvsram_b_bready       =1'b1;
assign  nvdla_core2cvsram_r_rready       =1'b1;

assign nvdla_core2dbb_aw_awid           = 'd0 ;
assign nvdla_core2dbb_aw_awaddr         = 'd0 ;
assign nvdla_core2dbb_aw_awlen          = 'd0 ;
assign nvdla_core2dbb_aw_awsize         = 'd0 ;
assign nvdla_core2dbb_aw_awburst        = 'd0 ;
assign nvdla_core2dbb_aw_awlock         = 'd0 ;
assign nvdla_core2dbb_aw_awcache        = 'd0 ;
assign nvdla_core2dbb_aw_awprot         = 'd0 ;
assign nvdla_core2dbb_aw_awvalid        = 'd0 ;
assign nvdla_core2dbb_w_wdata           = 'd0 ;
assign nvdla_core2dbb_w_wstrb           = 'd0 ;
assign nvdla_core2dbb_w_wlast           = 'd0 ;
assign nvdla_core2dbb_w_wvalid          = 'd0 ;

assign nvdla_core2dbb_ar_arid           = 'd0 ;
assign nvdla_core2dbb_ar_araddr         = 'd0 ;
assign nvdla_core2dbb_ar_arlen          = 'd0 ;
assign nvdla_core2dbb_ar_arsize         = 'd0 ;
assign nvdla_core2dbb_ar_arburst        = 'd0 ;
assign nvdla_core2dbb_ar_arlock         = 'd0 ;
assign nvdla_core2dbb_ar_arcache        = 'd0 ;
assign nvdla_core2dbb_ar_arprot         = 'd0 ;
assign nvdla_core2dbb_ar_arvalid        = 'd0 ;

assign nvdla_core2cvsram_aw_awid        = 'd0 ;
assign nvdla_core2cvsram_aw_awaddr      = 'd0 ;
assign nvdla_core2cvsram_aw_awlen       = 'd0 ;
assign nvdla_core2cvsram_aw_awsize      = 'd0 ;
assign nvdla_core2cvsram_aw_awburst     = 'd0 ;
assign nvdla_core2cvsram_aw_awlock      = 'd0 ;
assign nvdla_core2cvsram_aw_awcache     = 'd0 ;
assign nvdla_core2cvsram_aw_awprot      = 'd0 ;
assign nvdla_core2cvsram_aw_awvalid     = 'd0 ;
assign nvdla_core2cvsram_w_wdata        = 'd0 ;
assign nvdla_core2cvsram_w_wstrb        = 'd0 ;
assign nvdla_core2cvsram_w_wlast        = 'd0 ;
assign nvdla_core2cvsram_w_wvalid       = 'd0 ;

assign nvdla_core2cvsram_ar_arid        = 'd0 ;
assign nvdla_core2cvsram_ar_araddr      = 'd0 ;
assign nvdla_core2cvsram_ar_arlen       = 'd0 ;
assign nvdla_core2cvsram_ar_arsize      = 'd0 ;
assign nvdla_core2cvsram_ar_arburst     = 'd0 ;
assign nvdla_core2cvsram_ar_arlock      = 'd0 ;
assign nvdla_core2cvsram_ar_arcache     = 'd0 ;
assign nvdla_core2cvsram_ar_arprot      = 'd0 ;
assign nvdla_core2cvsram_ar_arvalid     = 'd0 ;

assign nvdla_intr                       = 'd0 ;
assign prdata                           = 'd0 ;

assign pslverr                          = 'd0 ;

























//
endmodule // NV_nvdla_top
