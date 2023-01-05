parameter reset_num_main = 13;
parameter riscv_debug_rst_num_c  = 8'd0;
parameter riscv_debug_rst_hw_c  = 1'b1;
parameter riscv_debug_rst_md_c  = 1'b1;
parameter riscv_debug_rst_wdt_c = 1'b0;
parameter riscv_debug_rst_sw_c = 1'b0;
parameter riscv_debug_rst_cpu_cnf = 1'b0;
parameter riscv_debug_rst_fsm_c = 1'b0;
parameter riscv_debug_rst_pd_cnf = 1'b0;
parameter riscv_rst_num_c  = 8'd1;
parameter riscv_rst_hw_c  = 1'b1;
parameter riscv_rst_md_c  = 1'b1;
parameter riscv_rst_wdt_c = 1'b1;
parameter riscv_rst_sw_c = 1'b1;
parameter riscv_rst_cpu_cnf = 1'b0;
parameter riscv_rst_fsm_c = 1'b0;
parameter riscv_rst_pd_cnf = 1'b0;
parameter core_nic_rst_num_c  = 8'd2;
parameter core_nic_rst_hw_c  = 1'b1;
parameter core_nic_rst_md_c  = 1'b1;
parameter core_nic_rst_wdt_c = 1'b1;
parameter core_nic_rst_sw_c = 1'b1;
parameter core_nic_rst_cpu_cnf = 1'b0;
parameter core_nic_rst_fsm_c = 1'b1;
parameter core_nic_rst_pd_cnf = 1'b0;
parameter uncore_nic_rst_num_c  = 8'd3;
parameter uncore_nic_rst_hw_c  = 1'b1;
parameter uncore_nic_rst_md_c  = 1'b1;
parameter uncore_nic_rst_wdt_c = 1'b1;
parameter uncore_nic_rst_sw_c = 1'b1;
parameter uncore_nic_rst_cpu_cnf = 1'b0;
parameter uncore_nic_rst_fsm_c = 1'b1;
parameter uncore_nic_rst_pd_cnf = 1'b0;
parameter uart_rst_num_c  = 8'd4;
parameter uart_rst_hw_c  = 1'b1;
parameter uart_rst_md_c  = 1'b1;
parameter uart_rst_wdt_c = 1'b1;
parameter uart_rst_sw_c = 1'b1;
parameter uart_rst_cpu_cnf = 1'b0;
parameter uart_rst_fsm_c = 1'b1;
parameter uart_rst_pd_cnf = 1'b0;
parameter timer0_rst_num_c  = 8'd5;
parameter timer0_rst_hw_c  = 1'b1;
parameter timer0_rst_md_c  = 1'b1;
parameter timer0_rst_wdt_c = 1'b1;
parameter timer0_rst_sw_c = 1'b1;
parameter timer0_rst_cpu_cnf = 1'b0;
parameter timer0_rst_fsm_c = 1'b1;
parameter timer0_rst_pd_cnf = 1'b0;
parameter timer1_rst_num_c  = 8'd6;
parameter timer1_rst_hw_c  = 1'b1;
parameter timer1_rst_md_c  = 1'b1;
parameter timer1_rst_wdt_c = 1'b1;
parameter timer1_rst_sw_c = 1'b1;
parameter timer1_rst_cpu_cnf = 1'b0;
parameter timer1_rst_fsm_c = 1'b1;
parameter timer1_rst_pd_cnf = 1'b0;
parameter wdt_rst_num_c  = 8'd7;
parameter wdt_rst_hw_c  = 1'b1;
parameter wdt_rst_md_c  = 1'b1;
parameter wdt_rst_wdt_c = 1'b1;
parameter wdt_rst_sw_c = 1'b1;
parameter wdt_rst_cpu_cnf = 1'b0;
parameter wdt_rst_fsm_c = 1'b1;
parameter wdt_rst_pd_cnf = 1'b0;
parameter main_scu_rst_num_c  = 8'd8;
parameter main_scu_rst_hw_c  = 1'b1;
parameter main_scu_rst_md_c  = 1'b1;
parameter main_scu_rst_wdt_c = 1'b1;
parameter main_scu_rst_sw_c = 1'b1;
parameter main_scu_rst_cpu_cnf = 1'b0;
parameter main_scu_rst_fsm_c = 1'b1;
parameter main_scu_rst_pd_cnf = 1'b0;
parameter jtag2ahb_rst_num_c  = 8'd9;
parameter jtag2ahb_rst_hw_c  = 1'b1;
parameter jtag2ahb_rst_md_c  = 1'b1;
parameter jtag2ahb_rst_wdt_c = 1'b1;
parameter jtag2ahb_rst_sw_c = 1'b1;
parameter jtag2ahb_rst_cpu_cnf = 1'b0;
parameter jtag2ahb_rst_fsm_c = 1'b1;
parameter jtag2ahb_rst_pd_cnf = 1'b0;
parameter dma_rst_num_c  = 8'd10;
parameter dma_rst_hw_c  = 1'b1;
parameter dma_rst_md_c  = 1'b1;
parameter dma_rst_wdt_c = 1'b1;
parameter dma_rst_sw_c = 1'b1;
parameter dma_rst_cpu_cnf = 1'b0;
parameter dma_rst_fsm_c = 1'b1;
parameter dma_rst_pd_cnf = 1'b0;
parameter mac_rst_num_c  = 8'd11;
parameter mac_rst_hw_c  = 1'b1;
parameter mac_rst_md_c  = 1'b1;
parameter mac_rst_wdt_c = 1'b1;
parameter mac_rst_sw_c = 1'b1;
parameter mac_rst_cpu_cnf = 1'b0;
parameter mac_rst_fsm_c = 1'b1;
parameter mac_rst_pd_cnf = 1'b0;
parameter ddr_rst_num_c  = 8'd12;
parameter ddr_rst_hw_c  = 1'b1;
parameter ddr_rst_md_c  = 1'b1;
parameter ddr_rst_wdt_c = 1'b1;
parameter ddr_rst_sw_c = 1'b1;
parameter ddr_rst_cpu_cnf = 1'b0;
parameter ddr_rst_fsm_c = 1'b1;
parameter ddr_rst_pd_cnf = 1'b0;

typedef struct packed {  
integer                  reset_index;
logic                    hw_rst_cnf;
logic                    mod_rst_req;
logic                    wdt_rst_req;
logic                    sw_rst_cnf;
logic                    cpu_rst_cnf;
logic                    rst_rls_ctrl;
logic                    pd_rst_cnf;
}scu_reset_define_main;

const scu_reset_define_main main_reset_matrix [0: 12]= '{
'{0,   riscv_debug_rst_hw_c,   riscv_debug_rst_md_c,   riscv_debug_rst_wdt_c,   riscv_debug_rst_sw_c,   riscv_debug_rst_cpu_cnf,   riscv_debug_rst_fsm_c,   riscv_debug_rst_pd_cnf},
'{1,   riscv_rst_hw_c,   riscv_rst_md_c,   riscv_rst_wdt_c,   riscv_rst_sw_c,   riscv_rst_cpu_cnf,   riscv_rst_fsm_c,   riscv_rst_pd_cnf},
'{2,   core_nic_rst_hw_c,   core_nic_rst_md_c,   core_nic_rst_wdt_c,   core_nic_rst_sw_c,   core_nic_rst_cpu_cnf,   core_nic_rst_fsm_c,   core_nic_rst_pd_cnf},
'{3,   uncore_nic_rst_hw_c,   uncore_nic_rst_md_c,   uncore_nic_rst_wdt_c,   uncore_nic_rst_sw_c,   uncore_nic_rst_cpu_cnf,   uncore_nic_rst_fsm_c,   uncore_nic_rst_pd_cnf},
'{4,   uart_rst_hw_c,   uart_rst_md_c,   uart_rst_wdt_c,   uart_rst_sw_c,   uart_rst_cpu_cnf,   uart_rst_fsm_c,   uart_rst_pd_cnf},
'{5,   timer0_rst_hw_c,   timer0_rst_md_c,   timer0_rst_wdt_c,   timer0_rst_sw_c,   timer0_rst_cpu_cnf,   timer0_rst_fsm_c,   timer0_rst_pd_cnf},
'{6,   timer1_rst_hw_c,   timer1_rst_md_c,   timer1_rst_wdt_c,   timer1_rst_sw_c,   timer1_rst_cpu_cnf,   timer1_rst_fsm_c,   timer1_rst_pd_cnf},
'{7,   wdt_rst_hw_c,   wdt_rst_md_c,   wdt_rst_wdt_c,   wdt_rst_sw_c,   wdt_rst_cpu_cnf,   wdt_rst_fsm_c,   wdt_rst_pd_cnf},
'{8,   main_scu_rst_hw_c,   main_scu_rst_md_c,   main_scu_rst_wdt_c,   main_scu_rst_sw_c,   main_scu_rst_cpu_cnf,   main_scu_rst_fsm_c,   main_scu_rst_pd_cnf},
'{9,   jtag2ahb_rst_hw_c,   jtag2ahb_rst_md_c,   jtag2ahb_rst_wdt_c,   jtag2ahb_rst_sw_c,   jtag2ahb_rst_cpu_cnf,   jtag2ahb_rst_fsm_c,   jtag2ahb_rst_pd_cnf},
'{10,   dma_rst_hw_c,   dma_rst_md_c,   dma_rst_wdt_c,   dma_rst_sw_c,   dma_rst_cpu_cnf,   dma_rst_fsm_c,   dma_rst_pd_cnf},
'{11,   mac_rst_hw_c,   mac_rst_md_c,   mac_rst_wdt_c,   mac_rst_sw_c,   mac_rst_cpu_cnf,   mac_rst_fsm_c,   mac_rst_pd_cnf},
'{12,   ddr_rst_hw_c,   ddr_rst_md_c,   ddr_rst_wdt_c,   ddr_rst_sw_c,   ddr_rst_cpu_cnf,   ddr_rst_fsm_c,   ddr_rst_pd_cnf}};
