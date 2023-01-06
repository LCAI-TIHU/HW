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
module  cgu_top
 (
   //clk & reset
   input                       sys_clk_i                   , //system clock
   input                       por_rstn_i                  , // por rstn   
   input                       por_rstn_sync_i             , //por_rstn_i by sync

   //mmcm
   output  logic               locked_o                    ,

   //reset bypass by mbist test  
   input                       jtag_rst_sync_bypass_i      ,

   //output clock
   //100MHz 
   output  logic               riscv_clk_o                 ,//riscv clock   
   output  logic               riscv_core_clk_o            ,//riscv core  clock
   output  logic               riscv_rtc_toggle_o          ,//riscv rtc_toggle clock
   output  logic               riscv_debug_clk_o           ,//riscv debug clock   
   output  logic               dma_clk_o                   ,//dma   clock   
   output  logic               per_clk_o                   ,//per   clock   
   output  logic               uart_clk_o                  ,//uart  clock   
   output  logic               uart_kernel_clk_o           ,//uart kernel clock   
   output  logic               timer0_ahb_clk_o            ,//timer0 ahb  clock  
   output  logic               timer0_kernel_clk_o         ,//timer0 kernel clock  
   output  logic               timer1_ahb_clk_o            ,//timer1 ahb  clock  
   output  logic               timer1_kernel_clk_o         ,//timer1 kernel clock 
   output  logic               dla_core_clk_o              ,//dla  core  clock   
   output  logic               dla_csb_clk_o               ,//dla  csb   clock 
   output  logic               scu_ker_clk_o                //scu kernel clock
  
  );

   logic                       mmcm_clk_s                  ;  
   logic                       mmcm_rstn_sync_s            ;

//output assign   
   assign riscv_clk_o                   = mmcm_clk_s       ;//riscv clock   
   assign riscv_core_clk_o              = mmcm_clk_s       ;//riscv core  clock
   assign riscv_debug_clk_o             = mmcm_clk_s       ;//riscv debug clock   
   assign dma_clk_o                     = mmcm_clk_s       ;//dma   clock   
   assign per_clk_o                     = mmcm_clk_s       ;//per   clock   
   assign uart_clk_o                    = mmcm_clk_s       ;//uart  clock   
   assign uart_kernel_clk_o             = mmcm_clk_s       ;//uart kernel clock   
   assign timer0_ahb_clk_o              = mmcm_clk_s       ;//timer0 ahb  clock  
   assign timer0_kernel_clk_o           = mmcm_clk_s       ;//timer0 kernel clock  
   assign timer1_ahb_clk_o              = mmcm_clk_s       ;//timer1 ahb  clock  
   assign timer1_kernel_clk_o           = mmcm_clk_s       ;//timer1 kernel clock 
   assign dla_core_clk_o                = mmcm_clk_s       ;//dla  core  clock   
   assign dla_csb_clk_o                 = mmcm_clk_s       ;//dla  csb   clock  
   assign scu_ker_clk_o                 = mmcm_clk_s       ;//dla  csb   clock  


//sync por_rstn to sys_clk domin
stdcc_rstn_jtag  stdcc_rstn_sync2_mmcm_inst(
  .clk                  ( sys_clk_i               ),
  .func_rstn            ( por_rstn_i              ), 
  .jtag_rst_sync_bypass ( jtag_rst_sync_bypass_i  ),
  
  .func_rstn_out        ( mmcm_rstn_sync_s        ) 
 );


 //mmcm inst
mmcm  mmcm_inst
 (
  // Clock out ports
  .clk_out1             (mmcm_clk_s               ),
  .clk_out2             (riscv_rtc_toggle_o       ),
  // Status and control signals
  .resetn               (mmcm_rstn_sync_s         ),
  .locked               (locked_o                 ),
 // Clock in ports
  .clk_in1              (sys_clk_i                )
 );  

//rtc_toggle clk divider
//clk_even_div #(.DIV(2)) clk_even_div2_riscv_rtc_toggle_inst(
//   .clk_i               (mmcm_clk_s               ),
//   .rst_n_i             (por_rstn_sync_i          ),
//   .clk_o               (riscv_rtc_toggle_o       )
// );  

endmodule
