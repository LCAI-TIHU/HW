// Copyright (c) 2019 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Authors:
// - Wolfgang Roenninger <wroennin@iis.ee.ethz.ch>
// - Andreas Kurth <akurth@iis.ee.ethz.ch>
// - Florian Zaruba <zarubaf@iis.ee.ethz.ch>


`include "axi/assign.svh"
`include "axi/typedef.svh"

module core_axi_xbar #(
  parameter int unsigned AXI_ADDR_WIDTH    = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 256,
  parameter int unsigned AXI_ID_WIDTH      = 4,
  parameter int unsigned AXI_USER_WIDTH    = 1
) (
  input                                             clk_i,
  input                                             rst_ni,
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
  output                                            mst6_r_rready  
  /*********************************************************************/
);

  localparam axi_pkg::xbar_cfg_t XBarCfg = '{
    NoSlvPorts        : 5,
    NoMstPorts        : 7,
    MaxMstTrans       : 4,
    MaxSlvTrans       : 4,
    FallThrough       : 1'b0,
    LatencyMode       : axi_pkg::CUT_MST_PORTS,
    AxiIdWidthSlvPorts: AXI_ID_WIDTH,
    AxiIdUsedSlvPorts : AXI_ID_WIDTH,
    UniqueIds         : 1'b0,
    AxiAddrWidth      : AXI_ADDR_WIDTH,
    AxiDataWidth      : AXI_DATA_WIDTH,
    NoAddrRules       : 7
  };

  axi_pkg::xbar_rule_64_t [7-1:0] routing_rules;
  assign routing_rules = '{
    '{idx: 0, start_addr: 64'h40460000, end_addr: 64'h4046ffff},
    '{idx: 1, start_addr: 64'h80000000, end_addr: 64'hffffffff},
    '{idx: 2, start_addr: 64'h40600000, end_addr: 64'h409fffff},
    '{idx: 3, start_addr: 64'h40400000, end_addr: 64'h4043ffff},
    '{idx: 4, start_addr: 64'h40a00000, end_addr: 64'h40abffff},
    '{idx: 5, start_addr: 64'h40b00000, end_addr: 64'h44afffff},
    '{idx: 6, start_addr: 64'h40000000, end_addr: 64'h403fffff}
  };

  localparam int unsigned AxiIdWidthMstPorts = XBarCfg.AxiIdWidthSlvPorts + $clog2(XBarCfg.NoSlvPorts);

  typedef logic [AxiIdWidthMstPorts         -1:0] id_mst_t;
  typedef logic [XBarCfg.AxiIdWidthSlvPorts -1:0] id_slv_t;
  typedef logic [XBarCfg.AxiAddrWidth       -1:0] addr_t;
  typedef logic [XBarCfg.AxiDataWidth       -1:0] data_t;
  typedef logic [XBarCfg.AxiDataWidth/8     -1:0] strb_t;
  typedef logic [AXI_USER_WIDTH             -1:0] user_t;

  `AXI_TYPEDEF_AW_CHAN_T(mst_aw_chan_t, addr_t, id_mst_t, user_t)
  `AXI_TYPEDEF_AW_CHAN_T(slv_aw_chan_t, addr_t, id_slv_t, user_t)
  `AXI_TYPEDEF_W_CHAN_T(w_chan_t, data_t, strb_t, user_t)
  `AXI_TYPEDEF_B_CHAN_T(mst_b_chan_t, id_mst_t, user_t)
  `AXI_TYPEDEF_B_CHAN_T(slv_b_chan_t, id_slv_t, user_t)
  `AXI_TYPEDEF_AR_CHAN_T(mst_ar_chan_t, addr_t, id_mst_t, user_t)
  `AXI_TYPEDEF_AR_CHAN_T(slv_ar_chan_t, addr_t, id_slv_t, user_t)
  `AXI_TYPEDEF_R_CHAN_T(mst_r_chan_t, data_t, id_mst_t, user_t)
  `AXI_TYPEDEF_R_CHAN_T(slv_r_chan_t, data_t, id_slv_t, user_t)
  `AXI_TYPEDEF_REQ_T(mst_req_t, mst_aw_chan_t, w_chan_t, mst_ar_chan_t)
  `AXI_TYPEDEF_REQ_T(slv_req_t, slv_aw_chan_t, w_chan_t, slv_ar_chan_t)
  `AXI_TYPEDEF_RESP_T(mst_resp_t, mst_b_chan_t, mst_r_chan_t)
  `AXI_TYPEDEF_RESP_T(slv_resp_t, slv_b_chan_t, slv_r_chan_t)

  mst_req_t   [XBarCfg.NoMstPorts-1:0]  mst_reqs;
  mst_resp_t  [XBarCfg.NoMstPorts-1:0]  mst_resps;
  slv_req_t   [XBarCfg.NoSlvPorts-1:0]  slv_reqs;
  slv_resp_t  [XBarCfg.NoSlvPorts-1:0]  slv_resps;

  //for (genvar i = 0; i < XBarCfg.NoMstPorts; i++) begin : gen_assign_mst
  //  `AXI_ASSIGN_FROM_REQ(mst_ports[i], mst_reqs[i])
  //  `AXI_ASSIGN_TO_RESP(mst_resps[i], mst_ports[i])
  //end

  //for (genvar i = 0; i < XBarCfg.NoSlvPorts; i++) begin : gen_assign_slv
  //  `AXI_ASSIGN_TO_REQ(slv_reqs[i], slv_ports[i])
  //  `AXI_ASSIGN_FROM_RESP(slv_ports[i], slv_resps[i])
  //end
  
  
  //AXI slave0 interface connection
  /*********************************************************************/
  /*request*/
  assign slv_reqs[0].aw.id     = slv0_aw_awid       ;
  assign slv_reqs[0].aw.addr   = slv0_aw_awaddr     ;
  assign slv_reqs[0].aw.len    = slv0_aw_awlen      ;
  assign slv_reqs[0].aw.size   = slv0_aw_awsize     ;
  assign slv_reqs[0].aw.burst  = slv0_aw_awburst    ;
  assign slv_reqs[0].aw.lock   = slv0_aw_awlock     ;
  assign slv_reqs[0].aw.cache  = slv0_aw_awcache    ;
  assign slv_reqs[0].aw.prot   = slv0_aw_awprot     ;
  assign slv_reqs[0].aw.region = slv0_aw_awregion   ;
  assign slv_reqs[0].aw.qos    = slv0_aw_awqos      ;
  assign slv_reqs[0].aw.atop   = 6'd0              ;
  assign slv_reqs[0].aw.user   = slv0_aw_awuser     ;
  assign slv_reqs[0].aw_valid  = slv0_aw_awvalid    ;

  assign slv_reqs[0].w.data    = slv0_w_wdata       ;
  assign slv_reqs[0].w.strb    = slv0_w_wstrb       ;
  assign slv_reqs[0].w.last    = slv0_w_wlast       ;
  assign slv_reqs[0].w.user    = slv0_w_wuser       ;
  assign slv_reqs[0].w_valid   = slv0_w_wvalid      ;

  assign slv_reqs[0].b_ready   = slv0_b_bready      ;

  assign slv_reqs[0].ar.id     = slv0_ar_arid       ;
  assign slv_reqs[0].ar.addr   = slv0_ar_araddr     ;
  assign slv_reqs[0].ar.len    = slv0_ar_arlen      ;   
  assign slv_reqs[0].ar.size   = slv0_ar_arsize     ;
  assign slv_reqs[0].ar.burst  = slv0_ar_arburst    ;
  assign slv_reqs[0].ar.lock   = slv0_ar_arlock     ;
  assign slv_reqs[0].ar.cache  = slv0_ar_arcache    ;
  assign slv_reqs[0].ar.prot   = slv0_ar_arprot     ;
  assign slv_reqs[0].ar.region = slv0_ar_arregion   ;
  assign slv_reqs[0].ar.qos    = slv0_ar_arqos      ;
  assign slv_reqs[0].ar.user   = slv0_ar_aruser     ;
  assign slv_reqs[0].ar_valid  = slv0_ar_arvalid    ;

  assign slv_reqs[0].r_ready   = slv0_r_rready      ;

  /*response*/
  assign slv0_aw_awready       = slv_resps[0].aw_ready ;

  assign slv0_w_wready         = slv_resps[0].w_ready  ;

  assign slv0_b_bid            = slv_resps[0].b.id     ;
  assign slv0_b_bresp          = slv_resps[0].b.resp   ;
  assign slv0_b_buser          = slv_resps[0].b.user   ;
  assign slv0_b_bvalid         = slv_resps[0].b_valid  ;

  assign slv0_ar_arready       = slv_resps[0].ar_ready ;

  assign slv0_r_rid            = slv_resps[0].r.id     ;
  assign slv0_r_rdata          = slv_resps[0].r.data   ;
  assign slv0_r_rresp          = slv_resps[0].r.resp   ;
  assign slv0_r_rlast          = slv_resps[0].r.last   ;
  assign slv0_r_ruser          = slv_resps[0].r.user   ;
  assign slv0_r_rvalid         = slv_resps[0].r_valid  ;
  /*********************************************************************/
  //AXI slave1 interface connection
  /*********************************************************************/
  /*request*/
  assign slv_reqs[1].aw.id     = slv1_aw_awid       ;
  assign slv_reqs[1].aw.addr   = slv1_aw_awaddr     ;
  assign slv_reqs[1].aw.len    = slv1_aw_awlen      ;
  assign slv_reqs[1].aw.size   = slv1_aw_awsize     ;
  assign slv_reqs[1].aw.burst  = slv1_aw_awburst    ;
  assign slv_reqs[1].aw.lock   = slv1_aw_awlock     ;
  assign slv_reqs[1].aw.cache  = slv1_aw_awcache    ;
  assign slv_reqs[1].aw.prot   = slv1_aw_awprot     ;
  assign slv_reqs[1].aw.region = slv1_aw_awregion   ;
  assign slv_reqs[1].aw.qos    = slv1_aw_awqos      ;
  assign slv_reqs[1].aw.atop   = 6'd0              ;
  assign slv_reqs[1].aw.user   = slv1_aw_awuser     ;
  assign slv_reqs[1].aw_valid  = slv1_aw_awvalid    ;

  assign slv_reqs[1].w.data    = slv1_w_wdata       ;
  assign slv_reqs[1].w.strb    = slv1_w_wstrb       ;
  assign slv_reqs[1].w.last    = slv1_w_wlast       ;
  assign slv_reqs[1].w.user    = slv1_w_wuser       ;
  assign slv_reqs[1].w_valid   = slv1_w_wvalid      ;

  assign slv_reqs[1].b_ready   = slv1_b_bready      ;

  assign slv_reqs[1].ar.id     = slv1_ar_arid       ;
  assign slv_reqs[1].ar.addr   = slv1_ar_araddr     ;
  assign slv_reqs[1].ar.len    = slv1_ar_arlen      ;   
  assign slv_reqs[1].ar.size   = slv1_ar_arsize     ;
  assign slv_reqs[1].ar.burst  = slv1_ar_arburst    ;
  assign slv_reqs[1].ar.lock   = slv1_ar_arlock     ;
  assign slv_reqs[1].ar.cache  = slv1_ar_arcache    ;
  assign slv_reqs[1].ar.prot   = slv1_ar_arprot     ;
  assign slv_reqs[1].ar.region = slv1_ar_arregion   ;
  assign slv_reqs[1].ar.qos    = slv1_ar_arqos      ;
  assign slv_reqs[1].ar.user   = slv1_ar_aruser     ;
  assign slv_reqs[1].ar_valid  = slv1_ar_arvalid    ;

  assign slv_reqs[1].r_ready   = slv1_r_rready      ;

  /*response*/
  assign slv1_aw_awready       = slv_resps[1].aw_ready ;

  assign slv1_w_wready         = slv_resps[1].w_ready  ;

  assign slv1_b_bid            = slv_resps[1].b.id     ;
  assign slv1_b_bresp          = slv_resps[1].b.resp   ;
  assign slv1_b_buser          = slv_resps[1].b.user   ;
  assign slv1_b_bvalid         = slv_resps[1].b_valid  ;

  assign slv1_ar_arready       = slv_resps[1].ar_ready ;

  assign slv1_r_rid            = slv_resps[1].r.id     ;
  assign slv1_r_rdata          = slv_resps[1].r.data   ;
  assign slv1_r_rresp          = slv_resps[1].r.resp   ;
  assign slv1_r_rlast          = slv_resps[1].r.last   ;
  assign slv1_r_ruser          = slv_resps[1].r.user   ;
  assign slv1_r_rvalid         = slv_resps[1].r_valid  ;
  /*********************************************************************/
  //AXI slave2 interface connection
  /*********************************************************************/
  /*request*/
  assign slv_reqs[2].aw.id     = slv2_aw_awid       ;
  assign slv_reqs[2].aw.addr   = slv2_aw_awaddr     ;
  assign slv_reqs[2].aw.len    = slv2_aw_awlen      ;
  assign slv_reqs[2].aw.size   = slv2_aw_awsize     ;
  assign slv_reqs[2].aw.burst  = slv2_aw_awburst    ;
  assign slv_reqs[2].aw.lock   = slv2_aw_awlock     ;
  assign slv_reqs[2].aw.cache  = slv2_aw_awcache    ;
  assign slv_reqs[2].aw.prot   = slv2_aw_awprot     ;
  assign slv_reqs[2].aw.region = slv2_aw_awregion   ;
  assign slv_reqs[2].aw.qos    = slv2_aw_awqos      ;
  assign slv_reqs[2].aw.atop   = 6'd0              ;
  assign slv_reqs[2].aw.user   = slv2_aw_awuser     ;
  assign slv_reqs[2].aw_valid  = slv2_aw_awvalid    ;

  assign slv_reqs[2].w.data    = slv2_w_wdata       ;
  assign slv_reqs[2].w.strb    = slv2_w_wstrb       ;
  assign slv_reqs[2].w.last    = slv2_w_wlast       ;
  assign slv_reqs[2].w.user    = slv2_w_wuser       ;
  assign slv_reqs[2].w_valid   = slv2_w_wvalid      ;

  assign slv_reqs[2].b_ready   = slv2_b_bready      ;

  assign slv_reqs[2].ar.id     = slv2_ar_arid       ;
  assign slv_reqs[2].ar.addr   = slv2_ar_araddr     ;
  assign slv_reqs[2].ar.len    = slv2_ar_arlen      ;   
  assign slv_reqs[2].ar.size   = slv2_ar_arsize     ;
  assign slv_reqs[2].ar.burst  = slv2_ar_arburst    ;
  assign slv_reqs[2].ar.lock   = slv2_ar_arlock     ;
  assign slv_reqs[2].ar.cache  = slv2_ar_arcache    ;
  assign slv_reqs[2].ar.prot   = slv2_ar_arprot     ;
  assign slv_reqs[2].ar.region = slv2_ar_arregion   ;
  assign slv_reqs[2].ar.qos    = slv2_ar_arqos      ;
  assign slv_reqs[2].ar.user   = slv2_ar_aruser     ;
  assign slv_reqs[2].ar_valid  = slv2_ar_arvalid    ;

  assign slv_reqs[2].r_ready   = slv2_r_rready      ;

  /*response*/
  assign slv2_aw_awready       = slv_resps[2].aw_ready ;

  assign slv2_w_wready         = slv_resps[2].w_ready  ;

  assign slv2_b_bid            = slv_resps[2].b.id     ;
  assign slv2_b_bresp          = slv_resps[2].b.resp   ;
  assign slv2_b_buser          = slv_resps[2].b.user   ;
  assign slv2_b_bvalid         = slv_resps[2].b_valid  ;

  assign slv2_ar_arready       = slv_resps[2].ar_ready ;

  assign slv2_r_rid            = slv_resps[2].r.id     ;
  assign slv2_r_rdata          = slv_resps[2].r.data   ;
  assign slv2_r_rresp          = slv_resps[2].r.resp   ;
  assign slv2_r_rlast          = slv_resps[2].r.last   ;
  assign slv2_r_ruser          = slv_resps[2].r.user   ;
  assign slv2_r_rvalid         = slv_resps[2].r_valid  ;
  /*********************************************************************/
  //AXI slave3 interface connection
  /*********************************************************************/
  /*request*/
  assign slv_reqs[3].aw.id     = slv3_aw_awid       ;
  assign slv_reqs[3].aw.addr   = slv3_aw_awaddr     ;
  assign slv_reqs[3].aw.len    = slv3_aw_awlen      ;
  assign slv_reqs[3].aw.size   = slv3_aw_awsize     ;
  assign slv_reqs[3].aw.burst  = slv3_aw_awburst    ;
  assign slv_reqs[3].aw.lock   = slv3_aw_awlock     ;
  assign slv_reqs[3].aw.cache  = slv3_aw_awcache    ;
  assign slv_reqs[3].aw.prot   = slv3_aw_awprot     ;
  assign slv_reqs[3].aw.region = slv3_aw_awregion   ;
  assign slv_reqs[3].aw.qos    = slv3_aw_awqos      ;
  assign slv_reqs[3].aw.atop   = 6'd0              ;
  assign slv_reqs[3].aw.user   = slv3_aw_awuser     ;
  assign slv_reqs[3].aw_valid  = slv3_aw_awvalid    ;

  assign slv_reqs[3].w.data    = slv3_w_wdata       ;
  assign slv_reqs[3].w.strb    = slv3_w_wstrb       ;
  assign slv_reqs[3].w.last    = slv3_w_wlast       ;
  assign slv_reqs[3].w.user    = slv3_w_wuser       ;
  assign slv_reqs[3].w_valid   = slv3_w_wvalid      ;

  assign slv_reqs[3].b_ready   = slv3_b_bready      ;

  assign slv_reqs[3].ar.id     = slv3_ar_arid       ;
  assign slv_reqs[3].ar.addr   = slv3_ar_araddr     ;
  assign slv_reqs[3].ar.len    = slv3_ar_arlen      ;   
  assign slv_reqs[3].ar.size   = slv3_ar_arsize     ;
  assign slv_reqs[3].ar.burst  = slv3_ar_arburst    ;
  assign slv_reqs[3].ar.lock   = slv3_ar_arlock     ;
  assign slv_reqs[3].ar.cache  = slv3_ar_arcache    ;
  assign slv_reqs[3].ar.prot   = slv3_ar_arprot     ;
  assign slv_reqs[3].ar.region = slv3_ar_arregion   ;
  assign slv_reqs[3].ar.qos    = slv3_ar_arqos      ;
  assign slv_reqs[3].ar.user   = slv3_ar_aruser     ;
  assign slv_reqs[3].ar_valid  = slv3_ar_arvalid    ;

  assign slv_reqs[3].r_ready   = slv3_r_rready      ;

  /*response*/
  assign slv3_aw_awready       = slv_resps[3].aw_ready ;

  assign slv3_w_wready         = slv_resps[3].w_ready  ;

  assign slv3_b_bid            = slv_resps[3].b.id     ;
  assign slv3_b_bresp          = slv_resps[3].b.resp   ;
  assign slv3_b_buser          = slv_resps[3].b.user   ;
  assign slv3_b_bvalid         = slv_resps[3].b_valid  ;

  assign slv3_ar_arready       = slv_resps[3].ar_ready ;

  assign slv3_r_rid            = slv_resps[3].r.id     ;
  assign slv3_r_rdata          = slv_resps[3].r.data   ;
  assign slv3_r_rresp          = slv_resps[3].r.resp   ;
  assign slv3_r_rlast          = slv_resps[3].r.last   ;
  assign slv3_r_ruser          = slv_resps[3].r.user   ;
  assign slv3_r_rvalid         = slv_resps[3].r_valid  ;
  /*********************************************************************/
  //AXI slave4 interface connection
  /*********************************************************************/
  /*request*/
  assign slv_reqs[4].aw.id     = slv4_aw_awid       ;
  assign slv_reqs[4].aw.addr   = slv4_aw_awaddr     ;
  assign slv_reqs[4].aw.len    = slv4_aw_awlen      ;
  assign slv_reqs[4].aw.size   = slv4_aw_awsize     ;
  assign slv_reqs[4].aw.burst  = slv4_aw_awburst    ;
  assign slv_reqs[4].aw.lock   = slv4_aw_awlock     ;
  assign slv_reqs[4].aw.cache  = slv4_aw_awcache    ;
  assign slv_reqs[4].aw.prot   = slv4_aw_awprot     ;
  assign slv_reqs[4].aw.region = slv4_aw_awregion   ;
  assign slv_reqs[4].aw.qos    = slv4_aw_awqos      ;
  assign slv_reqs[4].aw.atop   = 6'd0              ;
  assign slv_reqs[4].aw.user   = slv4_aw_awuser     ;
  assign slv_reqs[4].aw_valid  = slv4_aw_awvalid    ;

  assign slv_reqs[4].w.data    = slv4_w_wdata       ;
  assign slv_reqs[4].w.strb    = slv4_w_wstrb       ;
  assign slv_reqs[4].w.last    = slv4_w_wlast       ;
  assign slv_reqs[4].w.user    = slv4_w_wuser       ;
  assign slv_reqs[4].w_valid   = slv4_w_wvalid      ;

  assign slv_reqs[4].b_ready   = slv4_b_bready      ;

  assign slv_reqs[4].ar.id     = slv4_ar_arid       ;
  assign slv_reqs[4].ar.addr   = slv4_ar_araddr     ;
  assign slv_reqs[4].ar.len    = slv4_ar_arlen      ;   
  assign slv_reqs[4].ar.size   = slv4_ar_arsize     ;
  assign slv_reqs[4].ar.burst  = slv4_ar_arburst    ;
  assign slv_reqs[4].ar.lock   = slv4_ar_arlock     ;
  assign slv_reqs[4].ar.cache  = slv4_ar_arcache    ;
  assign slv_reqs[4].ar.prot   = slv4_ar_arprot     ;
  assign slv_reqs[4].ar.region = slv4_ar_arregion   ;
  assign slv_reqs[4].ar.qos    = slv4_ar_arqos      ;
  assign slv_reqs[4].ar.user   = slv4_ar_aruser     ;
  assign slv_reqs[4].ar_valid  = slv4_ar_arvalid    ;

  assign slv_reqs[4].r_ready   = slv4_r_rready      ;

  /*response*/
  assign slv4_aw_awready       = slv_resps[4].aw_ready ;

  assign slv4_w_wready         = slv_resps[4].w_ready  ;

  assign slv4_b_bid            = slv_resps[4].b.id     ;
  assign slv4_b_bresp          = slv_resps[4].b.resp   ;
  assign slv4_b_buser          = slv_resps[4].b.user   ;
  assign slv4_b_bvalid         = slv_resps[4].b_valid  ;

  assign slv4_ar_arready       = slv_resps[4].ar_ready ;

  assign slv4_r_rid            = slv_resps[4].r.id     ;
  assign slv4_r_rdata          = slv_resps[4].r.data   ;
  assign slv4_r_rresp          = slv_resps[4].r.resp   ;
  assign slv4_r_rlast          = slv_resps[4].r.last   ;
  assign slv4_r_ruser          = slv_resps[4].r.user   ;
  assign slv4_r_rvalid         = slv_resps[4].r_valid  ;
  /*********************************************************************/

  //AXI Master0 interface connection
  /*********************************************************************/
  /*request*/
  assign mst0_aw_awid          = mst_reqs[0].aw.id      ;
  assign mst0_aw_awaddr        = mst_reqs[0].aw.addr    ;
  assign mst0_aw_awlen         = mst_reqs[0].aw.len     ;
  assign mst0_aw_awsize        = mst_reqs[0].aw.size    ;
  assign mst0_aw_awburst       = mst_reqs[0].aw.burst   ;
  assign mst0_aw_awlock        = mst_reqs[0].aw.lock    ;
  assign mst0_aw_awcache       = mst_reqs[0].aw.cache   ;
  assign mst0_aw_awprot        = mst_reqs[0].aw.prot    ;
  assign mst0_aw_awregion      = mst_reqs[0].aw.region  ;
  assign mst0_aw_awqos         = mst_reqs[0].aw.qos     ;
  assign mst0_aw_awuser        = mst_reqs[0].aw.user    ;
  assign mst0_aw_awvalid       = mst_reqs[0].aw_valid   ;

  assign mst0_w_wdata          = mst_reqs[0].w.data     ;
  assign mst0_w_wstrb          = mst_reqs[0].w.strb     ;
  assign mst0_w_wlast          = mst_reqs[0].w.last     ;
  assign mst0_w_wuser          = mst_reqs[0].w.user     ;
  assign mst0_w_wvalid         = mst_reqs[0].w_valid    ;

  assign mst0_b_bready         = mst_reqs[0].b_ready    ;

  assign mst0_ar_arid          = mst_reqs[0].ar.id      ;
  assign mst0_ar_araddr        = mst_reqs[0].ar.addr    ;
  assign mst0_ar_arlen         = mst_reqs[0].ar.len     ;   
  assign mst0_ar_arsize        = mst_reqs[0].ar.size    ;
  assign mst0_ar_arburst       = mst_reqs[0].ar.burst   ;
  assign mst0_ar_arlock        = mst_reqs[0].ar.lock    ;
  assign mst0_ar_arcache       = mst_reqs[0].ar.cache   ;
  assign mst0_ar_arprot        = mst_reqs[0].ar.prot    ;
  assign mst0_ar_arregion      = mst_reqs[0].ar.region  ;
  assign mst0_ar_arqos         = mst_reqs[0].ar.qos     ;
  assign mst0_ar_aruser        = mst_reqs[0].ar.user    ;
  assign mst0_ar_arvalid       = mst_reqs[0].ar_valid   ;

  assign mst0_r_rready         = mst_reqs[0].r_ready    ;

  /*response*/
  assign mst_resps[0].aw_ready = mst0_aw_awready ;

  assign mst_resps[0].w_ready  = mst0_w_wready   ;

  assign mst_resps[0].b.id     = mst0_b_bid      ;
  assign mst_resps[0].b.resp   = mst0_b_bresp    ;
  assign mst_resps[0].b.user   = mst0_b_buser    ;
  assign mst_resps[0].b_valid  = mst0_b_bvalid   ;

  assign mst_resps[0].ar_ready = mst0_ar_arready ;

  assign mst_resps[0].r.id     = mst0_r_rid      ;
  assign mst_resps[0].r.data   = mst0_r_rdata    ;
  assign mst_resps[0].r.resp   = mst0_r_rresp    ;
  assign mst_resps[0].r.last   = mst0_r_rlast    ;
  assign mst_resps[0].r.user   = mst0_r_ruser    ;
  assign mst_resps[0].r_valid  = mst0_r_rvalid   ;
  /*********************************************************************/
  //AXI Master1 interface connection
  /*********************************************************************/
  /*request*/
  assign mst1_aw_awid          = mst_reqs[1].aw.id      ;
  assign mst1_aw_awaddr        = mst_reqs[1].aw.addr    ;
  assign mst1_aw_awlen         = mst_reqs[1].aw.len     ;
  assign mst1_aw_awsize        = mst_reqs[1].aw.size    ;
  assign mst1_aw_awburst       = mst_reqs[1].aw.burst   ;
  assign mst1_aw_awlock        = mst_reqs[1].aw.lock    ;
  assign mst1_aw_awcache       = mst_reqs[1].aw.cache   ;
  assign mst1_aw_awprot        = mst_reqs[1].aw.prot    ;
  assign mst1_aw_awregion      = mst_reqs[1].aw.region  ;
  assign mst1_aw_awqos         = mst_reqs[1].aw.qos     ;
  assign mst1_aw_awuser        = mst_reqs[1].aw.user    ;
  assign mst1_aw_awvalid       = mst_reqs[1].aw_valid   ;

  assign mst1_w_wdata          = mst_reqs[1].w.data     ;
  assign mst1_w_wstrb          = mst_reqs[1].w.strb     ;
  assign mst1_w_wlast          = mst_reqs[1].w.last     ;
  assign mst1_w_wuser          = mst_reqs[1].w.user     ;
  assign mst1_w_wvalid         = mst_reqs[1].w_valid    ;

  assign mst1_b_bready         = mst_reqs[1].b_ready    ;

  assign mst1_ar_arid          = mst_reqs[1].ar.id      ;
  assign mst1_ar_araddr        = mst_reqs[1].ar.addr    ;
  assign mst1_ar_arlen         = mst_reqs[1].ar.len     ;   
  assign mst1_ar_arsize        = mst_reqs[1].ar.size    ;
  assign mst1_ar_arburst       = mst_reqs[1].ar.burst   ;
  assign mst1_ar_arlock        = mst_reqs[1].ar.lock    ;
  assign mst1_ar_arcache       = mst_reqs[1].ar.cache   ;
  assign mst1_ar_arprot        = mst_reqs[1].ar.prot    ;
  assign mst1_ar_arregion      = mst_reqs[1].ar.region  ;
  assign mst1_ar_arqos         = mst_reqs[1].ar.qos     ;
  assign mst1_ar_aruser        = mst_reqs[1].ar.user    ;
  assign mst1_ar_arvalid       = mst_reqs[1].ar_valid   ;

  assign mst1_r_rready         = mst_reqs[1].r_ready    ;

  /*response*/
  assign mst_resps[1].aw_ready = mst1_aw_awready ;

  assign mst_resps[1].w_ready  = mst1_w_wready   ;

  assign mst_resps[1].b.id     = mst1_b_bid      ;
  assign mst_resps[1].b.resp   = mst1_b_bresp    ;
  assign mst_resps[1].b.user   = mst1_b_buser    ;
  assign mst_resps[1].b_valid  = mst1_b_bvalid   ;

  assign mst_resps[1].ar_ready = mst1_ar_arready ;

  assign mst_resps[1].r.id     = mst1_r_rid      ;
  assign mst_resps[1].r.data   = mst1_r_rdata    ;
  assign mst_resps[1].r.resp   = mst1_r_rresp    ;
  assign mst_resps[1].r.last   = mst1_r_rlast    ;
  assign mst_resps[1].r.user   = mst1_r_ruser    ;
  assign mst_resps[1].r_valid  = mst1_r_rvalid   ;
  /*********************************************************************/
  //AXI Master2 interface connection
  /*********************************************************************/
  /*request*/
  assign mst2_aw_awid          = mst_reqs[2].aw.id      ;
  assign mst2_aw_awaddr        = mst_reqs[2].aw.addr    ;
  assign mst2_aw_awlen         = mst_reqs[2].aw.len     ;
  assign mst2_aw_awsize        = mst_reqs[2].aw.size    ;
  assign mst2_aw_awburst       = mst_reqs[2].aw.burst   ;
  assign mst2_aw_awlock        = mst_reqs[2].aw.lock    ;
  assign mst2_aw_awcache       = mst_reqs[2].aw.cache   ;
  assign mst2_aw_awprot        = mst_reqs[2].aw.prot    ;
  assign mst2_aw_awregion      = mst_reqs[2].aw.region  ;
  assign mst2_aw_awqos         = mst_reqs[2].aw.qos     ;
  assign mst2_aw_awuser        = mst_reqs[2].aw.user    ;
  assign mst2_aw_awvalid       = mst_reqs[2].aw_valid   ;

  assign mst2_w_wdata          = mst_reqs[2].w.data     ;
  assign mst2_w_wstrb          = mst_reqs[2].w.strb     ;
  assign mst2_w_wlast          = mst_reqs[2].w.last     ;
  assign mst2_w_wuser          = mst_reqs[2].w.user     ;
  assign mst2_w_wvalid         = mst_reqs[2].w_valid    ;

  assign mst2_b_bready         = mst_reqs[2].b_ready    ;

  assign mst2_ar_arid          = mst_reqs[2].ar.id      ;
  assign mst2_ar_araddr        = mst_reqs[2].ar.addr    ;
  assign mst2_ar_arlen         = mst_reqs[2].ar.len     ;   
  assign mst2_ar_arsize        = mst_reqs[2].ar.size    ;
  assign mst2_ar_arburst       = mst_reqs[2].ar.burst   ;
  assign mst2_ar_arlock        = mst_reqs[2].ar.lock    ;
  assign mst2_ar_arcache       = mst_reqs[2].ar.cache   ;
  assign mst2_ar_arprot        = mst_reqs[2].ar.prot    ;
  assign mst2_ar_arregion      = mst_reqs[2].ar.region  ;
  assign mst2_ar_arqos         = mst_reqs[2].ar.qos     ;
  assign mst2_ar_aruser        = mst_reqs[2].ar.user    ;
  assign mst2_ar_arvalid       = mst_reqs[2].ar_valid   ;

  assign mst2_r_rready         = mst_reqs[2].r_ready    ;

  /*response*/
  assign mst_resps[2].aw_ready = mst2_aw_awready ;

  assign mst_resps[2].w_ready  = mst2_w_wready   ;

  assign mst_resps[2].b.id     = mst2_b_bid      ;
  assign mst_resps[2].b.resp   = mst2_b_bresp    ;
  assign mst_resps[2].b.user   = mst2_b_buser    ;
  assign mst_resps[2].b_valid  = mst2_b_bvalid   ;

  assign mst_resps[2].ar_ready = mst2_ar_arready ;

  assign mst_resps[2].r.id     = mst2_r_rid      ;
  assign mst_resps[2].r.data   = mst2_r_rdata    ;
  assign mst_resps[2].r.resp   = mst2_r_rresp    ;
  assign mst_resps[2].r.last   = mst2_r_rlast    ;
  assign mst_resps[2].r.user   = mst2_r_ruser    ;
  assign mst_resps[2].r_valid  = mst2_r_rvalid   ;
  /*********************************************************************/
  //AXI Master3 interface connection
  /*********************************************************************/
  /*request*/
  assign mst3_aw_awid          = mst_reqs[3].aw.id      ;
  assign mst3_aw_awaddr        = mst_reqs[3].aw.addr    ;
  assign mst3_aw_awlen         = mst_reqs[3].aw.len     ;
  assign mst3_aw_awsize        = mst_reqs[3].aw.size    ;
  assign mst3_aw_awburst       = mst_reqs[3].aw.burst   ;
  assign mst3_aw_awlock        = mst_reqs[3].aw.lock    ;
  assign mst3_aw_awcache       = mst_reqs[3].aw.cache   ;
  assign mst3_aw_awprot        = mst_reqs[3].aw.prot    ;
  assign mst3_aw_awregion      = mst_reqs[3].aw.region  ;
  assign mst3_aw_awqos         = mst_reqs[3].aw.qos     ;
  assign mst3_aw_awuser        = mst_reqs[3].aw.user    ;
  assign mst3_aw_awvalid       = mst_reqs[3].aw_valid   ;

  assign mst3_w_wdata          = mst_reqs[3].w.data     ;
  assign mst3_w_wstrb          = mst_reqs[3].w.strb     ;
  assign mst3_w_wlast          = mst_reqs[3].w.last     ;
  assign mst3_w_wuser          = mst_reqs[3].w.user     ;
  assign mst3_w_wvalid         = mst_reqs[3].w_valid    ;

  assign mst3_b_bready         = mst_reqs[3].b_ready    ;

  assign mst3_ar_arid          = mst_reqs[3].ar.id      ;
  assign mst3_ar_araddr        = mst_reqs[3].ar.addr    ;
  assign mst3_ar_arlen         = mst_reqs[3].ar.len     ;   
  assign mst3_ar_arsize        = mst_reqs[3].ar.size    ;
  assign mst3_ar_arburst       = mst_reqs[3].ar.burst   ;
  assign mst3_ar_arlock        = mst_reqs[3].ar.lock    ;
  assign mst3_ar_arcache       = mst_reqs[3].ar.cache   ;
  assign mst3_ar_arprot        = mst_reqs[3].ar.prot    ;
  assign mst3_ar_arregion      = mst_reqs[3].ar.region  ;
  assign mst3_ar_arqos         = mst_reqs[3].ar.qos     ;
  assign mst3_ar_aruser        = mst_reqs[3].ar.user    ;
  assign mst3_ar_arvalid       = mst_reqs[3].ar_valid   ;

  assign mst3_r_rready         = mst_reqs[3].r_ready    ;

  /*response*/
  assign mst_resps[3].aw_ready = mst3_aw_awready ;

  assign mst_resps[3].w_ready  = mst3_w_wready   ;

  assign mst_resps[3].b.id     = mst3_b_bid      ;
  assign mst_resps[3].b.resp   = mst3_b_bresp    ;
  assign mst_resps[3].b.user   = mst3_b_buser    ;
  assign mst_resps[3].b_valid  = mst3_b_bvalid   ;

  assign mst_resps[3].ar_ready = mst3_ar_arready ;

  assign mst_resps[3].r.id     = mst3_r_rid      ;
  assign mst_resps[3].r.data   = mst3_r_rdata    ;
  assign mst_resps[3].r.resp   = mst3_r_rresp    ;
  assign mst_resps[3].r.last   = mst3_r_rlast    ;
  assign mst_resps[3].r.user   = mst3_r_ruser    ;
  assign mst_resps[3].r_valid  = mst3_r_rvalid   ;
  /*********************************************************************/
  //AXI Master4 interface connection
  /*********************************************************************/
  /*request*/
  assign mst4_aw_awid          = mst_reqs[4].aw.id      ;
  assign mst4_aw_awaddr        = mst_reqs[4].aw.addr    ;
  assign mst4_aw_awlen         = mst_reqs[4].aw.len     ;
  assign mst4_aw_awsize        = mst_reqs[4].aw.size    ;
  assign mst4_aw_awburst       = mst_reqs[4].aw.burst   ;
  assign mst4_aw_awlock        = mst_reqs[4].aw.lock    ;
  assign mst4_aw_awcache       = mst_reqs[4].aw.cache   ;
  assign mst4_aw_awprot        = mst_reqs[4].aw.prot    ;
  assign mst4_aw_awregion      = mst_reqs[4].aw.region  ;
  assign mst4_aw_awqos         = mst_reqs[4].aw.qos     ;
  assign mst4_aw_awuser        = mst_reqs[4].aw.user    ;
  assign mst4_aw_awvalid       = mst_reqs[4].aw_valid   ;

  assign mst4_w_wdata          = mst_reqs[4].w.data     ;
  assign mst4_w_wstrb          = mst_reqs[4].w.strb     ;
  assign mst4_w_wlast          = mst_reqs[4].w.last     ;
  assign mst4_w_wuser          = mst_reqs[4].w.user     ;
  assign mst4_w_wvalid         = mst_reqs[4].w_valid    ;

  assign mst4_b_bready         = mst_reqs[4].b_ready    ;

  assign mst4_ar_arid          = mst_reqs[4].ar.id      ;
  assign mst4_ar_araddr        = mst_reqs[4].ar.addr    ;
  assign mst4_ar_arlen         = mst_reqs[4].ar.len     ;   
  assign mst4_ar_arsize        = mst_reqs[4].ar.size    ;
  assign mst4_ar_arburst       = mst_reqs[4].ar.burst   ;
  assign mst4_ar_arlock        = mst_reqs[4].ar.lock    ;
  assign mst4_ar_arcache       = mst_reqs[4].ar.cache   ;
  assign mst4_ar_arprot        = mst_reqs[4].ar.prot    ;
  assign mst4_ar_arregion      = mst_reqs[4].ar.region  ;
  assign mst4_ar_arqos         = mst_reqs[4].ar.qos     ;
  assign mst4_ar_aruser        = mst_reqs[4].ar.user    ;
  assign mst4_ar_arvalid       = mst_reqs[4].ar_valid   ;

  assign mst4_r_rready         = mst_reqs[4].r_ready    ;

  /*response*/
  assign mst_resps[4].aw_ready = mst4_aw_awready ;

  assign mst_resps[4].w_ready  = mst4_w_wready   ;

  assign mst_resps[4].b.id     = mst4_b_bid      ;
  assign mst_resps[4].b.resp   = mst4_b_bresp    ;
  assign mst_resps[4].b.user   = mst4_b_buser    ;
  assign mst_resps[4].b_valid  = mst4_b_bvalid   ;

  assign mst_resps[4].ar_ready = mst4_ar_arready ;

  assign mst_resps[4].r.id     = mst4_r_rid      ;
  assign mst_resps[4].r.data   = mst4_r_rdata    ;
  assign mst_resps[4].r.resp   = mst4_r_rresp    ;
  assign mst_resps[4].r.last   = mst4_r_rlast    ;
  assign mst_resps[4].r.user   = mst4_r_ruser    ;
  assign mst_resps[4].r_valid  = mst4_r_rvalid   ;
  /*********************************************************************/
  //AXI Master5 interface connection
  /*********************************************************************/
  /*request*/
  assign mst5_aw_awid          = mst_reqs[5].aw.id      ;
  assign mst5_aw_awaddr        = mst_reqs[5].aw.addr    ;
  assign mst5_aw_awlen         = mst_reqs[5].aw.len     ;
  assign mst5_aw_awsize        = mst_reqs[5].aw.size    ;
  assign mst5_aw_awburst       = mst_reqs[5].aw.burst   ;
  assign mst5_aw_awlock        = mst_reqs[5].aw.lock    ;
  assign mst5_aw_awcache       = mst_reqs[5].aw.cache   ;
  assign mst5_aw_awprot        = mst_reqs[5].aw.prot    ;
  assign mst5_aw_awregion      = mst_reqs[5].aw.region  ;
  assign mst5_aw_awqos         = mst_reqs[5].aw.qos     ;
  assign mst5_aw_awuser        = mst_reqs[5].aw.user    ;
  assign mst5_aw_awvalid       = mst_reqs[5].aw_valid   ;

  assign mst5_w_wdata          = mst_reqs[5].w.data     ;
  assign mst5_w_wstrb          = mst_reqs[5].w.strb     ;
  assign mst5_w_wlast          = mst_reqs[5].w.last     ;
  assign mst5_w_wuser          = mst_reqs[5].w.user     ;
  assign mst5_w_wvalid         = mst_reqs[5].w_valid    ;

  assign mst5_b_bready         = mst_reqs[5].b_ready    ;

  assign mst5_ar_arid          = mst_reqs[5].ar.id      ;
  assign mst5_ar_araddr        = mst_reqs[5].ar.addr    ;
  assign mst5_ar_arlen         = mst_reqs[5].ar.len     ;   
  assign mst5_ar_arsize        = mst_reqs[5].ar.size    ;
  assign mst5_ar_arburst       = mst_reqs[5].ar.burst   ;
  assign mst5_ar_arlock        = mst_reqs[5].ar.lock    ;
  assign mst5_ar_arcache       = mst_reqs[5].ar.cache   ;
  assign mst5_ar_arprot        = mst_reqs[5].ar.prot    ;
  assign mst5_ar_arregion      = mst_reqs[5].ar.region  ;
  assign mst5_ar_arqos         = mst_reqs[5].ar.qos     ;
  assign mst5_ar_aruser        = mst_reqs[5].ar.user    ;
  assign mst5_ar_arvalid       = mst_reqs[5].ar_valid   ;

  assign mst5_r_rready         = mst_reqs[5].r_ready    ;

  /*response*/
  assign mst_resps[5].aw_ready = mst5_aw_awready ;

  assign mst_resps[5].w_ready  = mst5_w_wready   ;

  assign mst_resps[5].b.id     = mst5_b_bid      ;
  assign mst_resps[5].b.resp   = mst5_b_bresp    ;
  assign mst_resps[5].b.user   = mst5_b_buser    ;
  assign mst_resps[5].b_valid  = mst5_b_bvalid   ;

  assign mst_resps[5].ar_ready = mst5_ar_arready ;

  assign mst_resps[5].r.id     = mst5_r_rid      ;
  assign mst_resps[5].r.data   = mst5_r_rdata    ;
  assign mst_resps[5].r.resp   = mst5_r_rresp    ;
  assign mst_resps[5].r.last   = mst5_r_rlast    ;
  assign mst_resps[5].r.user   = mst5_r_ruser    ;
  assign mst_resps[5].r_valid  = mst5_r_rvalid   ;
  /*********************************************************************/
  //AXI Master6 interface connection
  /*********************************************************************/
  /*request*/
  assign mst6_aw_awid          = mst_reqs[6].aw.id      ;
  assign mst6_aw_awaddr        = mst_reqs[6].aw.addr    ;
  assign mst6_aw_awlen         = mst_reqs[6].aw.len     ;
  assign mst6_aw_awsize        = mst_reqs[6].aw.size    ;
  assign mst6_aw_awburst       = mst_reqs[6].aw.burst   ;
  assign mst6_aw_awlock        = mst_reqs[6].aw.lock    ;
  assign mst6_aw_awcache       = mst_reqs[6].aw.cache   ;
  assign mst6_aw_awprot        = mst_reqs[6].aw.prot    ;
  assign mst6_aw_awregion      = mst_reqs[6].aw.region  ;
  assign mst6_aw_awqos         = mst_reqs[6].aw.qos     ;
  assign mst6_aw_awuser        = mst_reqs[6].aw.user    ;
  assign mst6_aw_awvalid       = mst_reqs[6].aw_valid   ;

  assign mst6_w_wdata          = mst_reqs[6].w.data     ;
  assign mst6_w_wstrb          = mst_reqs[6].w.strb     ;
  assign mst6_w_wlast          = mst_reqs[6].w.last     ;
  assign mst6_w_wuser          = mst_reqs[6].w.user     ;
  assign mst6_w_wvalid         = mst_reqs[6].w_valid    ;

  assign mst6_b_bready         = mst_reqs[6].b_ready    ;

  assign mst6_ar_arid          = mst_reqs[6].ar.id      ;
  assign mst6_ar_araddr        = mst_reqs[6].ar.addr    ;
  assign mst6_ar_arlen         = mst_reqs[6].ar.len     ;   
  assign mst6_ar_arsize        = mst_reqs[6].ar.size    ;
  assign mst6_ar_arburst       = mst_reqs[6].ar.burst   ;
  assign mst6_ar_arlock        = mst_reqs[6].ar.lock    ;
  assign mst6_ar_arcache       = mst_reqs[6].ar.cache   ;
  assign mst6_ar_arprot        = mst_reqs[6].ar.prot    ;
  assign mst6_ar_arregion      = mst_reqs[6].ar.region  ;
  assign mst6_ar_arqos         = mst_reqs[6].ar.qos     ;
  assign mst6_ar_aruser        = mst_reqs[6].ar.user    ;
  assign mst6_ar_arvalid       = mst_reqs[6].ar_valid   ;

  assign mst6_r_rready         = mst_reqs[6].r_ready    ;

  /*response*/
  assign mst_resps[6].aw_ready = mst6_aw_awready ;

  assign mst_resps[6].w_ready  = mst6_w_wready   ;

  assign mst_resps[6].b.id     = mst6_b_bid      ;
  assign mst_resps[6].b.resp   = mst6_b_bresp    ;
  assign mst_resps[6].b.user   = mst6_b_buser    ;
  assign mst_resps[6].b_valid  = mst6_b_bvalid   ;

  assign mst_resps[6].ar_ready = mst6_ar_arready ;

  assign mst_resps[6].r.id     = mst6_r_rid      ;
  assign mst_resps[6].r.data   = mst6_r_rdata    ;
  assign mst_resps[6].r.resp   = mst6_r_rresp    ;
  assign mst_resps[6].r.last   = mst6_r_rlast    ;
  assign mst_resps[6].r.user   = mst6_r_ruser    ;
  assign mst_resps[6].r_valid  = mst6_r_rvalid   ;
  /*********************************************************************/

  axi_xbar #(
    .Cfg               ( XBarCfg                ),
    .slv_aw_chan_t     ( slv_aw_chan_t          ),
    .mst_aw_chan_t     ( mst_aw_chan_t          ),
    .w_chan_t          ( w_chan_t               ),
    .slv_b_chan_t      ( slv_b_chan_t           ),
    .mst_b_chan_t      ( mst_b_chan_t           ),
    .slv_ar_chan_t     ( slv_ar_chan_t          ),
    .mst_ar_chan_t     ( mst_ar_chan_t          ),
    .slv_r_chan_t      ( slv_r_chan_t           ),
    .mst_r_chan_t      ( mst_r_chan_t           ),
    .slv_req_t         ( slv_req_t              ),
    .slv_resp_t        ( slv_resp_t             ),
    .mst_req_t         ( mst_req_t              ),
    .mst_resp_t        ( mst_resp_t             ),
    .rule_t            ( axi_pkg::xbar_rule_64_t),
    .slv_aw_chan_width ( 35+XBarCfg.AxiIdWidthSlvPorts+XBarCfg.AxiAddrWidth+AXI_USER_WIDTH),
    .slv_ar_chan_width ( 35+XBarCfg.AxiIdWidthSlvPorts+XBarCfg.AxiAddrWidth+AXI_USER_WIDTH)
  ) i_xbar (
    .clk_i,
    .rst_ni,
    .test_i               (1'b0),
    .slv_ports_req_i      (slv_reqs ),
    .slv_ports_resp_o     (slv_resps),
    .mst_ports_req_o      (mst_reqs ),
    .mst_ports_resp_i     (mst_resps),
    .addr_map_i           (routing_rules),
    .en_default_mst_port_i('0 ),
    .default_mst_port_i   ('0 )
  );

endmodule



