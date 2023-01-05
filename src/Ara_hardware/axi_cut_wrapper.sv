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

module axi_cut_wrapper #(
  parameter int unsigned AXI_ADDR_WIDTH    = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 32,
  parameter int unsigned AXI_ID_WIDTH      = 11,
  parameter int unsigned AXI_USER_WIDTH    = 1
) (
  input                                             clk_i,
  input                                             rst_ni,
  // SRC AXI Interface
  /*********************************************************************/
  //AW channel
  input                    [AXI_ID_WIDTH-1:0]       src_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     src_aw_awaddr,
  input                    [7:0]                    src_aw_awlen,
  input                    [2:0]                    src_aw_awsize,
  input                    [1:0]                    src_aw_awburst,
  input                                             src_aw_awlock,
  input                    [3:0]                    src_aw_awcache,
  input                    [2:0]                    src_aw_awprot,
  input                    [3:0]                    src_aw_awqos,
  input                    [3:0]                    src_aw_awregion,
  input                    [AXI_USER_WIDTH-1:0]     src_aw_awuser,//
  input                                             src_aw_awvalid,
  output                                            src_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     src_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   src_w_wstrb,
  input                                             src_w_wlast,
  input                    [AXI_USER_WIDTH-1:0]     src_w_wuser,
  input                                             src_w_wvalid,
  output                                            src_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       src_b_bid,
  output                   [1:0]                    src_b_bresp,
  output                   [AXI_USER_WIDTH-1:0]     src_b_buser,
  output                                            src_b_bvalid,
  input                                             src_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       src_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     src_ar_araddr,
  input                    [7:0]                    src_ar_arlen,
  input                    [2:0]                    src_ar_arsize,
  input                    [1:0]                    src_ar_arburst,
  input                                             src_ar_arlock,
  input                    [3:0]                    src_ar_arcache,
  input                    [2:0]                    src_ar_arprot,
  input                    [3:0]                    src_ar_arqos,
  input                    [3:0]                    src_ar_arregion,
  input                    [AXI_USER_WIDTH-1:0]     src_ar_aruser,
  input                                             src_ar_arvalid,
  output                                            src_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       src_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     src_r_rdata,
  output                   [1:0]                    src_r_rresp,
  output                                            src_r_rlast,
  output                   [AXI_USER_WIDTH-1:0]     src_r_ruser,
  output                                            src_r_rvalid,
  input                                             src_r_rready, 
  /*********************************************************************/

  // DST AXI Interface
  /*********************************************************************/
  //AW channel
  output                   [AXI_ID_WIDTH-1:0]       dst_aw_awid,
  output                   [AXI_ADDR_WIDTH-1:0]     dst_aw_awaddr,
  output                   [7:0]                    dst_aw_awlen,
  output                   [2:0]                    dst_aw_awsize,
  output                   [1:0]                    dst_aw_awburst,
  output                                            dst_aw_awlock,
  output                   [3:0]                    dst_aw_awcache,
  output                   [2:0]                    dst_aw_awprot,
  output                   [3:0]                    dst_aw_awqos,
  output                   [3:0]                    dst_aw_awregion,
  output                   [AXI_USER_WIDTH-1:0]     dst_aw_awuser,//
  output                                            dst_aw_awvalid,
  input                                             dst_aw_awready,
  //W channel
  output                   [AXI_DATA_WIDTH-1:0]     dst_w_wdata,
  output                   [AXI_DATA_WIDTH/8-1:0]   dst_w_wstrb,
  output                                            dst_w_wlast,
  output                   [AXI_USER_WIDTH-1:0]     dst_w_wuser,
  output                                            dst_w_wvalid,
  input                                             dst_w_wready,
  //AXI4-B channel
  input                    [AXI_ID_WIDTH-1:0]       dst_b_bid,
  input                    [1:0]                    dst_b_bresp,
  input                    [AXI_USER_WIDTH-1:0]     dst_b_buser,
  input                                             dst_b_bvalid,
  output                                            dst_b_bready,
  //AXI4-AR channel
  output                   [AXI_ID_WIDTH-1:0]       dst_ar_arid,
  output                   [AXI_ADDR_WIDTH-1:0]     dst_ar_araddr,
  output                   [7:0]                    dst_ar_arlen,
  output                   [2:0]                    dst_ar_arsize,
  output                   [1:0]                    dst_ar_arburst,
  output                                            dst_ar_arlock,
  output                   [3:0]                    dst_ar_arcache,
  output                   [2:0]                    dst_ar_arprot,
  output                   [3:0]                    dst_ar_arqos,
  output                   [3:0]                    dst_ar_arregion,
  output                   [AXI_USER_WIDTH-1:0]     dst_ar_aruser,
  output                                            dst_ar_arvalid,
  input                                             dst_ar_arready,
  //AXI4-R channel
  input                    [AXI_ID_WIDTH-1:0]       dst_r_rid,
  input                    [AXI_DATA_WIDTH-1:0]     dst_r_rdata,
  input                    [1:0]                    dst_r_rresp,
  input                                             dst_r_rlast,
  input                    [AXI_USER_WIDTH-1:0]     dst_r_ruser,
  input                                             dst_r_rvalid,
  output                                            dst_r_rready 
  /*********************************************************************/
);

`include "axi/assign.svh"
`include "axi/typedef.svh"

  typedef logic [AXI_ID_WIDTH-1:0]     id_t;
  typedef logic [AXI_ADDR_WIDTH-1:0]   addr_t;
  typedef logic [AXI_DATA_WIDTH-1:0]   data_t;
  typedef logic [AXI_DATA_WIDTH/8-1:0] strb_t;
  typedef logic [AXI_USER_WIDTH-1:0]   user_t;
  `AXI_TYPEDEF_AW_CHAN_T(aw_chan_t, addr_t, id_t, user_t)
  `AXI_TYPEDEF_W_CHAN_T(w_chan_t, data_t, strb_t, user_t)
  `AXI_TYPEDEF_B_CHAN_T(b_chan_t, id_t, user_t)
  `AXI_TYPEDEF_AR_CHAN_T(ar_chan_t, addr_t, id_t, user_t)
  `AXI_TYPEDEF_R_CHAN_T(r_chan_t, data_t, id_t, user_t)
  `AXI_TYPEDEF_REQ_T(req_t, aw_chan_t, w_chan_t, ar_chan_t)
  `AXI_TYPEDEF_RESP_T(resp_t, b_chan_t, r_chan_t)

  req_t  slv_req,  mst_req;
  resp_t slv_resp, mst_resp;

  //`AXI_ASSIGN_TO_REQ(slv_req, src)
  //`AXI_ASSIGN_FROM_RESP(src, slv_resp)

  //`AXI_ASSIGN_FROM_REQ(dst, mst_req)
  //`AXI_ASSIGN_TO_RESP(mst_resp, dst)

  //SRC AXI slave interface connection
  /*********************************************************************/
  /*request*/
  assign slv_req.aw.id     = src_aw_awid       ;
  assign slv_req.aw.addr   = src_aw_awaddr     ;
  assign slv_req.aw.len    = src_aw_awlen      ;
  assign slv_req.aw.size   = src_aw_awsize     ;
  assign slv_req.aw.burst  = src_aw_awburst    ;
  assign slv_req.aw.lock   = src_aw_awlock     ;
  assign slv_req.aw.cache  = src_aw_awcache    ;
  assign slv_req.aw.prot   = src_aw_awprot     ;
  assign slv_req.aw.region = src_aw_awregion   ;
  assign slv_req.aw.qos    = src_aw_awqos      ;
  assign slv_req.aw.atop   = 6'd0              ;
  assign slv_req.aw.user   = src_aw_awuser     ;
  assign slv_req.aw_valid  = src_aw_awvalid    ;

  assign slv_req.w.data    = src_w_wdata       ;
  assign slv_req.w.strb    = src_w_wstrb       ;
  assign slv_req.w.last    = src_w_wlast       ;
  assign slv_req.w.user    = src_w_wuser       ;
  assign slv_req.w_valid   = src_w_wvalid      ;

  assign slv_req.b_ready   = src_b_bready      ;

  assign slv_req.ar.id     = src_ar_arid       ;
  assign slv_req.ar.addr   = src_ar_araddr     ;
  assign slv_req.ar.len    = src_ar_arlen      ;   
  assign slv_req.ar.size   = src_ar_arsize     ;
  assign slv_req.ar.burst  = src_ar_arburst    ;
  assign slv_req.ar.lock   = src_ar_arlock     ;
  assign slv_req.ar.cache  = src_ar_arcache    ;
  assign slv_req.ar.prot   = src_ar_arprot     ;
  assign slv_req.ar.region = src_ar_arregion   ;
  assign slv_req.ar.qos    = src_ar_arqos      ;
  assign slv_req.ar.user   = src_ar_aruser     ;
  assign slv_req.ar_valid  = src_ar_arvalid    ;

  assign slv_req.r_ready   = src_r_rready      ;

  /*response*/
  assign src_aw_awready    = slv_resp.aw_ready ;

  assign src_w_wready      = slv_resp.w_ready  ;

  assign src_b_bid         = slv_resp.b.id     ;
  assign src_b_bresp       = slv_resp.b.resp   ;
  assign src_b_buser       = slv_resp.b.user   ;
  assign src_b_bvalid      = slv_resp.b_valid  ;

  assign src_ar_arready    = slv_resp.ar_ready ;

  assign src_r_rid         = slv_resp.r.id     ;
  assign src_r_rdata       = slv_resp.r.data   ;
  assign src_r_rresp       = slv_resp.r.resp   ;
  assign src_r_rlast       = slv_resp.r.last   ;
  assign src_r_ruser       = slv_resp.r.user   ;
  assign src_r_rvalid      = slv_resp.r_valid  ;
  /*********************************************************************/

  //DST AXI Master interface connection
  /*********************************************************************/
  /*request*/
  assign dst_aw_awid       = mst_req.aw.id     ;
  assign dst_aw_awaddr     = mst_req.aw.addr   ;
  assign dst_aw_awlen      = mst_req.aw.len    ;
  assign dst_aw_awsize     = mst_req.aw.size   ;
  assign dst_aw_awburst    = mst_req.aw.burst  ;
  assign dst_aw_awlock     = mst_req.aw.lock   ;
  assign dst_aw_awcache    = mst_req.aw.cache  ;
  assign dst_aw_awprot     = mst_req.aw.prot   ;
  assign dst_aw_awregion   = mst_req.aw.region ;
  assign dst_aw_awqos      = mst_req.aw.qos    ;
  assign dst_aw_awuser     = mst_req.aw.user   ;
  assign dst_aw_awvalid    = mst_req.aw_valid  ;

  assign dst_w_wdata       = mst_req.w.data    ;
  assign dst_w_wstrb       = mst_req.w.strb    ;
  assign dst_w_wlast       = mst_req.w.last    ;
  assign dst_w_wuser       = mst_req.w.user    ;
  assign dst_w_wvalid      = mst_req.w_valid   ;

  assign dst_b_bready      = mst_req.b_ready   ;

  assign dst_ar_arid       = mst_req.ar.id     ;
  assign dst_ar_araddr     = mst_req.ar.addr   ;
  assign dst_ar_arlen      = mst_req.ar.len    ;   
  assign dst_ar_arsize     = mst_req.ar.size   ;
  assign dst_ar_arburst    = mst_req.ar.burst  ;
  assign dst_ar_arlock     = mst_req.ar.lock   ;
  assign dst_ar_arcache    = mst_req.ar.cache  ;
  assign dst_ar_arprot     = mst_req.ar.prot   ;
  assign dst_ar_arregion   = mst_req.ar.region ;
  assign dst_ar_arqos      = mst_req.ar.qos    ;
  assign dst_ar_aruser     = mst_req.ar.user   ;
  assign dst_ar_arvalid    = mst_req.ar_valid  ;

  assign dst_r_rready      = mst_req.r_ready   ;

  /*response*/
  assign mst_resp.aw_ready = dst_aw_awready    ;

  assign mst_resp.w_ready  = dst_w_wready      ;

  assign mst_resp.b.id     = dst_b_bid         ;
  assign mst_resp.b.resp   = dst_b_bresp       ;
  assign mst_resp.b.user   = dst_b_buser       ;
  assign mst_resp.b_valid  = dst_b_bvalid      ;

  assign mst_resp.ar_ready = dst_ar_arready    ;

  assign mst_resp.r.id     = dst_r_rid         ;
  assign mst_resp.r.data   = dst_r_rdata       ;
  assign mst_resp.r.resp   = dst_r_rresp       ;
  assign mst_resp.r.last   = dst_r_rlast       ;
  assign mst_resp.r.user   = dst_r_ruser       ;
  assign mst_resp.r_valid  = dst_r_rvalid      ;
  /*********************************************************************/

axi_cut #(
  .Bypass       ( 1'b0      ),
  .aw_chan_t    ( aw_chan_t ),
  .w_chan_t     ( w_chan_t  ),
  .b_chan_t     ( b_chan_t  ),
  .ar_chan_t    ( ar_chan_t ),
  .r_chan_t     ( r_chan_t  ),
  .req_t        ( req_t     ),
  .resp_t       ( resp_t    )
) i_axi_cut (
    .clk_i,
    .rst_ni,
    .slv_req_i  ( slv_req  ),
    .slv_resp_o ( slv_resp ),
    .mst_req_o  ( mst_req  ),
    .mst_resp_i ( mst_resp )
);


endmodule


