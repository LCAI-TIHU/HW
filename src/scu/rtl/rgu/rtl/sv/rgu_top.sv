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

//import reset defintion from reset_definition_main.sv 
`include "reset_defintion_main.sv"

module rgu_top (
  input                       sys_clk_i                     ,
  input                       wdt_rst_req_i                 ,
  input                       sw_rst_req_i                  ,
  input                       locked_i                      ,

  input                       por_rstn_i                    ,// por rstn
  input                       pcie_hot_rstn_i               ,// pcie_hot_rstn  

  input [reset_num_main-1: 0] mod_rst_req_i                 ,
  input [reset_num_main-1: 0] mod_rst_mask_i                ,

  input                       jtag_rst_sync_bypass_i        ,
  
  output  logic               por_rstn_sync_o               ,

  //main SCU reset output
  output  logic               rst_riscv_debug_o             ,//riscv debug reset
  output  logic               rst_riscv_o                   ,//riscv reset 
  output  logic               rst_core_nic_n_o              ,//core nic reset 
  output  logic               rst_uncore_nic_n_o            ,//uncore nic reset 
  output  logic               rst_uart_n_o                  ,//uart0 reset 
  output  logic               rst_timer0_n_o                ,//timer0 reset 
  output  logic               rst_timer1_n_o                ,//timer1 reset 
  output  logic               rst_wdt_n_o                   ,//wdt reset
  output  logic               rst_scu_register_n_o          ,//SCU register reset 
  output  logic               rst_jtag2ahb_n_o              ,//jtag2ahb reset  
  output  logic               rst_dma_n_o                   ,//dma reset 
  output  logic               rst_mac_n_o                   ,//mac reset 
  output  logic               rst_ddr_o                      //ddr reset
  
);

parameter CPU_RST_DELAY_CNT = 8;
parameter PRE_RST_DELAY_CNT = 8;

logic                      por_rstn_sync_s        ;
logic                      pre_rst_release_s      ;
logic                      all_rst_release_s      ;
logic [reset_num_main-1:0] rst_array_s            ;

//output 
assign por_rstn_sync_o   = por_rstn_sync_s        ;

//por_rstn_s
assign por_rstn_s = por_rstn_i & pcie_hot_rstn_i & locked_i;

//sync por_rstn to sys_clk domin
  stdcc_rstn_jtag  stdcc_rstn_sync2_sys_clk_inst(
    .clk                  ( sys_clk_i               ),
    .func_rstn            ( por_rstn_s              ), 
    .jtag_rst_sync_bypass ( jtag_rst_sync_bypass_i  ),
    
    .func_rstn_out        ( por_rstn_sync_s         ) 
   ); 


main_boot_fsm  
#(.CPU_RST_DELAY_CNT (CPU_RST_DELAY_CNT),
  .PRE_RST_DELAY_CNT (PRE_RST_DELAY_CNT))
main_boot_fsm_inst(
.clk_i                         (sys_clk_i                    ),                   
.rst_n_i                       (por_rstn_sync_s              ),                 
.sw_rst_req_i                  (sw_rst_req_i                 ),            
.wdt_rst_req_i                 (wdt_rst_req_i                ),
.main_pre_reset_release_o      (pre_rst_release_s            ),
.main_all_reset_release_o      (all_rst_release_s            )
);


genvar i;
generate
for(i=0; i<reset_num_main; i=i+1)
  begin : reset_common_gen_for_main
  reset_common
  #(
    .mod_rst_delay_g  (1),
    .perst_delay_g    (1),
    .hot_rst_delay_g  (1),
    .ld_rst_delay_g   (1),
    .rst_value_g      (0),
    .rst_active_low_g (1),
    .rst_out_synced_g (0))
  inst_reset_common
  (
   .rcu_clk_i                (sys_clk_i),      
   .clk_sync_i               (sys_clk_i),           
   .sy_rst_rcu_n_i           (por_rstn_sync_s),       
   .pad_rst_n_i              (1'b1),          
   .wdt_rst_req_i            (wdt_rst_req_i),        
   .sw_rst_req_i             (sw_rst_req_i),         
   .wdt_rst_cnf_i            (main_reset_matrix[i].wdt_rst_req),        
   .sw_rst_cnf_i             (main_reset_matrix[i].sw_rst_cnf),         
   .pd_rst_req_i             (1'b0),         
   .mod_rst_req_i            (mod_rst_req_i[i]),        
   .mod_rst_mask_i           (mod_rst_mask_i[i]),       
   .cpu_rst_req_i            (1'b0) ,        
   .cpu_rst_cnf_i            (main_reset_matrix[i].cpu_rst_cnf) ,
   .i2c2ahbm_rst_req_i       (1'b0),
   .i2c2ahbm_rst_cnf_i       (1'b0),  
   .perst_req_i              (1'b0) ,
   .perst_cnf_i              (1'b0) ,
   .hot_rst_req_i            (1'b0) ,
   .hot_rst_cnf_i            (1'b0) ,
   .linkdown_rst_req_i       (1'b0) ,
   .linkdown_rst_cnf_i       (1'b0) ,
   .pre_rst_cnf_i            (main_reset_matrix[i].rst_rls_ctrl),
   .pd_rst_cnf_i             (main_reset_matrix[i].pd_rst_cnf),
   .pre_rst_release_i        (pre_rst_release_s),   
   .all_rst_release_i        (all_rst_release_s), 
   .append_rst_req_i         (1'b0),   
   .rst_sel_i                (1'b0),            
   .alt_rst_i                (1'b1),            
   .jtag_res_external_i      (1'b0), 
   .rc_rst_sft_n_i           (1'b0),
   .clear_resctrl_bits_i     (pre_rst_release_s),
   .load_resctrl_bits_i      (1'b1),
   .rst_n_o                  (rst_array_s[i])
  );
  end 
endgenerate   


//assign reset output 
assign rst_riscv_debug_o     =  rst_array_s[0];
assign rst_riscv_o           = ~rst_array_s[1];
assign rst_core_nic_n_o      =  rst_array_s[2];
assign rst_uncore_nic_n_o    =  rst_array_s[3];
assign rst_uart_n_o          =  rst_array_s[4];
assign rst_timer0_n_o        =  rst_array_s[5];
assign rst_timer1_n_o        =  rst_array_s[6];
assign rst_wdt_n_o           =  rst_array_s[7];
assign rst_scu_register_n_o  =  rst_array_s[8];
assign rst_jtag2ahb_n_o      =  rst_array_s[9];
assign rst_dma_n_o           =  rst_array_s[10];
assign rst_mac_n_o           =  rst_array_s[11];
assign rst_ddr_o             = ~rst_array_s[12];


endmodule
