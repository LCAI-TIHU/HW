//-------------------------------------------------------------- 
//  main_scu_bus_access_control_top.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_bus_access_control_top.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!                                                      
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//-------------------------------------------------------------------
//  File name : bus_access_control_top.sv
//-------------------------------------------------------------------
//  Function Notes : Bus Access control top 
//-------------------------------------------------------------------
//  Release History          :           
//  Version  Date        Author     Description
//  V0.1     2020-02-19  WangMingming     initial
//  V0.8     2020-12-31  liyang14         update this module according to the misc module and bac_register_block module
//  V0.8     2021-01-05  liyang14         Modify the interrupt related signal names(mask --> enable)
//  V0.8     2021-01-06  liyang14         integrate the bac_register_wrapper in this module
//-----------------------------------------------------------------
//**********************************************************************************************
//******************************It includes below blocks ***************************************
//**********************************************************************************************
//
//                    [AHB2SRAM Bridge]                                                                              
//                           | 
//   ________________________|___________________________________________________________________________
//  |                        |           bus_access_control_top                                          |
//  |     ___________________|________________________                                                   |
//  |    |                                            |                                                  |
//  |    |            bac_address_decoder             |                                                  |
//  |    |____________________________________________|                                                  |
//  |     |     |                               |                                                        |
//  |     |     |       ________________________|__________________________________________________      |
//  |     |     |      |                                                                           |     |
//  |     |     |      |                        bac_register_block                                 |     |
//  |     |     |      |___________________________________________________________________________|     |
//  |     |     |           |                    |                 |                   |                 |
//  |     |     |   ________|________    ________|________      ___|____      _________|_____________    |
//  |     |     |  |bac_rx_fifo_block|  |bac_tx_fifo_block|    |bac_misc|    |common_interrupt_handle|   |
//  |     |     |  |_________________|  |_________________|    |________|    |_______________________|   |
//  |     |     |            |                    |                 |                   |                |
//  |     |     |            |                    |                 |                   |                |
//  |_____|_____|____________|____________________|_________________|___________________|________________|
//        |     |            |                    |                 |                   |
//        |  [reg_bank]      |                    |                 |                   |                                 <==  connect to register bank 
//   [mem_if]            [rx fifo if     ] [tx fifo if]           [gated clock]   [interrupt hw set]                      <==  connect to kernel   
//                       [rx fifo dma if ] [rx fifo dma if ]                      [interrupt singals]                     <==  connect to IP external 
// 
//**********************************************************************************************


module main_scu_bus_access_control_top
#(



parameter p_num_of_bac_register            =16,
parameter p_bus_address_width               = 24,
parameter p_response_width                  = 3,									   
parameter p_memory_address_width            = 24, // memory will give full 24 bits address 
parameter p_bac_reg_offset_address_width    = 6,
parameter p_kernel_reg_offset_address_width = 12,
parameter p_client_num                      = 1, 
parameter p_func_int0_num                   = 32, 
parameter p_func_int1_num                   = 32, 
parameter p_error_int_num                   = 32, 
parameter p_tx_fifo_common_int_num          =  8,
parameter p_rx_fifo_common_int_num          =  8
)  
(
//clock & reset 
input                                            clk_i                      ,
input                                            resetn_i                   ,
//DFT port 
input                                            dft_scan_en_i              , //It will be used to control the clock gate cell
input                                            jtag_rst_sync_bypass_i     , //It will be used to control the Reset sync cell
input                                            bus_clk_i                  , // in case it is async bridge 
//synced reset for AHB2ESRAM Async Bridge  
output                                           synced_hclk_reset_o        ,
//SRAM Bus access interface                                           
input                                            bus_csb_i                    ,
input                                            bus_wr_i                     ,
input[p_bus_address_width-1:0]                   bus_address_i                ,
input[31:0]                                      bus_write_data_i             ,
input[3:0]                                       bus_byte_en_i                ,
output reg [31:0]                                bus_read_data_o              ,
output reg                                       bus_ready_o                  ,
output reg [p_response_width-1:0]                bus_response_o               ,
//to register bank                                                          
output                                           reg_csb_o                    ,
output                                           reg_wr_o                     ,
output[p_kernel_reg_offset_address_width-1:0]    reg_address_o                ,
output[31:0]                                     reg_write_data_o             ,
output[3:0]                                      reg_byte_en_o                ,
input [31:0]                                     reg_read_data_i              ,
input                                            reg_ready_i                  ,
input[p_response_width-1:0]                      reg_response_i               ,
									  
//interrupt HW set from Kernel side 
input [p_func_int0_num-1          :0] func_int0_hw_set_i         , 
output                                func_int0_interrupt_o      ,



//gated clocks
output gated_kernel_clk_o                                        ,
output gated_regbank_clk_o                                       ,
//synced kernel reset                                                    
output synced_kernel_reset_o                                      
);
//in this top level, only Wiring(signals & parameters) is allowed!!!!! 
//logic definition 
//SRAM access interface 
logic                                     bac_csb_s        ;
logic                                     bac_wr_s         ;
logic[p_bac_reg_offset_address_width-1:0] bac_address_s    ;
logic[31:0]                               bac_write_data_s ;
logic[3:0]                                bac_byte_en_s    ;
logic[31:0]                               bac_read_data_s  ;
logic                                     bac_ready_s      ; 
logic[p_response_width-1:0]               bac_response_s   ;

//TODO p_chipid_val p_checksum_val p_register_if_version_val p_module_versionid_val p_moduleid_val
logic [31:0] p_chipid_val_s             ;
logic [31:0] p_checksum_val_s           ;
logic [15:0] p_register_if_version_val_s;
logic [7:0]  p_module_versionid_val_s   ;
logic [7:0]  p_moduleid_val_s           ;

//common interrupts 
logic [p_func_int0_num-1          :0] func_int0_enable_set_s                    ; 
logic [p_func_int0_num-1          :0] func_int0_enable_clr_s                    ; 
logic [p_func_int0_num-1          :0] func_int0_sw_set_s                        ; 
logic [p_func_int0_num-1          :0] func_int0_sw_clr_s                        ; 
logic [p_func_int0_num-1          :0] func_int0_enable_status_s                 ; 
logic [p_func_int0_num-1          :0] func_int0_enabled_int_status_s            ; 
logic [p_func_int0_num-1          :0] func_int0_int_status_s                    ; 
//--
logic[p_client_num-1:0]  reg_bank_clk_i_en_set_wo_s     ;       
logic[p_client_num-1:0]  reg_bank_clk_i_en_clr_wo_s     ;       
logic[p_client_num-1:0]  reg_bank_clk_i_en_sta_ro_s     ;       
logic[p_client_num-1:0]  kernel_clk_i_en_set_wo_s       ;       
logic[p_client_num-1:0]  kernel_clk_i_en_clr_wo_s       ;       
logic[p_client_num-1:0]  kernel_clk_i_en_sta_ro_s       ;       
//TODO  because delete these ports---
//logic                   first_access_error_clear_wo_o    ; 
//logic                   last_access_error_clear_wo_o     ; 
//logic[31:0]             first_access_error_ro_i          ; 
//logic[31:0]             last_access_error_ro_i           ; 
//--
logic                   synced_kernel_reset_s;
//---
main_scu_bac_address_decoder
#(
.p_bus_address_width              (p_bus_address_width              ),
.p_response_width                 (p_response_width                 ),
.p_bac_reg_offset_address_width   (p_bac_reg_offset_address_width   ),
.p_kernel_reg_offset_address_width(p_kernel_reg_offset_address_width) 

) main_scu_bac_address_decoder_inst
(
.clk_i              (clk_i                 ),
.resetn_i           (synced_kernel_reset_s ),
.bus_csb_i          (bus_csb_i       ),
.bus_wr_i           (bus_wr_i        ),
.bus_address_i      (bus_address_i   ),
.bus_write_data_i   (bus_write_data_i),
.bus_byte_en_i      (bus_byte_en_i   ),
.bus_read_data_o    (bus_read_data_o ),
.bus_ready_o        (bus_ready_o     ),
.bus_response_o     (bus_response_o  ),
.bac_csb_o          (bac_csb_s       ),
.bac_wr_o           (bac_wr_s        ),
.bac_address_o      (bac_address_s   ),
.bac_write_data_o   (bac_write_data_s),
.bac_byte_en_o      (bac_byte_en_s   ),
.bac_read_data_i    (bac_read_data_s ),
.bac_ready_i        (bac_ready_s     ),
.bac_response_i     (bac_response_s  ),
.reg_csb_o          (reg_csb_o       ),
.reg_wr_o           (reg_wr_o        ),
.reg_address_o      (reg_address_o   ),
.reg_write_data_o   (reg_write_data_o),
.reg_byte_en_o      (reg_byte_en_o   ),
.reg_read_data_i    (reg_read_data_i ),
.reg_ready_i        (reg_ready_i     ),
.reg_response_i     (reg_response_i  )
);
//TODO main_scu_bac_register_block --> main_scu_bac_register_block_wrapper---
main_scu_bac_register_wrapper
#(
.p_bac_reg_offset_address_width(p_bac_reg_offset_address_width),
.p_response_width              (p_response_width              ),
.p_num_of_bac_register         (p_num_of_bac_register         ), // 4 TX/RX FIFO is not consider here
.p_tx_fifo_common_int_num      (p_tx_fifo_common_int_num      ),
.p_rx_fifo_common_int_num      (p_rx_fifo_common_int_num      )
)  main_scu_bac_register_wrapper_inst 
(
.clk_i                                                    (clk_i                      ),
.rst_n_i                                                  (synced_kernel_reset_s      ),
.bac_csb_i                                                (bac_csb_s                  ),
.bac_wr_i                                                 (bac_wr_s                   ),
.bac_address_i                                            (bac_address_s              ),
.bac_write_data_i                                         (bac_write_data_s           ),
.bac_byte_en_i                                            (bac_byte_en_s              ),
.bac_read_data_o                                          (bac_read_data_s            ),
.bac_ready_o                                              (bac_ready_s                ),
.bac_response_o                                           (bac_response_s             ),
//TODO?? need to connect for real function .. 
.register_bank_clock_enable_set_wo_set_o                  (reg_bank_clk_i_en_set_wo_s ),
.register_bank_clock_enable_clr_wo_clr_o                  (reg_bank_clk_i_en_clr_wo_s ),
.register_bank_clock_enable_status_ro_status_i            (reg_bank_clk_i_en_sta_ro_s ),
.kernel_clock_enable_set_wo_set_o                         (kernel_clk_i_en_set_wo_s   ),
.kernel_clock_enable_clr_wo_clr_o                         (kernel_clk_i_en_clr_wo_s   ),
.kernel_clock_enable_status_ro_status_i                   (kernel_clk_i_en_sta_ro_s   ),

.func_int_0_enable_set_wo_set_o                           (func_int0_enable_set_s         ),
.func_int_0_enable_clear_wo_clear_o                       (func_int0_enable_clr_s         ),
.func_int_0_set_wo_set_o                                  (func_int0_sw_set_s             ),
.func_int_0_clr_wo_clear_o                                (func_int0_sw_clr_s             ),
.func_int_0_enable_status_ro_status_i                     (func_int0_enable_status_s      ),
.func_int_0_status_enabled_ro_status_i                    (func_int0_enabled_int_status_s ),
.func_int_0_status_ro_status_i                            (func_int0_int_status_s         ),




.chipid_ro_chipid_i                                        (p_chipid_val_s                       ),
.moduleid_ro_module_id_i                                   (p_moduleid_val_s                     ),
.moduleid_ro_module_version_i                              (p_module_versionid_val_s             ),
.moduleid_ro_reg_if_version_i                              (p_register_if_version_val_s          ),
.checksum_ro_checksum_i                                    (p_checksum_val_s                     )
);


//---
main_scu_bac_common_interrupt_handle
#(
.p_func_int0_num                    (p_func_int0_num                    ),
.p_func_int1_num                    (p_func_int1_num                    ),
.p_error_int_num                    (p_error_int_num                    ),
.p_tx_fifo_common_int_num           (p_tx_fifo_common_int_num           ),
.p_rx_fifo_common_int_num           (p_rx_fifo_common_int_num           )
)  main_scu_bac_common_interrupt_handle_inst
(
.func_int0_enable_set_i             (func_int0_enable_set_s             ),
.func_int0_enable_clr_i             (func_int0_enable_clr_s             ),
.func_int0_hw_set_i                 (func_int0_hw_set_i                 ),
.func_int0_sw_set_i                 (func_int0_sw_set_s                 ),
.func_int0_sw_clr_i                 (func_int0_sw_clr_s                 ),
.func_int0_enable_status_o          (func_int0_enable_status_s          ),
.func_int0_enabled_int_status_o     (func_int0_enabled_int_status_s     ),
.func_int0_int_status_o             (func_int0_int_status_s             ),
.func_int0_interrupt_o              (func_int0_interrupt_o              ),

.clk_i                              (clk_i                              ),
.resetn_i                           (synced_kernel_reset_s              )
);


//---
 main_scu_bac_misc 
#(
.p_client_num(p_client_num)

) main_scu_bac_misc_inst
(
.kernel_clk_i                  (clk_i                         ),
.resetn_i                      (resetn_i                      ),
.dft_scan_en_i                 (dft_scan_en_i                 ) , 
.jtag_rst_sync_bypass_i        (jtag_rst_sync_bypass_i        ) ,
//---
.reg_bank_clk_en_set_i         (reg_bank_clk_i_en_set_wo_s    ),       
.reg_bank_clk_en_clr_i         (reg_bank_clk_i_en_clr_wo_s    ),       
.reg_bank_clk_en_sta_o         (reg_bank_clk_i_en_sta_ro_s    ),       
.kernel_clk_en_set_i           (kernel_clk_i_en_set_wo_s      ),       
.kernel_clk_en_clr_i           (kernel_clk_i_en_clr_wo_s      ),       
.kernel_clk_en_sta_o           (kernel_clk_i_en_sta_ro_s      ),   
//TODO p_chipid_val p_checksum_val p_register_if_version_val p_moduleid_val p_moduleid_val 
.p_chipid_val_o                (p_chipid_val_s                ),
.p_checksum_val_o              (p_checksum_val_s              ),
.p_register_if_version_val_o   (p_register_if_version_val_s   ),
.p_module_versionid_val_o      (p_module_versionid_val_s      ),
.p_moduleid_val_o              (p_moduleid_val_s              ),

.gated_kernel_clk_o            (gated_kernel_clk_o            ),
.gated_regbank_clk_o           (gated_regbank_clk_o           ),
.hclk_i                        (bus_clk_i                     ),
.synced_hclk_reset_o           (synced_hclk_reset_o           ),
.synced_kernel_reset_o         (synced_kernel_reset_s         )
);

                
                
								
assign synced_kernel_reset_o = synced_kernel_reset_s;
endmodule 