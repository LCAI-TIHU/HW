//-------------------------------------------------------------------
//       COPYRIGHT (C) 2021 INSPUR. ALL RIGHTS RESERVED 
//-------------------------------------------------------------------
// File name        : scu_uts_counter.sv
//-------------------------------------------------------------------
// Function Notes   :
//          Universal uts stamp counter unit
//-------------------------------------------------------------------
// Release   History     :           
// Version   Date        Author         Description
// 0.1       2021/02/19  wangzhen 
//-------------------------------------------------------------------

module  scu_uts_counter
  (
      input                     clk_i                       ,
      input                     rst_n_i                     ,
     
      input                     uts_counter_clr_i           ,//uts counter clear, high level clear uts counter          
      input                     uts_counter_value_read_i    ,//uts counter read pulse signal,this signal need to be configured before software read 
      
      output  logic             uts_counter_load_pulse_o    ,//uts counter value load pulse,then uts counter by load to register 
      output  logic [63:0]      uts_counter_o                //uts counter value
  );

   logic               uts_counter_load_pulse_r   ;
   logic [63:0]        uts_counter_value_load_r   ;
   logic [63:0]        uts_counter_r              ;

   assign uts_counter_load_pulse_o = uts_counter_load_pulse_r ;
   assign uts_counter_o            = uts_counter_value_load_r ;

//generation uts counter load pulse
  always_ff @(posedge clk_i,negedge rst_n_i)begin
    if(!rst_n_i)
      uts_counter_load_pulse_r <= 1'b0  ;
    else 
      uts_counter_load_pulse_r <= uts_counter_value_read_i; 
  end


//load uts counter value
  always_ff @(posedge clk_i,negedge rst_n_i)begin
    if(!rst_n_i)
      uts_counter_value_load_r  <= 64'd0           ;
    else if(uts_counter_value_read_i)
      uts_counter_value_load_r  <= uts_counter_r   ;
  end

//uts counter 
  always_ff @(posedge clk_i,negedge rst_n_i)begin
    if(!rst_n_i)
      uts_counter_r <= 64'd0                  ;
    else if(uts_counter_clr_i)
      uts_counter_r <= 64'd0                  ;
    else
      uts_counter_r <= uts_counter_r + 1'b1   ;
  end


endmodule
