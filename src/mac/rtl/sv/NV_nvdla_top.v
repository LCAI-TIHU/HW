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
wire                   cdma_wt_done_status0;
wire                   cdma_wt_done_status1;
wire                   cdma_dat_done_status0;
wire                   cdma_dat_done_status1;
wire                   cacc_done_status0;
wire                   cacc_done_status1;
wire                   sdp_done_status0;
wire                   sdp_done_status1;
wire                   pdp_done_status0;
wire                   pdp_done_status1;
wire                   cdp_done_status0;
wire                   cdp_done_status1;
wire                   bdma_done_status0;
wire                   bdma_done_status1;
wire [31:0]            cdma_wt_done_0_counter;
wire [31:0]            cdma_wt_done_1_counter;
wire [31:0]            cdma_dat_done_0_counter;
wire [31:0]            cdma_dat_done_1_counter;
wire [31:0]            cacc_done_0_counter;
wire [31:0]            cacc_done_1_counter;
wire [31:0]            sdp_done_0_counter;
wire [31:0]            sdp_done_1_counter;
wire [31:0]            pdp_done_0_counter;
wire [31:0]            pdp_done_1_counter;
wire [31:0]            cdp_done_0_counter;
wire [31:0]            cdp_done_1_counter;
wire [31:0]            bdma_done_0_counter;
wire [31:0]            bdma_done_1_counter;
wire [1:0]             cdma_img_status;
wire [1:0]             cdma_dc_status;
wire [1:0]             cdma_wt_status;
wire [6:0]             upper_limit_w;
wire [6:0]             lower_limit_w;

wire                   sc2mac_wt_a_pvld;
wire [32/2-1:0]        sc2mac_wt_a_sel;
wire [64 -1:0]         sc2mac_wt_a_mask;
wire [8 -1:0]          sc2mac_wt_a_data0;
wire                   sc2mac_dat_a_pvld;
wire [64 -1:0]         sc2mac_dat_a_mask;
wire [8 -1:0]          sc2mac_dat_a_data0;
wire                   mac_a2accu_pvld;
wire [32/2-1:0]        mac_a2accu_mask;
wire [22 -1:0]         mac_a2accu_data0;
wire                   sc2mac_wt_b_pvld;
wire [32/2-1:0]        sc2mac_wt_b_sel;
wire [64 -1:0]         sc2mac_wt_b_mask;
wire [8 -1:0]          sc2mac_wt_b_data0;
wire                   sc2mac_dat_b_pvld;
wire [64 -1:0]         sc2mac_dat_b_mask;
wire [8 -1:0]          sc2mac_dat_b_data0;
wire                   mac_b2accu_pvld;
wire [32/2-1:0]        mac_b2accu_mask;
wire [22 -1:0]         mac_b2accu_data0;

wire                   cacc2sdp_valid;
wire                   cacc2sdp_ready;
wire [32*16+2-1:0]     cacc2sdp_pd;
wire                   cacc2sdp_adpt_valid;
wire                   cacc2sdp_adpt_ready;
wire [32*16 +1:0]      cacc2sdp_adpt_pd;
wire                   sdp_dp2wdma_valid;
wire                   sdp_dp2wdma_ready;
wire [32*8 -1:0]       sdp_dp2wdma_pd;
wire                   sdp2pdp_valid;
wire                   sdp2pdp_ready;
wire [16*8 -1:0]       sdp2pdp_pd;
////////////////////////////////////////////////////////////////////////

//wire declarations
////////////////////////////////////////////////////////////////////////
wire           csb2nvdla_valid;
wire           csb2nvdla_ready;
wire [15:0]    csb2nvdla_addr;
wire [31:0]    csb2nvdla_wdat;
wire           csb2nvdla_write;
wire           csb2nvdla_nposted;
wire           nvdla2csb_valid;
wire [31:0]    nvdla2csb_data;
wire [7:0]     nvdla_core2dbb_aw_awid_t;
wire [3:0]     nvdla_core2dbb_aw_awlen_t;
wire [7:0]     nvdla_core2dbb_ar_arid_t;
wire [3:0]     nvdla_core2dbb_ar_arlen_t;
wire [7:0]     nvdla_core2cvsram_aw_awid_t;
wire [3:0]     nvdla_core2cvsram_aw_awlen_t;
wire [7:0]     nvdla_core2cvsram_ar_arid_t;
wire [3:0]     nvdla_core2cvsram_ar_arlen_t;
////////////////////////////////////////////////////////////////////////

//sub-module instantiation
////////////////////////////////////////////////////////////////////////
//
NV_NVDLA_apb2csb U_NVDLA_APB2CSB (
   .pclk                         (dla_csb_clk              )
  ,.prstn                        (dla_reset_rstn           )
  ,.psel                         (psel                     )
  ,.penable                      (penable                  )
  ,.pwrite                       (pwrite                   )
  ,.paddr                        (paddr                    )
  ,.pwdata                       (pwdata                   )
  ,.prdata                       (prdata                   )
  ,.pready                       (pready                   )
  ,.csb2nvdla_valid              (csb2nvdla_valid          )
  ,.csb2nvdla_ready              (csb2nvdla_ready          )
  ,.csb2nvdla_addr               (csb2nvdla_addr           )
  ,.csb2nvdla_wdat               (csb2nvdla_wdat           )
  ,.csb2nvdla_write              (csb2nvdla_write          )
  ,.csb2nvdla_nposted            (csb2nvdla_nposted        )
  ,.nvdla2csb_valid              (nvdla2csb_valid          )
  ,.nvdla2csb_data               (nvdla2csb_data           )
  );
//
NV_nvdla U_NVDLA_CORE            (
	//sys signals
   .dla_core_clk                 (dla_core_clk                     ) //|< i
  ,.dla_csb_clk                  (dla_csb_clk                      ) //|< i
  ,.global_clk_ovr_on            (1'b0                             ) //|< i
  ,.tmc2slcg_disable_clock_gating(1'b0                             ) //|< i
  ,.dla_reset_rstn               (dla_reset_rstn                   ) //|< i
  ,.direct_reset_                (1'b0                             ) //|< i
  ,.test_mode                    (1'b0                             ) //|< i
	//csb interface
  ,.csb2nvdla_valid              (csb2nvdla_valid                  )//|< i
  ,.csb2nvdla_ready              (csb2nvdla_ready                  )//|> o
  ,.csb2nvdla_addr               (csb2nvdla_addr                   )//|< i
  ,.csb2nvdla_wdat               (csb2nvdla_wdat                   )//|< i
  ,.csb2nvdla_write              (csb2nvdla_write                  )//|< i
  ,.csb2nvdla_nposted            (csb2nvdla_nposted                )//|< i
  ,.nvdla2csb_valid              (nvdla2csb_valid                  )//|> o
  ,.nvdla2csb_data               (nvdla2csb_data                   )//|> o
  ,.nvdla2csb_wr_complete        (                                 )//|> o
	//DBBIF --- AXI4 interface
  ,.nvdla_core2dbb_aw_awvalid    (nvdla_core2dbb_aw_awvalid        )//|> o
  ,.nvdla_core2dbb_aw_awready    (nvdla_core2dbb_aw_awready        )//|< i
  ,.nvdla_core2dbb_aw_awid       (nvdla_core2dbb_aw_awid_t         )//|> o
  ,.nvdla_core2dbb_aw_awlen      (nvdla_core2dbb_aw_awlen_t        )//|> o
  ,.nvdla_core2dbb_aw_awaddr     (nvdla_core2dbb_aw_awaddr         )//|> o
  ,.nvdla_core2dbb_w_wvalid      (nvdla_core2dbb_w_wvalid          )//|> o
  ,.nvdla_core2dbb_w_wready      (nvdla_core2dbb_w_wready          )//|< i
  ,.nvdla_core2dbb_w_wdata       (nvdla_core2dbb_w_wdata           )//|> o
  ,.nvdla_core2dbb_w_wstrb       (nvdla_core2dbb_w_wstrb           )//|> o
  ,.nvdla_core2dbb_w_wlast       (nvdla_core2dbb_w_wlast           )//|> o
  ,.nvdla_core2dbb_b_bvalid      (nvdla_core2dbb_b_bvalid          )//|< i
  ,.nvdla_core2dbb_b_bready      (nvdla_core2dbb_b_bready          )//|> o
  ,.nvdla_core2dbb_b_bid         ({2'b00,nvdla_core2dbb_b_bid}     )//|< i
  ,.nvdla_core2dbb_ar_arvalid    (nvdla_core2dbb_ar_arvalid        )//|> o
  ,.nvdla_core2dbb_ar_arready    (nvdla_core2dbb_ar_arready        )//|< i
  ,.nvdla_core2dbb_ar_arid       (nvdla_core2dbb_ar_arid_t         )//|> o
  ,.nvdla_core2dbb_ar_arlen      (nvdla_core2dbb_ar_arlen_t        )//|> o
  ,.nvdla_core2dbb_ar_araddr     (nvdla_core2dbb_ar_araddr         )//|> o
  ,.nvdla_core2dbb_r_rvalid      (nvdla_core2dbb_r_rvalid          )//|< i
  ,.nvdla_core2dbb_r_rready      (nvdla_core2dbb_r_rready          )//|> o
  ,.nvdla_core2dbb_r_rid         ({2'b00,nvdla_core2dbb_r_rid}     )//|< i
  ,.nvdla_core2dbb_r_rlast       (nvdla_core2dbb_r_rlast           )//|< i
  ,.nvdla_core2dbb_r_rdata       (nvdla_core2dbb_r_rdata           )//|< i

	//SRAMIF --- AXI4 interface
  ,.nvdla_core2cvsram_aw_awvalid (nvdla_core2cvsram_aw_awvalid     )//|> o
  ,.nvdla_core2cvsram_aw_awready (nvdla_core2cvsram_aw_awready     )//|< i
  ,.nvdla_core2cvsram_aw_awid    (nvdla_core2cvsram_aw_awid_t      )//|> o
  ,.nvdla_core2cvsram_aw_awlen   (nvdla_core2cvsram_aw_awlen_t     )//|> o
  ,.nvdla_core2cvsram_aw_awaddr  (nvdla_core2cvsram_aw_awaddr      )//|> o
  ,.nvdla_core2cvsram_w_wvalid   (nvdla_core2cvsram_w_wvalid       )//|> o
  ,.nvdla_core2cvsram_w_wready   (nvdla_core2cvsram_w_wready       )//|< i
  ,.nvdla_core2cvsram_w_wdata    (nvdla_core2cvsram_w_wdata        )//|> o
  ,.nvdla_core2cvsram_w_wstrb    (nvdla_core2cvsram_w_wstrb        )//|> o
  ,.nvdla_core2cvsram_w_wlast    (nvdla_core2cvsram_w_wlast        )//|> o
  ,.nvdla_core2cvsram_b_bvalid   (nvdla_core2cvsram_b_bvalid       )//|< i
  ,.nvdla_core2cvsram_b_bready   (nvdla_core2cvsram_b_bready       )//|> o
  ,.nvdla_core2cvsram_b_bid      ({2'b00,nvdla_core2cvsram_b_bid}  )//|< i
  ,.nvdla_core2cvsram_ar_arvalid (nvdla_core2cvsram_ar_arvalid     )//|> o
  ,.nvdla_core2cvsram_ar_arready (nvdla_core2cvsram_ar_arready     )//|< i
  ,.nvdla_core2cvsram_ar_arid    (nvdla_core2cvsram_ar_arid_t      )//|> o
  ,.nvdla_core2cvsram_ar_arlen   (nvdla_core2cvsram_ar_arlen_t     )//|> o
  ,.nvdla_core2cvsram_ar_araddr  (nvdla_core2cvsram_ar_araddr      )//|> o
  ,.nvdla_core2cvsram_r_rvalid   (nvdla_core2cvsram_r_rvalid       )//|< i
  ,.nvdla_core2cvsram_r_rready   (nvdla_core2cvsram_r_rready       )//|> o
  ,.nvdla_core2cvsram_r_rid      ({2'b00,nvdla_core2cvsram_r_rid}  )//|< i
  ,.nvdla_core2cvsram_r_rlast    (nvdla_core2cvsram_r_rlast        )//|< i
  ,.nvdla_core2cvsram_r_rdata    (nvdla_core2cvsram_r_rdata        )//|< i
	//NVDLA interrupt
  ,.dla_intr                     (nvdla_intr                       )//|> o
	//power control signals
  ,.nvdla_pwrbus_ram_c_pd        (32'd0                            )//|< i
  ,.nvdla_pwrbus_ram_ma_pd       (32'd0                            )//|< i *
  ,.nvdla_pwrbus_ram_mb_pd       (32'd0                            )//|< i *
  ,.nvdla_pwrbus_ram_p_pd        (32'd0                            )//|< i
  ,.nvdla_pwrbus_ram_o_pd        (32'd0                            )//|< i
  ,.nvdla_pwrbus_ram_a_pd        (32'd0                            )//|< i
	//for debug
  ,.cdma_wt_done_status0         (cdma_wt_done_status0             )
  ,.cdma_wt_done_status1         (cdma_wt_done_status1             )
  ,.cdma_dat_done_status0        (cdma_dat_done_status0            )
  ,.cdma_dat_done_status1        (cdma_dat_done_status1            )
  ,.cacc_done_status0            (cacc_done_status0                )
  ,.cacc_done_status1            (cacc_done_status1                )
  ,.sdp_done_status0             (sdp_done_status0                 )
  ,.sdp_done_status1             (sdp_done_status1                 )
  ,.pdp_done_status0             (pdp_done_status0                 )
  ,.pdp_done_status1             (pdp_done_status1                 )
  ,.cdp_done_status0             (cdp_done_status0                 )
  ,.cdp_done_status1             (cdp_done_status1                 )
  ,.bdma_done_status0            (bdma_done_status0                )
  ,.bdma_done_status1            (bdma_done_status1                )
  ,.cdma_wt_done_0_counter       (cdma_wt_done_0_counter           )
  ,.cdma_wt_done_1_counter       (cdma_wt_done_1_counter           )
  ,.cdma_dat_done_0_counter      (cdma_dat_done_0_counter          )
  ,.cdma_dat_done_1_counter      (cdma_dat_done_1_counter          )
  ,.cacc_done_0_counter          (cacc_done_0_counter              )
  ,.cacc_done_1_counter          (cacc_done_1_counter              )
  ,.sdp_done_0_counter           (sdp_done_0_counter               )
  ,.sdp_done_1_counter           (sdp_done_1_counter               )
  ,.pdp_done_0_counter           (pdp_done_0_counter               )
  ,.pdp_done_1_counter           (pdp_done_1_counter               )
  ,.cdp_done_0_counter           (cdp_done_0_counter               )
  ,.cdp_done_1_counter           (cdp_done_1_counter               )
  ,.bdma_done_0_counter          (bdma_done_0_counter              )
  ,.bdma_done_1_counter          (bdma_done_1_counter              )
  ,.cdma_img_status              (cdma_img_status                  )
  ,.cdma_dc_status               (cdma_dc_status                   )
  ,.cdma_wt_status               (cdma_wt_status                   )
  ,.upper_limit_w                (upper_limit_w                    )
  ,.lower_limit_w                (lower_limit_w                    )
  ,.sc2mac_wt_a_pvld             (sc2mac_wt_a_pvld                 )
  ,.sc2mac_wt_a_sel              (sc2mac_wt_a_sel                  )
  ,.sc2mac_wt_a_mask             (sc2mac_wt_a_mask                 )
  ,.sc2mac_wt_a_data0            (sc2mac_wt_a_data0                )
  ,.sc2mac_dat_a_pvld            (sc2mac_dat_a_pvld                )
  ,.sc2mac_dat_a_mask            (sc2mac_dat_a_mask                )
  ,.sc2mac_dat_a_data0           (sc2mac_dat_a_data0               )
  ,.mac_a2accu_pvld              (mac_a2accu_pvld                  )
  ,.mac_a2accu_mask              (mac_a2accu_mask                  )
  ,.mac_a2accu_data0             (mac_a2accu_data0                 )
  ,.sc2mac_wt_b_pvld             (sc2mac_wt_b_pvld                 )
  ,.sc2mac_wt_b_sel              (sc2mac_wt_b_sel                  )
  ,.sc2mac_wt_b_mask             (sc2mac_wt_b_mask                 )
  ,.sc2mac_wt_b_data0            (sc2mac_wt_b_data0                )
  ,.sc2mac_dat_b_pvld            (sc2mac_dat_b_pvld                )
  ,.sc2mac_dat_b_mask            (sc2mac_dat_b_mask                )
  ,.sc2mac_dat_b_data0           (sc2mac_dat_b_data0               )
  ,.mac_b2accu_pvld              (mac_b2accu_pvld                  )
  ,.mac_b2accu_mask              (mac_b2accu_mask                  )
  ,.mac_b2accu_data0             (mac_b2accu_data0                 )
  ,.cacc2sdp_valid               (cacc2sdp_valid                   )
  ,.cacc2sdp_ready               (cacc2sdp_ready                   )
  ,.cacc2sdp_pd                  (cacc2sdp_pd                      )
  ,.cacc2sdp_adpt_valid          (cacc2sdp_adpt_valid              )
  ,.cacc2sdp_adpt_ready          (cacc2sdp_adpt_ready              )
  ,.cacc2sdp_adpt_pd             (cacc2sdp_adpt_pd                 )
  ,.sdp_dp2wdma_ready            (sdp_dp2wdma_ready                )
  ,.sdp_dp2wdma_valid            (sdp_dp2wdma_valid                )
  ,.sdp_dp2wdma_pd               (sdp_dp2wdma_pd                   )
  ,.sdp2pdp_valid                (sdp2pdp_valid                    )
  ,.sdp2pdp_ready                (sdp2pdp_ready                    )
  ,.sdp2pdp_pd                   (sdp2pdp_pd                       )
  );


////////////////////////////////////////////////////////////////////////
//
//output assignment
////////////////////////////////////////////////////////////////////////
assign nvdla_core2dbb_aw_awid        = nvdla_core2dbb_aw_awid_t[3:0];
assign nvdla_core2dbb_aw_awlen       = {4'd0,nvdla_core2dbb_aw_awlen_t};
assign nvdla_core2dbb_aw_awsize      = 3'b101 ;//64 bit, needed to be verified
assign nvdla_core2dbb_aw_awburst     = 2'b01  ;//INCR burst type
assign nvdla_core2dbb_aw_awlock      = 1'b0   ;//normal access
assign nvdla_core2dbb_aw_awcache     = 4'b0000;//non-bufferable
assign nvdla_core2dbb_aw_awprot      = 3'b000 ;//unprivileged & secure & data access
assign nvdla_core2dbb_aw_awqos       = 4'b0000;//no QOS scheme
assign nvdla_core2dbb_aw_awregion    = 4'b0000;//default value
assign nvdla_core2dbb_aw_awuser      = 32'd0  ;//not sure about width

assign nvdla_core2dbb_w_wid          = 8'd0   ;//not needed for AXI4
assign nvdla_core2dbb_w_wuser        = 32'd0  ;//not sure about width

assign nvdla_core2dbb_ar_arid        = nvdla_core2dbb_ar_arid_t[3:0];
assign nvdla_core2dbb_ar_arlen       = {4'd0,nvdla_core2dbb_ar_arlen_t};
assign nvdla_core2dbb_ar_arsize      = 3'b101 ;//64 bit
assign nvdla_core2dbb_ar_arburst     = 2'b01  ;//INCE burst type
assign nvdla_core2dbb_ar_arlock      = 1'b0   ;//normal access
assign nvdla_core2dbb_ar_arcache     = 4'b0000;//non-bufferable
assign nvdla_core2dbb_ar_arprot      = 3'b000 ;//unprivileged & secure & data access
assign nvdla_core2dbb_ar_arqos       = 4'b0000;//no QOS scheme
assign nvdla_core2dbb_ar_arregion    = 4'b0000;//default value
assign nvdla_core2dbb_ar_aruser      = 32'd0  ;//not sure about signal width


assign nvdla_core2cvsram_aw_awid     = nvdla_core2cvsram_aw_awid_t[3:0];
assign nvdla_core2cvsram_aw_awlen    = {4'd0,nvdla_core2cvsram_aw_awlen_t};
assign nvdla_core2cvsram_aw_awsize   = 3'b101 ;//64 bit, needed to be verified
assign nvdla_core2cvsram_aw_awburst  = 2'b01  ;//INCR burst type
assign nvdla_core2cvsram_aw_awlock   = 1'b0   ;//normal access
assign nvdla_core2cvsram_aw_awcache  = 4'b0000;//non-bufferable
assign nvdla_core2cvsram_aw_awprot   = 3'b000 ;//unprivileged & secure & data access
assign nvdla_core2cvsram_aw_awqos    = 4'b0000;//no QOS scheme
assign nvdla_core2cvsram_aw_awregion = 4'b0000;//default value
assign nvdla_core2cvsram_aw_awuser   = 32'd0  ;//not sure about width

assign nvdla_core2cvsram_w_wid       = 8'd0   ;//not needed for AXI4
assign nvdla_core2cvsram_w_wuser     = 32'd0  ;//not sure about width

assign nvdla_core2cvsram_ar_arid     = nvdla_core2cvsram_ar_arid_t[3:0];
assign nvdla_core2cvsram_ar_arlen    = {4'd0,nvdla_core2cvsram_ar_arlen_t};
assign nvdla_core2cvsram_ar_arsize   = 3'b101 ;//64 bit
assign nvdla_core2cvsram_ar_arburst  = 2'b01  ;//INCE burst type
assign nvdla_core2cvsram_ar_arlock   = 1'b0   ;//normal access
assign nvdla_core2cvsram_ar_arcache  = 4'b0000;//non-bufferable
assign nvdla_core2cvsram_ar_arprot   = 3'b000 ;//unprivileged & secure & data access
assign nvdla_core2cvsram_ar_arqos    = 4'b0000;//no QOS scheme
assign nvdla_core2cvsram_ar_arregion = 4'b0000;//default value
assign nvdla_core2cvsram_ar_aruser   = 32'd0  ;//not sure about signal width

assign pslverr                       = 1'b0   ;
////////////////////////////////////////////////////////////////////////
//
endmodule // NV_nvdla_top
