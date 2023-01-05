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

module axilite_to_axi_wrapper #(
  parameter int unsigned AXI_ADDR_WIDTH    = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 256,
  parameter int unsigned AXI_ID_WIDTH      = 4,
  parameter int unsigned AXI_USER_WIDTH    = 1
) (
  // AXI-Lite Slave Interface
  /*********************************************************************/
  //AW channel
  input                    [AXI_ADDR_WIDTH-1:0]     slv_aw_awaddr,
  input                    [2:0]                    slv_aw_awprot,
  input                                             slv_aw_awvalid,
  output                                            slv_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     slv_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   slv_w_wstrb,
  input                                             slv_w_wvalid,
  output                                            slv_w_wready,
  //B channel
  output                   [1:0]                    slv_b_bresp,
  output                                            slv_b_bvalid,
  input                                             slv_b_bready,
  //AR channel
  input                    [AXI_ADDR_WIDTH-1:0]     slv_ar_araddr,
  input                    [2:0]                    slv_ar_arprot,
  input                                             slv_ar_arvalid,
  output                                            slv_ar_arready,
  //R channel
  output                   [AXI_DATA_WIDTH-1:0]     slv_r_rdata,
  output                   [1:0]                    slv_r_rresp,
  output                                            slv_r_rvalid,
  input                                             slv_r_rready, 
  /*********************************************************************/
  // AXI Slave Interface
  /*********************************************************************/
  //AW channel
  output                    [AXI_ID_WIDTH-1:0]      mst_aw_awid,
  output                    [AXI_ADDR_WIDTH-1:0]    mst_aw_awaddr,
  output                    [7:0]                   mst_aw_awlen,
  output                    [2:0]                   mst_aw_awsize,
  output                    [1:0]                   mst_aw_awburst,
  output                                            mst_aw_awlock,
  output                    [3:0]                   mst_aw_awcache,
  output                    [2:0]                   mst_aw_awprot,
  output                    [3:0]                   mst_aw_awregion,
  output                    [3:0]                   mst_aw_awqos,
  output                                            mst_aw_awuser,//
  output                                            mst_aw_awvalid,
  input                                             mst_aw_awready,
  //W channel
  output                    [AXI_DATA_WIDTH-1:0]    mst_w_wdata,
  output                    [AXI_DATA_WIDTH/8-1:0]  mst_w_wstrb,
  output                                            mst_w_wlast,
  output                                            mst_w_wuser,
  output                                            mst_w_wvalid,
  input                                             mst_w_wready,
  //B channel
  input                   [AXI_ID_WIDTH-1:0]        mst_b_bid,
  input                   [1:0]                     mst_b_bresp,
  input                                             mst_b_buser,
  input                                             mst_b_bvalid,
  output                                            mst_b_bready,
  //AR channel
  output                    [AXI_ID_WIDTH-1:0]      mst_ar_arid,
  output                    [AXI_ADDR_WIDTH-1:0]    mst_ar_araddr,
  output                    [7:0]                   mst_ar_arlen,
  output                    [2:0]                   mst_ar_arsize,
  output                    [1:0]                   mst_ar_arburst,
  output                                            mst_ar_arlock,
  output                    [3:0]                   mst_ar_arcache,
  output                    [2:0]                   mst_ar_arprot,
  output                    [3:0]                   mst_ar_arregion,
  output                    [3:0]                   mst_ar_arqos,
  output                                            mst_ar_aruser,
  output                                            mst_ar_arvalid,
  input                                             mst_ar_arready,
  //R channel
  input                   [AXI_ID_WIDTH-1:0]        mst_r_rid,
  input                   [AXI_DATA_WIDTH-1:0]      mst_r_rdata,
  input                   [1:0]                     mst_r_rresp,
  input                                             mst_r_rlast,
  input                                             mst_r_ruser,
  input                                             mst_r_rvalid,
  output                                            mst_r_rready 
  /*********************************************************************/
);

  `include "axi/typedef.svh"

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

  //AXI-Lite slave interface connection
  /*********************************************************************/
  /*request*/
  assign inner_axi_lite_req.aw.addr  = slv_aw_awaddr  ;
  assign inner_axi_lite_req.aw.prot  = slv_aw_awprot  ;
  assign inner_axi_lite_req.aw_valid = slv_aw_awvalid ;
                                     
  assign inner_axi_lite_req.w.data   = slv_w_wdata    ;
  assign inner_axi_lite_req.w.strb   = slv_w_wstrb    ;
  assign inner_axi_lite_req.w_valid  = slv_w_wvalid   ;
                                    
  assign inner_axi_lite_req.b_ready  = slv_b_bready   ;
                                   
  assign inner_axi_lite_req.ar.addr  = slv_ar_araddr  ;
  assign inner_axi_lite_req.ar.prot  = slv_ar_arprot  ;
  assign inner_axi_lite_req.ar_valid = slv_ar_arvalid ;
                                  
  assign inner_axi_lite_req.r_ready  = slv_r_rready   ;

  /*response*/
  assign slv_aw_awready              = inner_axi_lite_resp.aw_ready ;
                                     
  assign slv_w_wready                = inner_axi_lite_resp.w_ready  ;
                                     
  assign slv_b_bresp                 = inner_axi_lite_resp.b.resp   ;
  assign slv_b_bvalid                = inner_axi_lite_resp.b_valid  ;
                                     
  assign slv_ar_arready              = inner_axi_lite_resp.ar_ready ;
                                     
  assign slv_r_rdata                 = inner_axi_lite_resp.r.data   ;
  assign slv_r_rresp                 = inner_axi_lite_resp.r.resp   ;
  assign slv_r_rvalid                = inner_axi_lite_resp.r_valid  ;
  /*********************************************************************/

  //AXI Master interface connection
  /*********************************************************************/
  /*request*/
  assign mst_aw_awid             = inner_axi_req.aw.id      ;
  assign mst_aw_awaddr           = inner_axi_req.aw.addr    ;
  assign mst_aw_awlen            = inner_axi_req.aw.len     ;
  assign mst_aw_awsize           = inner_axi_req.aw.size    ;
  assign mst_aw_awburst          = inner_axi_req.aw.burst   ;
  assign mst_aw_awlock           = inner_axi_req.aw.lock    ;
  assign mst_aw_awcache          = inner_axi_req.aw.cache   ;
  assign mst_aw_awprot           = inner_axi_req.aw.prot    ;
  assign mst_aw_awregion         = inner_axi_req.aw.region  ;
  assign mst_aw_awqos            = inner_axi_req.aw.qos     ;
  assign mst_aw_awuser           = inner_axi_req.aw.user    ;
  assign mst_aw_awvalid          = inner_axi_req.aw_valid   ;

  assign mst_w_wdata             = inner_axi_req.w.data     ;
  assign mst_w_wstrb             = inner_axi_req.w.strb     ;
  assign mst_w_wlast             = inner_axi_req.w.last     ;
  assign mst_w_wuser             = inner_axi_req.w.user     ;
  assign mst_w_wvalid            = inner_axi_req.w_valid    ;

  assign mst_b_bready            = inner_axi_req.b_ready    ;

  assign mst_ar_arid             = inner_axi_req.ar.id      ;
  assign mst_ar_araddr           = inner_axi_req.ar.addr    ;
  assign mst_ar_arlen            = inner_axi_req.ar.len     ;   
  assign mst_ar_arsize           = inner_axi_req.ar.size    ;
  assign mst_ar_arburst          = inner_axi_req.ar.burst   ;
  assign mst_ar_arlock           = inner_axi_req.ar.lock    ;
  assign mst_ar_arcache          = inner_axi_req.ar.cache   ;
  assign mst_ar_arprot           = inner_axi_req.ar.prot    ;
  assign mst_ar_arregion         = inner_axi_req.ar.region  ;
  assign mst_ar_arqos            = inner_axi_req.ar.qos     ;
  assign mst_ar_aruser           = inner_axi_req.ar.user    ;
  assign mst_ar_arvalid          = inner_axi_req.ar_valid   ;

  assign mst_r_rready            = inner_axi_req.r_ready    ;

  /*response*/
  assign inner_axi_resp.aw_ready = mst_aw_awready ;

  assign inner_axi_resp.w_ready  = mst_w_wready   ;

  assign inner_axi_resp.b.id     = mst_b_bid      ;
  assign inner_axi_resp.b.resp   = mst_b_bresp    ;
  assign inner_axi_resp.b.user   = mst_b_buser    ;
  assign inner_axi_resp.b_valid  = mst_b_bvalid   ;

  assign inner_axi_resp.ar_ready = mst_ar_arready ;

  assign inner_axi_resp.r.id     = mst_r_rid      ;
  assign inner_axi_resp.r.data   = mst_r_rdata    ;
  assign inner_axi_resp.r.resp   = mst_r_rresp    ;
  assign inner_axi_resp.r.last   = mst_r_rlast    ;
  assign inner_axi_resp.r.user   = mst_r_ruser    ;
  assign inner_axi_resp.r_valid  = mst_r_rvalid   ;
  /*********************************************************************/


  /////////////////////////
  //  AXI-Lite to AXI    //
  /////////////////////////
  axi_lite_to_axi #(
    .AxiDataWidth ( AXI_DATA_WIDTH  ),
    .req_lite_t   ( axi_lite_req_t  ),
    .resp_lite_t  ( axi_lite_resp_t ),
    .req_t        ( axi_req_t       ),
    .resp_t       ( axi_resp_t      )
  ) i_axi_lite_to_axi (
    .slv_req_lite_i  (inner_axi_lite_req  ),
    .slv_resp_lite_o (inner_axi_lite_resp ),
    .slv_aw_cache_i  ( 4'd0               ),
    .slv_ar_cache_i  ( 4'd0               ),
    .mst_req_o       (inner_axi_req       ),
    .mst_resp_i      (inner_axi_resp      )
  );



endmodule


