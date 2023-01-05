// Copyright 2021 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Author: Matheus Cavalcante <matheusd@iis.ee.ethz.ch>
// Description:
// Ara's SoC, containing Ariane, Ara, and a L2 cache.

module ariane_ara_wrapper import axi_pkg::*; import ara_pkg::*; #(
    // RVV Parameters
    parameter  int           unsigned NrLanes      = 2,                          // Number of parallel vector lanes.
    // AXI Interface
    parameter  int           unsigned AxiAddrWidth = 64,
    parameter  int           unsigned AxiUserWidth = 1,
    parameter  int           unsigned AxiIdWidth   = 5,
    // Dependant parameters. DO NOT CHANGE!
    localparam  int          unsigned AxiDataWidth = 32*NrLanes,
    localparam type                   axi_data_t   = logic [AxiDataWidth-1:0],
    localparam type                   axi_strb_t   = logic [AxiDataWidth/8-1:0],
    localparam type                   axi_addr_t   = logic [AxiAddrWidth-1:0],
    localparam type                   axi_user_t   = logic [AxiUserWidth-1:0],
    localparam type                   axi_id_t     = logic [AxiIdWidth-1:0],
    // Support for floating-point data types
    localparam fpu_support_e          FPUSupport   = FPUSupportHalfSingleDouble
  ) (
    input                                clk_i,
    input                                rst_ni,
    // Core ID, Cluster ID and boot address are considered more or less static
    input                    [63:0]      boot_addr_i,  // reset boot address
    // Interrupt inputs
    input                    [1:0]       irq_i,        // level sensitive IR lines, mip & sip (async)
    input                                ipi_i,        // inter-processor interrupts (async)
    // Timer facilities
    input                                time_irq_i,   // timer interrupt in (async)
    input                                debug_req_i,  // debug request (async)
    // AXI Interface
    /*********************************************************************/
    //AW channel
    output            [4:0]              ariane_ara_sys_aw_awid,
    output            [64-1:0]           ariane_ara_sys_aw_awaddr,
    output            [7:0]              ariane_ara_sys_aw_awlen,
    output            [2:0]              ariane_ara_sys_aw_awsize,
    output            [1:0]              ariane_ara_sys_aw_awburst,
    output                               ariane_ara_sys_aw_awlock,
    output            [3:0]              ariane_ara_sys_aw_awcache,
    output            [2:0]              ariane_ara_sys_aw_awprot,
    output            [3:0]              ariane_ara_sys_aw_awqos,
    output            [3:0]              ariane_ara_sys_aw_awregion,
    output                               ariane_ara_sys_aw_awuser,//
    output                               ariane_ara_sys_aw_awvalid,
    input                                ariane_ara_sys_aw_awready,
    //W channel
    output            [NrLanes*32-1:0]   ariane_ara_sys_w_wdata,
    output            [NrLanes*32/8-1:0] ariane_ara_sys_w_wstrb,
    output                               ariane_ara_sys_w_wlast,
    output                               ariane_ara_sys_w_wuser,
    output                               ariane_ara_sys_w_wvalid,
    input                                ariane_ara_sys_w_wready,
    //AXI4-B channel
    input             [4:0]              ariane_ara_sys_b_bid,
    input             [1:0]              ariane_ara_sys_b_bresp,
    input                                ariane_ara_sys_b_buser,
    input                                ariane_ara_sys_b_bvalid,
    output                               ariane_ara_sys_b_bready,
    //AXI4-AR channel
    output            [4:0]              ariane_ara_sys_ar_arid,
    output            [64-1:0]           ariane_ara_sys_ar_araddr,
    output            [7:0]              ariane_ara_sys_ar_arlen,
    output            [2:0]              ariane_ara_sys_ar_arsize,
    output            [1:0]              ariane_ara_sys_ar_arburst,
    output                               ariane_ara_sys_ar_arlock,
    output            [3:0]              ariane_ara_sys_ar_arcache,
    output            [2:0]              ariane_ara_sys_ar_arprot,
    output            [3:0]              ariane_ara_sys_ar_arqos,
    output            [3:0]              ariane_ara_sys_ar_arregion,
    output                               ariane_ara_sys_ar_aruser,
    output                               ariane_ara_sys_ar_arvalid,
    input                                ariane_ara_sys_ar_arready,
    //AXI4-R channel
    input             [4:0]              ariane_ara_sys_r_rid,
    input             [NrLanes*32-1:0]   ariane_ara_sys_r_rdata,
    input             [1:0]              ariane_ara_sys_r_rresp,
    input                                ariane_ara_sys_r_rlast,
    input                                ariane_ara_sys_r_ruser,
    input                                ariane_ara_sys_r_rvalid,
    output                               ariane_ara_sys_r_rready 
    /*********************************************************************/
  );

  `include "assign.svh"
  `include "typedef.svh"
  `include "common_cells/registers.svh"

  //////////////////////
  //  Memory Regions  //
  //////////////////////
  localparam NrAXIMasters = 1; // Actually masters, but slaves on the crossbar
  localparam NrAXISlaves = 2 + 1;

  // Memory Map
  // 1GByte of DDR (split between two chips on Genesys2)
  localparam logic [63:0] DRAMLength = 64'h80000000;
  localparam logic [63:0] DRAMBase   = 64'h8000_0000;
  localparam logic [63:0] ROMLength  = 64'h20000;
  localparam logic [63:0] ROMBase    = 64'h4000_0000;
  localparam logic [63:0] RAMLength  = 64'h400000;
  localparam logic [63:0] RAMBase    = 64'h4060_0000;

  //typedef enum logic [63:0] {
  //  DRAMBase = 64'h8000_0000,
  //  UARTBase = 64'hC000_0000,
  //  CTRLBase = 64'hD000_0000
  //} soc_bus_start_e;

  ///////////
  //  AXI  //
  ///////////
  // Ariane's AXI port data width
  localparam AxiNarrowDataWidth = 64;
  localparam AxiNarrowStrbWidth = AxiNarrowDataWidth / 8;
  // Ara's AXI port data width
  localparam AxiWideDataWidth   = AxiDataWidth;
  localparam AXiWideStrbWidth   = AxiWideDataWidth / 8;

  localparam AxiSocIdWidth  = AxiIdWidth - $clog2(NrAXIMasters);
  localparam AxiCoreIdWidth = AxiSocIdWidth - 1;

  // Internal types
  typedef logic [AxiNarrowDataWidth-1:0] axi_narrow_data_t;
  typedef logic [AxiNarrowStrbWidth-1:0] axi_narrow_strb_t;
  typedef logic [AxiSocIdWidth-1:0] axi_soc_id_t;
  typedef logic [AxiCoreIdWidth-1:0] axi_core_id_t;

  // AXI Typedefs
  `AXI_TYPEDEF_ALL(system, axi_addr_t, axi_id_t, axi_data_t, axi_strb_t, axi_user_t)
  `AXI_TYPEDEF_ALL(ara_axi, axi_addr_t, axi_core_id_t, axi_data_t, axi_strb_t, axi_user_t)
  `AXI_TYPEDEF_ALL(ariane_axi, axi_addr_t, axi_core_id_t, axi_narrow_data_t, axi_narrow_strb_t,axi_user_t)


  // Buses
  system_req_t  system_axi_req;
  system_resp_t system_axi_resp;

  //system_axi_req connection
  assign ariane_ara_sys_aw_awid     = system_axi_req.aw.id;
  assign ariane_ara_sys_aw_awaddr   = system_axi_req.aw.addr;
  assign ariane_ara_sys_aw_awlen    = system_axi_req.aw.len;
  assign ariane_ara_sys_aw_awsize   = system_axi_req.aw.size;
  assign ariane_ara_sys_aw_awburst  = system_axi_req.aw.burst;
  assign ariane_ara_sys_aw_awlock   = system_axi_req.aw.lock;
  assign ariane_ara_sys_aw_awcache  = system_axi_req.aw.cache;
  assign ariane_ara_sys_aw_awprot   = system_axi_req.aw.prot;
  assign ariane_ara_sys_aw_awqos    = system_axi_req.aw.qos;
  assign ariane_ara_sys_aw_awregion = system_axi_req.aw.region;
  assign ariane_ara_sys_aw_awuser   = system_axi_req.aw.user;
  assign ariane_ara_sys_aw_awvalid  = system_axi_req.aw_valid;

  assign ariane_ara_sys_w_wdata     = system_axi_req.w.data;
  assign ariane_ara_sys_w_wstrb     = system_axi_req.w.strb;
  assign ariane_ara_sys_w_wlast     = system_axi_req.w.last;
  assign ariane_ara_sys_w_wuser     = system_axi_req.w.user;
  assign ariane_ara_sys_w_wvalid    = system_axi_req.w_valid;

  assign ariane_ara_sys_b_bready    = system_axi_req.b_ready;

  assign ariane_ara_sys_ar_arid     = system_axi_req.ar.id;
  assign ariane_ara_sys_ar_araddr   = system_axi_req.ar.addr;
  assign ariane_ara_sys_ar_arlen    = system_axi_req.ar.len;
  assign ariane_ara_sys_ar_arsize   = system_axi_req.ar.size;
  assign ariane_ara_sys_ar_arburst  = system_axi_req.ar.burst;
  assign ariane_ara_sys_ar_arlock   = system_axi_req.ar.lock;
  assign ariane_ara_sys_ar_arcache  = system_axi_req.ar.cache;
  assign ariane_ara_sys_ar_arprot   = system_axi_req.ar.prot;
  assign ariane_ara_sys_ar_arqos    = system_axi_req.ar.qos;
  assign ariane_ara_sys_ar_arregion = system_axi_req.ar.region;
  assign ariane_ara_sys_ar_aruser   = system_axi_req.ar.user;
  assign ariane_ara_sys_ar_arvalid  = system_axi_req.ar_valid;

  assign ariane_ara_sys_r_rready    = system_axi_req.r_ready; 


  //system_axi_resp connection
  assign system_axi_resp.aw_ready   = ariane_ara_sys_aw_awready;
  assign system_axi_resp.w_ready    = ariane_ara_sys_w_wready;
  assign system_axi_resp.ar_ready   = ariane_ara_sys_ar_arready;

  assign system_axi_resp.b.id       = ariane_ara_sys_b_bid;
  assign system_axi_resp.b.resp     = ariane_ara_sys_b_bresp;
  assign system_axi_resp.b.user     = ariane_ara_sys_b_buser;
  assign system_axi_resp.b_valid    = ariane_ara_sys_b_bvalid;

  assign system_axi_resp.r.id       = ariane_ara_sys_r_rid;
  assign system_axi_resp.r.data     = ariane_ara_sys_r_rdata;
  assign system_axi_resp.r.resp     = ariane_ara_sys_r_rresp;
  assign system_axi_resp.r.last     = ariane_ara_sys_r_rlast;
  assign system_axi_resp.r.user     = ariane_ara_sys_r_ruser;
  assign system_axi_resp.r_valid    = ariane_ara_sys_r_rvalid;


  //////////////
  //  System  //
  //////////////
  localparam ariane_pkg::ariane_cfg_t ArianeAraConfig = '{
    RASDepth             : 2,
    BTBEntries           : 32,
    BHTEntries           : 128,
    // idempotent region
    NrNonIdempotentRules : 2,
    NonIdempotentAddrBase: {64'b0, 64'b0},
    NonIdempotentLength  : {64'b0, 64'b0},
    NrExecuteRegionRules : 3,
    //                      DRAM,       Boot ROM,   RAM
    ExecuteRegionAddrBase: {DRAMBase  , ROMBase,    RAMBase  },
    ExecuteRegionLength  : {DRAMLength, ROMLength,  RAMLength},
    // cached region
    //NrCachedRegionRules  : 2,
    //CachedRegionAddrBase : {ROMBase,  DRAMBase},
    //CachedRegionLength   : {ROMLength,DRAMLength},
    NrCachedRegionRules  : 1,
    CachedRegionAddrBase : {DRAMBase},
    CachedRegionLength   : {DRAMLength},
    //  cache config
    Axi64BitCompliant    : 1'b1,
    SwapEndianess        : 1'b0,
    // debug
    DmBaseAddress        : 64'h0,
    NrPMPEntries         : 0
  };

  ariane_ara #(
    .NrLanes                  (NrLanes              ),
    .FPUSupport               (FPUSupport           ),
    .ArianeCfg                (ArianeAraConfig      ),
    .AxiAddrWidth             (AxiAddrWidth         ),
    .AxiIdWidth               (AxiCoreIdWidth       ),
    .AxiNarrowDataWidth       (AxiNarrowDataWidth   ),
    .AxiWideDataWidth         (AxiDataWidth         ),
    .ara_axi_ar_t             (ara_axi_ar_chan_t    ),
    .ara_axi_aw_t             (ara_axi_aw_chan_t    ),
    .ara_axi_b_t              (ara_axi_b_chan_t     ),
    .ara_axi_r_t              (ara_axi_r_chan_t     ),
    .ara_axi_w_t              (ara_axi_w_chan_t     ),
    .ara_axi_req_t            (ara_axi_req_t        ),
    .ara_axi_resp_t           (ara_axi_resp_t       ),
    .ariane_axi_ar_t          (ariane_axi_ar_chan_t ),
    .ariane_axi_aw_t          (ariane_axi_aw_chan_t ),
    .ariane_axi_b_t           (ariane_axi_b_chan_t  ),
    .ariane_axi_r_t           (ariane_axi_r_chan_t  ),
    .ariane_axi_w_t           (ariane_axi_w_chan_t  ),
    .ariane_axi_req_t         (ariane_axi_req_t     ),
    .ariane_axi_resp_t        (ariane_axi_resp_t    ),
    .system_axi_ar_t          (system_ar_chan_t     ),
    .system_axi_aw_t          (system_aw_chan_t     ),
    .system_axi_b_t           (system_b_chan_t      ),
    .system_axi_r_t           (system_r_chan_t      ),
    .system_axi_w_t           (system_w_chan_t      ),
    .system_axi_req_t         (system_req_t         ),
    .system_axi_resp_t        (system_resp_t        ),
    .ariane_axi_aw_chan_width (35+AxiCoreIdWidth+AxiAddrWidth+AxiUserWidth),
    .ariane_axi_ar_chan_width (35+AxiCoreIdWidth+AxiAddrWidth+AxiUserWidth))
  i_system (
    .clk_i        (clk_i            ),
    .rst_ni       (rst_ni           ),
    .boot_addr_i  (boot_addr_i      ), // reset boot address
    .irq_i        (irq_i            ), 
    .ipi_i        (ipi_i            ), 
    .time_irq_i   (time_irq_i       ), 
    .debug_req_i  (debug_req_i      ), 
    .scan_enable_i(1'b0             ),
    .scan_data_i  (1'b0             ),
    .scan_data_o  (/* Unconnected */),
    .axi_req_o    (system_axi_req   ),
    .axi_resp_i   (system_axi_resp  )
  );


  //////////////////
  //  Assertions  //
  //////////////////
  /*
  if (NrLanes == 0)
    $error("[ariane_ara_wrapper] Ara needs to have at least one lane.");

  if (AxiDataWidth == 0)
    $error("[ariane_ara_wrapper] The AXI data width must be greater than zero.");

  if (AxiAddrWidth == 0)
    $error("[ariane_ara_wrapper] The AXI address width must be greater than zero.");

  if (AxiUserWidth == 0)
    $error("[ariane_ara_wrapper] The AXI user width must be greater than zero.");

  if (AxiIdWidth == 0)
    $error("[ariane_ara_wrapper] The AXI ID width must be greater than zero.");
  */

endmodule : ariane_ara_wrapper
