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

module core_axi_interconnect #(
  parameter int unsigned AXI_ADDR_WIDTH    = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 256,
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
  // AXI Interface -- slave 2
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       slv2_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv2_aw_awaddr,
  input                    [7:0]                    slv2_aw_awlen,
  input                    [2:0]                    slv2_aw_awsize,
  input                    [1:0]                    slv2_aw_awburst,
  input                                             slv2_aw_awlock,
  input                    [3:0]                    slv2_aw_awcache,
  input                    [2:0]                    slv2_aw_awprot,
  input                    [3:0]                    slv2_aw_awqos,
  input                    [3:0]                    slv2_aw_awregion,
  input                                             slv2_aw_awuser,//
  input                                             slv2_aw_awvalid,
  output                                            slv2_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv2_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv2_w_wstrb,
  input                                             slv2_w_wlast,
  input                                             slv2_w_wuser,
  input                                             slv2_w_wvalid,
  output                                            slv2_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       slv2_b_bid,
  output                   [1:0]                    slv2_b_bresp,
  output                                            slv2_b_buser,
  output                                            slv2_b_bvalid,
  input                                             slv2_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       slv2_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv2_ar_araddr,
  input                    [7:0]                    slv2_ar_arlen,
  input                    [2:0]                    slv2_ar_arsize,
  input                    [1:0]                    slv2_ar_arburst,
  input                                             slv2_ar_arlock,
  input                    [3:0]                    slv2_ar_arcache,
  input                    [2:0]                    slv2_ar_arprot,
  input                    [3:0]                    slv2_ar_arqos,
  input                    [3:0]                    slv2_ar_arregion,
  input                                             slv2_ar_aruser,
  input                                             slv2_ar_arvalid,
  output                                            slv2_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       slv2_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     slv2_r_rdata,
  output                   [1:0]                    slv2_r_rresp,
  output                                            slv2_r_rlast,
  output                                            slv2_r_ruser,
  output                                            slv2_r_rvalid,
  input                                             slv2_r_rready, 
  /*********************************************************************/
  // AXI Interface -- slave 3
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       slv3_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv3_aw_awaddr,
  input                    [7:0]                    slv3_aw_awlen,
  input                    [2:0]                    slv3_aw_awsize,
  input                    [1:0]                    slv3_aw_awburst,
  input                                             slv3_aw_awlock,
  input                    [3:0]                    slv3_aw_awcache,
  input                    [2:0]                    slv3_aw_awprot,
  input                    [3:0]                    slv3_aw_awqos,
  input                    [3:0]                    slv3_aw_awregion,
  input                                             slv3_aw_awuser,//
  input                                             slv3_aw_awvalid,
  output                                            slv3_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv3_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv3_w_wstrb,
  input                                             slv3_w_wlast,
  input                                             slv3_w_wuser,
  input                                             slv3_w_wvalid,
  output                                            slv3_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       slv3_b_bid,
  output                   [1:0]                    slv3_b_bresp,
  output                                            slv3_b_buser,
  output                                            slv3_b_bvalid,
  input                                             slv3_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       slv3_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv3_ar_araddr,
  input                    [7:0]                    slv3_ar_arlen,
  input                    [2:0]                    slv3_ar_arsize,
  input                    [1:0]                    slv3_ar_arburst,
  input                                             slv3_ar_arlock,
  input                    [3:0]                    slv3_ar_arcache,
  input                    [2:0]                    slv3_ar_arprot,
  input                    [3:0]                    slv3_ar_arqos,
  input                    [3:0]                    slv3_ar_arregion,
  input                                             slv3_ar_aruser,
  input                                             slv3_ar_arvalid,
  output                                            slv3_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       slv3_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     slv3_r_rdata,
  output                   [1:0]                    slv3_r_rresp,
  output                                            slv3_r_rlast,
  output                                            slv3_r_ruser,
  output                                            slv3_r_rvalid,
  input                                             slv3_r_rready, 
  /*********************************************************************/
  // AXI Interface -- slave 4
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       slv4_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv4_aw_awaddr,
  input                    [7:0]                    slv4_aw_awlen,
  input                    [2:0]                    slv4_aw_awsize,
  input                    [1:0]                    slv4_aw_awburst,
  input                                             slv4_aw_awlock,
  input                    [3:0]                    slv4_aw_awcache,
  input                    [2:0]                    slv4_aw_awprot,
  input                    [3:0]                    slv4_aw_awqos,
  input                    [3:0]                    slv4_aw_awregion,
  input                                             slv4_aw_awuser,//
  input                                             slv4_aw_awvalid,
  output                                            slv4_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv4_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv4_w_wstrb,
  input                                             slv4_w_wlast,
  input                                             slv4_w_wuser,
  input                                             slv4_w_wvalid,
  output                                            slv4_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       slv4_b_bid,
  output                   [1:0]                    slv4_b_bresp,
  output                                            slv4_b_buser,
  output                                            slv4_b_bvalid,
  input                                             slv4_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       slv4_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv4_ar_araddr,
  input                    [7:0]                    slv4_ar_arlen,
  input                    [2:0]                    slv4_ar_arsize,
  input                    [1:0]                    slv4_ar_arburst,
  input                                             slv4_ar_arlock,
  input                    [3:0]                    slv4_ar_arcache,
  input                    [2:0]                    slv4_ar_arprot,
  input                    [3:0]                    slv4_ar_arqos,
  input                    [3:0]                    slv4_ar_arregion,
  input                                             slv4_ar_aruser,
  input                                             slv4_ar_arvalid,
  output                                            slv4_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       slv4_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     slv4_r_rdata,
  output                   [1:0]                    slv4_r_rresp,
  output                                            slv4_r_rlast,
  output                                            slv4_r_ruser,
  output                                            slv4_r_rvalid,
  input                                             slv4_r_rready, 
  /*********************************************************************/
  // AXI Interface -- slave 5
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       slv5_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv5_aw_awaddr,
  input                    [7:0]                    slv5_aw_awlen,
  input                    [2:0]                    slv5_aw_awsize,
  input                    [1:0]                    slv5_aw_awburst,
  input                                             slv5_aw_awlock,
  input                    [3:0]                    slv5_aw_awcache,
  input                    [2:0]                    slv5_aw_awprot,
  input                    [3:0]                    slv5_aw_awqos,
  input                    [3:0]                    slv5_aw_awregion,
  input                                             slv5_aw_awuser,//
  input                                             slv5_aw_awvalid,
  output                                            slv5_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv5_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv5_w_wstrb,
  input                                             slv5_w_wlast,
  input                                             slv5_w_wuser,
  input                                             slv5_w_wvalid,
  output                                            slv5_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       slv5_b_bid,
  output                   [1:0]                    slv5_b_bresp,
  output                                            slv5_b_buser,
  output                                            slv5_b_bvalid,
  input                                             slv5_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       slv5_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv5_ar_araddr,
  input                    [7:0]                    slv5_ar_arlen,
  input                    [2:0]                    slv5_ar_arsize,
  input                    [1:0]                    slv5_ar_arburst,
  input                                             slv5_ar_arlock,
  input                    [3:0]                    slv5_ar_arcache,
  input                    [2:0]                    slv5_ar_arprot,
  input                    [3:0]                    slv5_ar_arqos,
  input                    [3:0]                    slv5_ar_arregion,
  input                                             slv5_ar_aruser,
  input                                             slv5_ar_arvalid,
  output                                            slv5_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       slv5_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     slv5_r_rdata,
  output                   [1:0]                    slv5_r_rresp,
  output                                            slv5_r_rlast,
  output                                            slv5_r_ruser,
  output                                            slv5_r_rvalid,
  input                                             slv5_r_rready, 
  /*********************************************************************/
  // AXI Interface -- slave 6
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       slv6_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv6_aw_awaddr,
  input                    [7:0]                    slv6_aw_awlen,
  input                    [2:0]                    slv6_aw_awsize,
  input                    [1:0]                    slv6_aw_awburst,
  input                                             slv6_aw_awlock,
  input                    [3:0]                    slv6_aw_awcache,
  input                    [2:0]                    slv6_aw_awprot,
  input                    [3:0]                    slv6_aw_awqos,
  input                    [3:0]                    slv6_aw_awregion,
  input                                             slv6_aw_awuser,//
  input                                             slv6_aw_awvalid,
  output                                            slv6_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv6_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv6_w_wstrb,
  input                                             slv6_w_wlast,
  input                                             slv6_w_wuser,
  input                                             slv6_w_wvalid,
  output                                            slv6_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       slv6_b_bid,
  output                   [1:0]                    slv6_b_bresp,
  output                                            slv6_b_buser,
  output                                            slv6_b_bvalid,
  input                                             slv6_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       slv6_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv6_ar_araddr,
  input                    [7:0]                    slv6_ar_arlen,
  input                    [2:0]                    slv6_ar_arsize,
  input                    [1:0]                    slv6_ar_arburst,
  input                                             slv6_ar_arlock,
  input                    [3:0]                    slv6_ar_arcache,
  input                    [2:0]                    slv6_ar_arprot,
  input                    [3:0]                    slv6_ar_arqos,
  input                    [3:0]                    slv6_ar_arregion,
  input                                             slv6_ar_aruser,
  input                                             slv6_ar_arvalid,
  output                                            slv6_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       slv6_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     slv6_r_rdata,
  output                   [1:0]                    slv6_r_rresp,
  output                                            slv6_r_rlast,
  output                                            slv6_r_ruser,
  output                                            slv6_r_rvalid,
  input                                             slv6_r_rready, 
  /*********************************************************************/

  // AXI Interface -- master 0
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst0_aw_awid,
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
  input                    [AXI_ID_WIDTH+3-1:0]     mst0_b_bid,
  input                    [1:0]                    mst0_b_bresp,
  input                                             mst0_b_buser,
  input                                             mst0_b_bvalid,
  output                                            mst0_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst0_ar_arid,
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
  input                    [AXI_ID_WIDTH+3-1:0]     mst0_r_rid,
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
  output                   [AXI_ID_WIDTH+3-1:0]     mst1_aw_awid,
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
  input                    [AXI_ID_WIDTH+3-1:0]     mst1_b_bid,
  input                    [1:0]                    mst1_b_bresp,
  input                                             mst1_b_buser,
  input                                             mst1_b_bvalid,
  output                                            mst1_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst1_ar_arid,
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
  input                    [AXI_ID_WIDTH+3-1:0]     mst1_r_rid,
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
  output                   [AXI_ID_WIDTH+3-1:0]     mst2_aw_awid,
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
  input                    [AXI_ID_WIDTH+3-1:0]     mst2_b_bid,
  input                    [1:0]                    mst2_b_bresp,
  input                                             mst2_b_buser,
  input                                             mst2_b_bvalid,
  output                                            mst2_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst2_ar_arid,
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
  input                    [AXI_ID_WIDTH+3-1:0]     mst2_r_rid,
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
  output                   [AXI_ID_WIDTH+3-1:0]     mst3_aw_awid,
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
  input                    [AXI_ID_WIDTH+3-1:0]     mst3_b_bid,
  input                    [1:0]                    mst3_b_bresp,
  input                                             mst3_b_buser,
  input                                             mst3_b_bvalid,
  output                                            mst3_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst3_ar_arid,
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
  input                    [AXI_ID_WIDTH+3-1:0]     mst3_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst3_r_rdata,
  input                    [1:0]                    mst3_r_rresp,
  input                                             mst3_r_rlast,
  input                                             mst3_r_ruser,
  input                                             mst3_r_rvalid,
  output                                            mst3_r_rready, 
  /*********************************************************************/
  // AXI Interface -- master 4
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst4_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst4_aw_awaddr,
  output                   [7:0]                    mst4_aw_awlen,
  output                   [2:0]                    mst4_aw_awsize,
  output                   [1:0]                    mst4_aw_awburst,
  output                                            mst4_aw_awlock,
  output                   [3:0]                    mst4_aw_awcache,
  output                   [2:0]                    mst4_aw_awprot,
  output                   [3:0]                    mst4_aw_awqos,
  output                   [3:0]                    mst4_aw_awregion,
  output                                            mst4_aw_awuser,//
  output                                            mst4_aw_awvalid,
  input                                             mst4_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst4_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst4_w_wstrb,
  output                                            mst4_w_wlast,
  output                                            mst4_w_wuser,
  output                                            mst4_w_wvalid,
  input                                             mst4_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH+3-1:0]     mst4_b_bid,
  input                    [1:0]                    mst4_b_bresp,
  input                                             mst4_b_buser,
  input                                             mst4_b_bvalid,
  output                                            mst4_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst4_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst4_ar_araddr,
  output                   [7:0]                    mst4_ar_arlen,
  output                   [2:0]                    mst4_ar_arsize,
  output                   [1:0]                    mst4_ar_arburst,
  output                                            mst4_ar_arlock,
  output                   [3:0]                    mst4_ar_arcache,
  output                   [2:0]                    mst4_ar_arprot,
  output                   [3:0]                    mst4_ar_arqos,
  output                   [3:0]                    mst4_ar_arregion,
  output                                            mst4_ar_aruser,
  output                                            mst4_ar_arvalid,
  input                                             mst4_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH+3-1:0]     mst4_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst4_r_rdata,
  input                    [1:0]                    mst4_r_rresp,
  input                                             mst4_r_rlast,
  input                                             mst4_r_ruser,
  input                                             mst4_r_rvalid,
  output                                            mst4_r_rready, 
  /*********************************************************************/
  // AXI Interface -- master 5
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst5_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst5_aw_awaddr,
  output                   [7:0]                    mst5_aw_awlen,
  output                   [2:0]                    mst5_aw_awsize,
  output                   [1:0]                    mst5_aw_awburst,
  output                                            mst5_aw_awlock,
  output                   [3:0]                    mst5_aw_awcache,
  output                   [2:0]                    mst5_aw_awprot,
  output                   [3:0]                    mst5_aw_awqos,
  output                   [3:0]                    mst5_aw_awregion,
  output                                            mst5_aw_awuser,//
  output                                            mst5_aw_awvalid,
  input                                             mst5_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst5_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst5_w_wstrb,
  output                                            mst5_w_wlast,
  output                                            mst5_w_wuser,
  output                                            mst5_w_wvalid,
  input                                             mst5_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH+3-1:0]     mst5_b_bid,
  input                    [1:0]                    mst5_b_bresp,
  input                                             mst5_b_buser,
  input                                             mst5_b_bvalid,
  output                                            mst5_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst5_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst5_ar_araddr,
  output                   [7:0]                    mst5_ar_arlen,
  output                   [2:0]                    mst5_ar_arsize,
  output                   [1:0]                    mst5_ar_arburst,
  output                                            mst5_ar_arlock,
  output                   [3:0]                    mst5_ar_arcache,
  output                   [2:0]                    mst5_ar_arprot,
  output                   [3:0]                    mst5_ar_arqos,
  output                   [3:0]                    mst5_ar_arregion,
  output                                            mst5_ar_aruser,
  output                                            mst5_ar_arvalid,
  input                                             mst5_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH+3-1:0]     mst5_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst5_r_rdata,
  input                    [1:0]                    mst5_r_rresp,
  input                                             mst5_r_rlast,
  input                                             mst5_r_ruser,
  input                                             mst5_r_rvalid,
  output                                            mst5_r_rready,  
  /*********************************************************************/
  // AXI Interface -- master 6
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst6_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst6_aw_awaddr,
  output                   [7:0]                    mst6_aw_awlen,
  output                   [2:0]                    mst6_aw_awsize,
  output                   [1:0]                    mst6_aw_awburst,
  output                                            mst6_aw_awlock,
  output                   [3:0]                    mst6_aw_awcache,
  output                   [2:0]                    mst6_aw_awprot,
  output                   [3:0]                    mst6_aw_awqos,
  output                   [3:0]                    mst6_aw_awregion,
  output                                            mst6_aw_awuser,//
  output                                            mst6_aw_awvalid,
  input                                             mst6_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst6_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst6_w_wstrb,
  output                                            mst6_w_wlast,
  output                                            mst6_w_wuser,
  output                                            mst6_w_wvalid,
  input                                             mst6_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH+3-1:0]     mst6_b_bid,
  input                    [1:0]                    mst6_b_bresp,
  input                                             mst6_b_buser,
  input                                             mst6_b_bvalid,
  output                                            mst6_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst6_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst6_ar_araddr,
  output                   [7:0]                    mst6_ar_arlen,
  output                   [2:0]                    mst6_ar_arsize,
  output                   [1:0]                    mst6_ar_arburst,
  output                                            mst6_ar_arlock,
  output                   [3:0]                    mst6_ar_arcache,
  output                   [2:0]                    mst6_ar_arprot,
  output                   [3:0]                    mst6_ar_arqos,
  output                   [3:0]                    mst6_ar_arregion,
  output                                            mst6_ar_aruser,
  output                                            mst6_ar_arvalid,
  input                                             mst6_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH+3-1:0]     mst6_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst6_r_rdata,
  input                    [1:0]                    mst6_r_rresp,
  input                                             mst6_r_rlast,
  input                                             mst6_r_ruser,
  input                                             mst6_r_rvalid,
  output                                            mst6_r_rready,  
  /*********************************************************************/
  // AXI Interface -- master 7
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst7_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst7_aw_awaddr,
  output                   [7:0]                    mst7_aw_awlen,
  output                   [2:0]                    mst7_aw_awsize,
  output                   [1:0]                    mst7_aw_awburst,
  output                                            mst7_aw_awlock,
  output                   [3:0]                    mst7_aw_awcache,
  output                   [2:0]                    mst7_aw_awprot,
  output                   [3:0]                    mst7_aw_awqos,
  output                   [3:0]                    mst7_aw_awregion,
  output                                            mst7_aw_awuser,//
  output                                            mst7_aw_awvalid,
  input                                             mst7_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst7_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst7_w_wstrb,
  output                                            mst7_w_wlast,
  output                                            mst7_w_wuser,
  output                                            mst7_w_wvalid,
  input                                             mst7_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH+3-1:0]     mst7_b_bid,
  input                    [1:0]                    mst7_b_bresp,
  input                                             mst7_b_buser,
  input                                             mst7_b_bvalid,
  output                                            mst7_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH+3-1:0]     mst7_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     mst7_ar_araddr,
  output                   [7:0]                    mst7_ar_arlen,
  output                   [2:0]                    mst7_ar_arsize,
  output                   [1:0]                    mst7_ar_arburst,
  output                                            mst7_ar_arlock,
  output                   [3:0]                    mst7_ar_arcache,
  output                   [2:0]                    mst7_ar_arprot,
  output                   [3:0]                    mst7_ar_arqos,
  output                   [3:0]                    mst7_ar_arregion,
  output                                            mst7_ar_aruser,
  output                                            mst7_ar_arvalid,
  input                                             mst7_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH+3-1:0]     mst7_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     mst7_r_rdata,
  input                    [1:0]                    mst7_r_rresp,
  input                                             mst7_r_rlast,
  input                                             mst7_r_ruser,
  input                                             mst7_r_rvalid,
  output                                            mst7_r_rready  
  /*********************************************************************/
);


  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( AXI_ID_WIDTH        ),
    .AXI_USER_WIDTH ( 1                   )
  ) slave[6:0]();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( AXI_ID_WIDTH+3      ),
    .AXI_USER_WIDTH ( 1                   )
  ) master[7:0]();

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
  //slave 2 interface connection
  /*********************************************************************/
  assign slave[2].aw_id     = slv2_aw_awid       ;
  assign slave[2].aw_addr   = slv2_aw_awaddr     ;
  assign slave[2].aw_len    = slv2_aw_awlen      ;
  assign slave[2].aw_size   = slv2_aw_awsize     ;
  assign slave[2].aw_burst  = slv2_aw_awburst    ;
  assign slave[2].aw_lock   = slv2_aw_awlock     ;
  assign slave[2].aw_cache  = slv2_aw_awcache    ;
  assign slave[2].aw_prot   = slv2_aw_awprot     ;
  assign slave[2].aw_qos    = slv2_aw_awqos      ;
  assign slave[2].aw_region = slv2_aw_awregion   ;
  assign slave[2].aw_atop   = 6'd0               ;
  assign slave[2].aw_user   = slv2_aw_awuser     ;
  assign slave[2].aw_valid  = slv2_aw_awvalid    ;
  assign slv2_aw_awready    = slave[2].aw_ready  ;

  assign slave[2].w_data    = slv2_w_wdata       ;
  assign slave[2].w_strb    = slv2_w_wstrb       ;
  assign slave[2].w_last    = slv2_w_wlast       ;
  assign slave[2].w_user    = slv2_w_wuser       ;
  assign slave[2].w_valid   = slv2_w_wvalid      ;
  assign slv2_w_wready      = slave[2].w_ready   ;

  assign slv2_b_bid         = slave[2].b_id      ;
  assign slv2_b_bresp       = slave[2].b_resp    ;
  assign slv2_b_buser       = slave[2].b_user    ;
  assign slv2_b_bvalid      = slave[2].b_valid   ;
  assign slave[2].b_ready   = slv2_b_bready      ;

  assign slave[2].ar_id     = slv2_ar_arid       ;
  assign slave[2].ar_addr   = slv2_ar_araddr     ;
  assign slave[2].ar_len    = slv2_ar_arlen      ;   
  assign slave[2].ar_size   = slv2_ar_arsize     ;
  assign slave[2].ar_burst  = slv2_ar_arburst    ;
  assign slave[2].ar_lock   = slv2_ar_arlock     ;
  assign slave[2].ar_cache  = slv2_ar_arcache    ;
  assign slave[2].ar_prot   = slv2_ar_arprot     ;
  assign slave[2].ar_qos    = slv2_ar_arqos      ;
  assign slave[2].ar_region = slv2_ar_arregion   ;
  assign slave[2].ar_user   = slv2_ar_aruser     ;
  assign slave[2].ar_valid  = slv2_ar_arvalid    ;
  assign slv2_ar_arready    = slave[2].ar_ready  ;

  assign slv2_r_rid         = slave[2].r_id      ;
  assign slv2_r_rdata       = slave[2].r_data    ;
  assign slv2_r_rresp       = slave[2].r_resp    ;
  assign slv2_r_rlast       = slave[2].r_last    ;
  assign slv2_r_ruser       = slave[2].r_user    ;
  assign slv2_r_rvalid      = slave[2].r_valid   ;
  assign slave[2].r_ready   = slv2_r_rready      ;
  /*********************************************************************/
  //slave 3 interface connection
  /*********************************************************************/
  assign slave[3].aw_id     = slv3_aw_awid       ;
  assign slave[3].aw_addr   = slv3_aw_awaddr     ;
  assign slave[3].aw_len    = slv3_aw_awlen      ;
  assign slave[3].aw_size   = slv3_aw_awsize     ;
  assign slave[3].aw_burst  = slv3_aw_awburst    ;
  assign slave[3].aw_lock   = slv3_aw_awlock     ;
  assign slave[3].aw_cache  = slv3_aw_awcache    ;
  assign slave[3].aw_prot   = slv3_aw_awprot     ;
  assign slave[3].aw_qos    = slv3_aw_awqos      ;
  assign slave[3].aw_region = slv3_aw_awregion   ;
  assign slave[3].aw_atop   = 6'd0               ;
  assign slave[3].aw_user   = slv3_aw_awuser     ;
  assign slave[3].aw_valid  = slv3_aw_awvalid    ;
  assign slv3_aw_awready    = slave[3].aw_ready  ;

  assign slave[3].w_data    = slv3_w_wdata       ;
  assign slave[3].w_strb    = slv3_w_wstrb       ;
  assign slave[3].w_last    = slv3_w_wlast       ;
  assign slave[3].w_user    = slv3_w_wuser       ;
  assign slave[3].w_valid   = slv3_w_wvalid      ;
  assign slv3_w_wready      = slave[3].w_ready   ;

  assign slv3_b_bid         = slave[3].b_id      ;
  assign slv3_b_bresp       = slave[3].b_resp    ;
  assign slv3_b_buser       = slave[3].b_user    ;
  assign slv3_b_bvalid      = slave[3].b_valid   ;
  assign slave[3].b_ready   = slv3_b_bready      ;

  assign slave[3].ar_id     = slv3_ar_arid       ;
  assign slave[3].ar_addr   = slv3_ar_araddr     ;
  assign slave[3].ar_len    = slv3_ar_arlen      ;   
  assign slave[3].ar_size   = slv3_ar_arsize     ;
  assign slave[3].ar_burst  = slv3_ar_arburst    ;
  assign slave[3].ar_lock   = slv3_ar_arlock     ;
  assign slave[3].ar_cache  = slv3_ar_arcache    ;
  assign slave[3].ar_prot   = slv3_ar_arprot     ;
  assign slave[3].ar_qos    = slv3_ar_arqos      ;
  assign slave[3].ar_region = slv3_ar_arregion   ;
  assign slave[3].ar_user   = slv3_ar_aruser     ;
  assign slave[3].ar_valid  = slv3_ar_arvalid    ;
  assign slv3_ar_arready    = slave[3].ar_ready  ;

  assign slv3_r_rid         = slave[3].r_id      ;
  assign slv3_r_rdata       = slave[3].r_data    ;
  assign slv3_r_rresp       = slave[3].r_resp    ;
  assign slv3_r_rlast       = slave[3].r_last    ;
  assign slv3_r_ruser       = slave[3].r_user    ;
  assign slv3_r_rvalid      = slave[3].r_valid   ;
  assign slave[3].r_ready   = slv3_r_rready      ;
  /*********************************************************************/
  //slave 4 interface connection
  /*********************************************************************/
  assign slave[4].aw_id     = slv4_aw_awid       ;
  assign slave[4].aw_addr   = slv4_aw_awaddr     ;
  assign slave[4].aw_len    = slv4_aw_awlen      ;
  assign slave[4].aw_size   = slv4_aw_awsize     ;
  assign slave[4].aw_burst  = slv4_aw_awburst    ;
  assign slave[4].aw_lock   = slv4_aw_awlock     ;
  assign slave[4].aw_cache  = slv4_aw_awcache    ;
  assign slave[4].aw_prot   = slv4_aw_awprot     ;
  assign slave[4].aw_qos    = slv4_aw_awqos      ;
  assign slave[4].aw_region = slv4_aw_awregion   ;
  assign slave[4].aw_atop   = 6'd0               ;
  assign slave[4].aw_user   = slv4_aw_awuser     ;
  assign slave[4].aw_valid  = slv4_aw_awvalid    ;
  assign slv4_aw_awready    = slave[4].aw_ready  ;

  assign slave[4].w_data    = slv4_w_wdata       ;
  assign slave[4].w_strb    = slv4_w_wstrb       ;
  assign slave[4].w_last    = slv4_w_wlast       ;
  assign slave[4].w_user    = slv4_w_wuser       ;
  assign slave[4].w_valid   = slv4_w_wvalid      ;
  assign slv4_w_wready      = slave[4].w_ready   ;

  assign slv4_b_bid         = slave[4].b_id      ;
  assign slv4_b_bresp       = slave[4].b_resp    ;
  assign slv4_b_buser       = slave[4].b_user    ;
  assign slv4_b_bvalid      = slave[4].b_valid   ;
  assign slave[4].b_ready   = slv4_b_bready      ;

  assign slave[4].ar_id     = slv4_ar_arid       ;
  assign slave[4].ar_addr   = slv4_ar_araddr     ;
  assign slave[4].ar_len    = slv4_ar_arlen      ;   
  assign slave[4].ar_size   = slv4_ar_arsize     ;
  assign slave[4].ar_burst  = slv4_ar_arburst    ;
  assign slave[4].ar_lock   = slv4_ar_arlock     ;
  assign slave[4].ar_cache  = slv4_ar_arcache    ;
  assign slave[4].ar_prot   = slv4_ar_arprot     ;
  assign slave[4].ar_qos    = slv4_ar_arqos      ;
  assign slave[4].ar_region = slv4_ar_arregion   ;
  assign slave[4].ar_user   = slv4_ar_aruser     ;
  assign slave[4].ar_valid  = slv4_ar_arvalid    ;
  assign slv4_ar_arready    = slave[4].ar_ready  ;

  assign slv4_r_rid         = slave[4].r_id      ;
  assign slv4_r_rdata       = slave[4].r_data    ;
  assign slv4_r_rresp       = slave[4].r_resp    ;
  assign slv4_r_rlast       = slave[4].r_last    ;
  assign slv4_r_ruser       = slave[4].r_user    ;
  assign slv4_r_rvalid      = slave[4].r_valid   ;
  assign slave[4].r_ready   = slv4_r_rready      ;
  /*********************************************************************/
  //slave 5 interface connection
  /*********************************************************************/
  assign slave[5].aw_id     = slv5_aw_awid       ;
  assign slave[5].aw_addr   = slv5_aw_awaddr     ;
  assign slave[5].aw_len    = slv5_aw_awlen      ;
  assign slave[5].aw_size   = slv5_aw_awsize     ;
  assign slave[5].aw_burst  = slv5_aw_awburst    ;
  assign slave[5].aw_lock   = slv5_aw_awlock     ;
  assign slave[5].aw_cache  = slv5_aw_awcache    ;
  assign slave[5].aw_prot   = slv5_aw_awprot     ;
  assign slave[5].aw_qos    = slv5_aw_awqos      ;
  assign slave[5].aw_region = slv5_aw_awregion   ;
  assign slave[5].aw_atop   = 6'd0               ;
  assign slave[5].aw_user   = slv5_aw_awuser     ;
  assign slave[5].aw_valid  = slv5_aw_awvalid    ;
  assign slv5_aw_awready    = slave[5].aw_ready  ;

  assign slave[5].w_data    = slv5_w_wdata       ;
  assign slave[5].w_strb    = slv5_w_wstrb       ;
  assign slave[5].w_last    = slv5_w_wlast       ;
  assign slave[5].w_user    = slv5_w_wuser       ;
  assign slave[5].w_valid   = slv5_w_wvalid      ;
  assign slv5_w_wready      = slave[5].w_ready   ;

  assign slv5_b_bid         = slave[5].b_id      ;
  assign slv5_b_bresp       = slave[5].b_resp    ;
  assign slv5_b_buser       = slave[5].b_user    ;
  assign slv5_b_bvalid      = slave[5].b_valid   ;
  assign slave[5].b_ready   = slv5_b_bready      ;

  assign slave[5].ar_id     = slv5_ar_arid       ;
  assign slave[5].ar_addr   = slv5_ar_araddr     ;
  assign slave[5].ar_len    = slv5_ar_arlen      ;   
  assign slave[5].ar_size   = slv5_ar_arsize     ;
  assign slave[5].ar_burst  = slv5_ar_arburst    ;
  assign slave[5].ar_lock   = slv5_ar_arlock     ;
  assign slave[5].ar_cache  = slv5_ar_arcache    ;
  assign slave[5].ar_prot   = slv5_ar_arprot     ;
  assign slave[5].ar_qos    = slv5_ar_arqos      ;
  assign slave[5].ar_region = slv5_ar_arregion   ;
  assign slave[5].ar_user   = slv5_ar_aruser     ;
  assign slave[5].ar_valid  = slv5_ar_arvalid    ;
  assign slv5_ar_arready    = slave[5].ar_ready  ;

  assign slv5_r_rid         = slave[5].r_id      ;
  assign slv5_r_rdata       = slave[5].r_data    ;
  assign slv5_r_rresp       = slave[5].r_resp    ;
  assign slv5_r_rlast       = slave[5].r_last    ;
  assign slv5_r_ruser       = slave[5].r_user    ;
  assign slv5_r_rvalid      = slave[5].r_valid   ;
  assign slave[5].r_ready   = slv5_r_rready      ;
  /*********************************************************************/
  //slave 6 interface connection
  /*********************************************************************/
  assign slave[6].aw_id     = slv6_aw_awid       ;
  assign slave[6].aw_addr   = slv6_aw_awaddr     ;
  assign slave[6].aw_len    = slv6_aw_awlen      ;
  assign slave[6].aw_size   = slv6_aw_awsize     ;
  assign slave[6].aw_burst  = slv6_aw_awburst    ;
  assign slave[6].aw_lock   = slv6_aw_awlock     ;
  assign slave[6].aw_cache  = slv6_aw_awcache    ;
  assign slave[6].aw_prot   = slv6_aw_awprot     ;
  assign slave[6].aw_qos    = slv6_aw_awqos      ;
  assign slave[6].aw_region = slv6_aw_awregion   ;
  assign slave[6].aw_atop   = 6'd0               ;
  assign slave[6].aw_user   = slv6_aw_awuser     ;
  assign slave[6].aw_valid  = slv6_aw_awvalid    ;
  assign slv6_aw_awready    = slave[6].aw_ready  ;

  assign slave[6].w_data    = slv6_w_wdata       ;
  assign slave[6].w_strb    = slv6_w_wstrb       ;
  assign slave[6].w_last    = slv6_w_wlast       ;
  assign slave[6].w_user    = slv6_w_wuser       ;
  assign slave[6].w_valid   = slv6_w_wvalid      ;
  assign slv6_w_wready      = slave[6].w_ready   ;

  assign slv6_b_bid         = slave[6].b_id      ;
  assign slv6_b_bresp       = slave[6].b_resp    ;
  assign slv6_b_buser       = slave[6].b_user    ;
  assign slv6_b_bvalid      = slave[6].b_valid   ;
  assign slave[6].b_ready   = slv6_b_bready      ;

  assign slave[6].ar_id     = slv6_ar_arid       ;
  assign slave[6].ar_addr   = slv6_ar_araddr     ;
  assign slave[6].ar_len    = slv6_ar_arlen      ;   
  assign slave[6].ar_size   = slv6_ar_arsize     ;
  assign slave[6].ar_burst  = slv6_ar_arburst    ;
  assign slave[6].ar_lock   = slv6_ar_arlock     ;
  assign slave[6].ar_cache  = slv6_ar_arcache    ;
  assign slave[6].ar_prot   = slv6_ar_arprot     ;
  assign slave[6].ar_qos    = slv6_ar_arqos      ;
  assign slave[6].ar_region = slv6_ar_arregion   ;
  assign slave[6].ar_user   = slv6_ar_aruser     ;
  assign slave[6].ar_valid  = slv6_ar_arvalid    ;
  assign slv6_ar_arready    = slave[6].ar_ready  ;

  assign slv6_r_rid         = slave[6].r_id      ;
  assign slv6_r_rdata       = slave[6].r_data    ;
  assign slv6_r_rresp       = slave[6].r_resp    ;
  assign slv6_r_rlast       = slave[6].r_last    ;
  assign slv6_r_ruser       = slave[6].r_user    ;
  assign slv6_r_rvalid      = slave[6].r_valid   ;
  assign slave[6].r_ready   = slv6_r_rready      ;
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
  //master 4 interface connection
  /*********************************************************************/
  assign mst4_aw_awid       = master[4].aw_id        ;
  assign mst4_aw_awaddr     = master[4].aw_addr      ;
  assign mst4_aw_awlen      = master[4].aw_len       ;
  assign mst4_aw_awsize     = master[4].aw_size      ;
  assign mst4_aw_awburst    = master[4].aw_burst     ;
  assign mst4_aw_awlock     = master[4].aw_lock      ;
  assign mst4_aw_awcache    = master[4].aw_cache     ;
  assign mst4_aw_awprot     = master[4].aw_prot      ;
  assign mst4_aw_awqos      = master[4].aw_qos       ;
  assign mst4_aw_awregion   = master[4].aw_region    ;
  assign mst4_aw_awuser     = master[4].aw_user      ;
  assign mst4_aw_awvalid    = master[4].aw_valid     ;
  assign master[4].aw_ready = mst4_aw_awready        ;

  assign mst4_w_wdata       = master[4].w_data       ;
  assign mst4_w_wstrb       = master[4].w_strb       ;
  assign mst4_w_wlast       = master[4].w_last       ;
  assign mst4_w_wuser       = master[4].w_user       ;
  assign mst4_w_wvalid      = master[4].w_valid      ;
  assign master[4].w_ready  = mst4_w_wready          ;

  assign master[4].b_id     = mst4_b_bid             ;
  assign master[4].b_resp   = mst4_b_bresp           ;
  assign master[4].b_user   = mst4_b_buser           ;
  assign master[4].b_valid  = mst4_b_bvalid          ;
  assign mst4_b_bready      = master[4].b_ready      ;

  assign mst4_ar_arid       = master[4].ar_id        ;
  assign mst4_ar_araddr     = master[4].ar_addr      ;
  assign mst4_ar_arlen      = master[4].ar_len       ;   
  assign mst4_ar_arsize     = master[4].ar_size      ;
  assign mst4_ar_arburst    = master[4].ar_burst     ;
  assign mst4_ar_arlock     = master[4].ar_lock      ;
  assign mst4_ar_arcache    = master[4].ar_cache     ;
  assign mst4_ar_arprot     = master[4].ar_prot      ;
  assign mst4_ar_arqos      = master[4].ar_qos       ;
  assign mst4_ar_arregion   = master[4].ar_region    ;
  assign mst4_ar_aruser     = master[4].ar_user      ;
  assign mst4_ar_arvalid    = master[4].ar_valid     ;
  assign master[4].ar_ready = mst4_ar_arready        ;

  assign master[4].r_id     = mst4_r_rid             ;
  assign master[4].r_data   = mst4_r_rdata           ;
  assign master[4].r_resp   = mst4_r_rresp           ;
  assign master[4].r_last   = mst4_r_rlast           ;
  assign master[4].r_user   = mst4_r_ruser           ;
  assign master[4].r_valid  = mst4_r_rvalid          ;
  assign mst4_r_rready      = master[4].r_ready      ;
  /*********************************************************************/
  //master 5 interface connection
  /*********************************************************************/
  assign mst5_aw_awid       = master[5].aw_id        ;
  assign mst5_aw_awaddr     = master[5].aw_addr      ;
  assign mst5_aw_awlen      = master[5].aw_len       ;
  assign mst5_aw_awsize     = master[5].aw_size      ;
  assign mst5_aw_awburst    = master[5].aw_burst     ;
  assign mst5_aw_awlock     = master[5].aw_lock      ;
  assign mst5_aw_awcache    = master[5].aw_cache     ;
  assign mst5_aw_awprot     = master[5].aw_prot      ;
  assign mst5_aw_awqos      = master[5].aw_qos       ;
  assign mst5_aw_awregion   = master[5].aw_region    ;
  assign mst5_aw_awuser     = master[5].aw_user      ;
  assign mst5_aw_awvalid    = master[5].aw_valid     ;
  assign master[5].aw_ready = mst5_aw_awready        ;

  assign mst5_w_wdata       = master[5].w_data       ;
  assign mst5_w_wstrb       = master[5].w_strb       ;
  assign mst5_w_wlast       = master[5].w_last       ;
  assign mst5_w_wuser       = master[5].w_user       ;
  assign mst5_w_wvalid      = master[5].w_valid      ;
  assign master[5].w_ready  = mst5_w_wready          ;

  assign master[5].b_id     = mst5_b_bid             ;
  assign master[5].b_resp   = mst5_b_bresp           ;
  assign master[5].b_user   = mst5_b_buser           ;
  assign master[5].b_valid  = mst5_b_bvalid          ;
  assign mst5_b_bready      = master[5].b_ready      ;

  assign mst5_ar_arid       = master[5].ar_id        ;
  assign mst5_ar_araddr     = master[5].ar_addr      ;
  assign mst5_ar_arlen      = master[5].ar_len       ;   
  assign mst5_ar_arsize     = master[5].ar_size      ;
  assign mst5_ar_arburst    = master[5].ar_burst     ;
  assign mst5_ar_arlock     = master[5].ar_lock      ;
  assign mst5_ar_arcache    = master[5].ar_cache     ;
  assign mst5_ar_arprot     = master[5].ar_prot      ;
  assign mst5_ar_arqos      = master[5].ar_qos       ;
  assign mst5_ar_arregion   = master[5].ar_region    ;
  assign mst5_ar_aruser     = master[5].ar_user      ;
  assign mst5_ar_arvalid    = master[5].ar_valid     ;
  assign master[5].ar_ready = mst5_ar_arready        ;

  assign master[5].r_id     = mst5_r_rid             ;
  assign master[5].r_data   = mst5_r_rdata           ;
  assign master[5].r_resp   = mst5_r_rresp           ;
  assign master[5].r_last   = mst5_r_rlast           ;
  assign master[5].r_user   = mst5_r_ruser           ;
  assign master[5].r_valid  = mst5_r_rvalid          ;
  assign mst5_r_rready      = master[5].r_ready      ;
  /*********************************************************************/
  //master 6 interface connection
  /*********************************************************************/
  assign mst6_aw_awid       = master[6].aw_id        ;
  assign mst6_aw_awaddr     = master[6].aw_addr      ;
  assign mst6_aw_awlen      = master[6].aw_len       ;
  assign mst6_aw_awsize     = master[6].aw_size      ;
  assign mst6_aw_awburst    = master[6].aw_burst     ;
  assign mst6_aw_awlock     = master[6].aw_lock      ;
  assign mst6_aw_awcache    = master[6].aw_cache     ;
  assign mst6_aw_awprot     = master[6].aw_prot      ;
  assign mst6_aw_awqos      = master[6].aw_qos       ;
  assign mst6_aw_awregion   = master[6].aw_region    ;
  assign mst6_aw_awuser     = master[6].aw_user      ;
  assign mst6_aw_awvalid    = master[6].aw_valid     ;
  assign master[6].aw_ready = mst6_aw_awready        ;

  assign mst6_w_wdata       = master[6].w_data       ;
  assign mst6_w_wstrb       = master[6].w_strb       ;
  assign mst6_w_wlast       = master[6].w_last       ;
  assign mst6_w_wuser       = master[6].w_user       ;
  assign mst6_w_wvalid      = master[6].w_valid      ;
  assign master[6].w_ready  = mst6_w_wready          ;

  assign master[6].b_id     = mst6_b_bid             ;
  assign master[6].b_resp   = mst6_b_bresp           ;
  assign master[6].b_user   = mst6_b_buser           ;
  assign master[6].b_valid  = mst6_b_bvalid          ;
  assign mst6_b_bready      = master[6].b_ready      ;

  assign mst6_ar_arid       = master[6].ar_id        ;
  assign mst6_ar_araddr     = master[6].ar_addr      ;
  assign mst6_ar_arlen      = master[6].ar_len       ;   
  assign mst6_ar_arsize     = master[6].ar_size      ;
  assign mst6_ar_arburst    = master[6].ar_burst     ;
  assign mst6_ar_arlock     = master[6].ar_lock      ;
  assign mst6_ar_arcache    = master[6].ar_cache     ;
  assign mst6_ar_arprot     = master[6].ar_prot      ;
  assign mst6_ar_arqos      = master[6].ar_qos       ;
  assign mst6_ar_arregion   = master[6].ar_region    ;
  assign mst6_ar_aruser     = master[6].ar_user      ;
  assign mst6_ar_arvalid    = master[6].ar_valid     ;
  assign master[6].ar_ready = mst6_ar_arready        ;

  assign master[6].r_id     = mst6_r_rid             ;
  assign master[6].r_data   = mst6_r_rdata           ;
  assign master[6].r_resp   = mst6_r_rresp           ;
  assign master[6].r_last   = mst6_r_rlast           ;
  assign master[6].r_user   = mst6_r_ruser           ;
  assign master[6].r_valid  = mst6_r_rvalid          ;
  assign mst6_r_rready      = master[6].r_ready      ;
  /*********************************************************************/
  //master 7 interface connection
  /*********************************************************************/
  assign mst7_aw_awid       = master[7].aw_id        ;
  assign mst7_aw_awaddr     = master[7].aw_addr      ;
  assign mst7_aw_awlen      = master[7].aw_len       ;
  assign mst7_aw_awsize     = master[7].aw_size      ;
  assign mst7_aw_awburst    = master[7].aw_burst     ;
  assign mst7_aw_awlock     = master[7].aw_lock      ;
  assign mst7_aw_awcache    = master[7].aw_cache     ;
  assign mst7_aw_awprot     = master[7].aw_prot      ;
  assign mst7_aw_awqos      = master[7].aw_qos       ;
  assign mst7_aw_awregion   = master[7].aw_region    ;
  assign mst7_aw_awuser     = master[7].aw_user      ;
  assign mst7_aw_awvalid    = master[7].aw_valid     ;
  assign master[7].aw_ready = mst7_aw_awready        ;

  assign mst7_w_wdata       = master[7].w_data       ;
  assign mst7_w_wstrb       = master[7].w_strb       ;
  assign mst7_w_wlast       = master[7].w_last       ;
  assign mst7_w_wuser       = master[7].w_user       ;
  assign mst7_w_wvalid      = master[7].w_valid      ;
  assign master[7].w_ready  = mst7_w_wready          ;

  assign master[7].b_id     = mst7_b_bid             ;
  assign master[7].b_resp   = mst7_b_bresp           ;
  assign master[7].b_user   = mst7_b_buser           ;
  assign master[7].b_valid  = mst7_b_bvalid          ;
  assign mst7_b_bready      = master[7].b_ready      ;

  assign mst7_ar_arid       = master[7].ar_id        ;
  assign mst7_ar_araddr     = master[7].ar_addr      ;
  assign mst7_ar_arlen      = master[7].ar_len       ;   
  assign mst7_ar_arsize     = master[7].ar_size      ;
  assign mst7_ar_arburst    = master[7].ar_burst     ;
  assign mst7_ar_arlock     = master[7].ar_lock      ;
  assign mst7_ar_arcache    = master[7].ar_cache     ;
  assign mst7_ar_arprot     = master[7].ar_prot      ;
  assign mst7_ar_arqos      = master[7].ar_qos       ;
  assign mst7_ar_arregion   = master[7].ar_region    ;
  assign mst7_ar_aruser     = master[7].ar_user      ;
  assign mst7_ar_arvalid    = master[7].ar_valid     ;
  assign master[7].ar_ready = mst7_ar_arready        ;

  assign master[7].r_id     = mst7_r_rid             ;
  assign master[7].r_data   = mst7_r_rdata           ;
  assign master[7].r_resp   = mst7_r_rresp           ;
  assign master[7].r_last   = mst7_r_rlast           ;
  assign master[7].r_user   = mst7_r_ruser           ;
  assign master[7].r_valid  = mst7_r_rvalid          ;
  assign mst7_r_rready      = master[7].r_ready      ;
  /*********************************************************************/


  // ---------------
  // AXI Xbar
  // ---------------
  axi_node_intf_wrap #(
    .NB_SLAVE           ( 7               ),
    .NB_MASTER          ( 8               ),
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
	  64'h40460000,
	  64'h80000000,
	  64'h40600000,
      64'h40400000,
      64'h40450000,
      64'h40a00000,
      64'h40b00000,
      64'h40000000
    }),
    .end_addr_i   ({
	  64'h4046ffff,
	  64'hffffffff,
	  64'h409fffff,
      64'h4043ffff,
      64'h4045ffff,
      64'h40abffff,
      64'h44afffff,
      64'h403fffff
    }),
    .valid_rule_i (8'hff)
  );



endmodule
