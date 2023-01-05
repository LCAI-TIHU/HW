//-------------------------------------------------------------- 
//  main_scu_register_bank.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_register_bank.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!                                                      
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//--------------------------------------------------------------
//  Function Notes : User Defination control part registers
//-------------------------------------------------------------- 
//  Release History:
//  Version Time         Author     Description
//  V0.8    2020-12-30   liyang14   Delete the address decoder logic
//  V0.8    2020-12-30   liyang14   Use generate replace the for circulation
//  V0.8    2021-01-04   liyang14   Add byte en logic into this module
//  V0.8    2021-01-07   liyang14   reg_data_out_sw_strb signal from p_num_of_register bits to 1 bit 
//  V0.8    2021-03-02   liyang14   Modify the reg_data_out_o logic (assign)
//  V0.8    2021-03-09   liyang14   Add pipeline in the reg_data_in and reg_data_out
//-------------------------------------------------------------- 

//2. to generate the correct response 
//3. to clean the signals has no driver/no load 
//4. Does software write is necessary for RWH 
//5. can only use one integer i defintion for multiple for-loop? 
module main_scu_register_bank
#(
//These paramter need to set from its upper level with my_regsiter_bank_example is instanced. 
parameter p_num_of_register                 =23  ,
parameter p_kernel_reg_offset_address_width =12 , 
parameter p_reg_response_width              =3 
)
(
input clk_i,
input rst_n_i,

//Register access interface 
input                                                  reg_csb_i       ,
input                                                  reg_wr_i        ,
input        [p_kernel_reg_offset_address_width-1:0]   reg_address_i   ,
input        [31:0]                                    reg_write_data_i,
input        [3:0]                                     reg_byte_en_i   ,
output logic [31:0]                                    reg_read_data_o ,
output logic                                           reg_ready_o     ,
output logic [p_reg_response_width-1:0]                reg_response_o  ,

//from kernel 
input[31:0]                                            reg_data_in_i [p_num_of_register-1:0],
input                                                  reg_data_in_hw_strb_i[p_num_of_register-1:0],
//to kernel
output logic [31:0]                                    reg_data_out_o[p_num_of_register-1:0],
output logic                                           reg_data_out_sw_strb_o [p_num_of_register-1:0]
);

logic[31:0]                                            reg_data_out_s[p_num_of_register-1:0];
logic                                                  reg_data_out_sw_strb_r [p_num_of_register-1:0];

`include "main_scu_register_include.sv"

logic [31:0] mask_value_s                       ;
logic [31:0] mask_value_r                       ;
logic [3:0]  reg_byte_en_r                      ;
logic        csb_vld_wr_not_vld_s               ;
logic        csb_vld_wr_vld_s                   ;
logic [31:0] reg_read_data_r                    ;
logic [31:0] register_banks_r[p_num_of_register];
logic [31:0] invalid_access_value_s             ;

assign reg_ready_o=1;
assign reg_response_o=0;
assign invalid_access_value_s = 32'hdead_beef;

assign mask_value_s = {{8{reg_byte_en_i[3]}},{8{reg_byte_en_i[2]}},{8{reg_byte_en_i[1]}},{8{reg_byte_en_i[0]}}};

assign csb_vld_wr_not_vld_s = (~reg_csb_i) & (~reg_wr_i);
assign csb_vld_wr_vld_s = (~reg_csb_i) & (reg_wr_i);

//------------------------------------------------------------------------------------------------------------------------- 
//Insert pipeline for mask_value_r
//------------------------------------------------------------------------------------------------------------------------- 
always_ff @(posedge clk_i or negedge rst_n_i) begin
    if(!rst_n_i) begin
        reg_byte_en_r <= 4'h0;
    end
    else if(csb_vld_wr_not_vld_s) begin
        reg_byte_en_r <= reg_byte_en_i;
    end
end
assign mask_value_r = {{8{reg_byte_en_r[3]}},{8{reg_byte_en_r[2]}},{8{reg_byte_en_r[1]}},{8{reg_byte_en_r[0]}}};

logic [p_num_of_register-1:0] reg_select_enable_s;
genvar a;
generate
    for(a=0;a<p_num_of_register;a=a+1) begin : REG_SELECT_ENABLE
        assign reg_select_enable_s[a] = csb_vld_wr_vld_s & (main_scu_reg_list_c[a].reg_address == reg_address_i) ? 1'b1 : 1'b0;
    end
endgenerate
//------------------------------------------------------------------------------------------------------------------------- 
//RO Type
//------------------------------------------------------------------------------------------------------------------------- 
always_ff @(posedge clk_i or negedge rst_n_i) begin
    if(!rst_n_i) begin
        reg_read_data_r <= 32'h0;
    end
    else if(csb_vld_wr_not_vld_s) begin
        reg_read_data_r <= invalid_access_value_s;
        for(int d=0;d<p_num_of_register;d=d+1) begin
            if(main_scu_reg_list_c[d].reg_address == reg_address_i) begin
                if(main_scu_reg_list_c[d].reg_access_mode == RO) begin
                    reg_read_data_r <= reg_data_in_i[d];
                end
                else if(main_scu_reg_list_c[d].reg_access_mode != WO) begin
                    reg_read_data_r <= register_banks_r[d];
                end
            end
        end
    end
end
assign reg_read_data_o = reg_read_data_r & mask_value_r;
//-------------------------------------------------------------------------------------------------------------------------
//reg_data_out_sw_strb_o & reg_data_out_sw_strb_r
//------------------------------------------------------------------------------------------------------------------------- 
genvar e;
generate
    for(e=0;e<p_num_of_register;e=e+1) begin : REG_DATA_OUT_SW
        always_ff @(posedge clk_i or negedge rst_n_i) begin
            if(!rst_n_i) begin
                reg_data_out_sw_strb_r[e] <= 1'b0;
            end
            else begin
                if(reg_select_enable_s[e]) begin
                    if(main_scu_reg_list_c[e].reg_access_mode == RWS || main_scu_reg_list_c[e].reg_access_mode == RWHS) begin
                        reg_data_out_sw_strb_r[e] <= 1'b1;
                    end
                    else begin
                        reg_data_out_sw_strb_r[e] <= 1'b0;
                    end
                end
                else begin
                    reg_data_out_sw_strb_r[e] <= 1'b0;
                end
            end
        end
        assign reg_data_out_sw_strb_o[e] = reg_data_out_sw_strb_r[e];
    end
endgenerate


//register write,read,writeonly control process
//genvar i; 
//genvar x;
//generate
//    for(i=0;i<p_num_of_register;i=i+1) begin : REG_BANKS_PROC
//        for(x=0;x<4;x=x+1) begin : REG_BANKS_BYTE
//            always_ff @(posedge clk_i or negedge rst_n_i) begin
//                if(!rst_n_i) begin
//                    register_banks_r[i][x*8+:8] <= main_scu_reg_list_c[i].reg_reset_value[x*8+:8];
//                end
//                else begin
//                    if(reg_data_in_hw_strb_i[i]) begin
//                        register_banks_r[i][x*8+:8] <= reg_data_in_i[i][x*8+:8];
//                    end 
//                    else if(csb_vld_wr_vld_s && main_scu_reg_list_c[i].reg_address == reg_address_i && reg_byte_en_i[x]) begin 
//                        register_banks_r[i][x*8+:8] <= reg_write_data_i[x*8+:8] & main_scu_reg_list_c[i].reg_mask_value[x*8+:8];
//                    end 
//                end
//            end
//        end
//    end
//endgenerate
genvar f; 
generate
    for(f=0;f<p_num_of_register;f=f+1) begin : REG_BANKS_PROC
        always_ff @(posedge clk_i or negedge rst_n_i) begin
            if(!rst_n_i) begin
                register_banks_r[f] <= main_scu_reg_list_c[f].reg_reset_value;
            end
            else begin
                if(main_scu_reg_list_c[f].reg_access_mode == RWH || main_scu_reg_list_c[f].reg_access_mode == RWHS) begin     //software write has 1st priority
                    if(reg_select_enable_s[f]) begin
                        for(int g=0;g<4;g=g+1) begin
                            if(reg_byte_en_i[g]) begin
                                register_banks_r[f][g*8+:8] <= reg_write_data_i[g*8+:8] & main_scu_reg_list_c[f].reg_mask_value[g*8+:8];
                            end
                        end
                    end
                    else if(reg_data_in_hw_strb_i[f]) begin
                        register_banks_r[f] <= reg_data_in_i[f];
                    end
                end
                else begin
                    if(reg_select_enable_s[f]) begin
                        for(int g=0;g<4;g=g+1) begin
                            if(reg_byte_en_i[g]) begin
                                register_banks_r[f][g*8+:8] <= reg_write_data_i[g*8+:8] & main_scu_reg_list_c[f].reg_mask_value[g*8+:8];
                            end
                        end
                    end
                end
            end
        end
    end
endgenerate

genvar h;
generate
    for(h=0;h<p_num_of_register;h=h+1) begin : REG_DATA_OUT
        assign reg_data_out_s[h] = main_scu_reg_list_c[h].reg_access_mode == WO ? (reg_select_enable_s[h] ? (reg_write_data_i & mask_value_s) : main_scu_reg_list_c[h].reg_reset_value) : register_banks_r[h];
        assign reg_data_out_o[h] = reg_data_out_s[h];
    end
endgenerate


//synopsys translate_off
logic [31:0] error_indication_r;

//always_ff @(posedge clk_i or negedge rst_n_i) begin
//    error_indication_r = 32'h0;
//    for(int k=0;j<p_num_of_register;j=j+1) begin
//        if(reg_select_enable_s[j]) begin
//            error_indication_r <= error_indication_r + 1'b1;
//        end
//    end
//end

always_comb begin : ABNORMAL_INDICATION
    error_indication_r = 32'h0;
    for(int j=0;j<p_num_of_register;j=j+1) begin
        if(reg_select_enable_s[j]) begin
            error_indication_r = error_indication_r + 1'b1;
        end
    end
end

always_comb begin : ABNORMAL_CONDITION
    if(error_indication_r >= 2) begin
        $display("There is register bank error occurs !!!");
        $stop();
    end
end
//synopsys translate_on

endmodule
 