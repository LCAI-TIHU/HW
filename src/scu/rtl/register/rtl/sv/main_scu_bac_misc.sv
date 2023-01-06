//-------------------------------------------------------------- 
//  main_scu_bac_misc.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_bac_misc.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!! 
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//-------------------------------------------------------------------
//  Function Notes : including clock gateing, reset sync , error record, etc. 
//-------------------------------------------------------------------
//  Release History :           
//  Version  Date        Author     Description
//  V0.1     2020-02-19  WangMingming     initial
//  V0.8     2020-12-31  liyang14         move the parameters of bac_register_block_tmp(chipid,moduleid,module_version and register_version) into the misc mosule.
//  V0.8     2020-12-31  liyang14         Add the relevant output ports of these parameters.
//-----------------------------------------------------------------


module main_scu_bac_misc
#(
parameter p_client_num                   =  32,
parameter p_bus_address_width            =  24,
parameter p_chipid_val                   =  32'h12345678,    //TODO 
parameter p_moduleid_val                 =  8'h55,
parameter p_module_versionid_val         =  8'hAA,
parameter p_register_if_version_val      =  16'h80,
parameter p_checksum_val                 =  32'h8211faf8
) 
(
input                           kernel_clk_i          ,
input                           resetn_i              ,
//DFT port 
input                           dft_scan_en_i         , //It will be used to control the clock gate cell
input                           jtag_rst_sync_bypass_i, //It will be used to control the Reset sync cell

//kernel clock enable control & status 
input[p_client_num-1:0]         reg_bank_clk_en_set_i , 
input[p_client_num-1:0]         reg_bank_clk_en_clr_i ,
output[p_client_num-1:0]        reg_bank_clk_en_sta_o ,
//regbank clock enable control & status 
input[p_client_num-1:0]         kernel_clk_en_set_i   ,
input[p_client_num-1:0]         kernel_clk_en_clr_i   ,
output[p_client_num-1:0]        kernel_clk_en_sta_o   ,

//TODO masked the monitor related signals and first error and last error related signals.
//Gated clock 
output                          gated_kernel_clk_o    ,
output                          gated_regbank_clk_o   ,

//TODO  Add some relevant output ports into the misc module and connect them with bac_register_block_tmp
output logic [31:0]             p_chipid_val_o             ,
output logic [31:0]             p_checksum_val_o           ,
output logic [15:0]             p_register_if_version_val_o,
output logic [7:0]              p_module_versionid_val_o   ,
output logic [7:0]              p_moduleid_val_o           ,

//reset sync                   
input                           hclk_i                ,
output                          synced_hclk_reset_o   ,
output                          synced_kernel_reset_o 
);

//TODO??
//DFT feature to added for clock/reset control 
//the error handle need to add 

reg[p_client_num-1:0]   reg_bank_clk_en_r    ;
reg[p_client_num-1:0]   kernel_clk_en_r      ;
wire                    synced_kernel_reset_s;

//for loop
//integer i ; 
always_ff@(posedge kernel_clk_i or negedge synced_kernel_reset_s) begin : clk_en_seq
  if(!synced_kernel_reset_s) begin
      reg_bank_clk_en_r  <= 'h1; 
      kernel_clk_en_r    <= 'h1; 
  end 
  else begin 
    for(int i=0;i<p_client_num;i=i+1) begin : client_num_loop_seq
        if(reg_bank_clk_en_set_i[i]) begin 
            reg_bank_clk_en_r[i]<= 1'b1;
        end 
        else if(reg_bank_clk_en_clr_i[i]) begin 
            reg_bank_clk_en_r[i]<= 1'b0;
        end 
        if(kernel_clk_en_set_i[i]) begin 
            kernel_clk_en_r[i]<= 1'b1;
        end 
        else if(kernel_clk_en_clr_i[i]) begin 
            kernel_clk_en_r[i]<= 1'b0;
        end 
    end 
  end 
end 

//reset synced to kernel clock domain 
stdcc_rstn_jtag rst_sync_to_kernel_clk_domain
(
.clk                  (kernel_clk_i          ) , 
.func_rstn            (resetn_i              ) ,  
.jtag_rst_sync_bypass (jtag_rst_sync_bypass_i) ,
.func_rstn_out        (synced_kernel_reset_s ) 
);

//reset synced to bus clock domain 
stdcc_rstn_jtag rst_sync_to_bus_clk_domain
(
.clk                  (hclk_i                ) , 
.func_rstn            (resetn_i              ) , 
.jtag_rst_sync_bypass (jtag_rst_sync_bypass_i) ,
.func_rstn_out        (synced_hclk_reset_o   )  
);

stdcc_clkicg   reg_bank_clk_cg_inst 
(
.clk    (kernel_clk_i       )    , 
.en     (|reg_bank_clk_en_r )    , 
.scan_en(dft_scan_en_i      )    ,
.gclk   (gated_regbank_clk_o)
);

stdcc_clkicg   kernel_clk_cg_inst 
(
.clk    (kernel_clk_i       )    , 
.en     (|kernel_clk_en_r   )    , 
.scan_en(dft_scan_en_i      )    ,
.gclk   (gated_kernel_clk_o )
);

//output assignment 
assign synced_kernel_reset_o = synced_kernel_reset_s;
assign reg_bank_clk_en_sta_o = reg_bank_clk_en_r    ;
assign kernel_clk_en_sta_o   = kernel_clk_en_r      ;
//assign first_error_status_o = 32'h0;
//assign last_error_status_o  = 32'h0;

//TODO assign
assign p_chipid_val_o              = p_chipid_val             ;
assign p_moduleid_val_o            = p_moduleid_val           ;
assign p_module_versionid_val_o    = p_module_versionid_val   ;
assign p_register_if_version_val_o = p_register_if_version_val;
assign p_checksum_val_o            = p_checksum_val           ;

endmodule 