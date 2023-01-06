//-------------------------------------------------------------------
//       COPYRIGHT (C) 2020 INSPUR. ALL RIGHTS RESERVED 
//-------------------------------------------------------------------
// File     Name    : module_name.sv
//-------------------------------------------------------------------
// Function Notes   :
//                    module notes.
//-------------------------------------------------------------------
// Release  History :
// Version  Date           Author        Description
// 0.1      2020-08-20     zhangqian     Initial
//-------------------------------------------------------------------

module main_boot_fsm 
#( parameter CPU_RST_DELAY_CNT = 8, 
   parameter PRE_RST_DELAY_CNT = 8
 )
 (
      input                           clk_i                         ,//scu kernel clock
      input                           rst_n_i                       ,//por_rstn_sync
    
      input                           sw_rst_req_i                  , //software reset request  from scu regsiter
      input                           wdt_rst_req_i                 , //wdt reset request  from wdt

      output logic                    main_pre_reset_release_o      , // pre_reset_release
      output logic                    main_all_reset_release_o        // all_reset_release

);

 
  enum    logic  [2:0]  {  POWER_ON_RESET          =3'h0 ,
                           PRE_RESET_RELEASE       =3'h1 ,
                           ALL_RESET_RELEASE       =3'h2 ,   
                           WORKING_STATE           =3'h3 ,   
                           WAIT_STATE              =3'h4    
                           } current_state,next_state ;

  logic                        combine_rst_req_s                ;
  logic    [4:0]               riscv_rst_release_cnt_r          ;
  logic    [4:0]               pre_rst_release_cnt_r            ;


//reset request combine
  assign               combine_rst_req_s  = wdt_rst_req_i | sw_rst_req_i ;

// boot fsm
  always_ff @(posedge clk_i,negedge rst_n_i)begin
      if(!rst_n_i)
        current_state <= POWER_ON_RESET     ;
      else
        current_state <= next_state         ;
  end      


  always_comb begin
      next_state    = current_state    ;
      case(current_state)

        POWER_ON_RESET              : begin
                                        if(pre_rst_release_cnt_r == PRE_RST_DELAY_CNT && combine_rst_req_s == 1'b0)
                                          next_state = PRE_RESET_RELEASE ;
                                        else
                                          next_state = POWER_ON_RESET    ; 
                                      end
               
        PRE_RESET_RELEASE           : begin 
                                        if(riscv_rst_release_cnt_r == CPU_RST_DELAY_CNT) 
                                          next_state = ALL_RESET_RELEASE ;
                                        else
                                          next_state = PRE_RESET_RELEASE ;
                                      end
  
        ALL_RESET_RELEASE            : begin
                                           next_state = WORKING_STATE    ;
                                      end

        WORKING_STATE                : begin
                                        if(combine_rst_req_s == 1'b1)
                                          next_state = WAIT_STATE    ;
                                        else
                                          next_state = WORKING_STATE ;
                                      end

        WAIT_STATE                   : begin 
                                        if(combine_rst_req_s == 1'b0)
                                          next_state = PRE_RESET_RELEASE ;
                                        else
                                          next_state = WAIT_STATE        ;
                                      end

        default       :    next_state    =  POWER_ON_RESET    ;
     endcase  
  end


//release signal generate
  always_ff @(posedge clk_i,negedge rst_n_i)begin
      if(!rst_n_i) begin
        main_pre_reset_release_o   <= 1'b0  ;   
        main_all_reset_release_o   <= 1'b0  ;
      end
      else begin
        case(current_state)
          POWER_ON_RESET       :
                                  begin
                                    main_pre_reset_release_o   <= 1'b0 ;   
                                    main_all_reset_release_o   <= 1'b0 ;
                                  end

          PRE_RESET_RELEASE    :
                                  begin
                                    main_pre_reset_release_o   <= 1'b1 ;   
                                  end
 
          ALL_RESET_RELEASE    :  begin  
                                    main_all_reset_release_o   <= 1'b1 ;
                                  end

          WORKING_STATE, WAIT_STATE  :
                                  begin
                                    if(combine_rst_req_s) begin
                                      main_all_reset_release_o  <= 1'b0 ;
                                      main_pre_reset_release_o  <= 1'b0 ;
                                    end
                                  end

         default :                begin      
                                    main_pre_reset_release_o   <= 1'b0 ;   
                                    main_all_reset_release_o   <= 1'b0 ;
                                  end
        endcase
       end
  end

//
  always_ff @(posedge clk_i,negedge rst_n_i)begin
      if(!rst_n_i) 
        pre_rst_release_cnt_r    <= 5'd0   ;
      else if(current_state == POWER_ON_RESET)
        pre_rst_release_cnt_r    <= pre_rst_release_cnt_r + 1'b1 ;
      else
        pre_rst_release_cnt_r    <= 5'd0   ;
  end

//riscv_rst_release_cnt_r  
  always_ff @(posedge clk_i,negedge rst_n_i)begin
      if(!rst_n_i) 
        riscv_rst_release_cnt_r    <= 5'd0   ;
      else if(current_state == PRE_RESET_RELEASE && main_pre_reset_release_o == 1'b1)
        riscv_rst_release_cnt_r    <= riscv_rst_release_cnt_r + 1'b1 ;
      else
        riscv_rst_release_cnt_r    <= 5'd0   ;
  end
  

 endmodule

