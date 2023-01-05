// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Xilinx Peripehrals
module plic_wrapper 
  (
    input                               clk_i,        // Clock
    input                               rst_ni,       // Asynchronous reset active low
    input                   [29:0]      le_i,         // 0:level 1:edge
    // Interrupt Sources
    input                   [29:0]      irq_sources_i,
    // Interrupt notification to targets
    output                  [1:0]       irq_o,
    // AXI Interface
    /*********************************************************************/
    //AW channel
    input                   [4:0]       plic_aw_awid,
    input                   [64-1:0]    plic_aw_awaddr,
    input                   [7:0]       plic_aw_awlen,
    input                   [2:0]       plic_aw_awsize,
    input                   [1:0]       plic_aw_awburst,
    input                               plic_aw_awlock,
    input                   [3:0]       plic_aw_awcache,
    input                   [2:0]       plic_aw_awprot,
    input                   [3:0]       plic_aw_awqos,
    input                   [3:0]       plic_aw_awregion,
    input                               plic_aw_awuser,//
    input                               plic_aw_awvalid,
    output                              plic_aw_awready,
    //W channel
    input                   [64-1:0]    plic_w_wdata,
    input                   [64/8-1:0]  plic_w_wstrb,
    input                               plic_w_wlast,
    input                               plic_w_wuser,
    input                               plic_w_wvalid,
    output                              plic_w_wready,
    //AXI4-B channel
    output                  [4:0]       plic_b_bid,
    output                  [1:0]       plic_b_bresp,
    output                              plic_b_buser,
    output                              plic_b_bvalid,
    input                               plic_b_bready,
    //AXI4-AR channel
    input                   [4:0]       plic_ar_arid,
    input                   [64-1:0]    plic_ar_araddr,
    input                   [7:0]       plic_ar_arlen,
    input                   [2:0]       plic_ar_arsize,
    input                   [1:0]       plic_ar_arburst,
    input                               plic_ar_arlock,
    input                   [3:0]       plic_ar_arcache,
    input                   [2:0]       plic_ar_arprot,
    input                   [3:0]       plic_ar_arqos,
    input                   [3:0]       plic_ar_arregion,
    input                               plic_ar_aruser,
    input                               plic_ar_arvalid,
    output                              plic_ar_arready,
    //AXI4-R channel
    output                  [4:0]       plic_r_rid,
    output                  [64-1:0]    plic_r_rdata,
    output                  [1:0]       plic_r_rresp,
    output                              plic_r_rlast,
    output                              plic_r_ruser,
    output                              plic_r_rvalid,
    input                               plic_r_rready 
    /*********************************************************************/
);


    // ---------------
    // 1. PLIC
    // ---------------
    //logic [ariane_soc::NumSources-1:0] irq_sources;

    //// Unused interrupt sources
    //assign irq_sources[ariane_soc::NumSources-1:7] = '0;

    REG_BUS #(
        .ADDR_WIDTH ( 32 ),
        .DATA_WIDTH ( 32 )
    ) reg_bus (clk_i);

    logic         plic_penable;
    logic         plic_pwrite;
    logic [31:0]  plic_paddr;
    logic         plic_psel;
    logic [31:0]  plic_pwdata;
    logic [31:0]  plic_prdata;
    logic         plic_pready;
    logic         plic_pslverr;

    axi2apb_64_32 #(
        .AXI4_ADDRESS_WIDTH ( 64  ),
        .AXI4_RDATA_WIDTH   ( 64  ),
        .AXI4_WDATA_WIDTH   ( 64  ),
        .AXI4_ID_WIDTH      ( 5   ),
        .AXI4_USER_WIDTH    ( 1   ),
        .BUFF_DEPTH_SLAVE   ( 2   ),
        .APB_ADDR_WIDTH     ( 32  )
    ) i_axi2apb_64_32_plic (
        .ACLK      ( clk_i            ),
        .ARESETn   ( rst_ni           ),
        .test_en_i ( 1'b0             ),
        .AWID_i    ( plic_aw_awid     ),
        .AWADDR_i  ( plic_aw_awaddr   ),
        .AWLEN_i   ( plic_aw_awlen    ),
        .AWSIZE_i  ( plic_aw_awsize   ),
        .AWBURST_i ( plic_aw_awburst  ),
        .AWLOCK_i  ( plic_aw_awlock   ),
        .AWCACHE_i ( plic_aw_awcache  ),
        .AWPROT_i  ( plic_aw_awprot   ),
        .AWREGION_i( plic_aw_awregion ),
        .AWUSER_i  ( plic_aw_awuser   ),
        .AWQOS_i   ( plic_aw_awqos    ),
        .AWVALID_i ( plic_aw_awvalid  ),
        .AWREADY_o ( plic_aw_awready  ),
        .WDATA_i   ( plic_w_wdata     ),
        .WSTRB_i   ( plic_w_wstrb     ),
        .WLAST_i   ( plic_w_wlast     ),
        .WUSER_i   ( plic_w_wuser     ),
        .WVALID_i  ( plic_w_wvalid    ),
        .WREADY_o  ( plic_w_wready    ),
        .BID_o     ( plic_b_bid       ),
        .BRESP_o   ( plic_b_bresp     ),
        .BVALID_o  ( plic_b_bvalid    ),
        .BUSER_o   ( plic_b_buser     ),
        .BREADY_i  ( plic_b_bready    ),
        .ARID_i    ( plic_ar_arid     ),
        .ARADDR_i  ( plic_ar_araddr   ),
        .ARLEN_i   ( plic_ar_arlen    ),
        .ARSIZE_i  ( plic_ar_arsize   ),
        .ARBURST_i ( plic_ar_arburst  ),
        .ARLOCK_i  ( plic_ar_arlock   ),
        .ARCACHE_i ( plic_ar_arcache  ),
        .ARPROT_i  ( plic_ar_arprot   ),
        .ARREGION_i( plic_ar_arregion ),
        .ARUSER_i  ( plic_ar_aruser   ),
        .ARQOS_i   ( plic_ar_arqos    ),
        .ARVALID_i ( plic_ar_arvalid  ),
        .ARREADY_o ( plic_ar_arready  ),
        .RID_o     ( plic_r_rid       ),
        .RDATA_o   ( plic_r_rdata     ),
        .RRESP_o   ( plic_r_rresp     ),
        .RLAST_o   ( plic_r_rlast     ),
        .RUSER_o   ( plic_r_ruser     ),
        .RVALID_o  ( plic_r_rvalid    ),
        .RREADY_i  ( plic_r_rready    ),
        .PENABLE   ( plic_penable     ),
        .PWRITE    ( plic_pwrite      ),
        .PADDR     ( plic_paddr       ),
        .PSEL      ( plic_psel        ),
        .PWDATA    ( plic_pwdata      ),
        .PRDATA    ( plic_prdata      ),
        .PREADY    ( plic_pready      ),
        .PSLVERR   ( plic_pslverr     )
    );

    apb_to_reg i_apb_to_reg (
        .clk_i     ( clk_i        ),
        .rst_ni    ( rst_ni       ),
        .penable_i ( plic_penable ),
        .pwrite_i  ( plic_pwrite  ),
        .paddr_i   ( plic_paddr   ),
        .psel_i    ( plic_psel    ),
        .pwdata_i  ( plic_pwdata  ),
        .prdata_o  ( plic_prdata  ),
        .pready_o  ( plic_pready  ),
        .pslverr_o ( plic_pslverr ),
        .reg_o     ( reg_bus      )
    );

    reg_intf::reg_intf_resp_d32 plic_resp;
    reg_intf::reg_intf_req_a32_d32 plic_req;

    assign plic_req.addr  = reg_bus.addr;
    assign plic_req.write = reg_bus.write;
    assign plic_req.wdata = reg_bus.wdata;
    assign plic_req.wstrb = reg_bus.wstrb;
    assign plic_req.valid = reg_bus.valid;

    assign reg_bus.rdata = plic_resp.rdata;
    assign reg_bus.error = plic_resp.error;
    assign reg_bus.ready = plic_resp.ready;

    plic_top #(
      .N_SOURCE    ( 30/*ariane_soc::NumSources*/  ),
      .N_TARGET    ( 2 /*ariane_soc::NumTargets*/  ),
      .MAX_PRIO    ( 7 /*ariane_soc::MaxPriority*/ )
    ) i_plic (
      .clk_i,
      .rst_ni,
      .req_i         ( plic_req      ),
      .resp_o        ( plic_resp     ),
      .le_i          ( le_i          ), // 0:level 1:edge
      .irq_sources_i ( irq_sources_i ),
      .eip_targets_o ( irq_o         )
    );


endmodule
