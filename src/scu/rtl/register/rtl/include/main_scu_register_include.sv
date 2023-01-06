//-------------------------------------------------------------- 
//  main_scu_register_include.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_register_include.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!                                                      
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//--------------------------------------------------------------
//  Functions Descriptions:
//  Generate the registers of user defination
//--------------------------------------------------------------
//  Version modify History:
//  Version      Date         Author    Description
//  V0.8        2020-12-31   liyang14   Delete the unuseful signal, for example: index; reg_clk_mode; read_mask and write_mask two into one.
//-------------------------------------------------------------- 
//TODO??
//1. is my_example_reg_list_c defintion safe to generate a const 

//TODO  Delete the clk_mode define.
//inspur_register_include
parameter main_scu_num_of_register = 23;
typedef enum logic [31:0] {SECURE_MODE_0=0}                                                                   main_scu_secure_mode_t    ;
typedef enum logic [31:0] {PROT_MODE_0  =0}                                                                   main_scu_prot_mode_t      ;
typedef enum logic [31:0] {RO=0,WO=1,RW=2,RWH=3,RWS=4,RWHS=5}                                                 main_scu_reg_access_mode_t; 
typedef enum logic [31:0] {OK=0,READ_RESERVED_ERR=1,WRITE_RESERVED_ERR=2,READ_FORBIDDEN=3,WRITE_FORBIDDEN=4}  main_scu_reg_response_t   ;
typedef enum logic [31:0] {
//EXAMPLE_REG<id> = <register_name>
LMU_BOOT_ADDR_ALIAS_SEL=0,
BOOT_STRAP_PIN=1,
DDR_INITIAL_DONE=2,
UTS_COUNTER_H=3,
UTS_COUNTER_L=4,
UTS_COUNTER_CLR=5,
SW_INTERRUPT=6,
PCIE_INTERRUPT=7,
SW_RST_REQ_PREWARNING_INT=8,
PCIE_USER_LNK_UP=9,
PCIE_MSI_ENABLE=10,
PCIE_MSIX_ENABLE=11,
PCIE_INT_ACK=12,
MMCM_LOCK=13,
SW_RST_REQ=14,
MODULE_RST_CTRL=15,
MODULE_RST_CTRL_MASK=16,
RESET_STATUS=17,
WDT_CONTROL=18,
WDT_LOAD_VALUE=19,
WDT_INT_LEVEL=20,
WDT_RLD_UPD=21,
WDT_CNT_VAL=22} main_scu_reg_name_t ;

//TODO Delete the reg_index signal.
//TODO Delete the reg_clk_mode signal.
//TODO read_mask and write_mask signal two into one.
typedef struct packed {
logic[12-1:0]        reg_address      ;   //register address <offset>
logic[31:0]                                                                          reg_reset_value  ;
logic[31:0]                                                                          reg_mask_value       ;
main_scu_reg_access_mode_t                                                      reg_access_mode  ; 
}main_scu_register_define_t ;

//'{<offset>,<reset_value>,<mask_value>,<acc_type>}
 const main_scu_register_define_t   main_scu_reg_list_c [0:main_scu_num_of_register-1]  =
 '{
 '{ 12'h0,32'h0,32'h1,RWHS },
 '{ 12'h4,32'h0,32'h1,RO },
 '{ 12'h8,32'h0,32'h1,RO },
 '{ 12'hc,32'h0,32'hffffffff,RWHS },
 '{ 12'h10,32'h0,32'hffffffff,RWH },
 '{ 12'h14,32'h0,32'h1,RWS },
 '{ 12'h18,32'h0,32'h3,RW },
 '{ 12'h1c,32'h0,32'h1,RWHS },
 '{ 12'h20,32'h0,32'h1,RW },
 '{ 12'h24,32'h0,32'h1,RO },
 '{ 12'h28,32'h0,32'h1,RO },
 '{ 12'h2c,32'h0,32'h1,RO },
 '{ 12'h30,32'h0,32'h7,RO },
 '{ 12'h400,32'h0,32'h1,RO },
 '{ 12'h800,32'h0,32'h1,RW },
 '{ 12'h804,32'h0,32'h1fff,RW },
 '{ 12'h808,32'h0,32'h1fff,RW },
 '{ 12'h80c,32'h1801,32'h1fff,RO },
 '{ 12'hc00,32'h0,32'h3,RW },
 '{ 12'hc04,32'hffffffff,32'hffffffff,RW },
 '{ 12'hc08,32'h0,32'hffffffff,RW },
 '{ 12'hc0c,32'h0,32'h1,WO },
 '{ 12'hc10,32'hffffffff,32'hffffffff,RO } };
 //End of include 