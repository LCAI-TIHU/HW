//-------------------------------------------------------------- 
//  main_scu_bac_common_interrupt_handle.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_bac_common_interrupt_handle.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!     
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//-------------------------------------------------------------------
//  Release History :           
//  Version  Date        Author           Description
//  V0.1     2020-02-17  WangMingming     initial
//  V0.8     2020-01-05  liyang14         Modify the names about interrupt names
//  V0.8     2021-05-15  liyang14         Avoid interrupt output glitch and modify the interrupt to reg output 
//-----------------------------------------------------------------
//TODO at any time, only has one master access the tx fifo or rx fifo, so has a common enable.
//TODO for int0, int1 and error_int, maybe has some masters all access these interrupts.

module main_scu_bac_common_interrupt_handle
#(
parameter p_func_int0_num         =32,
parameter p_func_int1_num         =32,
parameter p_error_int_num         =32,
parameter p_tx_fifo_common_int_num=32,
parameter p_rx_fifo_common_int_num=32

)
(
//func0 int 
input [p_func_int0_num-1:0] func_int0_enable_set_i        ,// interrupt enable set 
input [p_func_int0_num-1:0] func_int0_enable_clr_i        ,// interrupt enable clear 
input [p_func_int0_num-1:0] func_int0_hw_set_i            ,// hardware interrupt set 
input [p_func_int0_num-1:0] func_int0_sw_set_i            ,// software interrupt set  
input [p_func_int0_num-1:0] func_int0_sw_clr_i            ,// software interrupt clear 
output[p_func_int0_num-1:0] func_int0_enable_status_o     ,// enable status    
output[p_func_int0_num-1:0] func_int0_enabled_int_status_o, 
output[p_func_int0_num-1:0] func_int0_int_status_o        , 
output reg                  func_int0_interrupt_o         ,

//rx fifo int 
input clk_i,
input resetn_i
);

//integer i ;
//Func_int0 part , Begin.. 
reg [p_func_int0_num-1:0] func_int0_enable_r;
reg [p_func_int0_num-1:0] func_int0_status_r;

//enable status register 
always@(posedge clk_i or negedge resetn_i)
begin 
   if(!resetn_i) begin 
     func_int0_enable_r<= 'h0;
   end 
   else begin 
      for(int i=0;i<p_func_int0_num;i=i+1) begin 
	    if(func_int0_enable_set_i[i]) begin 
		    func_int0_enable_r[i] <= 1'b1;
		end 
		else if (func_int0_enable_clr_i[i]) begin 
		   func_int0_enable_r[i] <=1'b0; 
		end 
	  end 
   end 
end 

//unenabled interrupt status 
//the status set/clear priority 
//hw_set>sw_set>sw_clr
always@(posedge clk_i or negedge resetn_i)
begin 
  if(!resetn_i) begin 
    func_int0_status_r<='h0;
  end 
  else begin 
    for(int i=0;i<p_func_int0_num;i=i+1) begin 
	   if(func_int0_hw_set_i[i]) begin 
	     func_int0_status_r[i]<=1'b1;
	   end 
	   else if (func_int0_sw_set_i[i]) begin 
	     func_int0_status_r[i]<=1'b1;
	   end 
	   else if(func_int0_sw_clr_i[i]) begin 
	     func_int0_status_r[i]<=1'b0;
	   end 
	end 
  end 
end 
assign func_int0_enable_status_o      = func_int0_enable_r;
assign func_int0_int_status_o         = func_int0_status_r;
assign func_int0_enabled_int_status_o = func_int0_status_r & func_int0_enable_r;

always_ff @(posedge clk_i or negedge resetn_i) begin
    if(!resetn_i) begin
        func_int0_interrupt_o <= 1'b0;
    end
    else begin
        func_int0_interrupt_o <= (|func_int0_enabled_int_status_o);
    end
end
//Func_int0 part , End.. 




endmodule 