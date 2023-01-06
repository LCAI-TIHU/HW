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

module clint_wrapper #(
  parameter int unsigned AXI_ADDRESS_WIDTH = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 64
) (
  input                               clk_i,       // Clock
  input                               rst_ni,      // Asynchronous reset active low
  input                               rtc_toggle_i,// Real-time clock in (usually 32.768 kHz)
  output                              timer_irq_o, // Timer interrupts
  output                              ipi_o,       // software interrupt (a.k.a inter-process-interrupt)
  // AXI Interface
  /*********************************************************************/
  //AW channel
  input                   [3:0]       clint_aw_awid,
  input                   [64-1:0]    clint_aw_awaddr,
  input                   [7:0]       clint_aw_awlen,
  input                   [2:0]       clint_aw_awsize,
  input                   [1:0]       clint_aw_awburst,
  input                               clint_aw_awlock,
  input                   [3:0]       clint_aw_awcache,
  input                   [2:0]       clint_aw_awprot,
  input                   [3:0]       clint_aw_awqos,
  input                   [3:0]       clint_aw_awregion,
  input                               clint_aw_awuser,//
  input                               clint_aw_awvalid,
  output                              clint_aw_awready,
  //W channel
  input                   [64-1:0]    clint_w_wdata,
  input                   [64/8-1:0]  clint_w_wstrb,
  input                               clint_w_wlast,
  input                               clint_w_wuser,
  input                               clint_w_wvalid,
  output                              clint_w_wready,
  //AXI4-B channel
  output                  [3:0]       clint_b_bid,
  output                  [1:0]       clint_b_bresp,
  output                              clint_b_buser,
  output                              clint_b_bvalid,
  input                               clint_b_bready,
  //AXI4-AR channel
  input                   [3:0]       clint_ar_arid,
  input                   [64-1:0]    clint_ar_araddr,
  input                   [7:0]       clint_ar_arlen,
  input                   [2:0]       clint_ar_arsize,
  input                   [1:0]       clint_ar_arburst,
  input                               clint_ar_arlock,
  input                   [3:0]       clint_ar_arcache,
  input                   [2:0]       clint_ar_arprot,
  input                   [3:0]       clint_ar_arqos,
  input                   [3:0]       clint_ar_arregion,
  input                               clint_ar_aruser,
  input                               clint_ar_arvalid,
  output                              clint_ar_arready,
  //AXI4-R channel
  output                  [3:0]       clint_r_rid,
  output                  [64-1:0]    clint_r_rdata,
  output                  [1:0]       clint_r_rresp,
  output                              clint_r_rlast,
  output                              clint_r_ruser,
  output                              clint_r_rvalid,
  input                               clint_r_rready 
  /*********************************************************************/
);


  // ---------------
  // CLINT
  // ---------------
  ariane_axi_soc::req_t    axi_clint_req;
  ariane_axi_soc::resp_t   axi_clint_resp;

  //axi_clint_req connection
  assign axi_clint_req.aw.id     = clint_aw_awid    ;
  assign axi_clint_req.aw.addr   = clint_aw_awaddr  ;
  assign axi_clint_req.aw.len    = clint_aw_awlen   ;
  assign axi_clint_req.aw.size   = clint_aw_awsize  ;
  assign axi_clint_req.aw.burst  = clint_aw_awburst ;
  assign axi_clint_req.aw.lock   = clint_aw_awlock  ;
  assign axi_clint_req.aw.cache  = clint_aw_awcache ;
  assign axi_clint_req.aw.prot   = clint_aw_awprot  ;
  assign axi_clint_req.aw.qos    = clint_aw_awqos   ;
  assign axi_clint_req.aw.region = clint_aw_awregion;
  assign axi_clint_req.aw.user   = clint_aw_awuser  ;
  assign axi_clint_req.aw.atop   = 5'd0             ;//non-atomic operation
  assign axi_clint_req.aw_valid  = clint_aw_awvalid ;

                                                    
  assign axi_clint_req.w.data    = clint_w_wdata    ;
  assign axi_clint_req.w.strb    = clint_w_wstrb    ;
  assign axi_clint_req.w.last    = clint_w_wlast    ;
  assign axi_clint_req.w.user    = clint_w_wuser    ;
  assign axi_clint_req.w_valid   = clint_w_wvalid   ;
                                                    
  assign axi_clint_req.b_ready   = clint_b_bready   ;
                                                    
  assign axi_clint_req.ar.id     = clint_ar_arid    ;
  assign axi_clint_req.ar.addr   = clint_ar_araddr  ;
  assign axi_clint_req.ar.len    = clint_ar_arlen   ;
  assign axi_clint_req.ar.size   = clint_ar_arsize  ;
  assign axi_clint_req.ar.burst  = clint_ar_arburst ;
  assign axi_clint_req.ar.lock   = clint_ar_arlock  ;
  assign axi_clint_req.ar.cache  = clint_ar_arcache ;
  assign axi_clint_req.ar.prot   = clint_ar_arprot  ;
  assign axi_clint_req.ar.qos    = clint_ar_arqos   ;
  assign axi_clint_req.ar.region = clint_ar_arregion;
  assign axi_clint_req.ar.user   = clint_ar_aruser  ;
  assign axi_clint_req.ar_valid  = clint_ar_arvalid ;
                                                    
  assign axi_clint_req.r_ready   = clint_r_rready   ; 


  //axi_clint_resp connection
  assign clint_aw_awready        = axi_clint_resp.aw_ready;
  assign clint_w_wready          = axi_clint_resp.w_ready ;
  assign clint_ar_arready        = axi_clint_resp.ar_ready;
                                                          
  assign clint_b_bid             = axi_clint_resp.b.id    ;
  assign clint_b_bresp           = axi_clint_resp.b.resp  ;
  assign clint_b_buser           = axi_clint_resp.b.user  ;
  assign clint_b_bvalid          = axi_clint_resp.b_valid ;
                                                          
  assign clint_r_rid             = axi_clint_resp.r.id    ;
  assign clint_r_rdata           = axi_clint_resp.r.data  ;
  assign clint_r_rresp           = axi_clint_resp.r.resp  ;
  assign clint_r_rlast           = axi_clint_resp.r.last  ;
  assign clint_r_ruser           = axi_clint_resp.r.user  ;
  assign clint_r_rvalid          = axi_clint_resp.r_valid ;


  /*********************************************************************/
  reg  sync_0;
  reg  sync_1;
  reg  sync_2;
  reg  rtc_toggle_sync_ff;
  reg  rtc_i;

  wire rtc_toggle_sync;

  always @(posedge clk_i or negedge rst_ni) begin
	  if(rst_ni == 1'b0) begin
          sync_0 <= 1'b0;
	  end
	  else begin
          sync_0 <= sync_1;
	  end
  end

  always @(posedge clk_i or negedge rst_ni) begin
	  if(rst_ni == 1'b0) begin
          sync_1 <= 1'b0;
	  end
	  else begin
          sync_1 <= sync_2;
	  end
  end

  always @(posedge clk_i or negedge rst_ni) begin
	  if(rst_ni == 1'b0) begin
          sync_2 <= 1'b0;
	  end
	  else begin
          sync_2 <= rtc_toggle_i;
	  end
  end

  assign rtc_toggle_sync = sync_0;

  always @(posedge clk_i or negedge rst_ni) begin
	  if(rst_ni == 1'b0) begin
          rtc_toggle_sync_ff <= 1'b0;
	  end
	  else begin
          rtc_toggle_sync_ff <= rtc_toggle_sync;
	  end
  end

  always @(posedge clk_i or negedge rst_ni) begin
	  if(rst_ni == 1'b0) begin
          rtc_i <= 1'b0;
	  end
	  else begin
          rtc_i <= rtc_toggle_sync & ~rtc_toggle_sync_ff;
	  end
  end
  /*********************************************************************/


  clint #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .NR_CORES       ( 1                        )
  ) i_clint (
    .clk_i       ( clk_i          ),
    .rst_ni      ( rst_ni         ),
    .testmode_i  ( 1'b0           ),
    .axi_req_i   ( axi_clint_req  ),
    .axi_resp_o  ( axi_clint_resp ),
    .rtc_i       ( rtc_i          ),
    .timer_irq_o ( timer_irq_o    ),
    .ipi_o       ( ipi_o          )
  );


endmodule
