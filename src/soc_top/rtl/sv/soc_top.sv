// This system-verilog module was generated by Vega
//               Please do not edit!

//---------------------------------------------------------------------------
//                                                                           
//              Inspur Confidential                                          
// Copyright (c) 2021 Inspur. All rights reserved
//                                                                           
// File    : /nfs/work/shared/aipu.work/dingzhiming/workspace/dingzhiming.aipu.default/env_repo/design_repo/rtl/soc_top/rtl/sv/soc_top.sv
// Author  : Inspur Xi'an R&D                                                
// History : 2021-Sep-29 11:27:34 AM - Created    
//                                                                           
//---------------------------------------------------------------------------

module soc_top(
    SYS_CLK,
    SYS_RST_n,
    DDR4_REF_CLK_p,
    DDR4_REF_CLK_n,
    PCIE_EP_nPRESET,
    PCIE_EP_REFCLK_p,
    PCIE_EP_REFCLK_n,
    TDI,
    TMS,
    TCK,
    TRST_n,
    UART_RXD,
    JTAG_MUX,
    BOOT_STRAP,
    PCIE_EP_EXP_RX_n,
    PCIE_EP_EXP_RX_p,
    C0_DDR4_ACT_n,
    C0_DDR4_CK_t,
    C0_DDR4_CK_c,
    C0_DDR4_RESET_n,
    PCIE_EP_LNK_UP,
    TDO,
    TDO_DRIVEN,
    UART_TXD,
    C0_DDR4_CKE,
    C0_DDR4_ODT,
    C0_DDR4_CS_n,
    C0_DDR4_ADR,
    C0_DDR4_BA,
    C0_DDR4_BG,
    PCIE_EP_EXP_TX_n,
    PCIE_EP_EXP_TX_p,
    C0_DDR4_DM_DBI_n,
    C0_DDR4_DQ,
    C0_DDR4_DQS_C,
    C0_DDR4_DQS_T
);
input SYS_CLK;
input SYS_RST_n;
input DDR4_REF_CLK_p;
input DDR4_REF_CLK_n;
input PCIE_EP_nPRESET;
input PCIE_EP_REFCLK_p;
input PCIE_EP_REFCLK_n;
input TDI;
input TMS;
input TCK;
input TRST_n;
input UART_RXD;
input JTAG_MUX;
input BOOT_STRAP;
input [1:0] PCIE_EP_EXP_RX_n;
input [1:0] PCIE_EP_EXP_RX_p;
output C0_DDR4_ACT_n;
output C0_DDR4_CK_t;
output C0_DDR4_CK_c;
output C0_DDR4_RESET_n;
output PCIE_EP_LNK_UP;
output TDO;
output TDO_DRIVEN;
output UART_TXD;
output C0_DDR4_CKE;
output C0_DDR4_ODT;
output C0_DDR4_CS_n;
output [16:0] C0_DDR4_ADR;
output [1:0] C0_DDR4_BA;
output [1:0] C0_DDR4_BG;
output [1:0] PCIE_EP_EXP_TX_n;
output [1:0] PCIE_EP_EXP_TX_p;
inout [8:0] C0_DDR4_DM_DBI_n;
inout [71:0] C0_DDR4_DQ;
inout [8:0] C0_DDR4_DQS_C;
inout [8:0] C0_DDR4_DQS_T;

// input wires

// output wires

// internal wires
wire        u_tdi_ahbmux_z_s;
wire        u_tdi_rmux_z_s;
wire        u_tms_ahbmux_z_s;
wire        u_tms_rmux_z_s;
wire        u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_s;

wire        riscv_debug_dmactive_i_s;
wire        riscv_debug_dmactiveack_s;

wire        u_uncore_top_riscv_clk_s;
wire        u_uncore_top_riscv_core_clk_s;
wire        u_uncore_top_riscv_rst_s;
wire        u_uncore_top_riscv_debug_clk_s;
wire        u_uncore_top_riscv_debug_rst_s;
wire        u_uncore_top_riscv_rtc_toggle_s;
wire        u_uncore_top_per_clk_s;
wire        u_uncore_top_core_nic_rst_n_s;
wire        u_uncore_top_dla_csb_clk_s;
wire        u_uncore_top_dla_core_clk_s;
wire        u_uncore_top_mac_rst_n_s;
wire        u_uncore_top_dma_clk_s;
wire        u_uncore_top_dma_rst_n_s;
wire        por_rstn_sync_s;
wire        u_xdma_0_top_axi_aclk_s;
wire        u_xdma_0_top_axi_aresetn_s;
wire        u_uncore_top_ddr_rst_s;
wire        u_ddr4_0_top_c0_init_calib_complete_s;
wire        msi_enable_s;
wire        msix_enable_s;
wire [2:0]  msi_vector_width_s;
wire [2:0]  usr_irq_req_s;
wire [2:0]  usr_irq_ack_s;

wire [10:0] u_uncore_top_AWID_AXI_CORE_MST_s;
wire        u_uncore_top_AWVALID_AXI_CORE_MST_s;
wire        u_uncore_top_AWREADY_AXI_CORE_MST_s;
wire [31:0] u_uncore_top_AWADDR_AXI_CORE_MST_s;
wire [7:0]  u_uncore_top_AWLEN_AXI_CORE_MST_s;
wire [2:0]  u_uncore_top_AWSIZE_AXI_CORE_MST_s;
wire [1:0]  u_uncore_top_AWBURST_AXI_CORE_MST_s;
wire        u_uncore_top_AWLOCK_AXI_CORE_MST_s;
wire [3:0]  u_uncore_top_AWCACHE_AXI_CORE_MST_s;
wire [2:0]  u_uncore_top_AWPROT_AXI_CORE_MST_s;
wire        u_uncore_top_WVALID_AXI_CORE_MST_s;
wire        u_uncore_top_WREADY_AXI_CORE_MST_s;
wire        u_uncore_top_WLAST_AXI_CORE_MST_s;
wire [31:0] u_uncore_top_WDATA_AXI_CORE_MST_s;
wire [3:0]  u_uncore_top_WSTRB_AXI_CORE_MST_s;
wire [10:0] u_uncore_top_BID_AXI_CORE_MST_s;
wire        u_uncore_top_BVALID_AXI_CORE_MST_s;
wire        u_uncore_top_BREADY_AXI_CORE_MST_s;
wire [1:0]  u_uncore_top_BRESP_AXI_CORE_MST_s;
wire [10:0] u_uncore_top_ARID_AXI_CORE_MST_s;
wire        u_uncore_top_ARVALID_AXI_CORE_MST_s;
wire        u_uncore_top_ARREADY_AXI_CORE_MST_s;
wire [31:0] u_uncore_top_ARADDR_AXI_CORE_MST_s;
wire [7:0]  u_uncore_top_ARLEN_AXI_CORE_MST_s;
wire [2:0]  u_uncore_top_ARSIZE_AXI_CORE_MST_s;
wire [1:0]  u_uncore_top_ARBURST_AXI_CORE_MST_s;
wire        u_uncore_top_ARLOCK_AXI_CORE_MST_s;
wire [3:0]  u_uncore_top_ARCACHE_AXI_CORE_MST_s;
wire [2:0]  u_uncore_top_ARPROT_AXI_CORE_MST_s;
wire [10:0] u_uncore_top_RID_AXI_CORE_MST_s;
wire        u_uncore_top_RVALID_AXI_CORE_MST_s;
wire        u_uncore_top_RREADY_AXI_CORE_MST_s;
wire [31:0] u_uncore_top_RDATA_AXI_CORE_MST_s;
wire [1:0]  u_uncore_top_RRESP_AXI_CORE_MST_s;
wire        u_uncore_top_RLAST_AXI_CORE_MST_s;

wire        u_uncore_top_timer0_int_ovf_s;
wire        u_uncore_top_timer0_int_cmp_s;
wire        u_uncore_top_timer1_int_ovf_s;
wire        u_uncore_top_timer1_int_cmp_s;
wire        u_uncore_top_sw_int0_s;
wire        u_uncore_top_sw_int1_s;
wire        u_uncore_top_scu_int_s;
wire        u_uncore_top_uart_int_s;

// input assign

// output assign

// internal assign

//u_jtag_mux instance
jtag_mux u_jtag_mux(
    //input ports
    .u_soc_top_JTAG_MUX_i(JTAG_MUX),
    .u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_i(u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_s),
    .u_uncore_top_jtag2ahb_tdo_i(1'b0),
    .u_soc_top_TDI_i(TDI),
    .u_soc_top_TMS_i(TMS),
    //output ports
    .u_tdo_mux_z_o(TDO),
    .u_tdi_rmux_z_o(u_tdi_rmux_z_s),
    .u_tms_rmux_z_o(u_tms_rmux_z_s),
    .u_tdi_ahbmux_z_o(u_tdi_ahbmux_z_s),
    .u_tms_ahbmux_z_o(u_tms_ahbmux_z_s)
    //inout ports
);

//u_core_top instance
core_top u_core_top(
    //added 
    .u_uncore_top_riscv_clk_i(u_uncore_top_riscv_clk_s),
    .u_uncore_top_riscv_core_clk_i(u_uncore_top_riscv_core_clk_s),
    .u_uncore_top_riscv_rst_i(u_uncore_top_riscv_rst_s),
    .u_uncore_top_riscv_debug_clk_i(u_uncore_top_riscv_debug_clk_s),
    .u_uncore_top_riscv_debug_rst_i(u_uncore_top_riscv_debug_rst_s),
    .u_uncore_top_riscv_rtc_toggle_i(u_uncore_top_riscv_rtc_toggle_s),
    .u_uncore_top_dla_csb_clk_i(u_uncore_top_dla_csb_clk_s),
    .u_uncore_top_dla_core_clk_i(u_uncore_top_dla_core_clk_s),
    .u_uncore_top_mac_rst_n_i(u_uncore_top_mac_rst_n_s),
    .u_uncore_top_dma_clk_i(u_uncore_top_dma_clk_s),
    .u_uncore_top_dma_rst_n_i(u_uncore_top_dma_rst_n_s),
    .u_uncore_top_per_clk_i(u_uncore_top_per_clk_s),
    .u_uncore_top_core_nic_rst_n_i(u_uncore_top_core_nic_rst_n_s),
    .por_rstn_sync(por_rstn_sync_s),
    .u_soc_top_PCIE_EP_REFCLK_p_i(PCIE_EP_REFCLK_p),
    .u_soc_top_PCIE_EP_REFCLK_n_i(PCIE_EP_REFCLK_n),
    .u_soc_top_PCIE_EP_nPRESET_i(PCIE_EP_nPRESET),
    .u_xdma_0_top_axi_aclk_s(u_xdma_0_top_axi_aclk_s),
    .u_xdma_0_top_axi_aresetn_o(u_xdma_0_top_axi_aresetn_s),
    .u_soc_top_DDR4_REF_CLK_p_i(DDR4_REF_CLK_p),
    .u_soc_top_DDR4_REF_CLK_n_i(DDR4_REF_CLK_n),
    .u_uncore_top_ddr_rst_i(u_uncore_top_ddr_rst_s),
    .u_soc_top_TCK_i(TCK),
    .u_soc_top_TRST_n_i(TRST_n),
    .u_tdi_rmux_z_i(u_tdi_rmux_z_s),
    .u_tms_rmux_z_i(u_tms_rmux_z_s),
    .debug_systemjtag_jtag_TDO_driven(TDO_DRIVEN),
    .u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_o(u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_s),
    .riscv_debug_dmactive(riscv_debug_dmactive_i_s),
    .riscv_debug_dmactiveack(riscv_debug_dmactiveack_s),
    .msi_enable_o(msi_enable_s),
    .msix_enable_o(msix_enable_s),
    .msi_vector_width_o(msi_vector_width_s),
    .usr_irq_req_i(usr_irq_req_s),
    .usr_irq_ack_o(usr_irq_ack_s),
    .u_xdma_0_top_user_lnk_up_o(PCIE_EP_LNK_UP),
    .u_xdma_0_top_pci_exp_txp_o(PCIE_EP_EXP_TX_p),
    .u_xdma_0_top_pci_exp_txn_o(PCIE_EP_EXP_TX_n),
    .u_soc_top_PCIE_EP_EXP_RX_p_i(PCIE_EP_EXP_RX_p),
    .u_soc_top_PCIE_EP_EXP_RX_n_i(PCIE_EP_EXP_RX_n),
    .u_ddr4_0_top_c0_ddr4_act_n_o(C0_DDR4_ACT_n),
    .u_ddr4_0_top_c0_ddr4_ck_t_o(C0_DDR4_CK_t),
    .u_ddr4_0_top_c0_ddr4_ck_c_o(C0_DDR4_CK_c),
    .u_ddr4_0_top_c0_ddr4_reset_n_o(C0_DDR4_RESET_n),
    .u_ddr4_0_top_c0_ddr4_adr_o(C0_DDR4_ADR),
    .u_ddr4_0_top_c0_ddr4_ba_o(C0_DDR4_BA),
    .u_ddr4_0_top_c0_ddr4_bg_o(C0_DDR4_BG),
    .u_ddr4_0_top_c0_ddr4_cs_n_o(C0_DDR4_CS_n),
    .u_ddr4_0_top_c0_ddr4_cke_o(C0_DDR4_CKE),
    .u_ddr4_0_top_c0_ddr4_odt_o(C0_DDR4_ODT),
    .u_ddr4_0_top_c0_ddr4_dm_dbi_n(C0_DDR4_DM_DBI_n),
    .u_ddr4_0_top_c0_ddr4_dq(C0_DDR4_DQ),
    .u_ddr4_0_top_c0_ddr4_dqs_c(C0_DDR4_DQS_C),
    .u_ddr4_0_top_c0_ddr4_dqs_t(C0_DDR4_DQS_T),
    .u_ddr4_0_top_c0_init_calib_complete_o(u_ddr4_0_top_c0_init_calib_complete_s),
    .u_uncore_top_AWID_AXI_CORE_MST_o(u_uncore_top_AWID_AXI_CORE_MST_s),
    .u_uncore_top_AWVALID_AXI_CORE_MST_o(u_uncore_top_AWVALID_AXI_CORE_MST_s),
    .u_uncore_top_AWREADY_AXI_CORE_MST_i(u_uncore_top_AWREADY_AXI_CORE_MST_s),
    .u_uncore_top_AWADDR_AXI_CORE_MST_o(u_uncore_top_AWADDR_AXI_CORE_MST_s),
    .u_uncore_top_AWLEN_AXI_CORE_MST_o(u_uncore_top_AWLEN_AXI_CORE_MST_s),
    .u_uncore_top_AWSIZE_AXI_CORE_MST_o(u_uncore_top_AWSIZE_AXI_CORE_MST_s),
    .u_uncore_top_AWBURST_AXI_CORE_MST_o(u_uncore_top_AWBURST_AXI_CORE_MST_s),
    .u_uncore_top_AWLOCK_AXI_CORE_MST_o(u_uncore_top_AWLOCK_AXI_CORE_MST_s),
    .u_uncore_top_AWCACHE_AXI_CORE_MST_o(u_uncore_top_AWCACHE_AXI_CORE_MST_s),
    .u_uncore_top_AWPROT_AXI_CORE_MST_o(u_uncore_top_AWPROT_AXI_CORE_MST_s),
    .u_uncore_top_WVALID_AXI_CORE_MST_o(u_uncore_top_WVALID_AXI_CORE_MST_s),
    .u_uncore_top_WREADY_AXI_CORE_MST_i(u_uncore_top_WREADY_AXI_CORE_MST_s),
    .u_uncore_top_WLAST_AXI_CORE_MST_o(u_uncore_top_WLAST_AXI_CORE_MST_s),
    .u_uncore_top_WDATA_AXI_CORE_MST_o(u_uncore_top_WDATA_AXI_CORE_MST_s),
    .u_uncore_top_WSTRB_AXI_CORE_MST_o(u_uncore_top_WSTRB_AXI_CORE_MST_s),
    .u_uncore_top_BID_AXI_CORE_MST_i(u_uncore_top_BID_AXI_CORE_MST_s),
    .u_uncore_top_BVALID_AXI_CORE_MST_i(u_uncore_top_BVALID_AXI_CORE_MST_s),
    .u_uncore_top_BREADY_AXI_CORE_MST_o(u_uncore_top_BREADY_AXI_CORE_MST_s),
    .u_uncore_top_BRESP_AXI_CORE_MST_i(u_uncore_top_BRESP_AXI_CORE_MST_s),
    .u_uncore_top_ARID_AXI_CORE_MST_o(u_uncore_top_ARID_AXI_CORE_MST_s),
    .u_uncore_top_ARVALID_AXI_CORE_MST_o(u_uncore_top_ARVALID_AXI_CORE_MST_s),
    .u_uncore_top_ARREADY_AXI_CORE_MST_i(u_uncore_top_ARREADY_AXI_CORE_MST_s),
    .u_uncore_top_ARADDR_AXI_CORE_MST_o(u_uncore_top_ARADDR_AXI_CORE_MST_s),
    .u_uncore_top_ARLEN_AXI_CORE_MST_o(u_uncore_top_ARLEN_AXI_CORE_MST_s),
    .u_uncore_top_ARSIZE_AXI_CORE_MST_o(u_uncore_top_ARSIZE_AXI_CORE_MST_s),
    .u_uncore_top_ARBURST_AXI_CORE_MST_o(u_uncore_top_ARBURST_AXI_CORE_MST_s),
    .u_uncore_top_ARLOCK_AXI_CORE_MST_o(u_uncore_top_ARLOCK_AXI_CORE_MST_s),
    .u_uncore_top_ARCACHE_AXI_CORE_MST_o(u_uncore_top_ARCACHE_AXI_CORE_MST_s),
    .u_uncore_top_ARPROT_AXI_CORE_MST_o(u_uncore_top_ARPROT_AXI_CORE_MST_s),
    .u_uncore_top_RID_AXI_CORE_MST_i(u_uncore_top_RID_AXI_CORE_MST_s),
    .u_uncore_top_RVALID_AXI_CORE_MST_i(u_uncore_top_RVALID_AXI_CORE_MST_s),
    .u_uncore_top_RREADY_AXI_CORE_MST_o(u_uncore_top_RREADY_AXI_CORE_MST_s),
    .u_uncore_top_RDATA_AXI_CORE_MST_i(u_uncore_top_RDATA_AXI_CORE_MST_s),
    .u_uncore_top_RRESP_AXI_CORE_MST_i(u_uncore_top_RRESP_AXI_CORE_MST_s),
    .u_uncore_top_RLAST_AXI_CORE_MST_i(u_uncore_top_RLAST_AXI_CORE_MST_s),
    .u_uncore_top_timer0_int_cmp_i(u_uncore_top_timer0_int_cmp_s),
    .u_uncore_top_timer0_int_ovf_i(u_uncore_top_timer0_int_ovf_s),
    .u_uncore_top_timer1_int_cmp_i(u_uncore_top_timer1_int_cmp_s),
    .u_uncore_top_timer1_int_ovf_i(u_uncore_top_timer1_int_ovf_s),
    .u_uncore_top_sw_int0_i(u_uncore_top_sw_int0_s),
    .u_uncore_top_sw_int1_i(u_uncore_top_sw_int1_s),
    .u_uncore_top_scu_int_i(u_uncore_top_scu_int_s),
    .u_uncore_top_uart_int_i(u_uncore_top_uart_int_s)
    //input ports
    //output ports
    //inout ports
);

assign usr_irq_req_s[2] = 1'b0 ;

//u_uncore_top instance
uncore_top u_uncore_top(
    .sys_clk_i(SYS_CLK),
    .sys_rst_n_i(SYS_RST_n),
    .pcie_clk_i(u_xdma_0_top_axi_aclk_s),
    .pcie_hot_rstn_i(u_xdma_0_top_axi_aresetn_s),
    .jtag_rst_sync_bypass_i(1'b0),
    .riscv_clk_o(u_uncore_top_riscv_clk_s),
    .riscv_core_clk_o(u_uncore_top_riscv_core_clk_s),
    .riscv_rst_o(u_uncore_top_riscv_rst_s),
    .riscv_debug_rst_o(u_uncore_top_riscv_debug_rst_s),
    .riscv_debug_clk_o(u_uncore_top_riscv_debug_clk_s),
    .riscv_rtc_toggle_o(u_uncore_top_riscv_rtc_toggle_s),
    .per_clk_o(u_uncore_top_per_clk_s),
    .core_nic_rst_n_o(u_uncore_top_core_nic_rst_n_s),
    .por_rstn_sync_o(por_rstn_sync_s),
    .dla_csb_clk_o(u_uncore_top_dla_csb_clk_s),
    .dla_core_clk_o(u_uncore_top_dla_core_clk_s),
    .mac_rst_n_o(u_uncore_top_mac_rst_n_s),
    .dma_clk_o(u_uncore_top_dma_clk_s),
    .dma_rst_n_o(u_uncore_top_dma_rst_n_s),
    .ddr_rst_o(u_uncore_top_ddr_rst_s),
    .boot_strap_i(BOOT_STRAP),
    .pcie_msi_enable_i(msi_enable_s),
    .pcie_msix_enable_i(msix_enable_s),
    .pcie_user_lnk_up_i(PCIE_EP_LNK_UP),
    .ddr_initial_done_i(u_ddr4_0_top_c0_init_calib_complete_s),
    .riscv_debug_dmactive_i(riscv_debug_dmactive_i_s),
    .riscv_debug_dmactiveack_o(riscv_debug_dmactiveack_s),
    .uart_rxd_i(UART_RXD),
    .uart_txd_o(UART_TXD),
    .u_core_top_AWID_AXI_UNCORE_SLV(u_uncore_top_AWID_AXI_CORE_MST_s),
    .u_core_top_AWVALID_AXI_UNCORE_SLV(u_uncore_top_AWVALID_AXI_CORE_MST_s),
    .u_core_top_AWREADY_AXI_UNCORE_SLV(u_uncore_top_AWREADY_AXI_CORE_MST_s),
    .u_core_top_AWADDR_AXI_UNCORE_SLV(u_uncore_top_AWADDR_AXI_CORE_MST_s),
    .u_core_top_AWLEN_AXI_UNCORE_SLV(u_uncore_top_AWLEN_AXI_CORE_MST_s),
    .u_core_top_AWSIZE_AXI_UNCORE_SLV(u_uncore_top_AWSIZE_AXI_CORE_MST_s),
    .u_core_top_AWBURST_AXI_UNCORE_SLV(u_uncore_top_AWBURST_AXI_CORE_MST_s),
    .u_core_top_AWLOCK_AXI_UNCORE_SLV(u_uncore_top_AWLOCK_AXI_CORE_MST_s),
    .u_core_top_AWCACHE_AXI_UNCORE_SLV(u_uncore_top_AWCACHE_AXI_CORE_MST_s),
    .u_core_top_AWPROT_AXI_UNCORE_SLV(u_uncore_top_AWPROT_AXI_CORE_MST_s),
    .u_core_top_WVALID_AXI_UNCORE_SLV(u_uncore_top_WVALID_AXI_CORE_MST_s),
    .u_core_top_WREADY_AXI_UNCORE_SLV(u_uncore_top_WREADY_AXI_CORE_MST_s),
    .u_core_top_WLAST_AXI_UNCORE_SLV(u_uncore_top_WLAST_AXI_CORE_MST_s),
    .u_core_top_WDATA_AXI_UNCORE_SLV(u_uncore_top_WDATA_AXI_CORE_MST_s),
    .u_core_top_WSTRB_AXI_UNCORE_SLV(u_uncore_top_WSTRB_AXI_CORE_MST_s),
    .u_core_top_BID_AXI_UNCORE_SLV(u_uncore_top_BID_AXI_CORE_MST_s),
    .u_core_top_BVALID_AXI_UNCORE_SLV(u_uncore_top_BVALID_AXI_CORE_MST_s),
    .u_core_top_BREADY_AXI_UNCORE_SLV(u_uncore_top_BREADY_AXI_CORE_MST_s),
    .u_core_top_BRESP_AXI_UNCORE_SLV(u_uncore_top_BRESP_AXI_CORE_MST_s),
    .u_core_top_ARID_AXI_UNCORE_SLV(u_uncore_top_ARID_AXI_CORE_MST_s),
    .u_core_top_ARVALID_AXI_UNCORE_SLV(u_uncore_top_ARVALID_AXI_CORE_MST_s),
    .u_core_top_ARREADY_AXI_UNCORE_SLV(u_uncore_top_ARREADY_AXI_CORE_MST_s),
    .u_core_top_ARADDR_AXI_UNCORE_SLV(u_uncore_top_ARADDR_AXI_CORE_MST_s),
    .u_core_top_ARLEN_AXI_UNCORE_SLV(u_uncore_top_ARLEN_AXI_CORE_MST_s),
    .u_core_top_ARSIZE_AXI_UNCORE_SLV(u_uncore_top_ARSIZE_AXI_CORE_MST_s),
    .u_core_top_ARBURST_AXI_UNCORE_SLV(u_uncore_top_ARBURST_AXI_CORE_MST_s),
    .u_core_top_ARLOCK_AXI_UNCORE_SLV(u_uncore_top_ARLOCK_AXI_CORE_MST_s),
    .u_core_top_ARCACHE_AXI_UNCORE_SLV(u_uncore_top_ARCACHE_AXI_CORE_MST_s),
    .u_core_top_ARPROT_AXI_UNCORE_SLV(u_uncore_top_ARPROT_AXI_CORE_MST_s),
    .u_core_top_RID_AXI_UNCORE_SLV(u_uncore_top_RID_AXI_CORE_MST_s),
    .u_core_top_RVALID_AXI_UNCORE_SLV(u_uncore_top_RVALID_AXI_CORE_MST_s),
    .u_core_top_RREADY_AXI_UNCORE_SLV(u_uncore_top_RREADY_AXI_CORE_MST_s),
    .u_core_top_RLAST_AXI_UNCORE_SLV(u_uncore_top_RLAST_AXI_CORE_MST_s),
    .u_core_top_RDATA_AXI_UNCORE_SLV(u_uncore_top_RDATA_AXI_CORE_MST_s),
    .u_core_top_RRESP_AXI_UNCORE_SLV(u_uncore_top_RRESP_AXI_CORE_MST_s),
    .timer0_int_ovf(u_uncore_top_timer0_int_ovf_s),
    .timer0_int_cmp(u_uncore_top_timer0_int_cmp_s),
    .timer1_int_ovf(u_uncore_top_timer1_int_ovf_s),
    .timer1_int_cmp(u_uncore_top_timer1_int_cmp_s),
    .sw_int0(u_uncore_top_sw_int0_s),
    .sw_int1(u_uncore_top_sw_int1_s),
    .scu_int(u_uncore_top_scu_int_s),
    .pcie_int(usr_irq_req_s[0]),
    .sw_rst_req_prewarning_int(usr_irq_req_s[1]),
    .uart_int(u_uncore_top_uart_int_s),
    .pcie_int_ack_i(usr_irq_ack_s)
    //input ports
    //output ports
    //inout ports
);
endmodule
