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

module axi_dw_converter_wrapper #(
  parameter int unsigned AXI_ADDR_WIDTH          = 64,
  parameter int unsigned AXI_SLV_PORT_DATA_WIDTH = 8 ,
  parameter int unsigned AXI_MST_PORT_DATA_WIDTH = 8 ,
  parameter int unsigned AXI_ID_WIDTH            = 11,
  parameter int unsigned AXI_USER_WIDTH          = 1 ,
  parameter int unsigned AXI_MAX_READS           = 8
) (
  input                                       clk_i,
  input                                       rst_ni,
  // SRC AXI Interface
  /*********************************************************************/
  //AW channel
  input     [AXI_ID_WIDTH-1:0]                slv_aw_awid,
  input     [AXI_ADDR_WIDTH-1:0]              slv_aw_awaddr,
  input     [7:0]                             slv_aw_awlen,
  input     [2:0]                             slv_aw_awsize,
  input     [1:0]                             slv_aw_awburst,
  input                                       slv_aw_awlock,
  input     [3:0]                             slv_aw_awcache,
  input     [2:0]                             slv_aw_awprot,
  input     [3:0]                             slv_aw_awqos,
  input     [3:0]                             slv_aw_awregion,
  input     [AXI_USER_WIDTH-1:0]              slv_aw_awuser,//
  input                                       slv_aw_awvalid,
  output                                      slv_aw_awready,
  //W channel
  input     [AXI_SLV_PORT_DATA_WIDTH-1:0]     slv_w_wdata,
  input     [AXI_SLV_PORT_DATA_WIDTH/8-1:0]   slv_w_wstrb,
  input                                       slv_w_wlast,
  input     [AXI_USER_WIDTH-1:0]              slv_w_wuser,
  input                                       slv_w_wvalid,
  output                                      slv_w_wready,
  //AXI4-B channel
  output    [AXI_ID_WIDTH-1:0]                slv_b_bid,
  output    [1:0]                             slv_b_bresp,
  output    [AXI_USER_WIDTH-1:0]              slv_b_buser,
  output                                      slv_b_bvalid,
  input                                       slv_b_bready,
  //AXI4-AR channel
  input     [AXI_ID_WIDTH-1:0]                slv_ar_arid,
  input     [AXI_ADDR_WIDTH-1:0]              slv_ar_araddr,
  input     [7:0]                             slv_ar_arlen,
  input     [2:0]                             slv_ar_arsize,
  input     [1:0]                             slv_ar_arburst,
  input                                       slv_ar_arlock,
  input     [3:0]                             slv_ar_arcache,
  input     [2:0]                             slv_ar_arprot,
  input     [3:0]                             slv_ar_arqos,
  input     [3:0]                             slv_ar_arregion,
  input     [AXI_USER_WIDTH-1:0]              slv_ar_aruser,
  input                                       slv_ar_arvalid,
  output                                      slv_ar_arready,
  //AXI4-R channel
  output    [AXI_ID_WIDTH-1:0]                slv_r_rid,
  output    [AXI_SLV_PORT_DATA_WIDTH-1:0]     slv_r_rdata,
  output    [1:0]                             slv_r_rresp,
  output                                      slv_r_rlast,
  output    [AXI_USER_WIDTH-1:0]              slv_r_ruser,
  output                                      slv_r_rvalid,
  input                                       slv_r_rready, 
  /*********************************************************************/

  // DST AXI Interface
  /*********************************************************************/
  //AW channel
  output    [AXI_ID_WIDTH-1:0]                mst_aw_awid,
  output    [AXI_ADDR_WIDTH-1:0]              mst_aw_awaddr,
  output    [7:0]                             mst_aw_awlen,
  output    [2:0]                             mst_aw_awsize,
  output    [1:0]                             mst_aw_awburst,
  output                                      mst_aw_awlock,
  output    [3:0]                             mst_aw_awcache,
  output    [2:0]                             mst_aw_awprot,
  output    [3:0]                             mst_aw_awqos,
  output    [3:0]                             mst_aw_awregion,
  output    [AXI_USER_WIDTH-1:0]              mst_aw_awuser,//
  output                                      mst_aw_awvalid,
  input                                       mst_aw_awready,
  //W channel
  output    [AXI_MST_PORT_DATA_WIDTH-1:0]     mst_w_wdata,
  output    [AXI_MST_PORT_DATA_WIDTH/8-1:0]   mst_w_wstrb,
  output                                      mst_w_wlast,
  output    [AXI_USER_WIDTH-1:0]              mst_w_wuser,
  output                                      mst_w_wvalid,
  input                                       mst_w_wready,
  //AXI4-B channel
  input     [AXI_ID_WIDTH-1:0]                mst_b_bid,
  input     [1:0]                             mst_b_bresp,
  input     [AXI_USER_WIDTH-1:0]              mst_b_buser,
  input                                       mst_b_bvalid,
  output                                      mst_b_bready,
  //AXI4-AR channel
  output    [AXI_ID_WIDTH-1:0]                mst_ar_arid,
  output    [AXI_ADDR_WIDTH-1:0]              mst_ar_araddr,
  output    [7:0]                             mst_ar_arlen,
  output    [2:0]                             mst_ar_arsize,
  output    [1:0]                             mst_ar_arburst,
  output                                      mst_ar_arlock,
  output    [3:0]                             mst_ar_arcache,
  output    [2:0]                             mst_ar_arprot,
  output    [3:0]                             mst_ar_arqos,
  output    [3:0]                             mst_ar_arregion,
  output    [AXI_USER_WIDTH-1:0]              mst_ar_aruser,
  output                                      mst_ar_arvalid,
  input                                       mst_ar_arready,
  //AXI4-R channel
  input     [AXI_ID_WIDTH-1:0]                mst_r_rid,
  input     [AXI_MST_PORT_DATA_WIDTH-1:0]     mst_r_rdata,
  input     [1:0]                             mst_r_rresp,
  input                                       mst_r_rlast,
  input     [AXI_USER_WIDTH-1:0]              mst_r_ruser,
  input                                       mst_r_rvalid,
  output                                      mst_r_rready 
  /*********************************************************************/
);

`include "axi/assign.svh"
`include "axi/typedef.svh"

  typedef logic [AXI_ID_WIDTH-1:0]              id_t;
  typedef logic [AXI_ADDR_WIDTH-1:0]            addr_t;
  typedef logic [AXI_MST_PORT_DATA_WIDTH-1:0]   mst_data_t;
  typedef logic [AXI_MST_PORT_DATA_WIDTH/8-1:0] mst_strb_t;
  typedef logic [AXI_SLV_PORT_DATA_WIDTH-1:0]   slv_data_t;
  typedef logic [AXI_SLV_PORT_DATA_WIDTH/8-1:0] slv_strb_t;
  typedef logic [AXI_USER_WIDTH-1:0]            user_t;
  `AXI_TYPEDEF_AW_CHAN_T(aw_chan_t, addr_t, id_t, user_t)
  `AXI_TYPEDEF_W_CHAN_T(mst_w_chan_t, mst_data_t, mst_strb_t, user_t)
  `AXI_TYPEDEF_W_CHAN_T(slv_w_chan_t, slv_data_t, slv_strb_t, user_t)
  `AXI_TYPEDEF_B_CHAN_T(b_chan_t, id_t, user_t)
  `AXI_TYPEDEF_AR_CHAN_T(ar_chan_t, addr_t, id_t, user_t)
  `AXI_TYPEDEF_R_CHAN_T(mst_r_chan_t, mst_data_t, id_t, user_t)
  `AXI_TYPEDEF_R_CHAN_T(slv_r_chan_t, slv_data_t, id_t, user_t)
  `AXI_TYPEDEF_REQ_T(mst_req_t, aw_chan_t, mst_w_chan_t, ar_chan_t)
  `AXI_TYPEDEF_RESP_T(mst_resp_t, b_chan_t, mst_r_chan_t)
  `AXI_TYPEDEF_REQ_T(slv_req_t, aw_chan_t, slv_w_chan_t, ar_chan_t)
  `AXI_TYPEDEF_RESP_T(slv_resp_t, b_chan_t, slv_r_chan_t)

  slv_req_t  slv_req;
  slv_resp_t slv_resp;
  mst_req_t  mst_req;
  mst_resp_t mst_resp;

  //`AXI_ASSIGN_TO_REQ(slv_req, slv)
  //`AXI_ASSIGN_FROM_RESP(slv, slv_resp)

  //`AXI_ASSIGN_FROM_REQ(mst, mst_req)
  //`AXI_ASSIGN_TO_RESP(mst_resp, mst)


  //Slave AXI slave interface connection
  /*********************************************************************/
  /*request*/
  assign slv_req.aw.id     = slv_aw_awid       ;
  assign slv_req.aw.addr   = slv_aw_awaddr     ;
  assign slv_req.aw.len    = slv_aw_awlen      ;
  assign slv_req.aw.size   = slv_aw_awsize     ;
  assign slv_req.aw.burst  = slv_aw_awburst    ;
  assign slv_req.aw.lock   = slv_aw_awlock     ;
  assign slv_req.aw.cache  = slv_aw_awcache    ;
  assign slv_req.aw.prot   = slv_aw_awprot     ;
  assign slv_req.aw.region = slv_aw_awregion   ;
  assign slv_req.aw.qos    = slv_aw_awqos      ;
  assign slv_req.aw.atop   = 6'd0              ;
  assign slv_req.aw.user   = slv_aw_awuser     ;
  assign slv_req.aw_valid  = slv_aw_awvalid    ;

  assign slv_req.w.data    = slv_w_wdata       ;
  assign slv_req.w.strb    = slv_w_wstrb       ;
  assign slv_req.w.last    = slv_w_wlast       ;
  assign slv_req.w.user    = slv_w_wuser       ;
  assign slv_req.w_valid   = slv_w_wvalid      ;

  assign slv_req.b_ready   = slv_b_bready      ;

  assign slv_req.ar.id     = slv_ar_arid       ;
  assign slv_req.ar.addr   = slv_ar_araddr     ;
  assign slv_req.ar.len    = slv_ar_arlen      ;   
  assign slv_req.ar.size   = slv_ar_arsize     ;
  assign slv_req.ar.burst  = slv_ar_arburst    ;
  assign slv_req.ar.lock   = slv_ar_arlock     ;
  assign slv_req.ar.cache  = slv_ar_arcache    ;
  assign slv_req.ar.prot   = slv_ar_arprot     ;
  assign slv_req.ar.region = slv_ar_arregion   ;
  assign slv_req.ar.qos    = slv_ar_arqos      ;
  assign slv_req.ar.user   = slv_ar_aruser     ;
  assign slv_req.ar_valid  = slv_ar_arvalid    ;

  assign slv_req.r_ready   = slv_r_rready      ;

  /*response*/
  assign slv_aw_awready    = slv_resp.aw_ready ;

  assign slv_w_wready      = slv_resp.w_ready  ;

  assign slv_b_bid         = slv_resp.b.id     ;
  assign slv_b_bresp       = slv_resp.b.resp   ;
  assign slv_b_buser       = slv_resp.b.user   ;
  assign slv_b_bvalid      = slv_resp.b_valid  ;

  assign slv_ar_arready    = slv_resp.ar_ready ;

  assign slv_r_rid         = slv_resp.r.id     ;
  assign slv_r_rdata       = slv_resp.r.data   ;
  assign slv_r_rresp       = slv_resp.r.resp   ;
  assign slv_r_rlast       = slv_resp.r.last   ;
  assign slv_r_ruser       = slv_resp.r.user   ;
  assign slv_r_rvalid      = slv_resp.r_valid  ;
  /*********************************************************************/

  //Master AXI Master interface connection
  /*********************************************************************/
  /*request*/
  assign mst_aw_awid       = mst_req.aw.id     ;
  assign mst_aw_awaddr     = mst_req.aw.addr   ;
  assign mst_aw_awlen      = mst_req.aw.len    ;
  assign mst_aw_awsize     = mst_req.aw.size   ;
  assign mst_aw_awburst    = mst_req.aw.burst  ;
  assign mst_aw_awlock     = mst_req.aw.lock   ;
  assign mst_aw_awcache    = mst_req.aw.cache  ;
  assign mst_aw_awprot     = mst_req.aw.prot   ;
  assign mst_aw_awregion   = mst_req.aw.region ;
  assign mst_aw_awqos      = mst_req.aw.qos    ;
  assign mst_aw_awuser     = mst_req.aw.user   ;
  assign mst_aw_awvalid    = mst_req.aw_valid  ;

  assign mst_w_wdata       = mst_req.w.data    ;
  assign mst_w_wstrb       = mst_req.w.strb    ;
  assign mst_w_wlast       = mst_req.w.last    ;
  assign mst_w_wuser       = mst_req.w.user    ;
  assign mst_w_wvalid      = mst_req.w_valid   ;

  assign mst_b_bready      = mst_req.b_ready   ;

  assign mst_ar_arid       = mst_req.ar.id     ;
  assign mst_ar_araddr     = mst_req.ar.addr   ;
  assign mst_ar_arlen      = mst_req.ar.len    ;   
  assign mst_ar_arsize     = mst_req.ar.size   ;
  assign mst_ar_arburst    = mst_req.ar.burst  ;
  assign mst_ar_arlock     = mst_req.ar.lock   ;
  assign mst_ar_arcache    = mst_req.ar.cache  ;
  assign mst_ar_arprot     = mst_req.ar.prot   ;
  assign mst_ar_arregion   = mst_req.ar.region ;
  assign mst_ar_arqos      = mst_req.ar.qos    ;
  assign mst_ar_aruser     = mst_req.ar.user   ;
  assign mst_ar_arvalid    = mst_req.ar_valid  ;

  assign mst_r_rready      = mst_req.r_ready   ;

  /*response*/
  assign mst_resp.aw_ready = mst_aw_awready    ;

  assign mst_resp.w_ready  = mst_w_wready      ;

  assign mst_resp.b.id     = mst_b_bid         ;
  assign mst_resp.b.resp   = mst_b_bresp       ;
  assign mst_resp.b.user   = mst_b_buser       ;
  assign mst_resp.b_valid  = mst_b_bvalid      ;

  assign mst_resp.ar_ready = mst_ar_arready    ;

  assign mst_resp.r.id     = mst_r_rid         ;
  assign mst_resp.r.data   = mst_r_rdata       ;
  assign mst_resp.r.resp   = mst_r_rresp       ;
  assign mst_resp.r.last   = mst_r_rlast       ;
  assign mst_resp.r.user   = mst_r_ruser       ;
  assign mst_resp.r_valid  = mst_r_rvalid      ;
  /*********************************************************************/


  axi_dw_converter #(
    .AxiMaxReads        ( AXI_MAX_READS           ),
    .AxiSlvPortDataWidth( AXI_SLV_PORT_DATA_WIDTH ),
    .AxiMstPortDataWidth( AXI_MST_PORT_DATA_WIDTH ),
    .AxiAddrWidth       ( AXI_ADDR_WIDTH          ),
    .AxiIdWidth         ( AXI_ID_WIDTH            ),
    .aw_chan_t          ( aw_chan_t               ),
    .mst_w_chan_t       ( mst_w_chan_t            ),
    .slv_w_chan_t       ( slv_w_chan_t            ),
    .b_chan_t           ( b_chan_t                ),
    .ar_chan_t          ( ar_chan_t               ),
    .mst_r_chan_t       ( mst_r_chan_t            ),
    .slv_r_chan_t       ( slv_r_chan_t            ),
    .axi_mst_req_t      ( mst_req_t               ),
    .axi_mst_resp_t     ( mst_resp_t              ),
    .axi_slv_req_t      ( slv_req_t               ),
    .axi_slv_resp_t     ( slv_resp_t              ),
    .aw_chan_width      ( 35+AXI_ID_WIDTH+AXI_ADDR_WIDTH+AXI_USER_WIDTH),
    .ar_chan_width      ( 35+AXI_ID_WIDTH+AXI_ADDR_WIDTH+AXI_USER_WIDTH)
  ) i_axi_dw_converter (
    .clk_i      ( clk_i    ),
    .rst_ni     ( rst_ni   ),
    // slave port
    .slv_req_i  ( slv_req  ),
    .slv_resp_o ( slv_resp ),
    // master port
    .mst_req_o  ( mst_req  ),
    .mst_resp_i ( mst_resp )
  );


endmodule



