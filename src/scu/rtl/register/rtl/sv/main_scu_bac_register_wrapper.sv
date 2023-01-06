//-------------------------------------------------------------- 
//  main_scu_bac_register_wrapper.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_bac_register_wrapper.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!                                                      
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//--------------------------------------------------------------
//  Functions Descriptions : avoid the warnings of bac_register.
//--------------------------------------------------------------
//  Version modify History:
//  Version    Date           Author     Description
//  V0.8     2021-01-05       liyang14   packet a wrapper fot the bac register.
//  V0.8     2021-01-07       liyang14   not generate the tx_fifo_start, tx_fifo_end, rx_fifo_start and rx_fifo_end port.
//  V0.8     2021-01-13       liyang14   TX_FIFO_ENABLE register
//-------------------------------------------------------------- 
module main_scu_bac_register_wrapper
#(
parameter p_tx_fifo_common_int_num       = 32,
parameter p_rx_fifo_common_int_num       = 32,
parameter p_bus_address_width            = 21,
parameter p_bac_reg_offset_address_width = 12, 
parameter p_response_width               = 2 ,
//TODO 4 TX/RX fifo is not comsider here, only generate the Y type bac register.



parameter p_num_of_bac_register          =16
)
(
output register_bank_clock_enable_set_wo_set_o,
output register_bank_clock_enable_clr_wo_clr_o,
input register_bank_clock_enable_status_ro_status_i,
output kernel_clock_enable_set_wo_set_o,
output kernel_clock_enable_clr_wo_clr_o,
input kernel_clock_enable_status_ro_status_i,
input [31:0] chipid_ro_chipid_i,
input [7:0] moduleid_ro_module_version_i,
input [7:0] moduleid_ro_module_id_i,
input [15:0] moduleid_ro_reg_if_version_i,
input [31:0] checksum_ro_checksum_i,
output [31:0] func_int_0_enable_set_wo_set_o,
output [31:0] func_int_0_enable_clear_wo_clear_o,
input [31:0] func_int_0_enable_status_ro_status_i,
output [31:0] func_int_0_set_wo_set_o,
output [31:0] func_int_0_clr_wo_clear_o,
input [31:0] func_int_0_status_enabled_ro_status_i,
input [31:0] func_int_0_status_ro_status_i,
//clock and reset signal
input                                           clk_i           ,
input                                           rst_n_i         ,
//bac related signal
input                                           bac_csb_i       ,
input                                           bac_wr_i        ,
input       [p_bac_reg_offset_address_width-1:0]bac_address_i   ,
input       [31:0]                              bac_write_data_i,
input       [3:0]                               bac_byte_en_i   ,
output logic[31:0]                              bac_read_data_o ,
output logic                                    bac_ready_o     ,
output logic[p_response_width-1:0]              bac_response_o  
);

//from kernel
logic[31:0] bac_data_in_s [p_num_of_bac_register-1:0];
//to kernel
logic[31:0] bac_data_out_s[p_num_of_bac_register-1:0];

main_scu_bac_register_block
#(
    .p_num_of_bac_register         (p_num_of_bac_register         ),
    .p_response_width              (p_response_width              ),
    .p_bac_reg_offset_address_width(p_bac_reg_offset_address_width)
)
main_scu_bac_register_block_inst
(
    .clk_i             (clk_i             ),
    .resetn_i          (rst_n_i           ),
    .bac_csb_i         (bac_csb_i         ),
    .bac_wr_i          (bac_wr_i          ),
    .bac_address_i     (bac_address_i     ),
    .bac_write_data_i  (bac_write_data_i  ),
    .bac_byte_en_i     (bac_byte_en_i     ),
    .bac_read_data_o   (bac_read_data_o   ),
    .bac_ready_o       (bac_ready_o       ),
    .bac_response_o    (bac_response_o    ),
    .bac_data_in_i     (bac_data_in_s     ),
    .bac_data_out_o    (bac_data_out_s    )
);

assign bac_data_in_s[0] = 32'h0;
assign register_bank_clock_enable_set_wo_set_o = bac_data_out_s[0][0];
assign bac_data_in_s[1] = 32'h0;
assign register_bank_clock_enable_clr_wo_clr_o = bac_data_out_s[1][0];
assign bac_data_in_s[2][31:1] = 31'b0;
assign bac_data_in_s[2][0] = register_bank_clock_enable_status_ro_status_i;
assign bac_data_in_s[3] = 32'h0;
assign kernel_clock_enable_set_wo_set_o = bac_data_out_s[3][0];
assign bac_data_in_s[4] = 32'h0;
assign kernel_clock_enable_clr_wo_clr_o = bac_data_out_s[4][0];
assign bac_data_in_s[5][31:1] = 31'b0;
assign bac_data_in_s[5][0] = kernel_clock_enable_status_ro_status_i;
assign bac_data_in_s[6][31:0] = chipid_ro_chipid_i;
assign bac_data_in_s[7][31:24] = moduleid_ro_module_version_i;
assign bac_data_in_s[7][23:16] = moduleid_ro_module_id_i;
assign bac_data_in_s[7][15:0] = moduleid_ro_reg_if_version_i;
assign bac_data_in_s[8][31:0] = checksum_ro_checksum_i;
assign bac_data_in_s[9] = 32'h0;
assign func_int_0_enable_set_wo_set_o = bac_data_out_s[9][31:0];
assign bac_data_in_s[10] = 32'h0;
assign func_int_0_enable_clear_wo_clear_o = bac_data_out_s[10][31:0];
assign bac_data_in_s[11][31:0] = func_int_0_enable_status_ro_status_i;
assign bac_data_in_s[12] = 32'h0;
assign func_int_0_set_wo_set_o = bac_data_out_s[12][31:0];
assign bac_data_in_s[13] = 32'h0;
assign func_int_0_clr_wo_clear_o = bac_data_out_s[13][31:0];
assign bac_data_in_s[14][31:0] = func_int_0_status_enabled_ro_status_i;
assign bac_data_in_s[15][31:0] = func_int_0_status_ro_status_i;





                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   
endmodule

