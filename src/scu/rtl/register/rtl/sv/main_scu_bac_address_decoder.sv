//-------------------------------------------------------------- 
//  main_scu_bac_address_decoder.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_bac_address_decoder.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!  
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//--------------------------------------------------------------
//  Release History          :           
//  Version  Date        Author     Description
//  V0.1     2020-02-17  WangMingming     initial
//  V0.8     2020-12-29  liyang14           Add else to always blocks to eliminate the warnings  (bus_ready & bus_read_data & bus_response)
//  V0.8     2020-12-30  liyang14           Add jinja2 {if-elif}} to the module
//--------------------------------------------------------------

//TODO?? 
//1. really need to gate addr/data/control signals to slaves?
//2. decoder part is hard code according to address definition, need to define a paramters?? 
//3. the ready signal need to extend to two ready, one is for request_cycle, one is for response_cyle.  
//   Currently, the ready now is stand for request_cycle. 
//   And it is assumed, the response will always true after request cycle!! 

module main_scu_bac_address_decoder
#(
parameter p_bus_address_width               = 24,
parameter p_response_width                  = 3 ,
parameter p_bac_reg_offset_address_width    = 10,
parameter p_kernel_reg_offset_address_width = 10 
)
(
//clock & reset 
input                                           clk_i         ,
input                                           resetn_i      ,
//Bus access interface                          
input                                           bus_csb_i       ,
input                                           bus_wr_i        ,
input[p_bus_address_width-1:0]                  bus_address_i   ,
input[31:0]                                     bus_write_data_i,
input[3:0]                                      bus_byte_en_i   ,
output reg [31:0]                               bus_read_data_o ,
output reg                                      bus_ready_o     ,
output reg [p_response_width-1:0]               bus_response_o  ,
//to BAC register 
output                                          bac_csb_o       ,
output                                          bac_wr_o        ,
output[p_bac_reg_offset_address_width-1:0]      bac_address_o   ,
output[31:0]                                    bac_write_data_o,
output[3:0]                                     bac_byte_en_o   ,
input [31:0]                                    bac_read_data_i ,
input                                           bac_ready_i     ,
input[p_response_width-1:0]                     bac_response_i  ,

//to register bank
output                                          reg_csb_o       ,
output                                          reg_wr_o        ,
output[p_kernel_reg_offset_address_width-1:0]   reg_address_o   ,
output[31:0]                                    reg_write_data_o,
output[3:0]                                     reg_byte_en_o   ,
input [31:0]                                    reg_read_data_i ,
input                                           reg_ready_i     ,
input [p_response_width-1:0]                    reg_response_i  
);

//TODO address distribution
//BAC  Reg      24'h00_0000 
//              24'h00_03FF
//TX   fifo     24'h00_0400
//              24'h00_07FC
//RX   fifo     24'h00_0800
//              24'h00_0BFC
//BAC  Reserved 24'h00_0C00
//              24'h00_0FFF
//Kernel Reg    24'h00_1000
//              24'h01_FFFF
//Memory IF     24'h02_0000
//              24'hFF_FFFF

logic bac_sel_s;
logic reg_sel_s;

logic bac_sel_r;
logic reg_sel_r;

//decoder 
always@(*)begin 
  bac_sel_s=1'b0;	
  reg_sel_s=1'b0;
  
    if(bus_address_i[23:0] < 24'h00_0040) begin
                                                                                       
        bac_sel_s= 1'b1; 
      end
    else if(bus_address_i[23:0] >= 24'h00_0040 && bus_address_i[23:0] < 24'hc10 + 24'h00_0040 + 24'h4 ) begin
                                                                                       //TODO   Extract the .csv max user offset address
        reg_sel_s= 1'b1;
      end
end 

always@(posedge clk_i or negedge resetn_i) 
begin 
if(!resetn_i) begin 
    bac_sel_r<=1'b0;
    reg_sel_r<=1'b0;
   
end 
else begin 
   if(!bus_csb_i && bus_ready_o) begin 
    bac_sel_r<=bac_sel_s;
	reg_sel_r<=reg_sel_s;
    
   end 
end 
end 


//BAC Reg 
assign bac_csb_o       =(bac_sel_s == 1)? bus_csb_i                                         : 1'b1                                   ;
assign bac_wr_o        =(bac_sel_s == 1)? bus_wr_i                                          : 1'b0                                   ;
assign bac_address_o   =(bac_sel_s == 1)? bus_address_i[p_bac_reg_offset_address_width-1:0] : {p_bac_reg_offset_address_width{1'b0} };
assign bac_write_data_o=(bac_sel_s == 1)? bus_write_data_i                                  : 32'h0                                  ;
assign bac_byte_en_o   =(bac_sel_s == 1)? bus_byte_en_i                                     : 4'h0                                   ;

//Kernel Reg 
////TODO?? need to make the kernel base address auto generated!!!
assign reg_csb_o       =(reg_sel_s == 1)? bus_csb_i                                       : 1'b1                                     ;
assign reg_wr_o        =(reg_sel_s == 1)? bus_wr_i                                        : 1'b0                                     ;
assign reg_address_o   =(reg_sel_s == 1)? bus_address_i[p_bus_address_width-8:0]-17'h0040 : {p_kernel_reg_offset_address_width{1'b0} };
 
assign reg_write_data_o=(reg_sel_s == 1)? bus_write_data_i                                : 32'h0                                     ;
assign reg_byte_en_o   =(reg_sel_s == 1)? bus_byte_en_i                                   : 4'h0                                      ;



always@(*)
begin 
   bus_read_data_o  = 'hdead_dead;                                                                                                
   bus_response_o   = 'h0;
if(bac_sel_r) begin
   bus_read_data_o  = bac_read_data_i ;
   bus_response_o   = bac_response_i  ; 
end 
else if(reg_sel_r) begin                                                                                                //TODO Add else to the always block
   bus_read_data_o  = reg_read_data_i ; 
   bus_response_o   = reg_response_i  ; 
end 

 

end 


always@(*)
begin 
   bus_ready_o      = 'h1;
if(bac_sel_s) begin
   bus_ready_o      = bac_ready_i     ;
end
else if(reg_sel_s) begin                                                                                                  //TODO Add else to the alwyas block
   bus_ready_o      = reg_ready_i     ; 
end 
end 

//TODO??
//
//need to verify the request_ready, response_ready behavior , 
//currently for BAC, kernel register, it is tied to "1"
//But in the future, when there is memory, it will need these two ready with
//correct backpressure on request and response 
endmodule 