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

module axi_cdc_wrapper #(
  parameter int unsigned AXI_ADDR_WIDTH    = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 256,
  parameter int unsigned AXI_ID_WIDTH      = 11,
  parameter int unsigned AXI_USER_WIDTH    = 1,
  /// Depth of the FIFO crossing the clock domain, given as 2**LOG_DEPTH.
  parameter int unsigned LOG_DEPTH         = 1
) (
  input                                             src_clk_i,
  input                                             src_rst_ni,
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

  input                                             dst_clk_i,
  input                                             dst_rst_ni,
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

  req_t  src_req,  dst_req;
  resp_t src_resp, dst_resp;

  //`AXI_ASSIGN_TO_REQ(src_req, src)
  //`AXI_ASSIGN_FROM_RESP(src, src_resp)

  //`AXI_ASSIGN_FROM_REQ(dst, dst_req)
  //`AXI_ASSIGN_TO_RESP(dst_resp, dst)

  //SRC AXI slave interface connection
  /*********************************************************************/
  /*request*/
  assign src_req.aw.id     = src_aw_awid       ;
  assign src_req.aw.addr   = src_aw_awaddr     ;
  assign src_req.aw.len    = src_aw_awlen      ;
  assign src_req.aw.size   = src_aw_awsize     ;
  assign src_req.aw.burst  = src_aw_awburst    ;
  assign src_req.aw.lock   = src_aw_awlock     ;
  assign src_req.aw.cache  = src_aw_awcache    ;
  assign src_req.aw.prot   = src_aw_awprot     ;
  assign src_req.aw.region = src_aw_awregion   ;
  assign src_req.aw.qos    = src_aw_awqos      ;
  assign src_req.aw.atop   = 6'd0              ;
  assign src_req.aw.user   = src_aw_awuser     ;
  assign src_req.aw_valid  = src_aw_awvalid    ;

  assign src_req.w.data    = src_w_wdata       ;
  assign src_req.w.strb    = src_w_wstrb       ;
  assign src_req.w.last    = src_w_wlast       ;
  assign src_req.w.user    = src_w_wuser       ;
  assign src_req.w_valid   = src_w_wvalid      ;

  assign src_req.b_ready   = src_b_bready      ;

  assign src_req.ar.id     = src_ar_arid       ;
  assign src_req.ar.addr   = src_ar_araddr     ;
  assign src_req.ar.len    = src_ar_arlen      ;   
  assign src_req.ar.size   = src_ar_arsize     ;
  assign src_req.ar.burst  = src_ar_arburst    ;
  assign src_req.ar.lock   = src_ar_arlock     ;
  assign src_req.ar.cache  = src_ar_arcache    ;
  assign src_req.ar.prot   = src_ar_arprot     ;
  assign src_req.ar.region = src_ar_arregion   ;
  assign src_req.ar.qos    = src_ar_arqos      ;
  assign src_req.ar.user   = src_ar_aruser     ;
  assign src_req.ar_valid  = src_ar_arvalid    ;

  assign src_req.r_ready   = src_r_rready      ;

  /*response*/
  assign src_aw_awready    = src_resp.aw_ready ;

  assign src_w_wready      = src_resp.w_ready  ;

  assign src_b_bid         = src_resp.b.id     ;
  assign src_b_bresp       = src_resp.b.resp   ;
  assign src_b_buser       = src_resp.b.user   ;
  assign src_b_bvalid      = src_resp.b_valid  ;

  assign src_ar_arready    = src_resp.ar_ready ;

  assign src_r_rid         = src_resp.r.id     ;
  assign src_r_rdata       = src_resp.r.data   ;
  assign src_r_rresp       = src_resp.r.resp   ;
  assign src_r_rlast       = src_resp.r.last   ;
  assign src_r_ruser       = src_resp.r.user   ;
  assign src_r_rvalid      = src_resp.r_valid  ;
  /*********************************************************************/

  //DST AXI Master interface connection
  /*********************************************************************/
  /*request*/
  assign dst_aw_awid       = dst_req.aw.id     ;
  assign dst_aw_awaddr     = dst_req.aw.addr   ;
  assign dst_aw_awlen      = dst_req.aw.len    ;
  assign dst_aw_awsize     = dst_req.aw.size   ;
  assign dst_aw_awburst    = dst_req.aw.burst  ;
  assign dst_aw_awlock     = dst_req.aw.lock   ;
  assign dst_aw_awcache    = dst_req.aw.cache  ;
  assign dst_aw_awprot     = dst_req.aw.prot   ;
  assign dst_aw_awregion   = dst_req.aw.region ;
  assign dst_aw_awqos      = dst_req.aw.qos    ;
  assign dst_aw_awuser     = dst_req.aw.user   ;
  assign dst_aw_awvalid    = dst_req.aw_valid  ;

  assign dst_w_wdata       = dst_req.w.data    ;
  assign dst_w_wstrb       = dst_req.w.strb    ;
  assign dst_w_wlast       = dst_req.w.last    ;
  assign dst_w_wuser       = dst_req.w.user    ;
  assign dst_w_wvalid      = dst_req.w_valid   ;

  assign dst_b_bready      = dst_req.b_ready   ;

  assign dst_ar_arid       = dst_req.ar.id     ;
  assign dst_ar_araddr     = dst_req.ar.addr   ;
  assign dst_ar_arlen      = dst_req.ar.len    ;   
  assign dst_ar_arsize     = dst_req.ar.size   ;
  assign dst_ar_arburst    = dst_req.ar.burst  ;
  assign dst_ar_arlock     = dst_req.ar.lock   ;
  assign dst_ar_arcache    = dst_req.ar.cache  ;
  assign dst_ar_arprot     = dst_req.ar.prot   ;
  assign dst_ar_arregion   = dst_req.ar.region ;
  assign dst_ar_arqos      = dst_req.ar.qos    ;
  assign dst_ar_aruser     = dst_req.ar.user   ;
  assign dst_ar_arvalid    = dst_req.ar_valid  ;

  assign dst_r_rready      = dst_req.r_ready   ;

  /*response*/
  assign dst_resp.aw_ready = dst_aw_awready    ;

  assign dst_resp.w_ready  = dst_w_wready      ;

  assign dst_resp.b.id     = dst_b_bid         ;
  assign dst_resp.b.resp   = dst_b_bresp       ;
  assign dst_resp.b.user   = dst_b_buser       ;
  assign dst_resp.b_valid  = dst_b_bvalid      ;

  assign dst_resp.ar_ready = dst_ar_arready    ;

  assign dst_resp.r.id     = dst_r_rid         ;
  assign dst_resp.r.data   = dst_r_rdata       ;
  assign dst_resp.r.resp   = dst_r_rresp       ;
  assign dst_resp.r.last   = dst_r_rlast       ;
  assign dst_resp.r.user   = dst_r_ruser       ;
  assign dst_resp.r_valid  = dst_r_rvalid      ;
  /*********************************************************************/

  axi_cdc #(
    .aw_chan_t  ( aw_chan_t ),
    .w_chan_t   ( w_chan_t  ),
    .b_chan_t   ( b_chan_t  ),
    .ar_chan_t  ( ar_chan_t ),
    .r_chan_t   ( r_chan_t  ),
    .axi_req_t  ( req_t     ),
    .axi_resp_t ( resp_t    ),
    .LogDepth   ( LOG_DEPTH )
  ) i_axi_cdc (
    .src_clk_i,
    .src_rst_ni,
    .src_req_i  ( src_req  ),
    .src_resp_o ( src_resp ),
    .dst_clk_i,
    .dst_rst_ni,
    .dst_req_o  ( dst_req  ),
    .dst_resp_i ( dst_resp )
  );


endmodule


