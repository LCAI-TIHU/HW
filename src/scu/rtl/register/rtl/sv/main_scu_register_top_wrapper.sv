//-------------------------------------------------------------- 
//  main_scu_register_top_wrapper.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_register_top_wrapper.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!                                                      
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//--------------------------------------------------------------
//  Functions Descriptions:
//  Provide the interface with the hardware logic.
//--------------------------------------------------------------
//  Version modify History:
//  Version    Date         Author    Description
//-------------------------------------------------------------- 
//TODO??
//Memory interface part not functional yet!!!

module main_scu_register_top_wrapper
#(
parameter p_num_of_register                 = 23 ,
parameter p_bus_address_width               = 24 , 
parameter p_kernel_reg_offset_address_width = 12 , 
parameter p_reg_response_width              = 3
)
(

 //Please aware :It is ASYNC Register interface , 
 //HCLK is the bus clock , and it is only used inside the async ahb2esram brdige 
 //kernel_clk_i is the kernel clock used in kernel clock domain 
input                              HCLK      ,// system bus clock
//AHB interface 
input                              kernel_clk_i     ,//Kernel clock
input                              module_resetn_i  ,// system bus reset
//DFT port 
input                              dft_scan_en_i         , //It will be used to control the clock gate cell
input                              jtag_rst_sync_bypass_i, //It will be used to control the Reset sync cell

input                              HSEL      ,// AHB peripheral select
input                              HREADY    ,// AHB ready input
input[1:0]                         HTRANS    ,// AHB transfer type
input[2:0]                         HSIZE     ,// AHB hsize
input                              HWRITE    ,// AHB hwrite
input[p_bus_address_width-1:0]     HADDR     ,// AHB address bus
input[31:0]                        HWDATA    ,// AHB write data bus
output                             HREADYOUT ,// AHB ready output to S->M mux
output[1:0]                        HRESP     ,// AHB response
output[31:0]                       HRDATA    ,// AHB read data bus



//interrupt HW set from Kernel side 
  //Func INT0
input [32-1          :0] func_int0_hw_set_i          , 
output                   func_int0_interrupt_o       ,

//gated clocks to Kernel , Kernel_demo can decide to use it or not! 
output gated_kernel_clk_o                                         ,
//synced reset   to kernel ,  Kernel_demo can decide to use it or not!
output synced_kernel_reset_o                                      ,      

//LMU_BOOT_ADDR_ALIAS_SEL ,RWHS
input   lmu_boot_addr_alias_sel_rwhs_strb_i, 
output  lmu_boot_addr_alias_sel_rwhs_strb_o, 
input   lmu_boot_addr_alias_sel_rwhs_boot_addr_alias_sel_i,
output  lmu_boot_addr_alias_sel_rwhs_boot_addr_alias_sel_o,
	
	
//BOOT_STRAP_PIN ,RO
input  boot_strap_pin_ro_boot_strap_pin_i,
	
//DDR_INITIAL_DONE ,RO
input  ddr_initial_done_ro_ddr_initial_done_i,
	
//UTS_COUNTER_H ,RWHS
input   uts_counter_h_rwhs_strb_i, 
output  uts_counter_h_rwhs_strb_o, 
input   [31:0]    uts_counter_h_rwhs_uts_counter_h_i,
output  [31:0]    uts_counter_h_rwhs_uts_counter_h_o,
	
	
//UTS_COUNTER_L ,RWH
input   uts_counter_l_rwh_strb_i,
 
input   [31:0]    uts_counter_l_rwh_uts_counter_l_i,
output  [31:0]    uts_counter_l_rwh_uts_counter_l_o,
	
	
//UTS_COUNTER_CLR ,RWS
output   uts_counter_clr_rws_strb_o, 
output   uts_counter_clr_rws_uts_counter_clr_o,
	
	
//SW_INTERRUPT ,RW
output   sw_interrupt_rw_sw_int1_o,
output   sw_interrupt_rw_sw_int0_o,
	
//PCIE_INTERRUPT ,RWHS
input   pcie_interrupt_rwhs_strb_i, 
output  pcie_interrupt_rwhs_strb_o, 
input   pcie_interrupt_rwhs_pcie_int_i,
output  pcie_interrupt_rwhs_pcie_int_o,
	
	
//SW_RST_REQ_PREWARNING_INT ,RW
output   sw_rst_req_prewarning_int_rw_sw_rst_req_prewarning_int_o,
	
//PCIE_USER_LNK_UP ,RO
input  pcie_user_lnk_up_ro_pcie_user_lnk_up_i,
	
//PCIE_MSI_ENABLE ,RO
input  pcie_msi_enable_ro_pcie_msi_enable_i,
	
//PCIE_MSIX_ENABLE ,RO
input  pcie_msix_enable_ro_pcie_msix_enable_i,
	
//PCIE_INT_ACK ,RO
input  pcie_int_ack_ro_wdt_prewarning_int_ack_i,
input  pcie_int_ack_ro_sw_rst_req_prewarning_int_ack_i,
input  pcie_int_ack_ro_pcie_int_ack_i,
	
//MMCM_LOCK ,RO
input  mmcm_lock_ro_mmcm_lock_i,
	
//SW_RST_REQ ,RW
output   sw_rst_req_rw_sw_rst_req_o,
	
//MODULE_RST_CTRL ,RW
output   module_rst_ctrl_rw_riscv_debug_rst_req_o,
output   module_rst_ctrl_rw_riscv_rst_req_o,
output   module_rst_ctrl_rw_core_nic_rstn_req_o,
output   module_rst_ctrl_rw_uncore_nic_rstn_req_o,
output   module_rst_ctrl_rw_uart_rstn_req_o,
output   module_rst_ctrl_rw_timer0_rstn_req_o,
output   module_rst_ctrl_rw_timer1_rstn_req_o,
output   module_rst_ctrl_rw_wdt_rstn_req_o,
output   module_rst_ctrl_rw_scu_register_rstn_req_o,
output   module_rst_ctrl_rw_jtag2ahb_rstn_req_o,
output   module_rst_ctrl_rw_dma_rstn_req_o,
output   module_rst_ctrl_rw_mac_rstn_req_o,
output   module_rst_ctrl_rw_ddr_rst_req_o,
	
//MODULE_RST_CTRL_MASK ,RW
output   module_rst_ctrl_mask_rw_riscv_debug_rst_req_mask_o,
output   module_rst_ctrl_mask_rw_riscv_rst_req_mask_o,
output   module_rst_ctrl_mask_rw_core_nic_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_uncore_nic_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_uart_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_timer0_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_timer1_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_wdt_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_scu_register_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_jtag2ahb_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_dma_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_mac_rstn_req_mask_o,
output   module_rst_ctrl_mask_rw_ddr_rst_req_mask_o,
	
//RESET_STATUS ,RO
input  reset_status_ro_riscv_debug_rst_sta_i,
input  reset_status_ro_riscv_rst_sta_i,
input  reset_status_ro_core_nic_rstn_sta_i,
input  reset_status_ro_uncore_nic_rstn_sta_i,
input  reset_status_ro_uart_rstn_sta_i,
input  reset_status_ro_timer0_rstn_sta_i,
input  reset_status_ro_timer1_rstn_sta_i,
input  reset_status_ro_wdt_rstn_sta_i,
input  reset_status_ro_scu_register_rstn_sta_i,
input  reset_status_ro_jtag2ahb_rstn_sta_i,
input  reset_status_ro_dma_rstn_sta_i,
input  reset_status_ro_mac_rstn_sta_i,
input  reset_status_ro_ddr_rst_sta_i,
	
//WDT_CONTROL ,RW
output   wdt_control_rw_resolution_o,
output   wdt_control_rw_en_o,
	
//WDT_LOAD_VALUE ,RW
output   [31:0]    wdt_load_value_rw_value_o,
	
//WDT_INT_LEVEL ,RW
output   [31:0]    wdt_int_level_rw_level_o,
	
//WDT_RLD_UPD ,WO
output wdt_rld_upd_wo_upd_o,
	
//WDT_CNT_VAL ,RO
input [31:0]    wdt_cnt_val_ro_value_i);
 
//from kernel 
logic[31:0]                                       reg_data_in_s [p_num_of_register-1:0];
logic                                             reg_data_in_hw_strb_s[p_num_of_register-1:0];
//to kernel
logic[31:0]                                       reg_data_out_s[p_num_of_register-1:0];
logic                                             reg_data_out_sw_strb_s [p_num_of_register-1:0];

logic                                             reg_csb_s       ;
logic                                             reg_wr_s        ;
logic [p_kernel_reg_offset_address_width-1:0]     reg_address_s   ;
logic [31:0]                                      reg_write_data_s;
logic [3:0]                                       reg_byte_en_s   ;
logic [31:0]                                      reg_read_data_s ;
logic                                             reg_ready_s     ;
logic [p_reg_response_width-1:0]                  reg_response_s  ;

logic                                             bus_csb_s       ;
logic                                             bus_wr_s        ;
logic [p_bus_address_width-3:0]                   bus_address_s   ; //2 LSB is not connected from AHB2SRAM Bridge
logic [31:0]                                      bus_write_data_s;
logic [3:0]                                       bus_byte_en_s   ;
logic [31:0]                                      bus_read_data_s ;
logic                                             bus_ready_s     ;
logic [p_reg_response_width-1:0]                  bus_response_s  ;

logic gated_regbank_clk_s;


logic synced_hclk_reset_s;

logic synced_kernel_reset_s  ;


main_scu_register_bank
#(
.p_num_of_register                (p_num_of_register                ),
.p_kernel_reg_offset_address_width(p_kernel_reg_offset_address_width),
.p_reg_response_width             (p_reg_response_width             )  
) 

main_scu_register_bank_inst(
.clk_i                     (gated_regbank_clk_s   ),
.rst_n_i                   (synced_kernel_reset_s ),

//Register access interface 
.reg_csb_i                 (reg_csb_s       ),
.reg_wr_i                  (reg_wr_s        ),
.reg_address_i             (reg_address_s   ),
.reg_write_data_i          (reg_write_data_s),
.reg_byte_en_i             (reg_byte_en_s   ),
.reg_read_data_o           (reg_read_data_s ),
.reg_ready_o               (reg_ready_s     ),
.reg_response_o            (reg_response_s  ),

//from kernel
.reg_data_in_i             (reg_data_in_s         ),
.reg_data_in_hw_strb_i     (reg_data_in_hw_strb_s ),
//to kernel
.reg_data_out_o            (reg_data_out_s        ),
.reg_data_out_sw_strb_o    (reg_data_out_sw_strb_s)
);

//ASYNC AHB2ESRAM Brdige 
main_scu_ahb2esram_async_bridge
#(
.p_bus_address_width(p_bus_address_width),
.p_reg_response_width(p_reg_response_width)
)
main_scu_ahb2esram_async_bridge_inst
(
 //AHB interface 
//ASYNC brdige , it need HCLK, bus clk and the corresponding reset 
.HCLK      (HCLK                 ),// AHB bus clock
.HRESETn   (synced_hclk_reset_s  ),// AHB bus clock domain reset
.bus_clk_i (kernel_clk_i         ),// kernel clock 
.bus_rstn_i(synced_kernel_reset_s),// kernel clock domain reset 
.HSEL      (HSEL     ),// AHB peripheral select
.HREADY    (HREADY   ),// AHB ready input
.HTRANS    (HTRANS   ),// AHB transfer type
.HSIZE     (HSIZE    ),// AHB hsize
.HWRITE    (HWRITE   ),// AHB hwrite
.HADDR     (HADDR    ),// AHB address bus
.HWDATA    (HWDATA   ),// AHB write data bus
.HREADYOUT (HREADYOUT),// AHB ready output to S->M mux
.HRESP     (HRESP    ),// AHB response
.HRDATA    (HRDATA   ),// AHB read data bus
 //SRAM-Like interface 
.bus_csb_o          (bus_csb_s       ),
.bus_wr_o           (bus_wr_s        ),
.bus_address_o      (bus_address_s   ),
.bus_write_data_o   (bus_write_data_s),
.bus_byte_en_o      (bus_byte_en_s   ),
.bus_read_data_i    (bus_read_data_s ),
.bus_req_ready_i    (1'b1            ),
.bus_res_ready_i    (1'b1            ),
.bus_response_i     (bus_response_s  )

);

//---BAC Top instance 
main_scu_bus_access_control_top  
#(
.p_response_width(p_reg_response_width)
)

main_scu_bus_access_control_top_inst
(
//clock & reset 
.clk_i                 (kernel_clk_i          )     ,
.resetn_i              (module_resetn_i       )     , //Async reset 
.dft_scan_en_i         (dft_scan_en_i         ) , 
.jtag_rst_sync_bypass_i(jtag_rst_sync_bypass_i) ,
//SRAM Bus access interface                                           
.bus_csb_i               (bus_csb_s               )     ,
.bus_wr_i                (bus_wr_s                )     ,
.bus_address_i           ({bus_address_s,2'b0}    )     , // need the 2 LSB bit 
.bus_write_data_i        (bus_write_data_s        )     ,
.bus_byte_en_i           (bus_byte_en_s           )     ,
.bus_read_data_o         (bus_read_data_s         )     ,
.bus_ready_o             (bus_ready_s             )     ,//TODO?
.bus_response_o          (bus_response_s          )     ,
//to register bank                                               
.reg_csb_o              (reg_csb_s              )    ,
.reg_wr_o               (reg_wr_s               )    ,
.reg_address_o          (reg_address_s          )    ,
.reg_write_data_o       (reg_write_data_s       )    ,
.reg_byte_en_o          (reg_byte_en_s          )    ,
.reg_read_data_i        (reg_read_data_s        )    ,
.reg_ready_i            (reg_ready_s            )    ,
.reg_response_i         (reg_response_s         )    ,
//To memory interface        
//No memory interface 
														         
//func0 int
.func_int0_hw_set_i         (func_int0_hw_set_i         ) , 
.func_int0_interrupt_o      (func_int0_interrupt_o      ) ,

.gated_kernel_clk_o         (gated_kernel_clk_o    )     ,
.gated_regbank_clk_o        (gated_regbank_clk_s   )     , 
.bus_clk_i                  (HCLK                  )     , // in case it is async bridge 
.synced_hclk_reset_o        (synced_hclk_reset_s   )     ,
.synced_kernel_reset_o      (synced_kernel_reset_s )     
);


//signal assignment 
//temp:

// LMU_BOOT_ADDR_ALIAS_SEL_RWHS
assign 	reg_data_in_hw_strb_s[0] = lmu_boot_addr_alias_sel_rwhs_strb_i; // only one strb for one register  is OK 
assign  lmu_boot_addr_alias_sel_rwhs_strb_o = reg_data_out_sw_strb_s[0] ;// only one strb for one register  is OK 
// Read and WRite only
assign reg_data_in_s[0][31:1] = 'h0;
assign reg_data_in_s[0][0]  =  lmu_boot_addr_alias_sel_rwhs_boot_addr_alias_sel_i;
assign lmu_boot_addr_alias_sel_rwhs_boot_addr_alias_sel_o = reg_data_out_s[0][0];
// BOOT_STRAP_PIN_RO
assign 	reg_data_in_hw_strb_s[1] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[1][31:1]  =  31'b0; 
assign reg_data_in_s[1][0]  =  boot_strap_pin_ro_boot_strap_pin_i;
// DDR_INITIAL_DONE_RO
assign 	reg_data_in_hw_strb_s[2] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[2][31:1]  =  31'b0; 
assign reg_data_in_s[2][0]  =  ddr_initial_done_ro_ddr_initial_done_i;
// UTS_COUNTER_H_RWHS
assign 	reg_data_in_hw_strb_s[3] = uts_counter_h_rwhs_strb_i; // only one strb for one register  is OK 
assign  uts_counter_h_rwhs_strb_o = reg_data_out_sw_strb_s[3] ;// only one strb for one register  is OK 
// Read and WRite only
assign reg_data_in_s[3][31:0]  =  uts_counter_h_rwhs_uts_counter_h_i;
assign uts_counter_h_rwhs_uts_counter_h_o = reg_data_out_s[3][31:0];
// UTS_COUNTER_L_RWH
assign reg_data_in_hw_strb_s[4] = uts_counter_l_rwh_strb_i;	 // only one strb for one register  is OK 
assign reg_data_in_s[4][31:0]  =  uts_counter_l_rwh_uts_counter_l_i;
assign uts_counter_l_rwh_uts_counter_l_o = reg_data_out_s[4][31:0];

// UTS_COUNTER_CLR_RWS
assign 	reg_data_in_hw_strb_s[5] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[5] ='h0;
assign uts_counter_clr_rws_strb_o = reg_data_out_sw_strb_s[5] ; // only one strb for one register  is OK 
assign uts_counter_clr_rws_uts_counter_clr_o = reg_data_out_s[5][0];
// SW_INTERRUPT_RW
assign reg_data_in_s[6] ='h0;
assign 	reg_data_in_hw_strb_s[6] = 1'b0; // to avoid spyglass warning
assign sw_interrupt_rw_sw_int1_o = reg_data_out_s[6][1];
assign sw_interrupt_rw_sw_int0_o = reg_data_out_s[6][0];
// PCIE_INTERRUPT_RWHS
assign 	reg_data_in_hw_strb_s[7] = pcie_interrupt_rwhs_strb_i; // only one strb for one register  is OK 
assign  pcie_interrupt_rwhs_strb_o = reg_data_out_sw_strb_s[7] ;// only one strb for one register  is OK 
// Read and WRite only
assign reg_data_in_s[7][31:1] = 'h0;
assign reg_data_in_s[7][0]  =  pcie_interrupt_rwhs_pcie_int_i;
assign pcie_interrupt_rwhs_pcie_int_o = reg_data_out_s[7][0];
// SW_RST_REQ_PREWARNING_INT_RW
assign reg_data_in_s[8] ='h0;
assign 	reg_data_in_hw_strb_s[8] = 1'b0; // to avoid spyglass warning
assign sw_rst_req_prewarning_int_rw_sw_rst_req_prewarning_int_o = reg_data_out_s[8][0];
// PCIE_USER_LNK_UP_RO
assign 	reg_data_in_hw_strb_s[9] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[9][31:1]  =  31'b0; 
assign reg_data_in_s[9][0]  =  pcie_user_lnk_up_ro_pcie_user_lnk_up_i;
// PCIE_MSI_ENABLE_RO
assign 	reg_data_in_hw_strb_s[10] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[10][31:1]  =  31'b0; 
assign reg_data_in_s[10][0]  =  pcie_msi_enable_ro_pcie_msi_enable_i;
// PCIE_MSIX_ENABLE_RO
assign 	reg_data_in_hw_strb_s[11] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[11][31:1]  =  31'b0; 
assign reg_data_in_s[11][0]  =  pcie_msix_enable_ro_pcie_msix_enable_i;
// PCIE_INT_ACK_RO
assign 	reg_data_in_hw_strb_s[12] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[12][31:3]  =  29'b0; 
assign reg_data_in_s[12][2]  =  pcie_int_ack_ro_wdt_prewarning_int_ack_i;
assign reg_data_in_s[12][1]  =  pcie_int_ack_ro_sw_rst_req_prewarning_int_ack_i;
assign reg_data_in_s[12][0]  =  pcie_int_ack_ro_pcie_int_ack_i;
// MMCM_LOCK_RO
assign 	reg_data_in_hw_strb_s[13] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[13][31:1]  =  31'b0; 
assign reg_data_in_s[13][0]  =  mmcm_lock_ro_mmcm_lock_i;
// SW_RST_REQ_RW
assign reg_data_in_s[14] ='h0;
assign 	reg_data_in_hw_strb_s[14] = 1'b0; // to avoid spyglass warning
assign sw_rst_req_rw_sw_rst_req_o = reg_data_out_s[14][0];
// MODULE_RST_CTRL_RW
assign reg_data_in_s[15] ='h0;
assign 	reg_data_in_hw_strb_s[15] = 1'b0; // to avoid spyglass warning
assign module_rst_ctrl_rw_riscv_debug_rst_req_o = reg_data_out_s[15][12];
assign module_rst_ctrl_rw_riscv_rst_req_o = reg_data_out_s[15][11];
assign module_rst_ctrl_rw_core_nic_rstn_req_o = reg_data_out_s[15][10];
assign module_rst_ctrl_rw_uncore_nic_rstn_req_o = reg_data_out_s[15][9];
assign module_rst_ctrl_rw_uart_rstn_req_o = reg_data_out_s[15][8];
assign module_rst_ctrl_rw_timer0_rstn_req_o = reg_data_out_s[15][7];
assign module_rst_ctrl_rw_timer1_rstn_req_o = reg_data_out_s[15][6];
assign module_rst_ctrl_rw_wdt_rstn_req_o = reg_data_out_s[15][5];
assign module_rst_ctrl_rw_scu_register_rstn_req_o = reg_data_out_s[15][4];
assign module_rst_ctrl_rw_jtag2ahb_rstn_req_o = reg_data_out_s[15][3];
assign module_rst_ctrl_rw_dma_rstn_req_o = reg_data_out_s[15][2];
assign module_rst_ctrl_rw_mac_rstn_req_o = reg_data_out_s[15][1];
assign module_rst_ctrl_rw_ddr_rst_req_o = reg_data_out_s[15][0];
// MODULE_RST_CTRL_MASK_RW
assign reg_data_in_s[16] ='h0;
assign 	reg_data_in_hw_strb_s[16] = 1'b0; // to avoid spyglass warning
assign module_rst_ctrl_mask_rw_riscv_debug_rst_req_mask_o = reg_data_out_s[16][12];
assign module_rst_ctrl_mask_rw_riscv_rst_req_mask_o = reg_data_out_s[16][11];
assign module_rst_ctrl_mask_rw_core_nic_rstn_req_mask_o = reg_data_out_s[16][10];
assign module_rst_ctrl_mask_rw_uncore_nic_rstn_req_mask_o = reg_data_out_s[16][9];
assign module_rst_ctrl_mask_rw_uart_rstn_req_mask_o = reg_data_out_s[16][8];
assign module_rst_ctrl_mask_rw_timer0_rstn_req_mask_o = reg_data_out_s[16][7];
assign module_rst_ctrl_mask_rw_timer1_rstn_req_mask_o = reg_data_out_s[16][6];
assign module_rst_ctrl_mask_rw_wdt_rstn_req_mask_o = reg_data_out_s[16][5];
assign module_rst_ctrl_mask_rw_scu_register_rstn_req_mask_o = reg_data_out_s[16][4];
assign module_rst_ctrl_mask_rw_jtag2ahb_rstn_req_mask_o = reg_data_out_s[16][3];
assign module_rst_ctrl_mask_rw_dma_rstn_req_mask_o = reg_data_out_s[16][2];
assign module_rst_ctrl_mask_rw_mac_rstn_req_mask_o = reg_data_out_s[16][1];
assign module_rst_ctrl_mask_rw_ddr_rst_req_mask_o = reg_data_out_s[16][0];
// RESET_STATUS_RO
assign 	reg_data_in_hw_strb_s[17] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[17][31:13]  =  19'b0; 
assign reg_data_in_s[17][12]  =  reset_status_ro_riscv_debug_rst_sta_i;
assign reg_data_in_s[17][11]  =  reset_status_ro_riscv_rst_sta_i;
assign reg_data_in_s[17][10]  =  reset_status_ro_core_nic_rstn_sta_i;
assign reg_data_in_s[17][9]  =  reset_status_ro_uncore_nic_rstn_sta_i;
assign reg_data_in_s[17][8]  =  reset_status_ro_uart_rstn_sta_i;
assign reg_data_in_s[17][7]  =  reset_status_ro_timer0_rstn_sta_i;
assign reg_data_in_s[17][6]  =  reset_status_ro_timer1_rstn_sta_i;
assign reg_data_in_s[17][5]  =  reset_status_ro_wdt_rstn_sta_i;
assign reg_data_in_s[17][4]  =  reset_status_ro_scu_register_rstn_sta_i;
assign reg_data_in_s[17][3]  =  reset_status_ro_jtag2ahb_rstn_sta_i;
assign reg_data_in_s[17][2]  =  reset_status_ro_dma_rstn_sta_i;
assign reg_data_in_s[17][1]  =  reset_status_ro_mac_rstn_sta_i;
assign reg_data_in_s[17][0]  =  reset_status_ro_ddr_rst_sta_i;
// WDT_CONTROL_RW
assign reg_data_in_s[18] ='h0;
assign 	reg_data_in_hw_strb_s[18] = 1'b0; // to avoid spyglass warning
assign wdt_control_rw_resolution_o = reg_data_out_s[18][1];
assign wdt_control_rw_en_o = reg_data_out_s[18][0];
// WDT_LOAD_VALUE_RW
assign reg_data_in_s[19] ='h0;
assign 	reg_data_in_hw_strb_s[19] = 1'b0; // to avoid spyglass warning
assign wdt_load_value_rw_value_o = reg_data_out_s[19][31:0];
// WDT_INT_LEVEL_RW
assign reg_data_in_s[20] ='h0;
assign 	reg_data_in_hw_strb_s[20] = 1'b0; // to avoid spyglass warning
assign wdt_int_level_rw_level_o = reg_data_out_s[20][31:0];
// WDT_RLD_UPD_WO
assign reg_data_in_s[21] ='h0;
assign 	reg_data_in_hw_strb_s[21] = 1'b0; // to avoid spyglass warning
assign wdt_rld_upd_wo_upd_o = reg_data_out_s[21][0];
	
// WDT_CNT_VAL_RO
assign 	reg_data_in_hw_strb_s[22] = 1'b0; // to avoid spyglass warning
assign reg_data_in_s[22][31:0]  =  wdt_cnt_val_ro_value_i;

assign synced_kernel_reset_o = synced_kernel_reset_s;
endmodule
