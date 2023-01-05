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

module axi2mem_wrapper #(
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
  input                    [AXI_ID_WIDTH-1:0]       axi_aw_awid,
  input                    [AXI_ADDR_WIDTH-1:0]     axi_aw_awaddr,
  input                    [7:0]                    axi_aw_awlen,
  input                    [2:0]                    axi_aw_awsize,
  input                    [1:0]                    axi_aw_awburst,
  input                                             axi_aw_awlock,
  input                    [3:0]                    axi_aw_awcache,
  input                    [2:0]                    axi_aw_awprot,
  input                    [3:0]                    axi_aw_awqos,
  input                    [3:0]                    axi_aw_awregion,
  input                    [AXI_USER_WIDTH-1:0]     axi_aw_awuser,//
  input                                             axi_aw_awvalid,
  output                                            axi_aw_awready,
  //W channel
  input                    [AXI_DATA_WIDTH-1:0]     axi_w_wdata,
  input                    [AXI_DATA_WIDTH/8-1:0]   axi_w_wstrb,
  input                                             axi_w_wlast,
  input                    [AXI_USER_WIDTH-1:0]     axi_w_wuser,
  input                                             axi_w_wvalid,
  output                                            axi_w_wready,
  //AXI4-B channel
  output                   [AXI_ID_WIDTH-1:0]       axi_b_bid,
  output                   [1:0]                    axi_b_bresp,
  output                   [AXI_USER_WIDTH-1:0]     axi_b_buser,
  output                                            axi_b_bvalid,
  input                                             axi_b_bready,
  //AXI4-AR channel
  input                    [AXI_ID_WIDTH-1:0]       axi_ar_arid,
  input                    [AXI_ADDR_WIDTH-1:0]     axi_ar_araddr,
  input                    [7:0]                    axi_ar_arlen,
  input                    [2:0]                    axi_ar_arsize,
  input                    [1:0]                    axi_ar_arburst,
  input                                             axi_ar_arlock,
  input                    [3:0]                    axi_ar_arcache,
  input                    [2:0]                    axi_ar_arprot,
  input                    [3:0]                    axi_ar_arqos,
  input                    [3:0]                    axi_ar_arregion,
  input                    [AXI_USER_WIDTH-1:0]     axi_ar_aruser,
  input                                             axi_ar_arvalid,
  output                                            axi_ar_arready,
  //AXI4-R channel
  output                   [AXI_ID_WIDTH-1:0]       axi_r_rid,
  output                   [AXI_DATA_WIDTH-1:0]     axi_r_rdata,
  output                   [1:0]                    axi_r_rresp,
  output                                            axi_r_rlast,
  output                   [AXI_USER_WIDTH-1:0]     axi_r_ruser,
  output                                            axi_r_rvalid,
  input                                             axi_r_rready, 
  /*********************************************************************/

  // MEM Interface
  /*********************************************************************/
  output                                            mem_req_o,
  output                                            mem_we_o,
  output                   [AXI_ADDR_WIDTH-1:0]     mem_addr_o,
  output                   [AXI_DATA_WIDTH/8-1:0]   mem_be_o,
  output                   [AXI_DATA_WIDTH-1:0]     mem_data_o,
  input                    [AXI_DATA_WIDTH-1:0]     mem_data_i
  /*********************************************************************/
);


  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH        ),
    .AXI_ID_WIDTH   ( AXI_ID_WIDTH          ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH        )
  ) mem_axi_mst ();


  //SRC AXI slave interface connection
  /*********************************************************************/
  /*request*/
  assign mem_axi_mst.aw_id     = axi_aw_awid       ;
  assign mem_axi_mst.aw_addr   = axi_aw_awaddr     ;
  assign mem_axi_mst.aw_len    = axi_aw_awlen      ;
  assign mem_axi_mst.aw_size   = axi_aw_awsize     ;
  assign mem_axi_mst.aw_burst  = axi_aw_awburst    ;
  assign mem_axi_mst.aw_lock   = axi_aw_awlock     ;
  assign mem_axi_mst.aw_cache  = axi_aw_awcache    ;
  assign mem_axi_mst.aw_prot   = axi_aw_awprot     ;
  assign mem_axi_mst.aw_region = axi_aw_awregion   ;
  assign mem_axi_mst.aw_qos    = axi_aw_awqos      ;
  assign mem_axi_mst.aw_atop   = 6'd0              ;
  assign mem_axi_mst.aw_user   = axi_aw_awuser     ;
  assign mem_axi_mst.aw_valid  = axi_aw_awvalid    ;

  assign mem_axi_mst.w_data    = axi_w_wdata       ;
  assign mem_axi_mst.w_strb    = axi_w_wstrb       ;
  assign mem_axi_mst.w_last    = axi_w_wlast       ;
  assign mem_axi_mst.w_user    = axi_w_wuser       ;
  assign mem_axi_mst.w_valid   = axi_w_wvalid      ;

  assign mem_axi_mst.b_ready   = axi_b_bready      ;

  assign mem_axi_mst.ar_id     = axi_ar_arid       ;
  assign mem_axi_mst.ar_addr   = axi_ar_araddr     ;
  assign mem_axi_mst.ar_len    = axi_ar_arlen      ;   
  assign mem_axi_mst.ar_size   = axi_ar_arsize     ;
  assign mem_axi_mst.ar_burst  = axi_ar_arburst    ;
  assign mem_axi_mst.ar_lock   = axi_ar_arlock     ;
  assign mem_axi_mst.ar_cache  = axi_ar_arcache    ;
  assign mem_axi_mst.ar_prot   = axi_ar_arprot     ;
  assign mem_axi_mst.ar_region = axi_ar_arregion   ;
  assign mem_axi_mst.ar_qos    = axi_ar_arqos      ;
  assign mem_axi_mst.ar_user   = axi_ar_aruser     ;
  assign mem_axi_mst.ar_valid  = axi_ar_arvalid    ;

  assign mem_axi_mst.r_ready   = axi_r_rready      ;

  /*response*/
  assign axi_aw_awready        = mem_axi_mst.aw_ready ;

  assign axi_w_wready          = mem_axi_mst.w_ready  ;

  assign axi_b_bid             = mem_axi_mst.b_id     ;
  assign axi_b_bresp           = mem_axi_mst.b_resp   ;
  assign axi_b_buser           = mem_axi_mst.b_user   ;
  assign axi_b_bvalid          = mem_axi_mst.b_valid  ;

  assign axi_ar_arready        = mem_axi_mst.ar_ready ;

  assign axi_r_rid             = mem_axi_mst.r_id     ;
  assign axi_r_rdata           = mem_axi_mst.r_data   ;
  assign axi_r_rresp           = mem_axi_mst.r_resp   ;
  assign axi_r_rlast           = mem_axi_mst.r_last   ;
  assign axi_r_ruser           = mem_axi_mst.r_user   ;
  assign axi_r_rvalid          = mem_axi_mst.r_valid  ;
  /*********************************************************************/

  //DST AXI Master interface connection
  /*********************************************************************/
  /*********************************************************************/

axi2mem #(
  .AXI_ID_WIDTH   ( AXI_ID_WIDTH          ),
  .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH        ),
  .AXI_DATA_WIDTH ( AXI_DATA_WIDTH        ),
  .AXI_USER_WIDTH ( AXI_USER_WIDTH        )
) i_axi2mem (
  .clk_i  ( clk_i        ),
  .rst_ni ( rst_ni       ),
  .slave  ( mem_axi_mst  ),
  .req_o  ( mem_req_o    ),
  .we_o   ( mem_we_o     ),
  .addr_o ( mem_addr_o   ),
  .be_o   ( mem_be_o     ),
  .data_o ( mem_data_o   ),
  .data_i ( mem_data_i   )
);



endmodule


