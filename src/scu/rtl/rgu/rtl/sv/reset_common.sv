//-------------------------------------------------------------------
//       COPYRIGHT (C) 2020 INSPUR. ALL RIGHTS RESERVED 
//-------------------------------------------------------------------
// File name        :  reset_common_cell.sv
//-------------------------------------------------------------------
// Function Notes   :
//    reset common logic based on reset matrix
//-------------------------------------------------------------------
// Release History   :           
// Version  Date        Author     Description
// 0.1      2020-12-23  Zhuxinping initial 
//-------------------------------------------------------------------

module reset_common 
  #(parameter int mod_rst_delay_g  = 1,
              int perst_delay_g    = 1,
              int hot_rst_delay_g  = 1,
              int ld_rst_delay_g   = 1,
              int rst_value_g      = 0,
              int rst_active_low_g = 1,
              int rst_out_synced_g = 0)
  
//--------------------------------------------------------------------------
//all input signal should sync to rcu_clk_i domain 
//--------------------------------------------------------------------------
  (input  rcu_clk_i,              //reset common logic clock
   input  sy_rst_rcu_n_i,         //RCU reset
   input  pad_rst_n_i,            //reset from PAD control
   input  wdt_rst_req_i,          //Watchdog reset request
   input  wdt_rst_cnf_i,          //Watchdog reset cnfext_reset_n_i
   input  sw_rst_req_i,           //SW reset req input, '0' if no use
   input  sw_rst_cnf_i,           //SW reset config
   input  cpu_rst_req_i,
   input  cpu_rst_cnf_i,
   input  i2c2ahbm_rst_req_i,
   input  i2c2ahbm_rst_cnf_i,
   input  perst_req_i,
   input  perst_cnf_i,
   input  hot_rst_req_i,
   input  hot_rst_cnf_i,
   input  linkdown_rst_req_i,
   input  linkdown_rst_cnf_i,
   input  pd_rst_cnf_i,
   input  pre_rst_cnf_i,          //rst relase control signal
   input  pd_rst_req_i,           //power down reset request
   input  mod_rst_req_i,          //module reset request
   input  mod_rst_mask_i,         //mask module reset
   input  append_rst_req_i,       //append reset requeset
   input  pre_rst_release_i,      //pre reset release control
   input  all_rst_release_i,      //all reset release control
   input  clk_sync_i,             //reset output synced clock 
   input  rst_sel_i,              //reset output select signal
   input  alt_rst_i,              //append clock select signal
   input  jtag_res_external_i,    //JTAG reset control
   input  clear_resctrl_bits_i,
   input  load_resctrl_bits_i,
   input  rc_rst_sft_n_i,
 //  input  test_rst_req_i,
   output rst_n_o);

  
//------------------------------------------------------------------------------
// Signal declarations
//------------------------------------------------------------------------------
  logic pad_rst_n_s;
  logic [mod_rst_delay_g:0] mods_delay_s;
  logic mod_res_req_edge_s;
  logic clear_mod_res_s;
  logic [perst_delay_g:0] perst_delay_s;
  logic perst_req_edge_s;
  logic clear_perst_s;
  logic [hot_rst_delay_g:0] hot_rst_delay_s;
  logic hot_rst_req_edge_s;
  logic clear_hot_rst_s;
  logic [ld_rst_delay_g:0] ld_rst_delay_s;
  logic ld_rst_req_edge_s;
  logic clear_ld_rst_s;

  logic combine_rst_req_s;
  logic rst_pre_n_s;
  logic rst_shadow_n_s;
  logic rst_pre_rls_n_s;
  
  logic rst_d1_n_s;
  logic rst_d2_n_s;
  logic rst_d3_n_s;
  logic rst_sync_n_s;
  logic rst_n_tmp_s;
  logic rst_n_and_s;

//PAD reset assign to internal siganl
assign pad_rst_n_s = pad_rst_n_i;
//------------------------------------------------------------------------------
//SEQUENTIAL PROCESS
//FUNCTION:
//    generation of module reset request & module reset clear siganl
//DESCRIPTION:
//    based on the value of mod_rst_delay_g HW logic generates
//    request and clear signal pulses for the module reset
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//CONDITION: mod_rst_delay_g >0
//delay mods register bits to detect edge
//------------------------------------------------------------------------------
generate if (mod_rst_delay_g > 0) begin: pulse_detect
  always_ff @(posedge rcu_clk_i, negedge rc_rst_sft_n_i)
    begin : p_mod_rst_req
      if  (rc_rst_sft_n_i == 1'b0)
        begin 
           mods_delay_s     <= {(mod_rst_delay_g + 1){1'b0}};
        end
      else
        begin
          //mods_delay_s    <= mods_delay_s << 1;
          //mods_delay_s[0] <= mod_rst_req_i;
          mods_delay_s    <= {mods_delay_s[mod_rst_delay_g-1:0],mod_rst_req_i};
        end 
    end 
  end 
//rising edge detect is detected at the begining of the shift register
assign mod_res_req_edge_s = (mod_rst_req_i == 1'b1 && mods_delay_s[0] == 1'b0) ? 1'b1 : 1'b0;
//faling edge detect is detected at the output of the shift register
assign clear_mod_res_s = (mods_delay_s[mod_rst_delay_g-1] == 1'b0 && mods_delay_s[mod_rst_delay_g] == 1'b1) ? 1'b1 : 1'b0;
endgenerate

//------------------------------------------------------------------------------
//CONDITION: mod_rst_delay_g == 0_
//if the generic is 0, there will not be rising and falling edge pulse!
//------------------------------------------------------------------------------
generate if (mod_rst_delay_g == 0) begin: no_pulse_detect
  assign mods_delay_s[0]    = 1'b0;
  assign mod_res_req_edge_s = 1'b0;
  assign clear_mod_res_s    = 1'b0;
end 
endgenerate

//------------------------------------------------------------------------------
//generate of the module reset request siganl based on the rising edge
//and the mask bit value for CTRL register for this module reset source
//------------------------------------------------------------------------------

//assign mod_res_req_s = mod_res_req_edge_s & (!mod_rst_mask_i);
assign mod_res_req_s = mod_rst_req_i & (!mod_rst_mask_i);

generate if (perst_delay_g> 0) begin: pulse_detect_2
  always_ff @(posedge rcu_clk_i, negedge rc_rst_sft_n_i)
    begin : perst_req
      if  (rc_rst_sft_n_i == 1'b0)
        begin 
           perst_delay_s     <= {(perst_delay_g+ 1){1'b0}};
        end
      else
        begin
//          perst_delay_s<= perst_delay_s<< 1;
//          perst_delay_s[0] <= perst_req_i;
            perst_delay_s <= {perst_delay_s[perst_delay_g-1:0],perst_req_i};
        end 
    end 
  end 
//rising edge detect is detected at the begining of the shift register
assign perst_req_edge_s= (perst_req_i== 1'b1 && perst_delay_s[0] == 1'b0) ? 1'b1 : 1'b0;
//faling edge detect is detected at the output of the shift register
assign clear_perst_s= (perst_delay_s[perst_delay_g-1] == 1'b0 && perst_delay_s[perst_delay_g] == 1'b1) ? 1'b1 : 1'b0;
endgenerate

//------------------------------------------------------------------------------
//CONDITION: perst_delay_g= 0_
//if the generic is 0, there will not be rising and falling edge pulse!
//------------------------------------------------------------------------------
generate if (perst_delay_g== 0) begin: no_pulse_detect_2
  assign perst_delay_s[0]    = 1'b0;
  assign perst_req_edge_s= 1'b0;
  assign clear_perst_s= 1'b0;
end 
endgenerate


//assign perst_req_s= perst_req_edge_s&perst_cnf_i ;
assign perst_req_s = perst_req_i& perst_cnf_i;


generate if (hot_rst_delay_g> 0) begin: pulse_detect_3
  always_ff @(posedge rcu_clk_i, negedge rc_rst_sft_n_i)
    begin : hot_rst_req
      if  (rc_rst_sft_n_i == 1'b0)
        begin 
           hot_rst_delay_s<= {(hot_rst_delay_g+ 1){1'b0}};
        end
      else
        begin
//          hot_rst_delay_s<= hot_rst_delay_s<< 1;
//          hot_rst_delay_s[0] <= hot_rst_req_i;
            hot_rst_delay_s <= {hot_rst_delay_s[hot_rst_delay_g-1:0],hot_rst_req_i};
        end 
    end 
  end 
//rising edge detect is detected at the begining of the shift register
assign hot_rst_req_edge_s= (hot_rst_req_i== 1'b1 && hot_rst_delay_s[0] == 1'b0) ? 1'b1 : 1'b0;
//faling edge detect is detected at the output of the shift register
assign clear_hot_rst_s= (hot_rst_delay_s[hot_rst_delay_g-1] == 1'b0 && hot_rst_delay_s[hot_rst_delay_g] == 1'b1) ? 1'b1 : 1'b0;
endgenerate

//------------------------------------------------------------------------------
//CONDITION: hot_rst_delay_g = 0
//if the generic is 0, there will not be rising and falling edge pulse!
//------------------------------------------------------------------------------
generate if (hot_rst_delay_g== 0) begin: no_pulse_detect_3
  assign hot_rst_delay_s[0]    = 1'b0;
  assign hot_rst_req_edge_s= 1'b0;
  assign clear_hot_rst_s= 1'b0;
end 
endgenerate


//assign hot_rst_req_s= hot_rst_req_edge_s& hot_rst_cnf_i;
assign hot_rst_req_s = hot_rst_req_i& hot_rst_cnf_i;


generate if (ld_rst_delay_g> 0) begin: pulse_detect_4
  always_ff @(posedge rcu_clk_i, negedge rc_rst_sft_n_i)
    begin : ld_rst_req
      if  (rc_rst_sft_n_i == 1'b0)
        begin 
           ld_rst_delay_s<= {(ld_rst_delay_g+ 1){1'b0}};
        end
      else
        begin
//          ld_rst_delay_s<= ld_rst_delay_s<< 1;
//          ld_rst_delay_s[0] <= linkdown_rst_req_i;
            ld_rst_delay_s <= {ld_rst_delay_s[ld_rst_delay_g-1:0],linkdown_rst_req_i};
        end 
    end 
  end 
//rising edge detect is detected at the begining of the shift register
assign ld_rst_req_edge_s= (linkdown_rst_req_i== 1'b1 && ld_rst_delay_s[0] == 1'b0) ? 1'b1 : 1'b0;
//faling edge detect is detected at the output of the shift register
assign clear_ld_rst_s= (ld_rst_delay_s[ld_rst_delay_g-1] == 1'b0 && ld_rst_delay_s[ld_rst_delay_g] == 1'b1) ? 1'b1 : 1'b0;
endgenerate

//------------------------------------------------------------------------------
//CONDITION: ld_rst_delay_g = 0
//if the generic is 0, there will not be rising and falling edge pulse!
//------------------------------------------------------------------------------
generate if (ld_rst_delay_g== 0) begin: no_pulse_detect_4
  assign ld_rst_delay_s[0]    = 1'b0;
  assign ld_rst_req_edge_s= 1'b0;
  assign clear_ld_rst_s= 1'b0;
end 
endgenerate


//assign ld_res_req_s= ld_rst_req_edge_s&linkdown_rst_cnf_i;
assign ld_res_req_s = linkdown_rst_req_i&linkdown_rst_cnf_i ;


//------------------------------------------------------------------------------
//SEQUENTIAL PROCESS
//FUNCTION:
//    generation of combine reset signal
//DESCRIPTION:
//    combined reset signal is generated based on:
//            -- watchdog reset and its mask
//            -- software reset and its mask
//            -- cpu      reset and its mask
//------------------------------------------------------------------------------

assign combine_rst_req_s = (wdt_rst_req_i & wdt_rst_cnf_i) | (sw_rst_req_i  & sw_rst_cnf_i) | ( cpu_rst_req_i & cpu_rst_cnf_i ) | (i2c2ahbm_rst_req_i & i2c2ahbm_rst_cnf_i);

//------------------------------------------------------------------------------
//SEQUENTIAL PROCESS
//FUNCTION:
//    generation of rst_n_s signal
//DESCRIPTION:
//    generation of the reset source based on the different inputs
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//process for  rst_pre_n_s signals
//------------------------------------------------------------------------------


always @ (posedge rcu_clk_i, negedge sy_rst_rcu_n_i)
    begin : p_rst_gen
      if  (sy_rst_rcu_n_i == 1'b0)
        begin 
           rst_pre_n_s       <= rst_value_g;
           rst_shadow_n_s    <= rst_value_g;
        end
      else
        begin
          if (pre_rst_release_i || all_rst_release_i || clear_mod_res_s || clear_perst_s || clear_hot_rst_s  || clear_ld_rst_s )
            begin
              rst_shadow_n_s <= 1'b1;
            end
          else if ((load_resctrl_bits_i  && combine_rst_req_s ) || mod_res_req_s || perst_req_s || hot_rst_req_s || ld_res_req_s)
            begin
              rst_shadow_n_s <= 1'b0;
            end
          
          if (pd_rst_req_i & pd_rst_cnf_i )
            begin
              rst_pre_n_s <= 1'b0;
            end
          else if (clear_mod_res_s || clear_perst_s  || clear_hot_rst_s || clear_ld_rst_s  )
            begin
              rst_pre_n_s <= 1'b1;
            end
          else if ((load_resctrl_bits_i  && combine_rst_req_s ) || mod_res_req_s  || perst_req_s || hot_rst_req_s || ld_res_req_s)
            begin
              rst_pre_n_s <= 1'b0;
            end
          else
            begin
              rst_pre_n_s <= rst_shadow_n_s;
            end
        end
    end 
//------------------------------------------------------------------------------
//SEQUENTIAL PROCESS
//FUNCTION:
//    release control
//DESCRIPTION:
//    generation of the reset release control sequence
//------------------------------------------------------------------------------
always @ (posedge rcu_clk_i, negedge sy_rst_rcu_n_i)
  begin : p_rst_release
      if (sy_rst_rcu_n_i == 1'b0)
        begin 
           rst_pre_rls_n_s <= rst_value_g;
        end
      else
        begin
          if (rst_pre_n_s == 1'b0 ) 
            begin
              rst_pre_rls_n_s    <= 1'b0;
            end 
          else if (pre_rst_cnf_i == 1'b1 && pre_rst_release_i == 1'b1  && all_rst_release_i == 1'b0)
            begin
              rst_pre_rls_n_s    <= 1'b1;
            end
          else if (all_rst_release_i == 1'b1)
            begin
              rst_pre_rls_n_s    <= 1'b1;
            end 
        end 
  end
//------------------------------------------------------------------------------
//rst_n_s generation depends on jtag_res_external_i
//jtag_res_external_i == 0  -> rst_pre_rls_n_s
//jtag_res_external_i == 1  -> pad_rst_n_s
//------------------------------------------------------------------------------
//assign rst_n_s = jtag_res_external_i == 1'b0 ? rst_pre_rls_n_s : pad_rst_n_s;

stdcc_mux u_dft_mux_rstn(
     .a                    (rst_pre_rls_n_s          ),
     .b                    (pad_rst_n_s              ),
     .sel                  (jtag_res_external_i      ),
     .z                    (rst_n_s                  )
   );

//------------------------------------------------------------------------------
//SEQUENTIAL PROCESS
//FUNCTION:
//    synchronization of the reset output 
//DESCRIPTION:
//    depending on the targeted clock domain, generated reset needs to be
//    synchroized to clk_sync_i
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//rst_out_synced_g = 0
//reset_source is rst_n_s (internal reset)
//append_rst_req used to generate a async reset from other request
//rst_sel_i selects the source of the reset generation
// 0: internal reset + append reset
// 1: alternative reset source
//------------------------------------------------------------------------------
generate if (rst_out_synced_g == 0) begin: rst_async_gen
//  assign rst_n_tmp_s = rst_sel_i == 1'b0 ? (rst_n_s && ~append_rst_req_i) : alt_rst_i;
  assign rst_n_and_s = rst_n_s && ~append_rst_req_i  ;
  stdcc_mux u_mux_rstn_stage0(
       .a                    (rst_n_and_s              ),
       .b                    (alt_rst_i                ),
       .sel                  (rst_sel_i                ),
       .z                    (rst_n_tmp_s              )
     );
end 
endgenerate

//------------------------------------------------------------------------------
//rst_out_synced_g = 1
//reset_source is pad_rst_n_s its release edge is synced to clk_sync_i
//rst_sel_i selects output reset between pad_rst_n_s or its synced version
//------------------------------------------------------------------------------
generate if (rst_out_synced_g == 1) begin: rst_sync_outer_3stage_gen
  always @ (posedge clk_sync_i, negedge pad_rst_n_s)
    begin
      if (pad_rst_n_s == 1'b0)
        begin
          rst_d1_n_s   <= 1'b0;
          rst_d2_n_s   <= 1'b0;
          rst_sync_n_s <= 1'b0;
        end
      else 
        begin
          rst_d1_n_s   <= 1'b1;
          rst_d2_n_s   <= rst_d1_n_s;
          rst_sync_n_s <= rst_d2_n_s;
        end 
    end 
//  assign rst_n_tmp_s = rst_sel_i == 1'b0 ? rst_sync_n_s : pad_rst_n_s;

  stdcc_mux u_mux_rstn_stage1(
       .a                    (rst_sync_n_s             ),
       .b                    (pad_rst_n_s              ),
       .sel                  (rst_sel_i                ),
       .z                    (rst_n_tmp_s              )
     );
 end 
endgenerate 

//------------------------------------------------------------------------------
//rst_out_synced_g = 3
//reset_source is rst_n_s (internal reset), its release edge is synced to
//clk_sync_i clock
//rst_sel_i selects the output between rst_n_s or its synced version
//------------------------------------------------------------------------------
generate if (rst_out_synced_g == 3) begin: rst_sync_inner_3stage_gen
  always @ (posedge clk_sync_i, negedge rst_n_s)
    begin
      if (rst_n_s == 1'b0)
        begin
          rst_d1_n_s   <= 1'b0;
          rst_d2_n_s   <= 1'b0;
          rst_sync_n_s <= 1'b0;
        end
      else 
        begin
          rst_d1_n_s   <= 1'b1;
          rst_d2_n_s   <= rst_d1_n_s;
          rst_sync_n_s <= rst_d2_n_s;
        end 
    end 
//  assign rst_n_tmp_s = rst_sel_i == 1'b0 ? rst_sync_n_s : rst_n_s;

  stdcc_mux u_mux_rstn_stage3(
       .a                    (rst_sync_n_s             ),
       .b                    (rst_n_s                  ),
       .sel                  (rst_sel_i                ),
       .z                    (rst_n_tmp_s              )
     );
end 
endgenerate 

//------------------------------------------------------------------------------
//rst_out_synced_g = 2
//reset_source is rst_n_s (internal reset), its release edge is synced to
//clk_sync_i clock
//scan mode input is controlled by rst_sel_i
//------------------------------------------------------------------------------

generate if (rst_out_synced_g == 2) begin: rst_sync_inner_2stage_gen
  stdcc_rstn_sync2 sync2_rstn (
   .clk  (clk_sync_i),
   .rstn (rst_n_s),
   .dout (rst_sync_n_s)
 );
// assign rst_n_tmp_s = rst_sel_i == 1'b0 ? rst_sync_n_s : rst_n_s;
 
 stdcc_mux u_mux_rstn_stage2(
       .a                    (rst_sync_n_s             ),
       .b                    (rst_n_s                  ),
       .sel                  (rst_sel_i                ),
       .z                    (rst_n_tmp_s              )
     );
 end 
endgenerate

//------------------------------------------------------------------------------
//COMBINATIANAL PROCESS
//FUNCTION:
//    output reset generation based on active LOW/HIGH generic congiguration  
//DESCRIPTION:
//------------------------------------------------------------------------------

//active LOW
generate
if (rst_active_low_g  == 1)
  begin : rst_active_low_gen
    assign rst_n_o = rst_n_tmp_s;
  end 
endgenerate 

//active HIGH
generate
if (rst_active_low_g  == 0)
  begin : rst_active_high_gen
    assign rst_n_o = !rst_n_tmp_s;
  end 
endgenerate 


endmodule: reset_common
