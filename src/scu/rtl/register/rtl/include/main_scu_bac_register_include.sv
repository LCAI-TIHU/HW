//-------------------------------------------------------------- 
//  main_scu_bac_register_include.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_bac_register_include.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!  
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//-------------------------------------------------------------- 
//  Function Descriptions : Only generate the bac registers by user selected
//-------------------------------------------------------------- 
//  Release History :
//  Version  time        Author     Description
//  V0.8     2020-12-31  liyang14   Modify the bac_register_include_tmp and make it only generate the user selected bac registers.
//  V0.8     2021-01-13  liyang14   because of script, modify the bac_reg_name_t and bac_register_define_t
//-------------------------------------------------------------- 
//TODO??
//1. is my_example_reg_list_c defintion safe to generate a const 

//inspur_register_include



parameter main_scu_bac_num_of_register = 16;

//`define num_of_register <xxx> 
//TODO  Delete the clk mode define 
//TODO  Delete the bac_has_reg_t define
typedef enum logic [31:0] {SECURE_MODE_0=0}                                                                   bac_secure_mode_t    ;
typedef enum logic [31:0] {PROT_MODE_0  =0}                                                                   bac_prot_mode_t      ;
//typedef enum {Y=1, N=0}                                                                          bac_has_reg_t        ;
typedef enum logic [31:0] {RO=0,WO=1,RW=2,RWH=3,RWS=4,RWHS=5}                                                 bac_reg_access_mode_t; 
typedef enum logic [31:0] {OK=0,READ_RESERVED_ERR=1,WRITE_RESERVED_ERR=2,READ_FORBIDDEN=3,WRITE_FORBIDDEN=4}  bac_reg_response_t   ;
typedef enum logic [31:0]{
//EXAMPLE_REG<id> = <register_name>
//TODO  Modify the bac_register_include_tmp list to the for circulation and only generate the Y.
REGISTER_BANK_CLOCK_ENABLE_SET=0,
REGISTER_BANK_CLOCK_ENABLE_CLR=1,
REGISTER_BANK_CLOCK_ENABLE_STATUS=2,
KERNEL_CLOCK_ENABLE_SET=3,
KERNEL_CLOCK_ENABLE_CLR=4,
KERNEL_CLOCK_ENABLE_STATUS=5,
CHIPID=6,
MODULEID=7,
CHECKSUM=8,
FUNC_INT_0_ENABLE_SET=9,
FUNC_INT_0_ENABLE_CLEAR=10,
FUNC_INT_0_ENABLE_STATUS=11,
FUNC_INT_0_SET=12,
FUNC_INT_0_CLR=13,
FUNC_INT_0_STATUS_ENABLED=14,
FUNC_INT_0_STATUS=15} bac_reg_name_t ;

//TODO Delete the reg_index, has_reg_define, reg_clk_mode, reg_write_mask and reg_read_mask two into one mask_value.
typedef struct packed {
//bac_has_reg_t             has_reg_define   ;   //1: there is reg define, 0: no reg define(a hole)
//bac_reg_name_t            reg_name         ;   //register name 
logic[6-1:0]             reg_address      ;   //register address <offset>
logic[31:0]               reg_reset_value  ;
logic[31:0]               reg_mask_value       ;
bac_reg_access_mode_t     reg_access_mode  ; 
}main_scu_bac_register_define_t ;

//'{<register_name>,<offset>,<reset_value>,<mask_value>,<acc_type>}
 const main_scu_bac_register_define_t   main_scu_bac_reg_list_c [0:main_scu_bac_num_of_register-1]  =
 '{
  '{ 6'h0,32'h0,32'h1,WO },
  '{ 6'h4,32'h0,32'h1,WO },
  '{ 6'h8,32'h0,32'h1,RO },
  '{ 6'hC,32'h0,32'h1,WO },
  '{ 6'h10,32'h0,32'h1,WO },
  '{ 6'h14,32'h0,32'h1,RO },
  '{ 6'h18,32'h12345678,32'hffffffff,RO },
  '{ 6'h1C,32'haa550080,32'hffffffff,RO },
  '{ 6'h20,32'h8211faf8,32'hffffffff,RO },
  '{ 6'h24,32'h0,32'hffffffff,WO },
  '{ 6'h28,32'h0,32'hffffffff,WO },
  '{ 6'h2C,32'h0,32'hffffffff,RO },
  '{ 6'h30,32'h0,32'hffffffff,WO },
  '{ 6'h34,32'h0,32'hffffffff,WO },
  '{ 6'h38,32'h0,32'hffffffff,RO },
  '{ 6'h3C,32'h0,32'hffffffff,RO } };

 //End of include 
 
 //localparam tx_fifo_start_addr= 32'h1000;
 //localparam tx_fifo_end_addr  = 32'h1FFC;
 //localparam rx_fifo_start_addr= 32'h2000;
 //localparam rx_fifo_end_addr  = 32'h2FFC;