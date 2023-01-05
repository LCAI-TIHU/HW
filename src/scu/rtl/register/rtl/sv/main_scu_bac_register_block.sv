//-------------------------------------------------------------- 
//  main_scu_bac_register_block.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_bac_register_block.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!  
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//-------------------------------------------------------------------
//  Function Notes : Bus Access control part register 
//-------------------------------------------------------------------
//  Release History :           
//  Version  Date        Author     Description
//  V0.1     2020-02-17  WangMingming     initial
//  V0.8     2020-12-30  liyang14         Delete the address decode logic
//  V0.8     2020-12-30  liyang14         Use generate replace the for circulation
//  V0.8     2021-01-04  liyang14         Add byte_en logic into this module
//  V0.8     2020-12-31  liyang14         move the parameters of bac_register_block_tmp(chipid,moduleid,module_version and register_version so on) into the misc module.
//  V0.8     2021-01-04  liyang14         Separate the high_watermark and low_watermark logic of tx fifo and rx fifo from this module.
//  V0.8     2021-01-04  liyang14         mask the first error and last error related signals.
//  V0.8     2021-01-04  liyang14         Packet a wrapper for this module 
//  V0.8     2021-01-20  liyang14         bac_address bit width is modified to p_bac_reg_offset_address_width
//-----------------------------------------------------------------
module main_scu_bac_register_block
#(
//parameter p_bus_address_width            = 21,
parameter p_bac_reg_offset_address_width = 12, 
//TODO 4 TX/RX fifo is not comsider here, only generate the Y type bac register.



parameter p_num_of_bac_register          =16,
parameter p_response_width               = 3
)
(
input                                                 clk_i           ,
input                                                 resetn_i        ,

input                                                 bac_csb_i       ,
input                                                 bac_wr_i        ,
input       [p_bac_reg_offset_address_width-1:0]      bac_address_i   ,
input       [31:0]                                    bac_write_data_i,
input       [3:0]                                     bac_byte_en_i   ,
output logic[31:0]                                    bac_read_data_o ,
output logic                                          bac_ready_o     ,
output logic[p_response_width-1:0]                    bac_response_o  ,
//TX FIFO interface register 
//FIFO entry
//RX FIFO interface register 
//FIFO entry 
//TODO Add the bac_data_in and bac_data_out signals.
input        [31:0]                 bac_data_in_i [p_num_of_bac_register-1:0],
output logic [31:0]                 bac_data_out_o[p_num_of_bac_register-1:0]
);
logic [3:0]  bac_byte_en_r                          ;
logic [31:0] mask_value_s                           ;
logic [31:0] mask_value_r                           ;
logic [31:0] bac_read_data_r                        ;
logic        csb_vld_wr_not_vld_s                   ;
logic        csb_vld_wr_vld_s                       ;
logic [31:0] register_banks_r[p_num_of_bac_register]; 
logic [31:0] invalid_access_value_s                 ;

assign invalid_access_value_s = 32'hdead_0bac;
assign csb_vld_wr_not_vld_s = (~bac_csb_i) && (~bac_wr_i);
assign csb_vld_wr_vld_s = (~bac_csb_i) && (bac_wr_i);
assign mask_value_s = {{8{bac_byte_en_i[3]}},{8{bac_byte_en_i[2]}},{8{bac_byte_en_i[1]}},{8{bac_byte_en_i[0]}}};
assign bac_ready_o=1;//always ready to read/write register/FIFO 
assign bac_response_o=0; //TODO?? tie to 0 , need to update later .. 

always_ff @(posedge clk_i or negedge resetn_i) begin
    if(!resetn_i) begin
        bac_byte_en_r <= 4'h0;
    end
    else if(csb_vld_wr_not_vld_s) begin
        bac_byte_en_r <= bac_byte_en_i;
    end
end
assign mask_value_r = {{8{bac_byte_en_r[3]}},{8{bac_byte_en_r[2]}},{8{bac_byte_en_r[1]}},{8{bac_byte_en_r[0]}}};

`include "main_scu_bac_register_include.sv"

always_ff @(posedge clk_i or negedge resetn_i) begin : REGISTER_READ_DATA
    if(!resetn_i) begin
        bac_read_data_r <= 32'h0;
    end
    else if(csb_vld_wr_not_vld_s) begin
        bac_read_data_r <= invalid_access_value_s;
        //RX FIFO readback data feedback
            for(int a=0;a<p_num_of_bac_register;a=a+1) begin
                if(main_scu_bac_reg_list_c[a].reg_address == bac_address_i) begin
                    if(main_scu_bac_reg_list_c[a].reg_access_mode == RW) begin
                        bac_read_data_r <= register_banks_r[a];
                    end
                    else if(main_scu_bac_reg_list_c[a].reg_access_mode == RO) begin
                        bac_read_data_r <= bac_data_in_i[a];
                    end
                end
            end
    end
end
assign bac_read_data_o = bac_read_data_r & mask_value_r;

//genvar y;   
//genvar i;
//generate
//    for(i=0;i<p_num_of_bac_register;i=i+1) begin : REGIATER_BANK
//        for(y=0;y<4;y=y+1) begin : REGISTER_BANKS_BYTE
//            always_ff @(posedge clk_i or negedge resetn_i) begin : reg_read_write_control_seq
//                if(!resetn_i) begin
//                    register_banks_r[i][y*8+:8] <= main_scu_bac_reg_list_c[i].reg_reset_value[y*8+:8];
//                end
//                else begin
//                    if(main_scu_bac_reg_list_c[i].reg_access_mode == RW) begin
//                        if(csb_vld_wr_vld_s && main_scu_bac_reg_list_c[i].reg_address == bac_address_i) begin
//                            if(bac_byte_en_i[y]) begin
//                                register_banks_r[i][y*8+:8] <= bac_write_data_i[y*8+:8] & main_scu_bac_reg_list_c[i].reg_mask_value[y*8+:8];
//                            end
//                        end
//                    end 
//                end
//            end
//        end
//    end
//endgenerate
logic [p_num_of_bac_register-1:0] bac_reg_select_enable_s;
genvar b;
generate
    for(b=0;b<p_num_of_bac_register;b=b+1) begin : BAC_REG_SELECT_ENABLE
        assign bac_reg_select_enable_s[b] = csb_vld_wr_vld_s & (main_scu_bac_reg_list_c[b].reg_address == bac_address_i) ? 1'b1 : 1'b0;
    end
endgenerate

genvar c;
generate
    for(c=0;c<p_num_of_bac_register;c=c+1) begin : REGIATER_BANK
        always_ff @(posedge clk_i or negedge resetn_i) begin
            if(!resetn_i) begin
                register_banks_r[c] <= main_scu_bac_reg_list_c[c].reg_reset_value;
            end
            else begin
                if(bac_reg_select_enable_s[c]) begin
                    for(int d=0;d<4;d=d+1) begin
                        if(bac_byte_en_i[d]) begin
                            register_banks_r[c][d*8+:8] <= bac_write_data_i[d*8+:8] & main_scu_bac_reg_list_c[c].reg_mask_value[d*8+:8];
                        end
                    end
                end
            end
        end
    end
endgenerate

genvar e;
generate
    for(e=0;e<p_num_of_bac_register;e=e+1) begin : REG_DATA_OUT
        assign bac_data_out_o[e] = (main_scu_bac_reg_list_c[e].reg_access_mode == WO) ? (bac_reg_select_enable_s[e] ? bac_write_data_i & mask_value_s : main_scu_bac_reg_list_c[e].reg_reset_value) : register_banks_r[e];
    end
endgenerate

//FIFO access handling 
//TX FIFO


//FIFO access handling 
// RX FIFO


//synopsys translate_off
logic [31:0] error_indication_r;
always_comb begin : ABNORMAL_INDICATION
    error_indication_r = 32'h0;
    for(int j=0;j<p_num_of_bac_register;j=j+1) begin
        if(bac_reg_select_enable_s[j]) begin
            error_indication_r = error_indication_r + 1'b1;
        end
    end
end

always_comb begin : ABNORMAL_CONDITION
    if(error_indication_r >= 2) begin
        $display("There is bac register block error occur !!!");
        $stop();
    end
end
//synopsys translate_on


endmodule 