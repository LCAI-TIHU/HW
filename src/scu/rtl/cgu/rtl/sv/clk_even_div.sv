
//-------------------------------------------------------------------
//       COPYRIGHT (C) 2020 INSPUR. ALL RIGHTS RESERVED 
//-------------------------------------------------------------------
// File name        :  clk_even_div.sv
//-------------------------------------------------------------------
// Function Notes   :
//        clock enve frequency division
//-------------------------------------------------------------------
// Release   History     :           
// Version   Date        Author         Description
// 0.1       2020/12/23  wangzhen 
//-------------------------------------------------------------------

 
module  clk_even_div #(
     parameter       DIV = 8 )
 (
   input          clk_i     ,
   input          rst_n_i   ,
   output  logic  clk_o  
  );
 
 logic               clk_r       ;   
 logic   [6:0]       cnt_r       ; 
 logic   [6:0]       div_param_s ;

 assign  clk_o        =  clk_r           ;
 assign  div_param_s  =  (DIV >> 1)-1'b1 ; 


   always_ff @(posedge clk_i,negedge rst_n_i)begin
      if(!rst_n_i)
        cnt_r  <=  7'd0    ;
      else if(cnt_r >= (DIV - 1'b1))
        cnt_r  <=  7'd0    ;
      else
        cnt_r  <=  cnt_r + 1'b1 ;
   end

   always_ff @(posedge clk_i,negedge rst_n_i)begin
      if(!rst_n_i)
        clk_r <= 1'b0  ;
      else if(cnt_r <= div_param_s)
        clk_r <= 1'b1  ;
      else 
        clk_r <= 1'b0  ;
   end


endmodule 
