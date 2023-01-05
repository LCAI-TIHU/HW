// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba, ETH Zurich
// Date: 19.03.2017
// Description: Test-harness for Ariane
//              Instantiates an AXI-Bus and memories

module uncore_axi_interconnect #(
  parameter int unsigned AXI_ADDR_WIDTH    = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 32,
  parameter int unsigned AXI_ID_WIDTH      = 4,
  parameter int unsigned AXI_USER_WIDTH    = 1
) (
  input  logic                                      clk_i,
  input  logic                                      rst_ni,
  // AXI Interface -- slave 0
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       slv0_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv0_aw_awaddr,
  input                    [7:0]                    slv0_aw_awlen,
  input                    [2:0]                    slv0_aw_awsize,
  input                    [1:0]                    slv0_aw_awburst,
  input                                             slv0_aw_awlock,
  input                    [3:0]                    slv0_aw_awcache,
  input                    [2:0]                    slv0_aw_awprot,
  input                    [3:0]                    slv0_aw_awqos,
  input                    [3:0]                    slv0_aw_awregion,
  input                                             slv0_aw_awuser,//
  input                                             slv0_aw_awvalid,
  output                                            slv0_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv0_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv0_w_wstrb,
  input                                             slv0_w_wlast,
  input                                             slv0_w_wuser,
  input                                             slv0_w_wvalid,
  output                                            slv0_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       slv0_b_bid,
  output                   [1:0]                    slv0_b_bresp,
  output                                            slv0_b_buser,
  output                                            slv0_b_bvalid,
  input                                             slv0_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       slv0_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv0_ar_araddr,
  input                    [7:0]                    slv0_ar_arlen,
  input                    [2:0]                    slv0_ar_arsize,
  input                    [1:0]                    slv0_ar_arburst,
  input                                             slv0_ar_arlock,
  input                    [3:0]                    slv0_ar_arcache,
  input                    [2:0]                    slv0_ar_arprot,
  input                    [3:0]                    slv0_ar_arqos,
  input                    [3:0]                    slv0_ar_arregion,
  input                                             slv0_ar_aruser,
  input                                             slv0_ar_arvalid,
  output                                            slv0_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       slv0_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     slv0_r_rdata,
  output                   [1:0]                    slv0_r_rresp,
  output                                            slv0_r_rlast,
  output                                            slv0_r_ruser,
  output                                            slv0_r_rvalid,
  input                                             slv0_r_rready, 
  /*********************************************************************/
  // AXI Interface -- slave 1
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       slv1_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv1_aw_awaddr,
  input                    [7:0]                    slv1_aw_awlen,
  input                    [2:0]                    slv1_aw_awsize,
  input                    [1:0]                    slv1_aw_awburst,
  input                                             slv1_aw_awlock,
  input                    [3:0]                    slv1_aw_awcache,
  input                    [2:0]                    slv1_aw_awprot,
  input                    [3:0]                    slv1_aw_awqos,
  input                    [3:0]                    slv1_aw_awregion,
  input                                             slv1_aw_awuser,//
  input                                             slv1_aw_awvalid,
  output                                            slv1_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv1_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv1_w_wstrb,
  input                                             slv1_w_wlast,
  input                                             slv1_w_wuser,
  input                                             slv1_w_wvalid,
  output                                            slv1_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       slv1_b_bid,
  output                   [1:0]                    slv1_b_bresp,
  output                                            slv1_b_buser,
  output                                            slv1_b_bvalid,
  input                                             slv1_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       slv1_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv1_ar_araddr,
  input                    [7:0]                    slv1_ar_arlen,
  input                    [2:0]                    slv1_ar_arsize,
  input                    [1:0]                    slv1_ar_arburst,
  input                                             slv1_ar_arlock,
  input                    [3:0]                    slv1_ar_arcache,
  input                    [2:0]                    slv1_ar_arprot,
  input                    [3:0]                    slv1_ar_arqos,
  input                    [3:0]                    slv1_ar_arregion,
  input                                             slv1_ar_aruser,
  input                                             slv1_ar_arvalid,
  output                                            slv1_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       slv1_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     slv1_r_rdata,
  output                   [1:0]                    slv1_r_rresp,
  output                                            slv1_r_rlast,
  output                                            slv1_r_ruser,
  output                                            slv1_r_rvalid,
  input                                             slv1_r_rready, 
  /*********************************************************************/

  // AXI Interface -- master 0
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+1-1:0]     mst0_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst0_aw_awaddr,
  output                   [7:0]                    mst0_aw_awlen,
  output                   [2:0]                    mst0_aw_awsize,
  output                   [1:0]                    mst0_aw_awburst,
  output                                            mst0_aw_awlock,
  output                   [3:0]                    mst0_aw_awcache,
  output                   [2:0]                    mst0_aw_awprot,
  output                   [3:0]                    mst0_aw_awqos,
  output                   [3:0]                    mst0_aw_awregion,
  output                                            mst0_aw_awuser,//
  output                                            mst0_aw_awvalid,
  input                                             mst0_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst0_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst0_w_wstrb,
  output                                            mst0_w_wlast,
  output                                            mst0_w_wuser,
  output                                            mst0_w_wvalid,
  input                                             mst0_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH+1-1:0]     mst0_b_bid,
  input                    [1:0]                    mst0_b_bresp,
  input                                             mst0_b_buser,
  input                                             mst0_b_bvalid,
  output                                            mst0_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+1-1:0]     mst0_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst0_ar_araddr,
  output                   [7:0]                    mst0_ar_arlen,
  output                   [2:0]                    mst0_ar_arsize,
  output                   [1:0]                    mst0_ar_arburst,
  output                                            mst0_ar_arlock,
  output                   [3:0]                    mst0_ar_arcache,
  output                   [2:0]                    mst0_ar_arprot,
  output                   [3:0]                    mst0_ar_arqos,
  output                   [3:0]                    mst0_ar_arregion,
  output                                            mst0_ar_aruser,
  output                                            mst0_ar_arvalid,
  input                                             mst0_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH+1-1:0]     mst0_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst0_r_rdata,
  input                    [1:0]                    mst0_r_rresp,
  input                                             mst0_r_rlast,
  input                                             mst0_r_ruser,
  input                                             mst0_r_rvalid,
  output                                            mst0_r_rready, 
  /*********************************************************************/
  // AXI Interface -- master 1
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+1-1:0]     mst1_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst1_aw_awaddr,
  output                   [7:0]                    mst1_aw_awlen,
  output                   [2:0]                    mst1_aw_awsize,
  output                   [1:0]                    mst1_aw_awburst,
  output                                            mst1_aw_awlock,
  output                   [3:0]                    mst1_aw_awcache,
  output                   [2:0]                    mst1_aw_awprot,
  output                   [3:0]                    mst1_aw_awqos,
  output                   [3:0]                    mst1_aw_awregion,
  output                                            mst1_aw_awuser,//
  output                                            mst1_aw_awvalid,
  input                                             mst1_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst1_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst1_w_wstrb,
  output                                            mst1_w_wlast,
  output                                            mst1_w_wuser,
  output                                            mst1_w_wvalid,
  input                                             mst1_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH+1-1:0]     mst1_b_bid,
  input                    [1:0]                    mst1_b_bresp,
  input                                             mst1_b_buser,
  input                                             mst1_b_bvalid,
  output                                            mst1_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+1-1:0]     mst1_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst1_ar_araddr,
  output                   [7:0]                    mst1_ar_arlen,
  output                   [2:0]                    mst1_ar_arsize,
  output                   [1:0]                    mst1_ar_arburst,
  output                                            mst1_ar_arlock,
  output                   [3:0]                    mst1_ar_arcache,
  output                   [2:0]                    mst1_ar_arprot,
  output                   [3:0]                    mst1_ar_arqos,
  output                   [3:0]                    mst1_ar_arregion,
  output                                            mst1_ar_aruser,
  output                                            mst1_ar_arvalid,
  input                                             mst1_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH+1-1:0]     mst1_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst1_r_rdata,
  input                    [1:0]                    mst1_r_rresp,
  input                                             mst1_r_rlast,
  input                                             mst1_r_ruser,
  input                                             mst1_r_rvalid,
  output                                            mst1_r_rready, 
  /*********************************************************************/
  // AXI Interface -- master 2
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+1-1:0]     mst2_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst2_aw_awaddr,
  output                   [7:0]                    mst2_aw_awlen,
  output                   [2:0]                    mst2_aw_awsize,
  output                   [1:0]                    mst2_aw_awburst,
  output                                            mst2_aw_awlock,
  output                   [3:0]                    mst2_aw_awcache,
  output                   [2:0]                    mst2_aw_awprot,
  output                   [3:0]                    mst2_aw_awqos,
  output                   [3:0]                    mst2_aw_awregion,
  output                                            mst2_aw_awuser,//
  output                                            mst2_aw_awvalid,
  input                                             mst2_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst2_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst2_w_wstrb,
  output                                            mst2_w_wlast,
  output                                            mst2_w_wuser,
  output                                            mst2_w_wvalid,
  input                                             mst2_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH+1-1:0]     mst2_b_bid,
  input                    [1:0]                    mst2_b_bresp,
  input                                             mst2_b_buser,
  input                                             mst2_b_bvalid,
  output                                            mst2_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+1-1:0]     mst2_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst2_ar_araddr,
  output                   [7:0]                    mst2_ar_arlen,
  output                   [2:0]                    mst2_ar_arsize,
  output                   [1:0]                    mst2_ar_arburst,
  output                                            mst2_ar_arlock,
  output                   [3:0]                    mst2_ar_arcache,
  output                   [2:0]                    mst2_ar_arprot,
  output                   [3:0]                    mst2_ar_arqos,
  output                   [3:0]                    mst2_ar_arregion,
  output                                            mst2_ar_aruser,
  output                                            mst2_ar_arvalid,
  input                                             mst2_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH+1-1:0]     mst2_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst2_r_rdata,
  input                    [1:0]                    mst2_r_rresp,
  input                                             mst2_r_rlast,
  input                                             mst2_r_ruser,
  input                                             mst2_r_rvalid,
  output                                            mst2_r_rready, 
  /*********************************************************************/
  // AXI Interface -- master 3
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+1-1:0]     mst3_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst3_aw_awaddr,
  output                   [7:0]                    mst3_aw_awlen,
  output                   [2:0]                    mst3_aw_awsize,
  output                   [1:0]                    mst3_aw_awburst,
  output                                            mst3_aw_awlock,
  output                   [3:0]                    mst3_aw_awcache,
  output                   [2:0]                    mst3_aw_awprot,
  output                   [3:0]                    mst3_aw_awqos,
  output                   [3:0]                    mst3_aw_awregion,
  output                                            mst3_aw_awuser,//
  output                                            mst3_aw_awvalid,
  input                                             mst3_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst3_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst3_w_wstrb,
  output                                            mst3_w_wlast,
  output                                            mst3_w_wuser,
  output                                            mst3_w_wvalid,
  input                                             mst3_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH+1-1:0]     mst3_b_bid,
  input                    [1:0]                    mst3_b_bresp,
  input                                             mst3_b_buser,
  input                                             mst3_b_bvalid,
  output                                            mst3_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+1-1:0]     mst3_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst3_ar_araddr,
  output                   [7:0]                    mst3_ar_arlen,
  output                   [2:0]                    mst3_ar_arsize,
  output                   [1:0]                    mst3_ar_arburst,
  output                                            mst3_ar_arlock,
  output                   [3:0]                    mst3_ar_arcache,
  output                   [2:0]                    mst3_ar_arprot,
  output                   [3:0]                    mst3_ar_arqos,
  output                   [3:0]                    mst3_ar_arregion,
  output                                            mst3_ar_aruser,
  output                                            mst3_ar_arvalid,
  input                                             mst3_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH+1-1:0]     mst3_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst3_r_rdata,
  input                    [1:0]                    mst3_r_rresp,
  input                                             mst3_r_rlast,
  input                                             mst3_r_ruser,
  input                                             mst3_r_rvalid,
  output                                            mst3_r_rready 
  /*********************************************************************/
);


  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( AXI_ID_WIDTH        ),
    .AXI_USER_WIDTH ( 1                   )
  ) slave[1:0]();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( AXI_ID_WIDTH+1      ),
    .AXI_USER_WIDTH ( 1                   )
  ) master[3:0]();

  //slave 0 interface connection
  /*********************************************************************/
  assign slave[0].aw_id     = slv0_aw_awid       ;
  assign slave[0].aw_addr   = slv0_aw_awaddr     ;
  assign slave[0].aw_len    = slv0_aw_awlen      ;
  assign slave[0].aw_size   = slv0_aw_awsize     ;
  assign slave[0].aw_burst  = slv0_aw_awburst    ;
  assign slave[0].aw_lock   = slv0_aw_awlock     ;
  assign slave[0].aw_cache  = slv0_aw_awcache    ;
  assign slave[0].aw_prot   = slv0_aw_awprot     ;
  assign slave[0].aw_qos    = slv0_aw_awqos      ;
  assign slave[0].aw_region = slv0_aw_awregion   ;
  assign slave[0].aw_atop   = 6'd0               ;
  assign slave[0].aw_user   = slv0_aw_awuser     ;
  assign slave[0].aw_valid  = slv0_aw_awvalid    ;
  assign slv0_aw_awready    = slave[0].aw_ready  ;

  assign slave[0].w_data    = slv0_w_wdata       ;
  assign slave[0].w_strb    = slv0_w_wstrb       ;
  assign slave[0].w_last    = slv0_w_wlast       ;
  assign slave[0].w_user    = slv0_w_wuser       ;
  assign slave[0].w_valid   = slv0_w_wvalid      ;
  assign slv0_w_wready      = slave[0].w_ready   ;

  assign slv0_b_bid         = slave[0].b_id      ;
  assign slv0_b_bresp       = slave[0].b_resp    ;
  assign slv0_b_buser       = slave[0].b_user    ;
  assign slv0_b_bvalid      = slave[0].b_valid   ;
  assign slave[0].b_ready   = slv0_b_bready      ;

  assign slave[0].ar_id     = slv0_ar_arid       ;
  assign slave[0].ar_addr   = slv0_ar_araddr     ;
  assign slave[0].ar_len    = slv0_ar_arlen      ;   
  assign slave[0].ar_size   = slv0_ar_arsize     ;
  assign slave[0].ar_burst  = slv0_ar_arburst    ;
  assign slave[0].ar_lock   = slv0_ar_arlock     ;
  assign slave[0].ar_cache  = slv0_ar_arcache    ;
  assign slave[0].ar_prot   = slv0_ar_arprot     ;
  assign slave[0].ar_qos    = slv0_ar_arqos      ;
  assign slave[0].ar_region = slv0_ar_arregion   ;
  assign slave[0].ar_user   = slv0_ar_aruser     ;
  assign slave[0].ar_valid  = slv0_ar_arvalid    ;
  assign slv0_ar_arready    = slave[0].ar_ready  ;

  assign slv0_r_rid         = slave[0].r_id      ;
  assign slv0_r_rdata       = slave[0].r_data    ;
  assign slv0_r_rresp       = slave[0].r_resp    ;
  assign slv0_r_rlast       = slave[0].r_last    ;
  assign slv0_r_ruser       = slave[0].r_user    ;
  assign slv0_r_rvalid      = slave[0].r_valid   ;
  assign slave[0].r_ready   = slv0_r_rready      ;
  /*********************************************************************/
  //slave 1 interface connection
  /*********************************************************************/
  assign slave[1].aw_id     = slv1_aw_awid       ;
  assign slave[1].aw_addr   = slv1_aw_awaddr     ;
  assign slave[1].aw_len    = slv1_aw_awlen      ;
  assign slave[1].aw_size   = slv1_aw_awsize     ;
  assign slave[1].aw_burst  = slv1_aw_awburst    ;
  assign slave[1].aw_lock   = slv1_aw_awlock     ;
  assign slave[1].aw_cache  = slv1_aw_awcache    ;
  assign slave[1].aw_prot   = slv1_aw_awprot     ;
  assign slave[1].aw_qos    = slv1_aw_awqos      ;
  assign slave[1].aw_region = slv1_aw_awregion   ;
  assign slave[1].aw_atop   = 6'd0               ;
  assign slave[1].aw_user   = slv1_aw_awuser     ;
  assign slave[1].aw_valid  = slv1_aw_awvalid    ;
  assign slv1_aw_awready    = slave[1].aw_ready  ;

  assign slave[1].w_data    = slv1_w_wdata       ;
  assign slave[1].w_strb    = slv1_w_wstrb       ;
  assign slave[1].w_last    = slv1_w_wlast       ;
  assign slave[1].w_user    = slv1_w_wuser       ;
  assign slave[1].w_valid   = slv1_w_wvalid      ;
  assign slv1_w_wready      = slave[1].w_ready   ;

  assign slv1_b_bid         = slave[1].b_id      ;
  assign slv1_b_bresp       = slave[1].b_resp    ;
  assign slv1_b_buser       = slave[1].b_user    ;
  assign slv1_b_bvalid      = slave[1].b_valid   ;
  assign slave[1].b_ready   = slv1_b_bready      ;

  assign slave[1].ar_id     = slv1_ar_arid       ;
  assign slave[1].ar_addr   = slv1_ar_araddr     ;
  assign slave[1].ar_len    = slv1_ar_arlen      ;   
  assign slave[1].ar_size   = slv1_ar_arsize     ;
  assign slave[1].ar_burst  = slv1_ar_arburst    ;
  assign slave[1].ar_lock   = slv1_ar_arlock     ;
  assign slave[1].ar_cache  = slv1_ar_arcache    ;
  assign slave[1].ar_prot   = slv1_ar_arprot     ;
  assign slave[1].ar_qos    = slv1_ar_arqos      ;
  assign slave[1].ar_region = slv1_ar_arregion   ;
  assign slave[1].ar_user   = slv1_ar_aruser     ;
  assign slave[1].ar_valid  = slv1_ar_arvalid    ;
  assign slv1_ar_arready    = slave[1].ar_ready  ;

  assign slv1_r_rid         = slave[1].r_id      ;
  assign slv1_r_rdata       = slave[1].r_data    ;
  assign slv1_r_rresp       = slave[1].r_resp    ;
  assign slv1_r_rlast       = slave[1].r_last    ;
  assign slv1_r_ruser       = slave[1].r_user    ;
  assign slv1_r_rvalid      = slave[1].r_valid   ;
  assign slave[1].r_ready   = slv1_r_rready      ;
  /*********************************************************************/

  //master 0 interface connection
  /*********************************************************************/
  assign mst0_aw_awid       = master[0].aw_id        ;
  assign mst0_aw_awaddr     = master[0].aw_addr      ;
  assign mst0_aw_awlen      = master[0].aw_len       ;
  assign mst0_aw_awsize     = master[0].aw_size      ;
  assign mst0_aw_awburst    = master[0].aw_burst     ;
  assign mst0_aw_awlock     = master[0].aw_lock      ;
  assign mst0_aw_awcache    = master[0].aw_cache     ;
  assign mst0_aw_awprot     = master[0].aw_prot      ;
  assign mst0_aw_awqos      = master[0].aw_qos       ;
  assign mst0_aw_awregion   = master[0].aw_region    ;
  assign mst0_aw_awuser     = master[0].aw_user      ;
  assign mst0_aw_awvalid    = master[0].aw_valid     ;
  assign master[0].aw_ready = mst0_aw_awready        ;

  assign mst0_w_wdata       = master[0].w_data       ;
  assign mst0_w_wstrb       = master[0].w_strb       ;
  assign mst0_w_wlast       = master[0].w_last       ;
  assign mst0_w_wuser       = master[0].w_user       ;
  assign mst0_w_wvalid      = master[0].w_valid      ;
  assign master[0].w_ready  = mst0_w_wready          ;

  assign master[0].b_id     = mst0_b_bid             ;
  assign master[0].b_resp   = mst0_b_bresp           ;
  assign master[0].b_user   = mst0_b_buser           ;
  assign master[0].b_valid  = mst0_b_bvalid          ;
  assign mst0_b_bready      = master[0].b_ready      ;

  assign mst0_ar_arid       = master[0].ar_id        ;
  assign mst0_ar_araddr     = master[0].ar_addr      ;
  assign mst0_ar_arlen      = master[0].ar_len       ;   
  assign mst0_ar_arsize     = master[0].ar_size      ;
  assign mst0_ar_arburst    = master[0].ar_burst     ;
  assign mst0_ar_arlock     = master[0].ar_lock      ;
  assign mst0_ar_arcache    = master[0].ar_cache     ;
  assign mst0_ar_arprot     = master[0].ar_prot      ;
  assign mst0_ar_arqos      = master[0].ar_qos       ;
  assign mst0_ar_arregion   = master[0].ar_region    ;
  assign mst0_ar_aruser     = master[0].ar_user      ;
  assign mst0_ar_arvalid    = master[0].ar_valid     ;
  assign master[0].ar_ready = mst0_ar_arready        ;

  assign master[0].r_id     = mst0_r_rid             ;
  assign master[0].r_data   = mst0_r_rdata           ;
  assign master[0].r_resp   = mst0_r_rresp           ;
  assign master[0].r_last   = mst0_r_rlast           ;
  assign master[0].r_user   = mst0_r_ruser           ;
  assign master[0].r_valid  = mst0_r_rvalid          ;
  assign mst0_r_rready      = master[0].r_ready      ;
  /*********************************************************************/
  //master 1 interface connection
  /*********************************************************************/
  assign mst1_aw_awid       = master[1].aw_id        ;
  assign mst1_aw_awaddr     = master[1].aw_addr      ;
  assign mst1_aw_awlen      = master[1].aw_len       ;
  assign mst1_aw_awsize     = master[1].aw_size      ;
  assign mst1_aw_awburst    = master[1].aw_burst     ;
  assign mst1_aw_awlock     = master[1].aw_lock      ;
  assign mst1_aw_awcache    = master[1].aw_cache     ;
  assign mst1_aw_awprot     = master[1].aw_prot      ;
  assign mst1_aw_awqos      = master[1].aw_qos       ;
  assign mst1_aw_awregion   = master[1].aw_region    ;
  assign mst1_aw_awuser     = master[1].aw_user      ;
  assign mst1_aw_awvalid    = master[1].aw_valid     ;
  assign master[1].aw_ready = mst1_aw_awready        ;

  assign mst1_w_wdata       = master[1].w_data       ;
  assign mst1_w_wstrb       = master[1].w_strb       ;
  assign mst1_w_wlast       = master[1].w_last       ;
  assign mst1_w_wuser       = master[1].w_user       ;
  assign mst1_w_wvalid      = master[1].w_valid      ;
  assign master[1].w_ready  = mst1_w_wready          ;

  assign master[1].b_id     = mst1_b_bid             ;
  assign master[1].b_resp   = mst1_b_bresp           ;
  assign master[1].b_user   = mst1_b_buser           ;
  assign master[1].b_valid  = mst1_b_bvalid          ;
  assign mst1_b_bready      = master[1].b_ready      ;

  assign mst1_ar_arid       = master[1].ar_id        ;
  assign mst1_ar_araddr     = master[1].ar_addr      ;
  assign mst1_ar_arlen      = master[1].ar_len       ;   
  assign mst1_ar_arsize     = master[1].ar_size      ;
  assign mst1_ar_arburst    = master[1].ar_burst     ;
  assign mst1_ar_arlock     = master[1].ar_lock      ;
  assign mst1_ar_arcache    = master[1].ar_cache     ;
  assign mst1_ar_arprot     = master[1].ar_prot      ;
  assign mst1_ar_arqos      = master[1].ar_qos       ;
  assign mst1_ar_arregion   = master[1].ar_region    ;
  assign mst1_ar_aruser     = master[1].ar_user      ;
  assign mst1_ar_arvalid    = master[1].ar_valid     ;
  assign master[1].ar_ready = mst1_ar_arready        ;

  assign master[1].r_id     = mst1_r_rid             ;
  assign master[1].r_data   = mst1_r_rdata           ;
  assign master[1].r_resp   = mst1_r_rresp           ;
  assign master[1].r_last   = mst1_r_rlast           ;
  assign master[1].r_user   = mst1_r_ruser           ;
  assign master[1].r_valid  = mst1_r_rvalid          ;
  assign mst1_r_rready      = master[1].r_ready      ;
  /*********************************************************************/
  //master 2 interface connection
  /*********************************************************************/
  assign mst2_aw_awid       = master[2].aw_id        ;
  assign mst2_aw_awaddr     = master[2].aw_addr      ;
  assign mst2_aw_awlen      = master[2].aw_len       ;
  assign mst2_aw_awsize     = master[2].aw_size      ;
  assign mst2_aw_awburst    = master[2].aw_burst     ;
  assign mst2_aw_awlock     = master[2].aw_lock      ;
  assign mst2_aw_awcache    = master[2].aw_cache     ;
  assign mst2_aw_awprot     = master[2].aw_prot      ;
  assign mst2_aw_awqos      = master[2].aw_qos       ;
  assign mst2_aw_awregion   = master[2].aw_region    ;
  assign mst2_aw_awuser     = master[2].aw_user      ;
  assign mst2_aw_awvalid    = master[2].aw_valid     ;
  assign master[2].aw_ready = mst2_aw_awready        ;

  assign mst2_w_wdata       = master[2].w_data       ;
  assign mst2_w_wstrb       = master[2].w_strb       ;
  assign mst2_w_wlast       = master[2].w_last       ;
  assign mst2_w_wuser       = master[2].w_user       ;
  assign mst2_w_wvalid      = master[2].w_valid      ;
  assign master[2].w_ready  = mst2_w_wready          ;

  assign master[2].b_id     = mst2_b_bid             ;
  assign master[2].b_resp   = mst2_b_bresp           ;
  assign master[2].b_user   = mst2_b_buser           ;
  assign master[2].b_valid  = mst2_b_bvalid          ;
  assign mst2_b_bready      = master[2].b_ready      ;

  assign mst2_ar_arid       = master[2].ar_id        ;
  assign mst2_ar_araddr     = master[2].ar_addr      ;
  assign mst2_ar_arlen      = master[2].ar_len       ;   
  assign mst2_ar_arsize     = master[2].ar_size      ;
  assign mst2_ar_arburst    = master[2].ar_burst     ;
  assign mst2_ar_arlock     = master[2].ar_lock      ;
  assign mst2_ar_arcache    = master[2].ar_cache     ;
  assign mst2_ar_arprot     = master[2].ar_prot      ;
  assign mst2_ar_arqos      = master[2].ar_qos       ;
  assign mst2_ar_arregion   = master[2].ar_region    ;
  assign mst2_ar_aruser     = master[2].ar_user      ;
  assign mst2_ar_arvalid    = master[2].ar_valid     ;
  assign master[2].ar_ready = mst2_ar_arready        ;

  assign master[2].r_id     = mst2_r_rid             ;
  assign master[2].r_data   = mst2_r_rdata           ;
  assign master[2].r_resp   = mst2_r_rresp           ;
  assign master[2].r_last   = mst2_r_rlast           ;
  assign master[2].r_user   = mst2_r_ruser           ;
  assign master[2].r_valid  = mst2_r_rvalid          ;
  assign mst2_r_rready      = master[2].r_ready      ;
  /*********************************************************************/
  //master 3 interface connection
  /*********************************************************************/
  assign mst3_aw_awid       = master[3].aw_id        ;
  assign mst3_aw_awaddr     = master[3].aw_addr      ;
  assign mst3_aw_awlen      = master[3].aw_len       ;
  assign mst3_aw_awsize     = master[3].aw_size      ;
  assign mst3_aw_awburst    = master[3].aw_burst     ;
  assign mst3_aw_awlock     = master[3].aw_lock      ;
  assign mst3_aw_awcache    = master[3].aw_cache     ;
  assign mst3_aw_awprot     = master[3].aw_prot      ;
  assign mst3_aw_awqos      = master[3].aw_qos       ;
  assign mst3_aw_awregion   = master[3].aw_region    ;
  assign mst3_aw_awuser     = master[3].aw_user      ;
  assign mst3_aw_awvalid    = master[3].aw_valid     ;
  assign master[3].aw_ready = mst3_aw_awready        ;

  assign mst3_w_wdata       = master[3].w_data       ;
  assign mst3_w_wstrb       = master[3].w_strb       ;
  assign mst3_w_wlast       = master[3].w_last       ;
  assign mst3_w_wuser       = master[3].w_user       ;
  assign mst3_w_wvalid      = master[3].w_valid      ;
  assign master[3].w_ready  = mst3_w_wready          ;

  assign master[3].b_id     = mst3_b_bid             ;
  assign master[3].b_resp   = mst3_b_bresp           ;
  assign master[3].b_user   = mst3_b_buser           ;
  assign master[3].b_valid  = mst3_b_bvalid          ;
  assign mst3_b_bready      = master[3].b_ready      ;

  assign mst3_ar_arid       = master[3].ar_id        ;
  assign mst3_ar_araddr     = master[3].ar_addr      ;
  assign mst3_ar_arlen      = master[3].ar_len       ;   
  assign mst3_ar_arsize     = master[3].ar_size      ;
  assign mst3_ar_arburst    = master[3].ar_burst     ;
  assign mst3_ar_arlock     = master[3].ar_lock      ;
  assign mst3_ar_arcache    = master[3].ar_cache     ;
  assign mst3_ar_arprot     = master[3].ar_prot      ;
  assign mst3_ar_arqos      = master[3].ar_qos       ;
  assign mst3_ar_arregion   = master[3].ar_region    ;
  assign mst3_ar_aruser     = master[3].ar_user      ;
  assign mst3_ar_arvalid    = master[3].ar_valid     ;
  assign master[3].ar_ready = mst3_ar_arready        ;

  assign master[3].r_id     = mst3_r_rid             ;
  assign master[3].r_data   = mst3_r_rdata           ;
  assign master[3].r_resp   = mst3_r_rresp           ;
  assign master[3].r_last   = mst3_r_rlast           ;
  assign master[3].r_user   = mst3_r_ruser           ;
  assign master[3].r_valid  = mst3_r_rvalid          ;
  assign mst3_r_rready      = master[3].r_ready      ;
  /*********************************************************************/


  // ---------------
  // AXI Xbar
  // ---------------
  axi_node_intf_wrap #(
    .NB_SLAVE           ( 2               ),
    .NB_MASTER          ( 4               ),
    .NB_REGION          ( 1               ),
    .AXI_ADDR_WIDTH     ( AXI_ADDR_WIDTH  ),
    .AXI_DATA_WIDTH     ( AXI_DATA_WIDTH  ),
    .AXI_USER_WIDTH     ( 1               ),
    .AXI_ID_WIDTH       ( AXI_ID_WIDTH    )
  ) i_axi_xbar (
    .clk          ( clk_i      ),
    .rst_n        ( rst_ni     ),
    .test_en_i    ( 1'b0       ),
    .slave        ( slave      ),
    .master       ( master     ),
    .start_addr_i ({
      64'h40400000,
      64'h40000000,
      64'h40100000,
      64'h40300000
    }),
    .end_addr_i   ({
      64'hffffffff,
      64'h4001ffff,
      64'h4012ffff,
      64'h4030ffff
    }),

    .valid_rule_i (4'hf)
  );



endmodule
