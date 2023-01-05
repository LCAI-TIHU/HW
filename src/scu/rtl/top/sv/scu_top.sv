//-------------------------------------------------------------------
//       COPYRIGHT (C) 2020 INSPUR. ALL RIGHTS RESERVED 
//-------------------------------------------------------------------
// File name        : scu_top.sv
//-------------------------------------------------------------------
// Function Notes   :
//        system control module
//        system clock and reset generation 
//        power on function information load
//        tsensor control 
//-------------------------------------------------------------------
// Release   History     :           
// Version   Date        Author         Description
// 0.1       2021/09/01  wangzhen 
//-------------------------------------------------------------------

 
module  scu_top
 (
   input                            sys_clk_i                     ,//sys clk
   input                            por_rstn_i                    ,//por rstn 
   //JTAG
   input                            jtag_trstn_i                  ,//JTAG rstn
   input                            jtag_rst_sync_bypass_i        ,//jtag_rst_sync_bypass
   //pcie clk & rstn
   input                            pcie_clk_i                    ,//pcie clk
   input                            pcie_hot_rstn_i               ,//pcie_hot_rstn
   //pcie signal
   input         [2:0]              pcie_int_ack_i                ,//pcie interrupt ack
   input                            pcie_msi_enable_i             ,//pcie msi  enable
   input                            pcie_msix_enable_i            ,//pcie msix enable
   //AHB interface                   
   input                            ahb_sel_i                     ,//AHB peripheral select
   input                            ahb_ready_i                   ,//AHB ready input
   input         [1:0]              ahb_trans_i                   ,//AHB transfer type
   input         [2:0]              ahb_size_i                    ,//AHB hsize
   input                            ahb_write_i                   ,//AHB hwrite
   input         [23:0]             ahb_addr_i                    ,//AHB address bus
   input         [31:0]             ahb_wdata_i                   ,//AHB write data bus
   output  logic                    ahb_readyout_o                ,//AHB ready output to S->M mux
   output  logic [1:0]              ahb_resp_o                    ,//AHB response
   output  logic [31:0]             ahb_rdata_o                   ,//AHB read data bus
   //RISC-V 
   input                            riscv_debug_dmactive_i        ,//riscv debug_dmactive
   output                           riscv_debug_dmactiveack_o     ,//riscv debug_dmactiveack
   //boot
   input                            boot_strap_i                  ,//boot start mode
   //DDR
   input                            ddr_initial_done_i            ,//ddr_initial_done
   //PCIE
   input                            pcie_user_lnk_up_i            ,//pcie_user_lnk_up
   //intrrupt
   output                           scu_int_o                     ,//wdt_prewarning_int | sw_int0 | sw_int1. high level trigger intrrupt
   output                           sw_int0_o                     ,//software configure  intrrupt0   high level trigger intrrupt 
   output                           sw_int1_o                     ,//software configure  intrrupt1   high level trigger intrrupt
   output                           wdt_prewarning_int_o          ,//wdt prewarning intrrupt.  high level trigger intrrupt
   output                           sw_rst_req_prewarning_int_o   ,//sw reset requeset prewarning intrrupt. high level trigger intrrupt
   output                           pcie_int_o                    ,//pcie intrrupt
   //output clock
   //100MHz 
   output  logic                    riscv_clk_o                   ,//riscv clock   
   output  logic                    riscv_core_clk_o              ,//riscv core  clock
   output  logic                    riscv_rtc_toggle_o            ,//riscv rtc_toggle clock
   output  logic                    riscv_debug_clk_o             ,//riscv debug clock   
   output  logic                    dma_clk_o                     ,//dma   clock   
   output  logic                    per_clk_o                     ,//per   clock   
   output  logic                    uart_clk_o                    ,//uart  clock   
   output  logic                    uart_kernel_clk_o             ,//uart kernel clock   
   output  logic                    timer0_ahb_clk_o              ,//timer0 ahb  clock  
   output  logic                    timer0_kernel_clk_o           ,//timer0 kernel clock  
   output  logic                    timer1_ahb_clk_o              ,//timer1 ahb  clock  
   output  logic                    timer1_kernel_clk_o           ,//timer1 kernel clock 
   output  logic                    dla_core_clk_o                ,//dla  core  clock   
   output  logic                    dla_csb_clk_o                 ,//dla  csb   clock   
   
   //output reset
   output  logic                    por_rstn_sync_o               ,//por_rstn sync
   output  logic                    riscv_debug_rst_o             ,//riscv debug reset
   output  logic                    riscv_rst_o                   ,//riscv reset
   output  logic                    core_nic_rst_n_o              ,//core nic reset  
   output  logic                    uncore_nic_rst_n_o            ,//uncore nic reset  
   output  logic                    uart_rst_n_o                  ,//uart0 reset 
   output  logic                    timer0_rst_n_o                ,//timer0 reset  
   output  logic                    timer1_rst_n_o                ,//timer1 reset  
   output  logic                    jtag2ahb_rst_n_o              ,//jtag2ahb reset  
   output  logic                    dma_rst_n_o                   ,//dma reset 
   output  logic                    mac_rst_n_o                   ,//i2c2ahbm reset  
   output  logic                    ddr_rst_o                      //ddr reset       

  );

  //internal signals
  //clock
   logic                            scu_kernel_clk_s                 ;
   logic                            riscv_clk_s                      ;
  //reset
   logic                            por_rstn_sync_s                  ;
   logic                            rst_riscv_debug_s                ;
  //lock
   logic                            mmcm_lock_s                      ;
  //sw reset request
   logic                            sw_rst_req_s                     ;
  //riscv 
   logic                            debug_rstn                       ;
   logic                            riscv_debug_reset_s              ;
   logic                            riscv_debug_dmactiveack_s        ;
  //uts counter
   logic                            uts_counter_value_read_strb_s    ; 
   logic                            uts_counter_load_pulse_s         ; 
   logic                            uts_counter_clr_strb_s           ; 
   logic                            uts_counter_clr_s                ; 
   logic                            uts_counter_clr_pulse_s          ;    
   logic   [63:0]                   uts_counter_s                    ;

  //interrupt 
   logic                            sw_int0_s                        ;       
   logic                            sw_int0_dly_r                    ;
   logic                            sw_int0_pulse_s                  ;
   logic                            sw_int1_s                        ;
   logic                            sw_int1_dly_r                    ;
   logic                            sw_int1_pulse_s                  ;

   logic                            sw_rst_req_prewarning_int_s      ;
   logic                            pcie_int_clear_r                 ;
   logic                            pcie_int_s                       ;

   logic   [31:0]                   func_int0_hw_set_s               ;   
  //boot
   logic                            boot_strap_pin_r                 ; 
   logic                            boot_strap_en_r                  ;
   logic                            boot_strap_en_r2                 ;

  //module reset req and mask
   logic   [12:0]                   module_rst_req_s                 ;  
   logic   [12:0]                   module_rst_mask_s                ;     
  //wdt
   //logic                            wdt_resolution_s                 ;
   //logic                            wdt_en_s                         ;
   //logic   [31:0]                   wdt_load_value_s                 ;
   //logic   [31:0]                   wdt_int_level_s                  ;
   //logic                            wdt_rld_upd_s                    ;
   //logic   [31:0]                   wdt_cnt_val_s                    ;
   //logic                            wdt_prewarning_event_dly_r       ;
   //logic                            wdt_prewarning_pulse_s           ;
   //logic                            wdt_prewarning_event_s           ;
   //logic                            wdt_rst_req_s                    ;
   //rst
   logic                            scu_register_rst_n_s             ;
   logic                            scu_register_rst_n_sync_s        ;
   logic                            scu_wdt_rst_n_s                  ;
   //pcie_int_ack
   logic                            pcie_int_ack_clear_s             ;
   logic                            pcie_int_ack_r                   ;
   logic                            pcie_int_ack_level               ;
   logic                            pcie_int_ack_rising_edge_s       ;
   logic                            pcie_int_ack_sync_pulse_s        ;
   logic                            sw_rst_req_prewarning_int_ack    ;
   logic                            wdt_prewarning_int_ack           ;


//output assign   
assign   pcie_int_o                   =  pcie_int_s                  ;
assign   sw_rst_req_prewarning_int_o  =  sw_rst_req_prewarning_int_s ;
assign   sw_int0_o                    =  sw_int0_s                   ;
assign   sw_int1_o                    =  sw_int1_s                   ;
assign   wdt_prewarning_int_o         =  1'b0;//wdt_prewarning_event_s;
assign   por_rstn_sync_o              =  por_rstn_sync_s             ;
assign   riscv_clk_o                  =  riscv_clk_s                 ;
assign   riscv_debug_rst_o            = ~riscv_debug_reset_s         ;//Active-high reset
assign   riscv_debug_dmactiveack_o    =  riscv_debug_dmactiveack_s   ;

//uts counter
assign uts_counter_clr_pulse_s   =  uts_counter_clr_strb_s & uts_counter_clr_s ;

//debug reset 
assign debug_rstn = jtag_trstn_i & rst_riscv_debug_s;

//asynchronous reset will be released after synced with clk
stdcc_rstn_sync2  stdcc_rstn_sync2_debug_rstn
   (
    .clk      (riscv_clk_s                ),
    .rstn     (debug_rstn                 ),
    .dout     (debug_rstn_sync_s          )
   );

//2-stage sync cell 
stdcc_sync2_rstn  stdcc_sync2_rstn_riscv_debug_reset
   (
    .din      (debug_rstn_sync_s          ),
    .clk      (riscv_clk_s                ), 
    .rstn     (debug_rstn                 ), 
    .dout     (riscv_debug_reset_s        )
   );

//3-stage sync cell   
stdcc_sync_cell 
   #(
    .p_sync_stage (3)
    )
stdcc_sync_cell_riscv_debug_dmactive
   (
    .din      (riscv_debug_dmactive_i     ),
    .clk      (riscv_clk_s                ), 
    .rst      (riscv_debug_reset_s        ), 
    .dout     (riscv_debug_dmactiveack_s  )
   );

//boot_strap_en dly
always_ff @(posedge sys_clk_i,negedge por_rstn_sync_s)begin
     if(!por_rstn_sync_s) begin
       boot_strap_en_r  <= 1'b0 ;
       boot_strap_en_r2 <= 1'b0 ;
     end
     else begin
       boot_strap_en_r  <= 1'b1             ;
       boot_strap_en_r2 <= boot_strap_en_r  ;
     end
   end

//boot_strap_pin_r   
always_latch  begin
    if(!boot_strap_en_r2)
       boot_strap_pin_r  = boot_strap_i ;
   end

//asynchronous reset will be released after synced with clk
stdcc_rstn_sync2  stdcc_rstn_sync2_scu_register_rst_n_s
   (
    .clk      (pcie_clk_i                     ),
    .rstn     (scu_register_rst_n_s           ),
    .dout     (scu_register_rst_n_sync_s      )
   );


//pcie interrupt
always_ff @(posedge pcie_clk_i or negedge scu_register_rst_n_sync_s)
    begin
      if(!scu_register_rst_n_sync_s) begin
        pcie_int_ack_r  <= 1'b0;
      end
      else begin
        pcie_int_ack_r  <= pcie_int_ack_i[0];
      end
    end

//detect the rising edge of pcie_int_ac
assign pcie_int_ack_rising_edge_s = pcie_int_ack_i[0] & (!pcie_int_ack_r); 

//pcie_int_ack_inst
stdcc_p2psync  pcie_int_ack_inst (
    .pulse_out_o    (pcie_int_ack_sync_pulse_s           ),
	.pulse_in_i     (pcie_int_ack_rising_edge_s          ),
	.clk_in_i       (pcie_clk_i                          ),
	.rst_n_in_i     (scu_register_rst_n_sync_s           ),
	.clk_out_i      (scu_kernel_clk_s                    ),
	.rst_n_out_i    (scu_register_rst_n_s                )
    );

//generation pcie interrupt
always_ff @(posedge scu_kernel_clk_s or negedge scu_register_rst_n_s)
    begin
      if(!scu_register_rst_n_s)
        pcie_int_clear_r       <= 1'b0                     ;
      else 
        pcie_int_clear_r       <= pcie_int_ack_sync_pulse_s;
    end

//generation pcie_int_ack_level
always_ff @(posedge scu_kernel_clk_s or negedge scu_register_rst_n_s)
    begin
      if (!scu_register_rst_n_s)
        pcie_int_ack_level             <= 1'b0;
      else if(pcie_int_s & pcie_int_ack_clear_s)
        pcie_int_ack_level             <= 1'b0;
      else if(pcie_int_ack_sync_pulse_s)
        pcie_int_ack_level             <= 1'b1;
    end

//generation sw_rst_req_prewarning_int_ack
always_ff @(posedge pcie_clk_i or negedge scu_register_rst_n_sync_s)
    begin
      if(!scu_register_rst_n_sync_s)begin
        sw_rst_req_prewarning_int_ack  <= 1'b0;
      end
      else if(pcie_int_ack_i[1] == 1'b1)begin
        sw_rst_req_prewarning_int_ack  <= 1'b1;
      end
    end

//generation wdt_prewarning_int_ack
always_ff @(posedge pcie_clk_i or negedge scu_register_rst_n_sync_s)
    begin
      if(!scu_register_rst_n_sync_s)begin
        wdt_prewarning_int_ack         <= 1'b0;
      end
      else if(pcie_int_ack_i[2] == 1'b1)begin
        wdt_prewarning_int_ack         <= 1'b1;
      end
    end

//sw_int0 & sw_int1 dly   
always_ff @(posedge scu_kernel_clk_s or negedge scu_register_rst_n_s)
    begin
      if (!scu_register_rst_n_s)
        begin
          sw_int0_dly_r <= 1'b0;
          sw_int1_dly_r <= 1'b0;
        end
      else
        begin
          sw_int0_dly_r <= sw_int0_s;
          sw_int1_dly_r <= sw_int1_s;
        end
    end

////wdt_prewarning_event_dly_r
//always_ff @(posedge scu_kernel_clk_s, negedge scu_wdt_rst_n_s)
//    begin
//      if (!scu_wdt_rst_n_s)
//        wdt_prewarning_event_dly_r <= 1'b0;
//      else
//        wdt_prewarning_event_dly_r <= wdt_prewarning_event_s;
//    end

//interrupt pulse    
//assign wdt_prewarning_pulse_s = wdt_prewarning_event_s & ~wdt_prewarning_event_dly_r;
assign sw_int1_pulse_s        = sw_int1_s & ~sw_int1_dly_r; 
assign sw_int0_pulse_s        = sw_int0_s & ~sw_int0_dly_r; 

//func_int0_hw_set_s
assign func_int0_hw_set_s     = {{29{1'b0}},sw_int1_pulse_s,sw_int0_pulse_s,1'b0};


//main_scu_register_top_wrapper
main_scu_register_top_wrapper main_scu_register_top_wrapper(
  .HCLK                                                     (per_clk_o                      ),// system bus clock
  .kernel_clk_i                                             (scu_kernel_clk_s               ),//Kernel clock
  .module_resetn_i                                          (scu_register_rst_n_s           ),// system bus reset
  .dft_scan_en_i                                            (1'b0                           ), //It will be used to control the clock gate cell
  .jtag_rst_sync_bypass_i                                   (jtag_rst_sync_bypass_i         ), //It will be used to control the Reset sync cell
    
  .HSEL                                                     (ahb_sel_i                      ),// AHB peripheral select
  .HREADY                                                   (ahb_ready_i                    ),// AHB ready input
  .HTRANS                                                   (ahb_trans_i                    ),// AHB transfer type
  .HSIZE                                                    (ahb_size_i                     ),// AHB hsize
  .HWRITE                                                   (ahb_write_i                    ),// AHB hwrite
  .HADDR                                                    (ahb_addr_i                     ),// AHB address bus
  .HWDATA                                                   (ahb_wdata_i                    ),// AHB write data bus
  .HREADYOUT                                                (ahb_readyout_o                 ),// AHB ready output to S->M mux
  .HRESP                                                    (ahb_resp_o                     ),// AHB response
  .HRDATA                                                   (ahb_rdata_o                    ),// AHB read data bus

  .func_int0_hw_set_i                                       (func_int0_hw_set_s             ), 
  .func_int0_interrupt_o                                    (scu_int_o                      ),
  .gated_kernel_clk_o                                       (                               ),
  .synced_kernel_reset_o                                    (                               ),      
	
//LMU_BOOT_ADDR_ALIAS_SEL ,RWHS
  .lmu_boot_addr_alias_sel_rwhs_strb_i                      (1'b0                           ), 
  .lmu_boot_addr_alias_sel_rwhs_strb_o                      (                               ), 
  .lmu_boot_addr_alias_sel_rwhs_boot_addr_alias_sel_i       (1'b0                           ),
  .lmu_boot_addr_alias_sel_rwhs_boot_addr_alias_sel_o       (                               ),

//BOOT_STRAP_PIN ,RO
  .boot_strap_pin_ro_boot_strap_pin_i                       (boot_strap_pin_r               ),

//DDR_INITIAL_DONE ,RO
  .ddr_initial_done_ro_ddr_initial_done_i                   (ddr_initial_done_i             ),  
//UTS_COUNTER_H ,RWHS
  .uts_counter_h_rwhs_strb_i                                (uts_counter_load_pulse_s       ), 
  .uts_counter_h_rwhs_strb_o                                (uts_counter_value_read_strb_s  ), 
  .uts_counter_h_rwhs_uts_counter_h_i                       (uts_counter_s[63:32]           ),
  .uts_counter_h_rwhs_uts_counter_h_o                       (                               ),
	
//UTS_COUNTER_L ,RWH
  .uts_counter_l_rwh_strb_i                                 (uts_counter_load_pulse_s       ),
  .uts_counter_l_rwh_uts_counter_l_i                        (uts_counter_s[31:0]            ),
  .uts_counter_l_rwh_uts_counter_l_o                        (                               ),

//UTS_COUNTER_CLR ,RWS
  .uts_counter_clr_rws_strb_o                               (uts_counter_clr_strb_s         ), 
  .uts_counter_clr_rws_uts_counter_clr_o                    (uts_counter_clr_s              ),    

//SW_INTERRUPT ,RW
  .sw_interrupt_rw_sw_int1_o                                (sw_int1_s                      ),
  .sw_interrupt_rw_sw_int0_o                                (sw_int0_s                      ),

//PCIE_INTERRUPT ,RWHS
  .pcie_interrupt_rwhs_strb_i                               (pcie_int_clear_r               ), 
  .pcie_interrupt_rwhs_strb_o                               (pcie_int_ack_clear_s           ), 
  .pcie_interrupt_rwhs_pcie_int_i                           (1'b0                           ),
  .pcie_interrupt_rwhs_pcie_int_o                           (pcie_int_s                     ),  

//PCIE_PREWARNING_INT ,RW
  .sw_rst_req_prewarning_int_rw_sw_rst_req_prewarning_int_o (sw_rst_req_prewarning_int_s    ),

//PCIE_USER_LNK_UP ,RO
  .pcie_user_lnk_up_ro_pcie_user_lnk_up_i                   (pcie_user_lnk_up_i             ),

//PCIE_MSI_ENABLE ,RO
  .pcie_msi_enable_ro_pcie_msi_enable_i                     (pcie_msi_enable_i              ),
	
//PCIE_MSIX_ENABLE ,RO
  .pcie_msix_enable_ro_pcie_msix_enable_i                   (pcie_msix_enable_i             ),

//PCIE_INT_ACK ,RO
  .pcie_int_ack_ro_wdt_prewarning_int_ack_i                 (wdt_prewarning_int_ack         ),
  .pcie_int_ack_ro_sw_rst_req_prewarning_int_ack_i          (sw_rst_req_prewarning_int_ack  ),
  .pcie_int_ack_ro_pcie_int_ack_i                           (pcie_int_ack_level             ),

//MMCM_LOCK ,RO
  .mmcm_lock_ro_mmcm_lock_i                                 (mmcm_lock_s                    ),
	
//SW_RST_REQ ,RW
  .sw_rst_req_rw_sw_rst_req_o                               (sw_rst_req_s                   ),

//MODULE_RST_CTRL ,RW
  .module_rst_ctrl_rw_riscv_debug_rst_req_o                 (module_rst_req_s[0]            ),
  .module_rst_ctrl_rw_riscv_rst_req_o                       (module_rst_req_s[1]            ),
  .module_rst_ctrl_rw_core_nic_rstn_req_o                   (module_rst_req_s[2]            ),
  .module_rst_ctrl_rw_uncore_nic_rstn_req_o                 (module_rst_req_s[3]            ),
  .module_rst_ctrl_rw_uart_rstn_req_o                       (module_rst_req_s[4]            ),
  .module_rst_ctrl_rw_timer0_rstn_req_o                     (module_rst_req_s[5]            ),
  .module_rst_ctrl_rw_timer1_rstn_req_o                     (module_rst_req_s[6]            ),
  .module_rst_ctrl_rw_wdt_rstn_req_o                        (module_rst_req_s[7]            ),
  .module_rst_ctrl_rw_scu_register_rstn_req_o               (module_rst_req_s[8]            ),
  .module_rst_ctrl_rw_jtag2ahb_rstn_req_o                   (module_rst_req_s[9]            ),
  .module_rst_ctrl_rw_dma_rstn_req_o                        (module_rst_req_s[10]           ),
  .module_rst_ctrl_rw_mac_rstn_req_o                        (module_rst_req_s[11]           ),
  .module_rst_ctrl_rw_ddr_rst_req_o                         (module_rst_req_s[12]           ),

//MODULE_RST_CTRL_MASK ,RW
  .module_rst_ctrl_mask_rw_riscv_debug_rst_req_mask_o       (module_rst_mask_s[0]           ),
  .module_rst_ctrl_mask_rw_riscv_rst_req_mask_o             (module_rst_mask_s[1]           ),
  .module_rst_ctrl_mask_rw_core_nic_rstn_req_mask_o         (module_rst_mask_s[2]           ),
  .module_rst_ctrl_mask_rw_uncore_nic_rstn_req_mask_o       (module_rst_mask_s[3]           ),
  .module_rst_ctrl_mask_rw_uart_rstn_req_mask_o             (module_rst_mask_s[4]           ),
  .module_rst_ctrl_mask_rw_timer0_rstn_req_mask_o           (module_rst_mask_s[5]           ),
  .module_rst_ctrl_mask_rw_timer1_rstn_req_mask_o           (module_rst_mask_s[6]           ),
  .module_rst_ctrl_mask_rw_wdt_rstn_req_mask_o              (module_rst_mask_s[7]           ),
  .module_rst_ctrl_mask_rw_scu_register_rstn_req_mask_o     (module_rst_mask_s[8]           ),
  .module_rst_ctrl_mask_rw_jtag2ahb_rstn_req_mask_o         (module_rst_mask_s[9]           ),
  .module_rst_ctrl_mask_rw_dma_rstn_req_mask_o              (module_rst_mask_s[10]          ),
  .module_rst_ctrl_mask_rw_mac_rstn_req_mask_o              (module_rst_mask_s[11]          ),
  .module_rst_ctrl_mask_rw_ddr_rst_req_mask_o               (module_rst_mask_s[12]          ),

//RESET_STATUS ,RO
  .reset_status_ro_riscv_debug_rst_sta_i                    (riscv_debug_rst_o              ),
  .reset_status_ro_riscv_rst_sta_i                          (riscv_rst_o                    ),
  .reset_status_ro_core_nic_rstn_sta_i                      (core_nic_rst_n_o               ),
  .reset_status_ro_uncore_nic_rstn_sta_i                    (uncore_nic_rst_n_o             ),
  .reset_status_ro_uart_rstn_sta_i                          (uart_rst_n_o                   ),
  .reset_status_ro_timer0_rstn_sta_i                        (timer1_rst_n_o                 ),
  .reset_status_ro_timer1_rstn_sta_i                        (timer0_rst_n_o                 ),
  .reset_status_ro_wdt_rstn_sta_i                           (scu_wdt_rst_n_s                ),
  .reset_status_ro_scu_register_rstn_sta_i                  (scu_register_rst_n_s           ),
  .reset_status_ro_jtag2ahb_rstn_sta_i                      (jtag2ahb_rst_n_o               ),
  .reset_status_ro_dma_rstn_sta_i                           (dma_rst_n_o                    ),
  .reset_status_ro_mac_rstn_sta_i                           (mac_rst_n_o                    ),
  .reset_status_ro_ddr_rst_sta_i                            (ddr_rst_o                      ),
	
//WDT
  .wdt_control_rw_resolution_o                              (    /*wdt_resolution_s*/       ),
  .wdt_control_rw_en_o                                      (    /*wdt_en_s        */       ),
  .wdt_load_value_rw_value_o                                (    /*wdt_load_value_s*/       ),
  .wdt_int_level_rw_level_o                                 (    /*wdt_int_level_s */       ),
  .wdt_rld_upd_wo_upd_o                                     (    /*wdt_rld_upd_s   */       ),
  .wdt_cnt_val_ro_value_i                                   (    /*wdt_cnt_val_s   */       )
);



cgu_top  cgu_top_inst(
//clk & reset
  .sys_clk_i                                                (sys_clk_i                      ), //system clock 
  .por_rstn_i                                               (por_rstn_i                     ),// por rstn
  .por_rstn_sync_i                                          (por_rstn_sync_s                ), //por_rstn_i by sync
//mmcm
  .locked_o                                                 (mmcm_lock_s                    ),
//reset bypass by mbist test                           
  .jtag_rst_sync_bypass_i                                   (jtag_rst_sync_bypass_i         ),
//output clock
  .riscv_clk_o                                              (riscv_clk_s                    ),//riscv clock   
  .riscv_core_clk_o                                         (riscv_core_clk_o               ),//riscv core  clock
  .riscv_rtc_toggle_o                                       (riscv_rtc_toggle_o             ),//riscv rtc_toggle clock
  .riscv_debug_clk_o                                        (riscv_debug_clk_o              ),//riscv debug clock   
  .dma_clk_o                                                (dma_clk_o                      ),//dma   clock   
  .per_clk_o                                                (per_clk_o                      ),//per   clock   
  .uart_clk_o                                               (uart_clk_o                     ),//uart  clock   
  .uart_kernel_clk_o                                        (uart_kernel_clk_o              ),//uart kernel clock   
  .timer0_ahb_clk_o                                         (timer0_ahb_clk_o               ),//timer0 ahb  clock  
  .timer0_kernel_clk_o                                      (timer0_kernel_clk_o            ),//timer0 kernel clock  
  .timer1_ahb_clk_o                                         (timer1_ahb_clk_o               ),//timer1 ahb  clock  
  .timer1_kernel_clk_o                                      (timer1_kernel_clk_o            ),//timer1 kernel clock 
  .dla_core_clk_o                                           (dla_core_clk_o                 ),//dla  core  clock   
  .dla_csb_clk_o                                            (dla_csb_clk_o                  ),//dla  csb   clock 
  .scu_ker_clk_o                                            (scu_kernel_clk_s               ) //scu kernel clock
   );


rgu_top rgu_top_inst(
  .sys_clk_i                                                (scu_kernel_clk_s               ),
  .wdt_rst_req_i                                            (1'b0                           ),  
  .sw_rst_req_i                                             (sw_rst_req_s                   ),
  .locked_i                                                 (mmcm_lock_s                    ),
  .por_rstn_i                                               (por_rstn_i                     ),// por rstn
  .pcie_hot_rstn_i                                          (pcie_hot_rstn_i                ),// pcie_hot_rstn  

  .mod_rst_req_i                                            (module_rst_req_s               ),      
  .mod_rst_mask_i                                           (module_rst_mask_s              ),  

  .jtag_rst_sync_bypass_i                                   (jtag_rst_sync_bypass_i         ),
  .por_rstn_sync_o                                          (por_rstn_sync_s                ),//to sync reset 
  .rst_riscv_debug_o                                        (rst_riscv_debug_s              ),//riscv debug reset
  .rst_riscv_o                                              (riscv_rst_o                    ),//riscv reset 
  .rst_core_nic_n_o                                         (core_nic_rst_n_o               ),//core nic reset 
  .rst_uncore_nic_n_o                                       (uncore_nic_rst_n_o             ),//uncore nic reset 
  .rst_uart_n_o                                             (uart_rst_n_o                   ),//uart0 reset 
  .rst_timer0_n_o                                           (timer0_rst_n_o                 ),//timer0 reset 
  .rst_timer1_n_o                                           (timer1_rst_n_o                 ),//timer1 reset 
  .rst_wdt_n_o                                              (scu_wdt_rst_n_s                ),//wdt reset
  .rst_scu_register_n_o                                     (scu_register_rst_n_s           ),//SCU register reset 
  .rst_jtag2ahb_n_o                                         (jtag2ahb_rst_n_o               ),//jtag2ahb reset  
  .rst_dma_n_o                                              (dma_rst_n_o                    ),//dma reset 
  .rst_mac_n_o                                              (mac_rst_n_o                    ),//mac reset 
  .rst_ddr_o                                                (ddr_rst_o                      ) //ddr reset
   ); 

   
scu_uts_counter scu_uts_counter_inst(
  .clk_i                                                    (scu_kernel_clk_s               ), 
  .rst_n_i                                                  (por_rstn_sync_s                ),         
  .uts_counter_clr_i                                        (uts_counter_clr_pulse_s        ),    
  .uts_counter_value_read_i                                 (uts_counter_value_read_strb_s  ),  
  .uts_counter_load_pulse_o                                 (uts_counter_load_pulse_s       ),  
  .uts_counter_o                                            (uts_counter_s                  )    
   ); 


//wdt_kernel wdt_kernel_inst (
//  .wdt_kernel_clk_i                                         (scu_kernel_clk_s               ),
//  .wdt_rst_n_i                                              (scu_wdt_rst_n_s                ),
//  .wdt_en_i                                                 (wdt_en_s                       ),
//  .wdt_resolution_i                                         (wdt_resolution_s               ),
//  .wdt_rld_upd_i                                            (wdt_rld_upd_s                  ),
//  .wdt_tst_speedup_i                                        (1'b0                           ),
//  .wdt_tst_prewarning_mask_i                                (1'b0                           ),
//  .wdt_load_value_i                                         (wdt_load_value_s               ),
//  .wdt_int_level_i                                          (wdt_int_level_s                ),
//  .wdt_prewarning_event_o                                   (wdt_prewarning_event_s         ),
//  .wdt_rst_req_o                                            (wdt_rst_req_s                  ),
//  .wdt_cnt_val_o                                            (wdt_cnt_val_s                  )
//  );






endmodule                                             
