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

module axi_to_axilite_wrapper #(
  parameter int unsigned AXI_ADDR_WIDTH    = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 256,
  parameter int unsigned AXI_ID_WIDTH      = 4,
  parameter int unsigned AXI_USER_WIDTH    = 1
) (
  input                                             clk_i,
  input                                             rst_ni,
  // AXI Slave Interface
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       slv_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv_aw_awaddr,
  input                    [7:0]                    slv_aw_awlen,
  input                    [2:0]                    slv_aw_awsize,
  input                    [1:0]                    slv_aw_awburst,
  input                                             slv_aw_awlock,
  input                    [3:0]                    slv_aw_awcache,
  input                    [2:0]                    slv_aw_awprot,
  input                    [3:0]                    slv_aw_awregion,
  input                    [3:0]                    slv_aw_awqos,
  input                                             slv_aw_awuser,//
  input                                             slv_aw_awvalid,
  output                                            slv_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv_w_wstrb,
  input                                             slv_w_wlast,
  input                                             slv_w_wuser,
  input                                             slv_w_wvalid,
  output                                            slv_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       slv_b_bid,
  output                   [1:0]                    slv_b_bresp,
  output                                            slv_b_buser,
  output                                            slv_b_bvalid,
  input                                             slv_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       slv_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     slv_ar_araddr,
  input                    [7:0]                    slv_ar_arlen,
  input                    [2:0]                    slv_ar_arsize,
  input                    [1:0]                    slv_ar_arburst,
  input                                             slv_ar_arlock,
  input                    [3:0]                    slv_ar_arcache,
  input                    [2:0]                    slv_ar_arprot,
  input                    [3:0]                    slv_ar_arregion,
  input                    [3:0]                    slv_ar_arqos,
  input                                             slv_ar_aruser,
  input                                             slv_ar_arvalid,
  output                                            slv_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       slv_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     slv_r_rdata,
  output                   [1:0]                    slv_r_rresp,
  output                                            slv_r_rlast,
  output                                            slv_r_ruser,
  output                                            slv_r_rvalid,
  input                                             slv_r_rready, 
  /*********************************************************************/

  // AXI-Lite Master Interface
  /*********************************************************************/
  //AW channel
  output                   [AXI_ADDR_WIDTH-1:0]     mst_aw_awaddr,
  output                   [2:0]                    mst_aw_awprot,
  output                                            mst_aw_awvalid,
  input                                             mst_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     mst_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   mst_w_wstrb,
  output                                            mst_w_wvalid,
  input                                             mst_w_wready,
  //AXI4-B channel
  input                    [1:0]                    mst_b_bresp,
  input                                             mst_b_bvalid,
  output                                            mst_b_bready,
  //AXI4-AR channel
  output                   [AXI_ADDR_WIDTH-1:0]     mst_ar_araddr,
  output                   [2:0]                    mst_ar_arprot,
  output                                            mst_ar_arvalid,
  input                                             mst_ar_arready,
  //AXI4-R channel
  input                    [AXI_DATA_WIDTH-1:0]     mst_r_rdata,
  input                    [1:0]                    mst_r_rresp,
  input                                             mst_r_rvalid,
  output                                            mst_r_rready 
  /*********************************************************************/
);

  //`include "axi/assign.svh"
  `include "axi/typedef.svh"
  //`include "common_cells/registers.svh"

  // Internal types
  typedef logic [AXI_ADDR_WIDTH-1:0]   axi_addr_t;
  typedef logic [AXI_DATA_WIDTH-1:0]   axi_data_t;
  typedef logic [AXI_DATA_WIDTH/8-1:0] axi_strb_t;
  typedef logic [AXI_ID_WIDTH-1:0]     axi_id_t;
  typedef logic [AXI_USER_WIDTH-1:0]   axi_user_t;

  // AXI Typedefs
  `AXI_TYPEDEF_ALL(axi, axi_addr_t, axi_id_t, axi_data_t, axi_strb_t,axi_user_t)
  `AXI_LITE_TYPEDEF_ALL(axi_lite, axi_addr_t, axi_data_t, axi_strb_t)

  // Buses
  axi_req_t       inner_axi_req;
  axi_resp_t      inner_axi_resp;
  axi_lite_req_t  inner_axi_lite_req;
  axi_lite_resp_t inner_axi_lite_resp;

  //AXI slave interface connection
  /*********************************************************************/
  /*request*/
  assign inner_axi_req.aw.id     = slv_aw_awid       ;
  assign inner_axi_req.aw.addr   = slv_aw_awaddr     ;
  assign inner_axi_req.aw.len    = slv_aw_awlen      ;
  assign inner_axi_req.aw.size   = slv_aw_awsize     ;
  assign inner_axi_req.aw.burst  = slv_aw_awburst    ;
  assign inner_axi_req.aw.lock   = slv_aw_awlock     ;
  assign inner_axi_req.aw.cache  = slv_aw_awcache    ;
  assign inner_axi_req.aw.prot   = slv_aw_awprot     ;
  assign inner_axi_req.aw.region = slv_aw_awregion   ;
  assign inner_axi_req.aw.qos    = slv_aw_awqos      ;
  assign inner_axi_req.aw.atop   = 6'd0              ;
  assign inner_axi_req.aw.user   = slv_aw_awuser     ;
  assign inner_axi_req.aw_valid  = slv_aw_awvalid    ;

  assign inner_axi_req.w.data    = slv_w_wdata       ;
  assign inner_axi_req.w.strb    = slv_w_wstrb       ;
  assign inner_axi_req.w.last    = slv_w_wlast       ;
  assign inner_axi_req.w.user    = slv_w_wuser       ;
  assign inner_axi_req.w_valid   = slv_w_wvalid      ;

  assign inner_axi_req.b_ready   = slv_b_bready      ;

  assign inner_axi_req.ar.id     = slv_ar_arid       ;
  assign inner_axi_req.ar.addr   = slv_ar_araddr     ;
  assign inner_axi_req.ar.len    = slv_ar_arlen      ;   
  assign inner_axi_req.ar.size   = slv_ar_arsize     ;
  assign inner_axi_req.ar.burst  = slv_ar_arburst    ;
  assign inner_axi_req.ar.lock   = slv_ar_arlock     ;
  assign inner_axi_req.ar.cache  = slv_ar_arcache    ;
  assign inner_axi_req.ar.prot   = slv_ar_arprot     ;
  assign inner_axi_req.ar.region = slv_ar_arregion   ;
  assign inner_axi_req.ar.qos    = slv_ar_arqos      ;
  assign inner_axi_req.ar.user   = slv_ar_aruser     ;
  assign inner_axi_req.ar_valid  = slv_ar_arvalid    ;

  assign inner_axi_req.r_ready   = slv_r_rready      ;

  /*response*/
  assign slv_aw_awready          = inner_axi_resp.aw_ready  ;

  assign slv_w_wready            = inner_axi_resp.w_ready   ;

  assign slv_b_bid               = inner_axi_resp.b.id      ;
  assign slv_b_bresp             = inner_axi_resp.b.resp    ;
  assign slv_b_buser             = inner_axi_resp.b.user    ;
  assign slv_b_bvalid            = inner_axi_resp.b_valid   ;

  assign slv_ar_arready          = inner_axi_resp.ar_ready  ;

  assign slv_r_rid               = inner_axi_resp.r.id      ;
  assign slv_r_rdata             = inner_axi_resp.r.data    ;
  assign slv_r_rresp             = inner_axi_resp.r.resp    ;
  assign slv_r_rlast             = inner_axi_resp.r.last    ;
  assign slv_r_ruser             = inner_axi_resp.r.user    ;
  assign slv_r_rvalid            = inner_axi_resp.r_valid   ;
  /*********************************************************************/

  //AXI-Lite master interface connection
  /*********************************************************************/
  /*request*/
  assign mst_aw_awaddr                = inner_axi_lite_req.aw.addr  ;
  assign mst_aw_awprot                = inner_axi_lite_req.aw.prot  ;
  assign mst_aw_awvalid               = inner_axi_lite_req.aw_valid ;

  assign mst_w_wdata                  = inner_axi_lite_req.w.data   ;
  assign mst_w_wstrb                  = inner_axi_lite_req.w.strb   ;
  assign mst_w_wvalid                 = inner_axi_lite_req.w_valid  ;

  assign mst_b_bready                 = inner_axi_lite_req.b_ready  ;

  assign mst_ar_araddr                = inner_axi_lite_req.ar.addr  ;
  assign mst_ar_arprot                = inner_axi_lite_req.ar.prot  ;
  assign mst_ar_arvalid               = inner_axi_lite_req.ar_valid ;

  assign mst_r_rready                 = inner_axi_lite_req.r_ready  ;

  /*response*/
  assign inner_axi_lite_resp.aw_ready = mst_aw_awready ;

  assign inner_axi_lite_resp.w_ready  = mst_w_wready   ;

  assign inner_axi_lite_resp.b.resp   = mst_b_bresp    ;
  assign inner_axi_lite_resp.b_valid  = mst_b_bvalid   ;

  assign inner_axi_lite_resp.ar_ready = mst_ar_arready ;

  assign inner_axi_lite_resp.r.data   = mst_r_rdata    ;
  assign inner_axi_lite_resp.r.resp   = mst_r_rresp    ;
  assign inner_axi_lite_resp.r_valid  = mst_r_rvalid   ;
  /*********************************************************************/


  /////////////////////////
  //  AXI to AXI-Lite  //
  /////////////////////////
  axi_to_axi_lite #(
    .AxiAddrWidth   (AXI_ADDR_WIDTH ),
    .AxiDataWidth   (AXI_DATA_WIDTH ),
    .AxiIdWidth     (AXI_ID_WIDTH   ),
    .AxiUserWidth   (AXI_USER_WIDTH ),
    .AxiMaxReadTxns (1              ),
    .AxiMaxWriteTxns(1              ),
    .FallThrough    (1'b0           ),
    .full_req_t     (axi_req_t      ),
    .full_resp_t    (axi_resp_t     ),
    .lite_req_t     (axi_lite_req_t ),
    .lite_resp_t    (axi_lite_resp_t)
  ) i_axi_to_axi_lite (
    .clk_i     (clk_i               ),
    .rst_ni    (rst_ni              ),
    .test_i    (1'b0                ),
    .slv_req_i (inner_axi_req       ),
    .slv_resp_o(inner_axi_resp      ),
    .mst_req_o (inner_axi_lite_req  ),
    .mst_resp_i(inner_axi_lite_resp )
  );



endmodule


