## 各子模块寄存器地址空间分配
| 子模块    | 起始地址    | 结束地址    | 地址空间大小 |
|-----------|-------------|-------------|--------|
| CFGROM    | 0x0000_0000 | 0x0000_0FFF | 4KB    |
| GLB       | 0x0000_1000 | 0x0000_1FFF | 4KB    |
| MCIF      | 0x0000_2000 | 0x0000_2FFF | 4KB    |
| CDMA      | 0x0000_3000 | 0x0000_3FFF | 4KB    |
| CSC       | 0x0000_4000 | 0x0000_4FFF | 4KB    |
| CMAC_A    | 0x0000_5000 | 0x0000_5FFF | 4KB    |
| CMAC_B    | 0x0000_6000 | 0x0000_6FFF | 4KB    |
| CACC      | 0x0000_7000 | 0x0000_7FFF | 4KB    |
| SDP_RDMA  | 0x0000_8000 | 0x0000_8FFF | 4KB    |
| SDP       | 0x0000_9000 | 0x0000_9FFF | 4KB    |
| reserved  | 0x0000_A000 | 0x0000_AFFF | 4KB    |
| reserved  | 0x0000_B000 | 0x0000_BFFF | 4KB    |
| reserved  | 0x0000_C000 | 0x0000_CFFF | 4KB    |
| reserved  | 0x0000_D000 | 0x0000_DFFF | 4KB    |
| reserved  | 0x0000_E000 | 0x0000_EFFF | 4KB    |
| CVIF      | 0x0000_F000 | 0x0000_FFFF | 4KB    |
| BDMA      | 0x0001_0000 | 0x0001_0FFF | 4KB    |
| reserved  | 0x0001_1000 | 0x0003_FFFF | 188KB  |


## GLB
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|-----------|------------------------|---------|-----------------------|------|----------------------------------------------------------------------------------|
| 32'h1000   | glb_s_nvdla_hw_version |         |                       |      | 硬件版本号寄存器。                      |
|            |                        | [31:24] | reserved              | -    | reserved                                |
|            |                        | [23:8]  | minor                 | RO   | 分支版本号，该位域的值固定为16'h3030。  |
|            |                        | [7:0]   | major                 | RO   | 主版本号，该位域的值固定为8'h31。       |
| 32'h1004   | glb_s_intr_mask        |         |                       |      | 中断屏蔽寄存器。                        |
|            |                        | [31:22] | reserved              | -    | reserved                                |
|            |                        | 21      | cacc_done_mask1       | RW   | CACC完成中断1的屏蔽位，用于屏蔽使用乒乓寄存器组中的第1组时（s_status.comsumer=1）产生的CACC完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 20      | cacc_done_mask0       | RW   | CACC完成中断0的屏蔽位，用于屏蔽使用乒乓寄存器组中的第0组时（s_status.comsumer=0）产生的CACC完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 19      | cdma_wt_done_mask1    | RW   | CDMA weight传输完成中断1的屏蔽位，用于屏蔽使用乒乓寄存器组中的第1组时（s_status.comsumer=1）weight传输完成中断：<br>0：不屏蔽该中断； <br>1：屏蔽该中断。|
|            |                        | 18      | cdma_wt_done_mask0    | RW   | CDMA weight传输完成中断0的屏蔽位，用于屏蔽使用乒乓寄存器组中的第0组时（s_status.comsumer=0）weight传输完成中断：<br>0：不屏蔽该中断； <br>1：屏蔽该中断。|
|            |                        | 17      | cdma_dat_done_mask1   | RW   | CDMA data传输完成中断1的屏蔽位，用于屏蔽使用乒乓寄存器组中的第1组时（s_status.comsumer=1）data传输完成中断：<br>0：不屏蔽该中断； <br>1：屏蔽该中断。|
|            |                        | 16      | cdma_dat_done_mask0   | RW   | CDMA data传输完成中断0的屏蔽位，用于屏蔽使用乒乓寄存器组中的第0组时（s_status.comsumer=0）data传输完成中断：<br>0：不屏蔽该中断； <br>1：屏蔽该中断。|
|            |                        | [15:10] | reserved              | -    | reserved                                |
|            |                        | 9       | rubik_done_mask1      | RW   | RUBIK完成中断1的屏蔽位，用于屏蔽使用乒乓寄存器组中的第1组时（s_status.comsumer=1）产生的RUBIK完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 8       | rubik_done_mask0      | RW   | RUBIK完成中断0的屏蔽位，用于屏蔽使用乒乓寄存器组中的第0组时（s_status.comsumer=0）产生的RUBIK完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 7       | bdma_done_mask1       | RW   | BDMA完成中断1的屏蔽位，用于屏蔽group1传输完成的中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 6       | bdma_done_mask0       | RW   | BDMA完成中断0的屏蔽位，用于屏蔽group0传输完成的中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 5       | pdp_done_mask1        | RW   | PDP完成中断1的屏蔽位，用于屏蔽使用乒乓寄存器组中的第1组时（s_status.comsumer=1）产生的PDP计算完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 4       | pdp_done_mask0        | RW   | PDP完成中断0的屏蔽位，用于屏蔽使用乒乓寄存器组中的第0组时（s_status.comsumer=0）产生的PDP计算完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 3       | cdp_done_mask1        | RW   | CDP完成中断1的屏蔽位，用于屏蔽使用乒乓寄存器组中的第1组时（s_status.comsumer=1）产生的CDP计算完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 2       | cdp_done_mask0        | RW   | CDP完成中断0的屏蔽位，用于屏蔽使用乒乓寄存器组中的第0组时（s_status.comsumer=0）产生的CDP计算完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 1       | sdp_done_mask1        | RW   | SDP完成中断1的屏蔽位，用于屏蔽使用乒乓寄存器组中的第1组时（s_status.comsumer=1）产生的SDP计算完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
|            |                        | 0       | sdp_done_mask0        | RW   | SDP完成中断0的屏蔽位，用于屏蔽使用乒乓寄存器组中的第0组时（s_status.comsumer=0）产生的SDP计算完成中断：<br>0：不屏蔽该中断；<br>1：屏蔽该中断。|
| 32'h1008   | glb_s_intr_set         |         |                       |      | 中断触发寄存器，向该寄存器写1可以触发对应的中断，读寄存器返回0。|
|            |                        | [31:22] | reserved              | -    | reserved                                |
|            |                        | 21      | cacc_done_set1        | WO   | CACC完成中断1的触发位，用于触发使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的CACC计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 20      | cacc_done_set0        | WO   | CACC完成中断0的触发位，用于触发使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的CACC计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 19      | cdma_wt_done_set1     | WO   | CDMA weight传输完成中断1的触发位，用于触发使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的weight传输完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 18      | cdma_wt_done_set0     | WO   | CDMA weight传输完成中断0的触发位，用于触发使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的weight传输完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 17      | cdma_dat_done_set1    | WO   | CDMA data传输完成中断1的触发位，用于触发使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的data传输完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 16      | cdma_dat_done_set0    | WO   | CDMA data传输完成中断0的触发位，用于触发使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的data传输完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | [15:10] | reserved              | -    | reserved                                |
|            |                        | 9       | rubik_done_set1       | WO   | RUBIK完成中断1的触发位，用于触发使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的RUBIK计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 8       | rubik_done_set0       | WO   | RUBIK完成中断0的触发位，用于触发使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的RUBIK计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 7       | bdma_done_set1        | WO   | BDMA传输完成中断1的触发位，用于触发group1传输完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 6       | bdma_done_set0        | WO   | BDMA传输完成中断0的触发位，用于触发group0传输完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 5       | pdp_done_set1         | WO   | PDP完成中断1的触发位，用于触发使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的PDP计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 4       | pdp_done_set0         | WO   | PDP完成中断0的触发位，用于触发使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的PDP计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 3       | cdp_done_set1         | WO   | CDP完成中断1的触发位，用于触发使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的CDP计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 2       | cdp_done_set0         | WO   | CDP完成中断0的触发位，用于触发使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的CDP计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 1       | sdp_done_set1         | WO   | SDP完成中断1的触发位，用于触发使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的SDP计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
|            |                        | 0       | sdp_done_set0         | WO   | SDP完成中断0的触发位，用于触发使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的SDP计算完成中断：<br>0：不触发该中断；<br>1：触发该中断。|
| 32'h100c   | glb_s_intr_status      |         |                       |      | 中断状态寄存器，读寄存器可以得到中断状态，向寄存器写1可以清除对应的中断。|
|            |                        | [31:22] | reserved              | -    | reserved                                |
|            |                        | 21      | cacc_done_status1     | RO   | CACC完成中断1的状态，用于指示使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的CACC完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 20      | cacc_done_status0     | RO   | CACC完成中断0的状态，用于指示使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的CACC完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 19      | cdma_wt_done_status1  | RO   | CDMA weight传输完成中断1的状态，用于指示使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的weight传输完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 18      | cdma_wt_done_status0  | RO   | CDMA weight传输完成中断0的状态，用于指示使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的weight传输完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 17      | cdma_dat_done_status1 | RO   | CDMA data传输完成中断1的状态，用于指示使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的data传输完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 16      | cdma_dat_done_status0 | RO   | CDMA data传输完成中断0的状态，用于指示使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的data传输完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | [15:10] | reserved              | -    | reserved                                |
|            |                        | 9       | rubik_done_status1    | RO   | RUBIK完成中断1的状态，用于指示使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的RUBIK完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 8       | rubik_done_status0    | RO   | RUBIK完成中断0的状态，用于指示使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的RUBIK完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 7       | bdma_done_status1     | RO   | BDMA完成中断1的状态，用于指示group1传输完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 6       | bdma_done_status0     | RO   | BDMA完成中断0的状态，用于指示group0传输完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 5       | pdp_done_status1      | WC   | PDP完成中断1的状态，用于指示使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的PDP计算完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 4       | pdp_done_status0      | WC   | PDP完成中断0的状态，用于指示使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的PDP计算完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 3       | cdp_done_status1      | WC   | CDP完成中断1的状态，用于指示使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的CDP计算完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 2       | cdp_done_status0      | WC   | CDP完成中断0的状态，用于指示使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的CDP计算完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 1       | sdp_done_status1      | WC   | SDP完成中断1的状态，用于指示使用乒乓寄存器组中的第1组时（s_status.comsumer=1）的SDP计算完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|
|            |                        | 0       | sdp_done_status0      | WC   | SDP完成中断0的状态，用于指示使用乒乓寄存器组中的第0组时（s_status.comsumer=0）的SDP计算完成中断是否产生：<br>0：没有产生中断；<br>1：产生中断。|


## MCIF
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|----------------|--------------------------|---------|--------------------|------|--------------------------------------------------------------|
| 32'h2000   | mcif_cfg_rd_weight_0     |         |                    |      | 读通道各master的权重，读通道的仲裁采用WRR（weighted round robin，带权重的轮询），该寄存器配置各模块的权重。|
|            |                          | [31:24] | rd_weight_cdp      | RW   | CDP（master 7）的权重，默认值为1。           |
|            |                          | [23:16] | rd_weight_pdp      | RW   | PDP（master 6）的权重，默认值为1。           |
|            |                          | [15:8]  | rd_weight_sdp      | RW   | SDP（master 2）的权重，默认值为1。           |
|            |                          | [7:0]   | rd_weight_bdma     | RW   | BDMA（master 8）的权重，默认值为1。          |
| 32'h2004   | mcif_cfg_rd_weight_1     |         |                    |      | 读通道各master的权重。                       |
|            |                          | [31:24] | rd_weight_cdma_dat | RW   | CDMA_DAT（master 0）的权重，默认值为1。      |
|            |                          | [23:16] | rd_weight_sdp_e    | RW   | SDP_E（master 5）的权重，默认值为1。         |
|            |                          | [15:8]  | rd_weight_sdp_n    | RW   | SDP_N（master 4）的权重，默认值为1。         |
|            |                          | [7:0]   | rd_weight_sdp_b    | RW   | SDP_B（master 3）的权重，默认值为1。         |
| 32'h2008   | mcif_cfg_rd_weight_2     |         |                    |      | 读通道各master的权重。                       |
|            |                          | [31:16] | reserved           | -    | reserved                                     |
|            |                          | [15:8]  | rd_weight_rbk      | RW   | RUBIK的权重，默认值为1，当前版本不支持RUBIK。|
|            |                          | [7:0]   | rd_weight_cdma_wt  | RW   | CDMA_WEIGHT（master 1）的权重，默认值为1。   |
| 32'h200c   | mcif_cfg_wr_weight_0     |         |                    |      | 写通道各master的权重，写通道的仲裁采用WRR（weighted round robin，带权重的轮询），该寄存器配置各master的权重。 |
|            |                          | [31:24] | wr_weight_cdp      | RW   | CDP（master 2）的权重，默认值为1。           |
|            |                          | [23:16] | wr_weight_pdp      | RW   | PDP（master 1）的权重，默认值为1。           |
|            |                          | [15:8]  | wr_weight_sdp      | RW   | SDP（master 0）的权重，默认值为1。           |
|            |                          | [7:0]   | wr_weight_bdma     | RW   | BDMA（master 3）的权重，默认值为1。          |
| 32'h2010   | mcif_cfg_wr_weight_1     |         |                    |      | 写通道各master的权重。                       |
|            |                          | [31:8]  | reserved           | -    | reserved                                     |
|            |                          | [7:0]   | wr_weight_rbk      | RW   | RUBIK的权重，默认值为1，当前版本不支持RUBIK。|
| 32'h2014   | mcif_cfg_outstanding_cnt |         |                    |      | outstanding配置寄存器。                      |
|            |                          | [31:16] | reserved           | -    | reserved                                     |
|            |                          | [15:8]  | wr_os_cnt          | RW   | 写通道的outstanding，默认值是255。           |
|            |                          | [7:0]   | rd_os_cnt          | RW   | 读通道的outstanding，默认值是255。           |
| 32'h2018   | mcif_status              |         |                    |      | 状态寄存器。                                 |
|            |                          | [31:16] | reserved           | -    | reserved                                     |
|            |                          | 8       | idle               | RO   | 该位域的值固定为1，没有实际作用。            |
|            |                          | [7:0]   | reserved           | -    | reserved                                     |


## CDMA
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|---------------------------|------------------------------|---------|---------------------|------|----------------------------------------------------------|
| 32'h3000   | cdma_s_status                |         |                     |      | 乒乓寄存器组状态寄存器。|
|            |                              | [31:18] | reserved            | -    | reserved            |
|            |                              | [17:16] | status_1            | RO   | 指示乒乓寄存器组1的状态，<br>0：寄存器组1空闲，可以配置；<br>1：寄存器组1正在被使用，配置无效；<br>2：寄存器组1已经配置完，但还未被使用；<br>3：保留。|
|            |                              | [15:2]  | reserved            | -    | reserved            |
|            |                              | [1:0]   | status_0            | RO   | 指示乒乓寄存器组0的状态，<br>0：寄存器组0空闲，可以配置；<br>1：寄存器组0正在被使用，配置无效；<br>2：寄存器组0已经配置完，但还未被使用；<br>3：保留。|
| 32'h3004   | cdma_s_pointer               |         |                     |      | 乒乓寄存器组指针寄存器。|
|            |                              | [31:17] | reserved            | -    | reserved            |
|            |                              | 16      | consumer            | RO   | 指示数据通路执行计算用到的乒乓寄存器组；<br>0：当前使用的是寄存器组0；<br>1：当前使用的是寄存器组1。|
|            |                              | [15:1]  | reserved            | -    | reserved            |
|            |                              | 0       | producer            | RW   | 指示CPU配置的乒乓寄存器组：<br>0：CPU配置寄存器组0；<br>1：CPU配置寄存器组1。|
| 32'h3008   | cdma_s_arbiter               |         |                     |      |                     |
|            |                              | [31:20] | reserved            | -    | reserved            |
|            |                              | [19:16] | arb_wmb             | RW   | 该位域未使用。      |
|            |                              | [15:4]  | reserved            | -    | reserved            |
|            |                              | [3:0]   | arb_weight          | RW   | 该位域未使用。      |
| 32'h300c   | cdma_s_cbuf_flush_status     |         |                     |      | CBUF flush状态寄存器。|
|            |                              | [31:1]  | reserved            | -    | reserved            |
|            |                              | 0       | flush_done          | RO   | CBUF flush完成标志信号。|
| 32'h3010   | cdma_d_op_enable             |         |                     |      | CDMA使能寄存器。    |
|            |                              | [31:1]  | reserved            | -    | reserved            |
|            |                              | 0       | op_en               | RW   | CDMA使能（该寄存器的读出值与写入值不一定相同）；<br>0：不使能；<br>1：使能。|
| 32'h3014   | cdma_d_misc_cfg              |         |                     |      | CDMA配置寄存器。    |
|            |                              | [31:29] | reserved            | -    | reserved            |
|            |                              | 28      | skip_weight_rls     | RW   | 是否释放CBUF中的weight；<br>0：释放，需要重新读取weight；<br>1：不释放，可以复用weight。|
|            |                              | [27:25] | reserved            | -    | reserved            |
|            |                              | 24      | skip_data_rls       | RW   | 是否释放CBUF中的data；<br>0：释放，需要重新读取data；1：不释放，可以复用data。|
|            |                              | [23:21] | reserved            | -    | reserved            |
|            |                              | 20      | weight_reuse        | RW   | 是否复用weight；<br>0：不复用，需要读取weight；<br>1：复用，跳过weight读取。|
|            |                              | [19:17] | reserved            | -    | reserved            |
|            |                              | 16      | data_reuse          | RW   | 是否复用feature；<br>0：不复用，需要读取feature；<br>1：复用，跳过feature读取。|
|            |                              | [15:14] | reserved            | -    | reserved            |
|            |                              | [13:12] | proc_precision      | RW   | 数据处理精度；<br>0：int8，实际上该寄存器配置为0的情况没用到；<br>1：int16；<br>2~3：保留。|
|            |                              | [11:10] | reserved            | -    | reserved            |
|            |                              | [9:8]   | in_precision        | RW   | 输入数据的精度，该寄存器没有用到。|
|            |                              | [7:1]   | reserved            | -    | reserved            |
|            |                              | 0       | conv_mode           | RW   | 卷积模式；<br>0：普通卷积模式（DC模式或image输入模式）；<br>1：winograd模式，当前版本不支持。|
| 32'h3018   | cdma_d_datain_format         |         |                     |      | CDMA输入数据格式配置寄存器。                                         |
|            |                              | [31:21] | reserved            | -    | reserved            |
|            |                              | 20      | pixel_sign_override | RW   | 输入pixel按照有符号数还是无符号数解释；<br>0：输入的pixel按照无符号数解释；<br>1：输入pixel按照有符号数解释。|
|            |                              | [19:17] | reserved            | -    | reserved            |
|            |                              | 16      | pixel_mapping       | RW   | 该寄存器未使用。    |
|            |                              | [15:14] | reserved            | -    | reserved            |
|            |                              | [13:8]  | pixel_format        | RW   | 输入pixel的格式；<br>0x0：T_R8；<br>0xC：T_A8B8G8R8；<br>0xD：T_A8R8G8B8；<br>0xE：T_B8G8R8A8；<br>0xF：T_R8G8B8A8；<br>0x10：T_X8B8G8R8；<br>0x11：T_X8R8G8B8；<br>0x12：T_B8G8R8X8；<br>0x13：T_R8G8B8X8；<br>0x1A：T_A8Y8U8V8；<br>0x1B：T_V8U8Y8A8；<br>0x1C：T_Y8___U8V8_N444；<br>0x1D：T_Y8___V8U8_N444；<br>其他：保留。|
|            |                              | [7:1]   | reserved            | -    | reserved            |
|            |                              | 0       | datain_format       | RW   | 输入数据的类型；<br>0：输入数据是feature；<br>1：输入数据是pixel。|
| 32'h301c   | cdma_d_datain_size_0         |         |                     |      | 输入size配置寄存器0。|
|            |                              | [31:29] | reserved            | -    | reserved            |
|            |                              | [28:16] | datain_height       | RW   | 输入数据的高度，真实高度减1配置。|
|            |                              | [15:13] | reserved            | -    | reserved            |
|            |                              | [12:0]  | datain_width        | RW   | 输入数据得宽度，真实宽度减1配置。|
| 32'h3020   | cdma_d_datain_size_1         |         |                     |      | 输入size配置寄存器1。|
|            |                              | [31:13] | reserved            | -    | reserved            |
|            |                              | [12:0]  | datain_channel      | RW   | 输入数据的通道数，真实通道数减1配置。|
| 32'h3024   | cdma_d_datain_size_ext_0     |         |                     |      |                     |
|            |                              | [31:29] | reserved            | -    | reserved            |
|            |                              | [28:16] | datain_height_ext   | RW   | 该位域未使用。      |
|            |                              | [15:13] | reserved            | -    | reserved            |
|            |                              | [12:0]  | datain_width_ext    | RW   | 该位域未使用。      |
| 32'h3028   | cdma_d_pixel_offset          |         |                     |      | 配置的起始地址与有效数据真正的起始地址之间的偏移。|
|            |                              | [31:19] | reserved            | -    |                     |
|            |                              | [18:16] | pixel_y_offset      | RW   | 配置的起始地址与有效数据真正的起始地址在x方向的偏移。|
|            |                              | [15:5]  | reserved            | -    |                     |
|            |                              | [4:0]   | pixel_x_offset      | RW   | 配置的起始地址与有效数据真正的起始地址在y方向的偏移。|
| 32'h302c   | cdma_d_dain_ram_type         |         |                     |      | 存储输入data的memory类型。|
|            |                              | [31:1]  | reserved            | -    | reserved            |
|            |                              | 0       | datain_ram_type     | RW   | 存储data（feature或pixel）的memory类型；<br>0：SRAM；<br>1：DRAM。|
| 32'h3030   | cdma_d_dain_addr_high_0      |         |                     |      | 输入data存储基地址高32位。|
|            |                              | [31:0]  | datain_addr_high_0  | RW   | DC/img模式时memory中的feature/pixel数据基地址的高32位。|
| 32'h3034   | cdma_d_dain_addr_low_0       |         |                     |      | 输入data存储基地址低32位。|
|            |                              | [31:0]  | datain_addr_low_0   | RW   | DC/img模式时memory中的feature/pixel数据基地址的低32位。|
| 32'h3038   | cdma_d_dain_addr_high_1      |         |                     |      | img模式下planer1的像素数据基地址的高32位。|
|            |                              | [31:0]  | datain_addr_high_1  | RW   | img模式下planer1的像素数据基地址的高32位。|
| 32'h303c   | cdma_d_dain_addr_low_1       |         |                     |      | img模式下planer1的像素数据基地址的低32位。|
|            |                              | [31:0]  | datain_addr_low_1   | RW   | img模式下planer1的像素数据基地址的低32位。|
| 32'h3040   | cdma_d_line_stride           |         |                     |      | 相邻行之间的地址偏移。|
|            |                              | [31:0]  | line_stride         | RW   | memory中存储feature/pixel时相邻行之间的地址偏移。|
| 32'h3044   | cdma_d_line_uv_stride        |         |                     |      | planer1相邻行之间的地址偏移。|
|            |                              | [31:0]  | uv_line_stride      | RW   | memory中存储pixel时planar 1 的相邻行之间的地址偏移。|
| 32'h3048   | cdma_d_surf_stride           |         |                     |      |                     |
|            |                              | [31:0]  | surf_stride         | RW   | memory中存储feature时相邻surface之间的地址偏移。|
| 32'h304c   | cdma_d_dain_map              |         |                     |      | 输入data在memory中是否连续存储。|
|            |                              | [31:17] | reserved            | -    | reserved            |
|            |                              | 16      | surf_packed         | RW   | memory中存储feature时相邻surface之间是否连续存储；<br>0：不连续存储；<br>1：连续存储。|
|            |                              | [15:1]  | reserved            | -    | reserved            |
|            |                              | 0       | line_packed         | RW   | memory中存储feature时相邻行之间是否连续存储；<br>0：不连续存储；<br>1：连续存储。|
| 32'h3050   | cdma_d_reserved_x_cfg        |         |                     |      |                     |
|            |                              | [31:26] | reserved            | -    | reserved            |
|            |                              | [25:16] | rsv_per_uv_line     | RW   | 该位域未用到。      |
|            |                              | [15:10] | reserved            | -    | reserved            |
|            |                              | [9:0]   | rsv_per_line        | RW   | 该位域未用到。      |
| 32'h3054   | cdma_d_reserved_y_cfg        |         |                     |      |                     |
|            |                              | [31:21] | reserved            | -    | reserved            |
|            |                              | [20:16] | rsv_y_index         | RW   | 该位域未用到。      |
|            |                              | [15:3]  | reserved            | -    | reserved            |
|            |                              | [2:0]   | rsv_height          | RW   | 该位域未用到。      |
| 32'h3058   | cdma_d_batch_number          |         |                     |      | batch数量。         |
|            |                              | [31:5]  | reserved            | -    | reserved            |
|            |                              | [4:0]   | batches             | RW   | batch数量。         |
| 32'h305c   | cdma_d_batch_stride          |         |                     |      | batch地址偏移。     |
|            |                              | [31:0]  | batch_stride        | RW   | memory中存储feature时相邻batch之间的地址偏移。|
| 32'h3060   | cdma_d_entry_per_slice       |         |                     |      | 每个slice占CBUF的entry数量。|
|            |                              | [31:14] | reserved            | -    | reserved            |
|            |                              | [13:0]  | entries             | RW   | 每个slice占CBUF的entry数量。|
| 32'h3064   | cdma_d_fetch_grain           |         |                     |      | 每次请求读取的slice数量。   |
|            |                              | [31:12] | reserved            | -    |                     |
|            |                              | [11:0]  | grains              | RW   | 读feature时每次请求读取的slice数量，减1配置。|
| 32'h3068   | cdma_d_weight_format         |         |                     |      |                     |
|            |                              | [31:1]  | reserved            | -    | reserved            |
|            |                              | 0       | weight_format       | RW   | 该位域未用到。      |
| 32'h306c   | cdma_d_weight_size_0         |         |                     |      | 单个weight kernel的数据量。|
|            |                              | [31:18] | reserved            | -    |                     |
|            |                              | [17:0]  | byte_per_kernel     | RW   | 每个weight kernel的数据量，以byte为单位，减1配置。|
| 32'h3070   | cdma_d_weight_size_1         |         |                     |      | weight kernel的数量。|
|            |                              | [31:13] | reserved            | -    | reserved            |
|            |                              | [12:0]  | weight_kernel       | RW   | weight kernel的数量，减1配置。|
| 32'h3074   | cdma_d_weight_ram_type       |         |                     |      | 存储weight的memory类型。    |
|            |                              | [31:1]  | reserved            | -    | reserved            |
|            |                              | 0       | weight_ram_type     | RW   |存储weight的memory类型：<br>0：SRAM；<br>1：DDR。|
| 32'h3078   | cdma_d_weight_addr_high      |         |                     |      | weight地址的高32位。|
|            |                              | [31:0]  | weight_addr_high    | RW   | weight存储地址的高32位。    |
| 32'h307c   | cdma_d_weight_addr_low       |         |                     |      | weight地址的低32位。|
|            |                              | [31:0]  | weight_addr_low     | RW   | weight存储地址的低32位。    |
| 32'h3080   | cdma_d_weight_bytes          |         |                     |      | weight的字节总数    |
|            |                              | [31:0]  | weight_bytes        | RW   | weight的数据量，以byte为单位。|
| 32'h3084   | cdma_d_wgs_addr_high         |         |                     |      | wgs地址的高32位。   |
|            |                              | [31:0]  | wgs_addr_high       | RW   | WGS（weight group size）地址的高32位，当前版本不支持weight compression。|
| 32'h3088   | cdma_d_wgs_addr_low          |         |                     |      | wgs地址的低32位。   |
|            |                              | [31:0]  | wgs_addr_low        | RW   | WGS（weight group size）地址的低32位，当前版本不支持weight compression。|
| 32'h308c   | cdma_d_wmb_addr_high         |         |                     |      | wmb地址的高32位。   |
|            |                              | [31:0]  | wmb_addr_high       | RW   | WMB（weight mask bit）地址的高32位，当前版本不支持weight compression。|
| 32'h3090   | cdma_d_wmb_addr_low          |         |                     |      | wmb地址的低32位。   |
|            |                              | [31:0]  | wmb_addr_low        | RW   | WMB（weight mask bit）地址的低32位，当前版本不支持weight compression。|
| 32'h3094   | cdma_d_wmb_bytes             |         |                     |      | wmb的数据量。       |
|            |                              | [31:28] | reserved            | -    | reserved            |
|            |                              | [27:0]  | wmb_bytes           | RW   | WMB的数据量，以byte为单位，当前版本不支持weight compression。|
| 32'h3098   | cdma_d_mean_format           |         |                     |      | 选择CDMA convertor计算时的偏置。|
|            |                              | [31:1]  | reserved            | -    | reserved            |
|            |                              | 0       | mean_format         | RW   | CDMA convertor计算时的偏置选择配置的平均值还是选择配置的offset；<br>0：选择配置的均值；<br>1：选择配置的offset。|
| 32'h309c   | cdma_d_mean_global_0         |         |                     |      | CDMA convertor计算需要的均值|
|            |                              | [31:16] | mean_gu             | RW   | 为CDMA convertor计算配置的均值：ARGB格式下G通道或XYUV格式下U通道的均值。|
|            |                              | [15:0]  | mean_ry             | RW   | 为CDMA convertor计算配置的均值：ARGB格式下R通道或XYUV格式下Y通道的均值。|
| 32'h30a0   | cdma_d_mean_global_1         |         |                     |      | CDMA convertor计算需要的均值|
|            |                              | [31:16] | mean_ax             | RW   | 为CDMA convertor计算配置的均值：ARGB格式下A通道或XYUV格式下X通道的均值。|
|            |                              | [15:0]  | mean_bv             | RW   | 为CDMA convertor计算配置的均值：ARGB格式下B通道或XYUV格式下V通道的均值。|
| 32'h30a4   | cdma_d_cvt_cfg               |         |                     |      | CDMA convertor参数配置。|
|            |                              | [31:10] | reserved            | -    | reserved            |
|            |                              | [9:4]   | cvt_truncate        | RW   | CDMA convertor计算时右移的位数。|
|            |                              | [3:1]   | reserved            | -    | reserved            |
|            |                              | 0       | cvt_en              | RW   | 是否开启CDMAconvertor；<br>0：不开启；<br>1：开启。|
| 32'h30a8   | cdma_d_cvt_offset            |         |                     |      | CDMA convertor计算offset配置。|
|            |                              | [31:16] | reserved            | -    | reserved            |
|            |                              | [15:0]  | cvt_offset          | RW   | CDMA convertor计算时配置的offset。|
| 32'h30ac   | cdma_d_cvt_scale             |         |                     |      | CDMA convertor计算scale配置。|
|            |                              | [31:16] | reserved            | -    | reserved            |
|            |                              | [15:0]  | cvt_scale           | RW   | CDMA convertor计算时的缩放系数。 |
| 32'h30b0   | cdma_d_conv_stride           |         |                     |      |                     |
|            |                              | [31:19] | reserved            | -    | reserved            |
|            |                              | [18:16] | conv_y_stride       | RW   | 该位域未用到。      |
|            |                              | [15:3]  | reserved            | -    | reserved            |
|            |                              | [2:0]   | conv_x_stride       | RW   | 该位域未用到。      |
| 32'h30b4   | cdma_d_zero_padding          |         |                     |      | padding数量配置。   |
|            |                              | [31:30] | reserved            | -    | reserved            |
|            |                              | [29:24] | pad_bottom          | RW   | 顶部padding的数量。 |
|            |                              | [23:21] | reserved            | -    | reserved            |
|            |                              | [20:16] | pad_top             | RW   | 底部padding的数量。 |
|            |                              | [15:14] | reserved            | -    | reserved            |
|            |                              | [13:8]  | pad_right           | RW   | 右侧padding的数量。 |
|            |                              | [7:5]   | reserved            | -    | reserved            |
|            |                              | [4:0]   | pad_left            | RW   | 左侧padding的数量。 |
| 32'h30b8   | cdma_d_zero_padding_value    |         |                     |      | padding值配置。     |
|            |                              | [31:16] | reserved            | -    | reserved            |
|            |                              | [15:0]  | pad_value           | RW   | padding值。         |
| 32'h30bc   | cdma_d_bank                  |         |                     |      | CBUF bank分配寄存器。|
|            |                              | [31:21] | reserved            | -    |                     |
|            |                              | [20:16] | weight_bank         | RW   | weight占用CBUF的bank数。|
|            |                              | [15:5]  | reserved            | -    |                     |
|            |                              | [4:0]   | data_bank           | RW   | data占用CBUF的bank数。|
| 32'h30c0   | cdma_d_nan_flush_to_zero     |         |                     |      |                     |
|            |                              | [31:1]  | reserved            | -    | reserved            |
|            |                              | 0       | nan_to_zero         | RW   | 将nan替换为0，该位域未用到。|
| 32'h30c4   | cdma_d_nan_input_data_num    |         |                     |      |                     |
|            |                              | [31:0]  | nan_data_num        | RO   | 输入data（feature或pixel）中nan（not a number）的数量，该寄存器未用到。|
| 32'h30c8   | cdma_d_nan_input_weight_num  |         |                     |      |                     |
|            |                              | [31:0]  | nan_weight_num      | RO   | 输入weight中nan（not a number）的数量，该寄存器未用到。|
| 32'h30cc   | cdma_d_inf_input_data_num    |         |                     |      |                     |
|            |                              | [31:0]  | inf_data_num        | RO   | 输入data（feature或pixel）中inf（无限大的数值）的数量，该寄存器未用到。|
| 32'h30d0   | cdma_d_inf_input_weight_num  |         |                     |      |                     |
|            |                              | [31:0]  | inf_weight_num      | RO   | 输入weight中inf（无限大的数值）的数量，该寄存器未用到。|
| 32'h30d4   | cdma_d_perf_enable           |         |                     |      | 性能统计使能。      |
|            |                              | [31:1]  | reserved            | -    | reserved            |
|            |                              | 0       | dma_en              | RW   | DMA性能统计使能；<br>0：不使能；<br>1：使能。|
| 32'h30d8   | cdma_d_perf_dat_read_stall   |         |                     |      | 读取data时被阻塞的周期数。|
|            |                              | [31:0]  | dat_rd_stall        | RO   | data和weight载入过程中data被阻塞的周期数。|
| 32'h30dc   | cdma_d_perf_wt_read_stall    |         |                     |      | 读取weight时被阻塞的周期数。|
|            |                              | [31:0]  | wt_rd_stall         | RO   | data和weight载入过程中weight被阻塞的周期数。|
| 32'h30e0   | cdma_d_perf_dat_read_latency |         |                     |      | 读取data的延迟。   |
|            |                              | [31:0]  | dat_rd_latency      | RO   | data和weight载入过程中data延迟的周期数。|
| 32'h30e4   | cdma_d_perf_wt_read_latency  |         |                     |      | 读取weight的延迟。 |
|            |                              | [31:0]  | wt_rd_latency       | RO   | data和weight载入过程中weight延迟的周期数。|
| 32'h30e8   | cdma_d_cya                   |         |                     |      |                    |
|            |                              | [31:0]  | cya                 |      | 该寄存器未用到。   |


## CSC
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|------------------------|--------------------------|---------|--------------------|------|---------------------------------------------------------|
| 32'h4000   | csc_s_status             |         |                    |      | 乒乓寄存器组状态寄存器。    |
|            |                          | [31:18] | reserved           | -    | reserved                    |
|            |                          | [17:16] | status_1           | RO   | "指示乒乓寄存器组1的状态，<br>0：寄存器组1空闲，可以配置；<br>1：寄存器组1正在被使用，配置无效；<br>2：寄存器组1已经配置完，但还未被使用；<br>3：保留。|
|            |                          | [15:2]  | reserved           | -    | reserved                    |
|            |                          | [1:0]   | status_0           | RO   | 指示乒乓寄存器组0的状态，<br>0：寄存器组0空闲，可以配置；<br>1：寄存器组0正在被使用，配置无效；<br>2：寄存器组0已经配置完，但还未被使用；<br>3：保留。|
| 32'h4004   | csc_s_pointer            |         |                    |      | 乒乓寄存器组指针寄存器。    |
|            |                          | [31:17] | reserved           | -    | reserved                    |
|            |                          | 16      | consumer           | RO   | 指示数据通路执行计算用到的乒乓寄存器组；<br>0：当前使用的是寄存器组0；<br>1：当前使用的是寄存器组1。|
|            |                          | [15:1]  | reserved           | -    | reserved                    |
|            |                          | 0       | producer           | RW   | 指示CPU配置的乒乓寄存器组：<br>0：CPU配置寄存器组0；<br>1：CPU配置寄存器组1。|
| 32'h4008   | csc_d_op_enable          |         |                    |      | CSC使能。                   |
|            |                          | [31:1]  | reserved           | -    | reserved                    |
|            |                          | 0       | op_en              | RW   | CSC使能（该寄存器的读出值与写入值不一定相同）；<br>0：不使能；<br>1：使能。|
| 32'h400c   | csc_d_misc_cfg           |         |                    |      | CSC配置寄存器。             |
|            |                          | [31:29] | reserved           | -    | reserved                    |
|            |                          | 28      | skip_weight_rls    | RW   | 是否释放CBUF中的weight；<br>0：释放，需要重新读取weight；<br>1：不释放，可以复用weight。|
|            |                          | [27:25] | reserved           | -    | reserved                    |
|            |                          | 24      | skip_data_rls      | RW   | 是否释放CBUF中的data；<br>0：释放，需要重新读取data；<br>1：不释放，可以复用data。|
|            |                          | [23:21] | reserved           | -    | reserved                    |
|            |                          | 20      | weight_reuse       | RW   | 是否复用weight；<br>0：不复用，需要读取weight；<br>1：复用，跳过weight读取。|
|            |                          | [19:17] | reserved           | -    | reserved                    |
|            |                          | 16      | data_reuse         | RW   | 是否复用feature；<br>0：不复用，需要读取feature；<br>1：复用，跳过feature读取。|
|            |                          | [15:14] | reserved           | -    | reserved                    |
|            |                          | [13:12] | proc_precision     | RW   | 数据处理精度；<br>0：int8；<br>1：int16；<br>2：fp16；<br>3：保留。|
|            |                          | [11:10] | reserved           | -    | reserved                    |
|            |                          | [9:8]   | in_precision       | RW   | 输入数据的精度，该寄存器没有用到。|
|            |                          | [7:1]   | reserved           | -    | reserved                    |
|            |                          | 0       | conv_mode          | RW   | 卷积模式；<br>0：DC模式或image输入模式；<br>1：winograd模式，当前版本不支持。|
| 32'h4010   | csc_d_datain_format      |         |                    |      | 输入数据的格式。            |
|            |                          | [31:1]  | reserved           | -    | reserved                    |
|            |                          | 0       | datain_format      | RW   | 输入数据的类型；<br>0：输入数据是feature；<br>1：输入数据是pixel。|
| 32'h4014   | csc_d_datain_size_ext_0  |         |                    |      | 输入数据size寄存器0（与CDMA中的配置值可能不同）。|
|            |                          | [31:29] | reserved           | -    | reserved                    |
|            |                          | [28:16] | datain_height_ext  | RW   | 输入数据的高度，减1配置。   |
|            |                          | [15:13] | reserved           | -    | reserved                    |
|            |                          | [12:0]  | datain_width_ext   | RW   | 输入数据的宽度，减1配置。   |
| 32'h4018   | csc_d_datain_size_ext_1  |         |                    |      | 输入数据size寄存器1（与CDMA中的配置值可能不同）。|
|            |                          | [31:13] | reserved           | -    | reserved                    |
|            |                          | [12:0]  | datain_channel_ext | RW   | 输入数据的通道数，减1配置。 |
| 32'h401c   | csc_d_batch_number       |         |                    |      | batch num。                 |
|            |                          | [31:5]  | reserved           | -    | reserved                    |
|            |                          | [4:0]   | batches            | RW   | batch数量。                 |
| 32'h4020   | csc_d_post_y_extension   |         |                    |      | 通道后扩展时一组之内的行数。|
|            |                          | [31:2]  | reserved           | -    | reserved                    |
|            |                          | [1:0]   | y_extension        | RW   | 通道后扩展时一组之内的行数；<br>0：不做通道后扩展；<br>1：2行为一组；<br>2：4行为一组；<br>3：保留。|
| 32'h4024   | csc_d_entry_per_slice    |         |                    |      | 每个slice占CBUF的entry数量。|
|            |                          | [31:14] | reserved           | -    | reserved                    |
|            |                          | [13:0]  | entries            | RW   | 每个slice占CBUF的entry数量。|
| 32'h4028   | csc_d_weight_format      |         |                    |      | weight的格式。              |
|            |                          | [31:1]  | reserved           | -    | reserved                    |
|            |                          | 0       | weight_format      | RW   | weight的格式；<br>0：非压缩格式；<br>1：压缩格式（当前不支持压缩weight）。 <br>nv_large中没有用到。|
| 32'h402c   | csc_d_weight_size_ext_0  |         |                    |      | weight kernel size寄存器0。 |
|            |                          | [31:21] | reserved           | -    | reserved                    |
|            |                          | [20:16] | weight_height_ext  | RW   | weight kernel的高度，减1配置。|
|            |                          | [15:5]  | reserved           | -    | reserved                    |
|            |                          | [4:0]   | weight_width_ext   | RW   | weight kernel的宽度，减1配置。|
| 32'h4030   | csc_d_weight_size_ext_1  |         |                    |      | weight kernel size寄存器1。 |
|            |                          | [31:29] | reserved           | -    | reserved                    |
|            |                          | [28:16] | weight_kernel      | RW   | weight kernel的数量，减1配置。|
|            |                          | [15:13] | reserved           | -    | reserved                    |
|            |                          | [12:0]  | weight_channel_ext | RW   | weight kernel的通道数，减1配置。|
| 32'h4034   | csc_d_weight_bytes       |         |                    |      | weight的数据量。            |
|            |                          | [31:0]  | weight_bytes       | RW   | weight的数据量，以byte为单位。|
| 32'h4038   | csc_d_wmb_bytes          |         |                    |      | WMB的数据量。               |
|            |                          | [31:28] | reserved           | -    | reserved                    |
|            |                          | [27:0]  | wmb_bytes          | RW   | WMB的数据量，以byte为单位，当前版本不支持weight compression。|
| 32'h403c   | csc_d_dataout_size_0     |         |                    |      | 输出数据的高度和宽度        |
|            |                          | [31:29] | reserved           | -    | reserved                    |
|            |                          | [28:16] | dataout_height     | RW   | 输出数据的高度，减1配置。   |
|            |                          | [15:13] | reserved           | -    | reserved                    |
|            |                          | [12:0]  | dataout_width      | RW   | 输出数据的宽度，减1配置。   |
| 32'h4040   | csc_d_dataout_size_1     |         |                    |      | 输出数据的channel数目       |
|            |                          | [31:13] | reserved           | -    | reserved                    |
|            |                          | [12:0]  | dataout_channel    | RW   | 输出数据的通道数，减1配置。 |
| 32'h4044   | csc_d_atomics            |         |                    |      | 输出feature的一个surface中atomic的数目。|
|            |                          | [31:21] | reserved           | -    | reserved                    |
|            |                          | [20:0]  | atomics            | RW   | 输出feature的一个surface中atomic的数目。|
| 32'h4048   | csc_d_release            |         |                    |      | 释放CBUF中存储data的slice的数量。|
|            |                          | [31:12] | reserved           | -    | reserved                    |
|            |                          | [11:0]  | rls_slices         | RW   | cdma_d_misc_cfg.skip_data_rls=0时释放CBUF中存储data的slice的数量。|
| 32'h404c   | csc_d_conv_stride_ext    |         |                    |      | 卷积的stride。              |
|            |                          | [31:19] | reserved           | -    | reserved                    |
|            |                          | [18:16] | conv_y_stride_ext  | RW   | y方向的stride。             |
|            |                          | [15:3]  | reserved           | -    | reserved                    |
|            |                          | [2:0]   | conv_x_stride_ext  | RW   | x方向的stride。             |
| 32'h4050   | csc_d_dilation_ext       |         |                    |      | weight的扩张系数。          |
|            |                          | [31:21] | reserved           | -    | reserved                    |
|            |                          | [20:16] | y_dilation_ext     | RW   | weight在y方向的扩张系数，减1配置。|
|            |                          | [15:5]  | reserved           | -    | reserved                    |
|            |                          | [4:0]   | x_dilation_ext     | RW   | weight在x方向的扩张系数，减1配置。|
| 32'h4054   | csc_d_zero_padding       |         |                    |      | padding的数量。             |
|            |                          | [31:21] | reserved           | -    | reserved                    |
|            |                          | [20:16] | pad_top            | RW   | 底部padding的数量。         |
|            |                          | [15:5]  | reserved           | -    | reserved                    |
|            |                          | [4:0]   | pad_left           | RW   | 左侧padding的数量。         |
| 32'h4058   | csc_d_zero_padding_value |         |                    |      | padding值。                 |
|            |                          | [31:16] | reserved           | -    | reserved                    |
|            |                          | [15:0]  | pad_value          | RW   | padding值。                 |
| 32'h405c   | csc_d_bank               |         |                    |      | CBUF中weight和feature占用的bank数。|
|            |                          | [31:21] | reserved           | -    |                             |
|            |                          | [20:16] | weight_bank        | RW   | weight占用CBUF的bank数。    |
|            |                          | [15:5]  | reserved           | -    |                             |
|            |                          | [4:0]   | data_bank          | RW   | data占用CBUF的bank数。      |
| 32'h4060   | csc_d_pra_cfg            |         |                    |      |                             |
|            |                          | [31:2]  | reserved           | -    | reserved                    |
|            |                          | [1:0]   | pra_truncate       | RW   | winograd模式下的寄存器，当前不支持winograd模式。|
| 32'h4064   | csc_d_cya                |         |                    |      |                             |
|            |                          | [31:0]  | cya                |      | 该寄存器未用到。            |


## CMAC_A
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|------------------------|--------------------|---------|----------------|------|-------------------------------|
| 32'h5000   | cmac_a_s_status    |         |                |      | 乒乓寄存器组状态寄存器。      |
|            |                    | [31:18] | reserved       | -    | reserved                      |
|            |                    | [17:16] | status_1       | RO   | 指示乒乓寄存器组1的状态，<br>0：寄存器组1空闲，可以配置；<br>1：寄存器组1正在被使用，配置无效；<br>2：寄存器组1已经配置完，但还未被使用；<br>3：保留。|
|            |                    | [15:2]  | reserved       | -    | reserved                      |
|            |                    | [1:0]   | status_0       | RO   | 指示乒乓寄存器组0的状态，<br>0：寄存器组0空闲，可以配置；<br>1：寄存器组0正在被使用，配置无效；<br>2：寄存器组0已经配置完，但还未被使用；<br>3：保留。|
| 32'h5004   | cmac_a_s_pointer   |         |                |      | 乒乓寄存器组指针寄存器。      |
|            |                    | [31:17] | reserved       | -    | reserved                      |
|            |                    | 16      | consumer       | RO   | 指示数据通路执行计算用到的乒乓寄存器组；<br>0：当前使用的是寄存器组0；<br>1：当前使用的是寄存器组1。|
|            |                    | [15:1]  | reserved       | -    | reserved                      |
|            |                    | 0       | producer       | RW   | 指示CPU配置的乒乓寄存器组：<br>0：CPU配置寄存器组0；<br>1：CPU配置寄存器组1。|
| 32'h5008   | cmac_a_d_op_enable |         |                |      | CMAC_A使能寄存器。            |
|            |                    | [31:1]  | reserved       | -    | reserved                      |
|            |                    | 0       | op_en          | RW   | CMAC_A使能（该寄存器的读出值与写入值不一定相同）；<br>0：不使能；<br>1：使能。|
| 32'h500c   | cmac_a_d_misc_cfg  |         |                |      | CMAC_A配置寄存器。            |
|            |                    | [31:14] | reserved       | -    | reserved                      |
|            |                    | [13:12] | proc_precision | RW   | 数据处理精度；<br>0：int8；<br>1：int16，当前版本不支持；<br>2：fp16，当前版本不支持；<br>3：保留。|
|            |                    | [11:1]  | reserved       | -    | reserved                      |
|            |                    | 0       | conv_mode      | RW   | 卷积模式；<br>0：DC模式或image输入模式；<br>1：winograd模式，当前版本不支持。|


## CMAC_B
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|------------------------|--------------------|---------|----------------|------|-------------------------------|
| 32'h6000   | cmac_a_s_status    |         |                |      | 乒乓寄存器组状态寄存器。      |
|            |                    | [31:18] | reserved       | -    | reserved                      |
|            |                    | [17:16] | status_1       | RO   | 指示乒乓寄存器组1的状态，<br>0：寄存器组1空闲，可以配置；<br>1：寄存器组1正在被使用，配置无效；<br>2：寄存器组1已经配置完，但还未被使用；<br>3：保留。|
|            |                    | [15:2]  | reserved       | -    | reserved                      |
|            |                    | [1:0]   | status_0       | RO   | 指示乒乓寄存器组0的状态，<br>0：寄存器组0空闲，可以配置；<br>1：寄存器组0正在被使用，配置无效；<br>2：寄存器组0已经配置完，但还未被使用；<br>3：保留。|
| 32'h6004   | cmac_a_s_pointer   |         |                |      | 乒乓寄存器组指针寄存器。      |
|            |                    | [31:17] | reserved       | -    | reserved                      |
|            |                    | 16      | consumer       | RO   | 指示数据通路执行计算用到的乒乓寄存器组；<br>0：当前使用的是寄存器组0；<br>1：当前使用的是寄存器组1。|
|            |                    | [15:1]  | reserved       | -    | reserved                      |
|            |                    | 0       | producer       | RW   | 指示CPU配置的乒乓寄存器组：<br>0：CPU配置寄存器组0；<br>1：CPU配置寄存器组1。|
| 32'h6008   | cmac_a_d_op_enable |         |                |      | CMAC_B使能寄存器。            |
|            |                    | [31:1]  | reserved       | -    | reserved                      |
|            |                    | 0       | op_en          | RW   | CMAC_B使能（该寄存器的读出值与写入值不一定相同）； <br>0：不使能；<br>1：使能。|
| 32'h600c   | cmac_a_d_misc_cfg  |         |                |      | CMAC_B配置寄存器。            |
|            |                    | [31:14] | reserved       | -    | reserved                      |
|            |                    | [13:12] | proc_precision | RW   | 数据处理精度；<br>0：int8；<br>1：int16，当前版本不支持；<br>2：fp16，当前版本不支持；<br>3：保留。|
|            |                    | [11:1]  | reserved       | -    | reserved                      |
|            |                    | 0       | conv_mode      | RW   | 卷积模式；<br>0：DC模式或image输入模式；<br>1：winograd模式，当前版本不支持。|


## CACC
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|------------------------|-----------------------|---------|-----------------|------|-------------------------------------------|
| 32'h7000   | cacc_s_status         |         |                 |      | 乒乓寄存器组状态寄存器。          |
|            |                       | [31:18] | reserved        | -    | reserved                          |
|            |                       | [17:16] | status_1        | RO   | 指示乒乓寄存器组1的状态，<br>0：寄存器组1空闲，可以配置；<br>1：寄存器组1正在被使用，配置无效；<br>2：寄存器组1已经配置完，但还未被使用；<br>3：保留。|
|            |                       | [15:2]  | reserved        | -    | reserved                          |
|            |                       | [1:0]   | status_0        | RO   | 指示乒乓寄存器组0的状态，<br>0：寄存器组0空闲，可以配置；<br>1：寄存器组0正在被使用，配置无效；<br>2：寄存器组0已经配置完，但还未被使用；<br>3：保留。|
| 32'h7004   | cacc_s_pointer        |         |                 |      | 乒乓寄存器组指针寄存器。          |
|            |                       | [31:17] | reserved        | -    | reserved                          |
|            |                       | 16      | consumer        | RO   | 指示数据通路执行计算用到的乒乓寄存器组；<br>0：当前使用的是寄存器组0；<br>1：当前使用的是寄存器组1。|
|            |                       | [15:1]  | reserved        | -    | reserved                          |
|            |                       | 0       | producer        | RW   | 指示CPU配置的乒乓寄存器组：<br>0：CPU配置寄存器组0；<br>1：CPU配置寄存器组1。|
| 32'h7008   | cacc_d_op_enable      |         |                 |      | CACC使能寄存器。                  |
|            |                       | [31:1]  | reserved        | -    | reserved                          |
|            |                       | 0       | op_en           | RW   | CACC使能（该寄存器的读出值与写入值不一定相同）；<br>0：不使能；<br>1：使能。|
| 32'h700c   | cacc_d_misc_cfg       |         |                 |      | CACC配置寄存器。                  |
|            |                       | [31:14] | reserved        | -    | reserved                          |
|            |                       | [13:12] | proc_precision  | RW   | 数据处理精度；<br>0：int8；<br>1：int16，当前版本不支持；<br>2：fp16，当前版本不支持；<br>3：保留。|
|            |                       | [11:1]  | reserved        | -    | reserved                          |
|            |                       | 0       | conv_mode       | RW   | 卷积模式；<br>0：DC模式或image输入模式；<br>1：winograd模式，当前版本不支持。|
| 32'h7010   | cacc_d_dataout_size_0 |         |                 |      | 输出size配置寄存器0。             |
|            |                       | [31:29] | reserved        | -    | reserved                          |
|            |                       | [28:16] | dataout_height  | RW   | 输出数据的高度，减1配置，该位域未用到。|
|            |                       | [15:13] | reserved        | -    | reserved                          |
|            |                       | [12:0]  | dataout_width   | RW   | 输出数据的宽度，减1配置，该位域未用到。|
| 32'h7014   | cacc_d_dataout_size_1 |         |                 |      | 输出size配置寄存器1。             |
|            |                       | [31:13] | reserved        | -    | reserved                          |
|            |                       | [12:0]  | dataout_channel | RW   | 输出数据的通道数，减1配置，该位域未用到。|
| 32'h7018   | cacc_d_dataout_addr   |         |                 |      | 输出数据地址。                    |
|            |                       | [31:0]  | dataout_addr    | RW   | 输出数据的地址，该寄存器未用到。  |
| 32'h701c   | cacc_d_batch_number   |         |                 |      | batch size。                      |
|            |                       | [31:5]  | reserved        | -    | reserved                          |
|            |                       | [4:0]   | batches         | RW   | batch数量，该位域未用到。         |
| 32'h7020   | cacc_d_line_stride    |         |                 |      | 相邻行之间的地址偏移。            |
|            |                       | [31:24] | reserved        | -    | reserved                          |
|            |                       | [23:0]  | line_stride     | RW   | memory中存储feature/pixel时相邻行之间的地址偏移，该位域未用到。|
| 32'h7024   | cacc_d_surf_stride    |         |                 |      | 相邻surface之间的地址偏移。       |
|            |                       | [31:24] | reserved        | -    | reserved                          |
|            |                       | [23:0]  | surf_stride     | RW   | memory中存储feature时相邻surface之间的地址偏移，该位域未用到。|
| 32'h7028   | cacc_d_dataout_map    |         |                 |      | 输出数据是否连续存储。            |
|            |                       | [31:17] | reserved        | -    | reserved                          |
|            |                       | 16      | surf_packed     | RW   | memory中存储feature时相邻surface之间是否连续存储；<br>0：不连续存储；<br>1：连续存储。<br>该位域未用到。|
|            |                       | [15:1]  | reserved        | -    | reserved                          |
|            |                       | 0       | line_packed     | RW   | memory中存储feature时相邻行之间是否连续存储；<br>0：不连续存储；<br>1：连续存储。<br>该位域未用到。|
| 32'h702c   | cacc_d_clip_cfg       |         |                 |      |                                   |
|            |                       | [31:5]  | reserved        | -    | reserved                          |
|            |                       | [4:0]   | clip_truncate   | RW   | 该位域未用到。                    |
| 32'h7030   | cacc_d_out_saturation |         |                 |      | 饱和的累加和的数量。              |
|            |                       | [31:0]  | sat_count       | RO   | 统计值，饱和的累加和的数量。      |
| 32'h7034   | cacc_d_cya            |         |                 |      |                                   |
|            |                       | [31:0]  | cya             |      | 该寄存器未用到。                  |


## SDP_RDMA
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|--------------------------------------|-----------------------------------|---------|-----------------------|------|---------------------------------|
| 32'h8000   | sdp_rdma_s_status                 |         |                       |      | 乒乓寄存器组状态寄存器。|
|            |                                   | [31:18] | reserved              | -    | reserved |
|            |                                   | [17:16] | status_1              | RO   | 指示乒乓寄存器组1的状态，<br>0：寄存器组1空闲，可以配置；<br>1：寄存器组1正在被使用，配置无效；<br>2：寄存器组1已经配置完，但还未被使用；<br>3：保留。|
|            |                                   | [15:2]  | reserved              | -    | reserved |
|            |                                   | [1:0]   | status_0              | RO   | 指示乒乓寄存器组0的状态，<br>0：寄存器组0空闲，可以配置；<br>1：寄存器组0正在被使用，配置无效；<br>2：寄存器组0已经配置完，但还未被使用；<br>3：保留。|
| 32'h8004   | sdp_rdma_s_pointer                |         |                       |      | 乒乓寄存器组指针寄存器。|
|            |                                   | [31:17] | reserved              | -    | reserved |
|            |                                   | 16      | consumer              | RO   | 指示数据通路执行计算用到的乒乓寄存器组；<br>0：当前使用的是寄存器组0；<br>1：当前使用的是寄存器组1。|
|            |                                   | [15:1]  | reserved              | -    | reserved |
|            |                                   | 0       | producer              | RW   | 指示CPU配置的乒乓寄存器组：<br>0：CPU配置寄存器组0；<br>1：CPU配置寄存器组1。|
| 32'h8008   | sdp_rdma_d_op_enable              |         |                       |      | SDP_RDMA使能。|
|            |                                   | [31:1]  | reserved              | -    | reserved |
|            |                                   | 0       | op_en                 | RW   | SDP_RDMA使能（该寄存器的读出值与写入值不一定相同）；<br>0：不使能；<br>1：使能。|
| 32'h800c   | sdp_rdma_d_data_cube_width        |         |                       |      | 读取数据的宽度。                          |
|            |                                   | [31:13] | reserved              | -    | reserved                                  |
|            |                                   | [12:0]  | width                 | RW   | SDP_RDMA读取数据的宽度，减1配置。         |
| 32'h8010   | sdp_rdma_d_data_cube_height       |         |                       |      | 读取数据的高度。                          |
|            |                                   | [31:13] | reserved              | -    | reserved                                  |
|            |                                   | [12:0]  | height                | RW   | SDP_RDMA读取数据的高度，减1配置。         |
| 32'h8014   | sdp_rdma_d_data_cube_channel      |         |                       |      | 读取数据的通道数。                        |
|            |                                   | [31:13] | reserved              | -    | reserved                                  |
|            |                                   | [12:0]  | channel               | RW   | SDP_RDMA读取数据的通道数，减1配置。       |
| 32'h8018   | sdp_rdma_d_src_base_addr_low      |         |                       |      | 数据基地址的低32位。                      |
|            |                                   | [31:0]  | src_base_addr_low     | RW   | 数据基地址的低32位。                      |
| 32'h801c   | sdp_rdma_d_src_base_addr_high     |         |                       |      | 数据基地址的高32位。                      |
|            |                                   | [31:0]  | src_base_addr_high    | RW   | 数据基地址的高32位。                      |
| 32'h8020   | sdp_rdma_d_src_line_stride        |         |                       |      | 数据相邻行之间的地址偏移。                |
|            |                                   | [31:0]  | src_line_stride       | RW   | MRDMA读取数据时相邻行之间的地址偏移。     |
| 32'h8024   | sdp_rdma_d_src_surface_stride     |         |                       |      | 数据相邻surface之间的地址偏移。           |
|            |                                   | [31:0]  | src_surface_stride    | RW   | MRDMA读取数据时相邻surface之间的地址偏移。|
| 32'h8028   | sdp_rdma_d_brdma_cfg              |         |                       |      | BRDMA配置寄存器。                         |
|            |                                   | [31:6]  | reserved              | -    | reserved                                  |
|            |                                   | 5       | brdma_ram_type        | RW   | BRDMA读取数据的memory类型；<br>0：SRAM；<br>1：DRAM。|
|            |                                   | 4       | brdma_data_mode       | RW   | BRDMA读取操作数的数据量；<br>0：每通道一个操作数（per kernel）；<br>1：每个输入数据一个操作数（per element）。|
|            |                                   | 3       | brdma_data_size       | RW   | BRDMA读取操作数的每个元素的位宽；<br>0：1 byte；<br>1：2 byte。|
|            |                                   | [2:1]   | brdma_data_use        | RW   | BRDMA读取的数据种类；<br>0：只需要MUL的操作数；<br>1：只需要ALU的操作数；<br>2：需要MUL和ALU的操作数；<br>3：保留。|
|            |                                   | 0       | brdma_disable         | RW   | BRDMA是否关闭；<br>0：不关闭；<br>1：关闭。|
| 32'h802c   | sdp_rdma_d_bs_base_addr_low       |         |                       |      | BRDMA读数据基地址的低32位。                |
|            |                                   | [31:0]  | bs_base_addr_low      | RW   | BRDMA读取数据基地址的低32位。              |
| 32'h8030   | sdp_rdma_d_bs_base_addr_high      |         |                       |      | BRDMA读数据基地址的高32位。                |
|            |                                   | [31:0]  | bs_base_addr_high     | RW   | BRDMA读取数据基地址的高32位。              |
| 32'h8034   | sdp_rdma_d_bs_line_stride         |         |                       |      | BRDMA读数据相邻行之间的地址偏移。          |
|            |                                   | [31:0]  | bs_line_stride        | RW   | BRDMA读取数据时相邻行之间的地址偏移。      |
| 32'h8038   | sdp_rdma_d_bs_surface_stride      |         |                       |      | BRDMA读数据相邻surface之间的地址偏移。     |
|            |                                   | [31:0]  | bs_surface_stride     | RW   | BRDMA读取数据时相邻surface之间的地址偏移。 |
| 32'h803c   | sdp_rdma_d_bs_batch_stride        |         |                       |      | BRDMA读数据相邻batch之间的地址偏移。       |
|            |                                   | [31:0]  | bs_batch_stride       | RW   | BRDMA读取数据时相邻batch之间的地址偏移。   |
| 32'h8040   | sdp_rdma_d_nrdma_cfg              |         |                       |      | NRDMA配置寄存器。                          |
|            |                                   | [31:6]  | reserved              | -    | reserved                                   |
|            |                                   | 5       | nrdma_ram_type        | RW   | NRDMA读取数据的memory类型；<br>0：SRAM；<br>1：DRAM。|
|            |                                   | 4       | nrdma_data_mode       | RW   | NRDMA读取操作数的数据量；<br>0：每通道一个操作数（per kernel）；<br>1：每个输入数据一个操作数（per element）。|
|            |                                   | 3       | nrdma_data_size       | RW   | NRDM读取操作数的每个元素的位宽；<br>0：1 byte；<br>1：2 byte。|
|            |                                   | [2:1]   | nrdma_data_use        | RW   | NRDMA读取的数据种类；<br>0：只需要MUL的操作数；<br>1：只需要ALU的操作数；<br>2：需要MUL和ALU的操作数；<br>3：保留。|
|            |                                   | 0       | nrdma_disable         | RW   | NRDMA是否关闭；<br>0：不关闭；<br>1：关闭。|
| 32'h8044   | sdp_rdma_d_bn_base_addr_low       |         |                       |      | NRDMA读数据基地址的低32位。                |
|            |                                   | [31:0]  | bn_base_addr_low      | RW   | NRDMA读取数据基地址的低32位。              |
| 32'h8048   | sdp_rdma_d_bn_base_addr_high      |         |                       |      | NRDMA读数据基地址的高32位。                |
|            |                                   | [31:0]  | bn_base_addr_high     | RW   | NRDMA读取数据基地址的高32位。              |
| 32'h804c   | sdp_rdma_d_bn_line_stride         |         |                       |      | NRDMA读数据相邻行之间的地址偏移。          |
|            |                                   | [31:0]  | bn_line_stride        | RW   | NRDMA读取数据时相邻行之间的地址偏移。      |
| 32'h8050   | sdp_rdma_d_bn_surface_stride      |         |                       |      | NRDMA读数据相邻surface之间的地址偏移。     |
|            |                                   | [31:0]  | bn_surface_stride     | RW   | NRDMA读取数据时相邻surface之间的地址偏移。 |
| 32'h8054   | sdp_rdma_d_bn_batch_stride        |         |                       |      | NRDMA读数据相邻batch之间的地址偏移。       |
|            |                                   | [31:0]  | bn_batch_stride       | RW   | NRDMA读取数据时相邻batch之间的地址偏移。   |
| 32'h8058   | sdp_rdma_d_erdma_cfg              |         |                       |      | ERDMA配置寄存器。                          |
|            |                                   | [31:6]  | reserved              | -    | reserved                                   |
|            |                                   | 5       | erdma_ram_type        | RW   | ERDMA读取数据时的memory类型；<br>0：SRAM；<br>1：DRAM；|
|            |                                   | 4       | erdma_data_mode       | RW   | ERDMA读取操作数的数据量；<br>0：每通道一个操作数（per kernel）；<br>1：每个输入数据一个操作数（per element）。|
|            |                                   | 3       | erdma_data_size       | RW   | ERDMA读取操作数的每个元素的位宽；<br>0：1 byte；<br>1：2 byte。|
|            |                                   | [2:1]   | erdma_data_use        | RW   | ERDMA读取的数据种类；<br>0：只需要MUL的操作数；<br>1：只需要ALU的操作数；<br>2：需要MUL和ALU的操作数；<br>3：保留。|
|            |                                   | 0       | erdma_disable         | RW   | ERDMA是否关闭；<br>0：不关闭；<br>1：关闭。|
| 32'h805c   | sdp_rdma_d_ew_base_addr_low       |         |                       |      | ERDMA读数据基地址的低32位。                |
|            |                                   | [31:0]  | ew_base_addr_low      | RW   | ERDMA读取数据基地址的低32位。              |
| 32'h8060   | sdp_rdma_d_ew_base_addr_high      |         |                       |      | ERDMA读数据基地址的高32位。                |
|            |                                   | [31:0]  | ew_base_addr_high     | RW   | ERDMA读取数据基地址的高32位。              |
| 32'h8064   | sdp_rdma_d_ew_line_stride         |         |                       |      | ERDMA读数据相邻行之间的地址偏移。          |
|            |                                   | [31:0]  | ew_line_stride        | RW   | ERDMA读取数据时相邻行之间的地址偏移。      |
| 32'h8068   | sdp_rdma_d_ew_surface_stride      |         |                       |      | ERDMA读数据相邻surface之间的地址偏移。     |
|            |                                   | [31:0]  | ew_surface_stride     | RW   | ERDMA读取数据时相邻surface之间的地址偏移。 |
| 32'h806c   | sdp_rdma_d_ew_batch_stride        |         |                       |      | ERDMA读数据相邻batch之间的地址偏移。       |
|            |                                   | [31:0]  | ew_batch_stride       | RW   | ERDMA读取数据时相邻batch之间的地址偏移。   |
| 32'h8070   | sdp_rdma_d_feature_mode_cfg       |         |                       |      | 运行模式配置寄存器。                       |
|            |                                   | [31:13] | reserved              | -    | reserved                                   |
|            |                                   | [12:8]  | batch_number          | RW   | batch数。                                  |
|            |                                   | [7:6]   | out_precision         | RW   | 输出数据的精度；<br>0：int8；<br>1：int16；<br>2：fp16；<br>3：保留。|
|            |                                   | [5:4]   | proc_precision        | RW   | 数据处理的精度；<br>0：int8；<br>1：int16；<br>2：fp16；<br>3：保留。|
|            |                                   | [3:2]   | in_precision          | RW   | 输入数据的精度；<br>0：int8；<br>1：int16；<br>2：fp16；<br>3：保留。|
|            |                                   | 1       | winograd              | RW   | 该位域没有用到。                           |
|            |                                   | 0       | flying_mode           | RW   | SDP的运行模式；<br>0：off-fly模式，输入来自DRAM或SRAM，此时MRDMA开启；<br>1：on-fly模式，输入来自前级的CACC模块，此时MRDMA关闭。|
| 32'h8074   | sdp_rdma_d_src_dma_cfg            |         |                       |      | memory类型配置寄存器。                     |
|            |                                   | [31:1]  | reserved              | -    | reserved                                   |
|            |                                   | 0       | src_ram_type          | RW   | MRDMA所读取的数据存储的memory类型；<br>0：SRAM；<br>1：DRAM。|
| 32'h8078   | sdp_rdma_d_status_nan_input_num   |         |                       |      | MRDMA输入数据中nan的数量。                 |
|            |                                   | [31:0]  | status_nan_input_num  | RO   | MRDMA输入数据中nan的数量，该寄存器未用到。 |
| 32'h807c   | sdp_rdma_d_status_inf_input_num   |         |                       |      | MRDMA输入数据中inf的数量                   |
|            |                                   | [31:0]  | status_inf_input_num  | RO   | MRDMA输入数据中inf的数量，该寄存器未用到。 |
| 32'h8080   | sdp_rdma_d_perf_enable            |         |                       |      | 性能统计使能。                             |
|            |                                   | [31:2]  | reserved              | -    | reserved                                   |
|            |                                   | 1       | perf_nan_inf_count_en | RW   | 该位域未用到。                             |
|            |                                   | 0       | perf_dma_en           | RW   | RDMA性能统计使能；<br>0：不使能；<br>1：使能。|
| 32'h8084   | sdp_rdma_d_perf_mrdma_read_stall  |         |                       |      | MRDMA读取数据时被阻塞的周期数。            |
|            |                                   | [31:0]  | mrdma_stall           | RO   | MRDMA读取数据时被阻塞的周期数。            |
| 32'h8088   | sdp_rdma_d_perf_brdma_read_stall  |         |                       |      | BRDMA读取数据时被阻塞的周期数。            |
|            |                                   | [31:0]  | brdma_stall           | RO   | BRDMA读取数据时被阻塞的周期数。            |
| 32'h808c   | sdp_rdma_d_perf_nrdma_read_stall  |         |                       |      | NRDMA读取数据时被阻塞的周期数。            |
|            |                                   | [31:0]  | nrdma_stall           | RO   | NRDMA读取数据时被阻塞的周期数。            |
| 32'h8090   | sdp_rdma_d_perf_erdma_read_stall  |         |                       |      | ERDMA读取数据时被阻塞的周期数。            |
|            |                                   | [31:0]  | erdma_stall           | RO   | ERDMA读取数据时被阻塞的周期数。            |


## SDP
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|------------------------------|------------------------------------|---------|--------------------------|------|-----------------------------------------------------|
| 32'h9000   | sdp_s_status                       |         |                          |      | 乒乓寄存器组状态寄存器。                               |
|            |                                    | [31:18] | reserved                 | -    | reserved                                               |
|            |                                    | [17:16] | status_1                 | RO   | 指示乒乓寄存器组1的状态，<br>0：寄存器组1空闲，可以配置；<br>1：寄存器组1正在被使用，配置无效；<br>2：寄存器组1已经配置完，但还未被使用；<br>3：保留。|
|            |                                    | [15:2]  | reserved                 | -    | reserved                                               |
|            |                                    | [1:0]   | status_0                 | RO   | 指示乒乓寄存器组0的状态，<br>0：寄存器组0空闲，可以配置；<br>1：寄存器组0正在被使用，配置无效；<br>2：寄存器组0已经配置完，但还未被使用；<br>3：保留。|
| 32'h9004   | sdp_s_pointer                      |         |                          |      | 乒乓寄存器组指针寄存器。                               |
|            |                                    | [31:17] | reserved                 | -    | reserved                                               |
|            |                                    | 16      | consumer                 | RO   | 指示数据通路执行计算用到的乒乓寄存器组；<br>0：当前使用的是寄存器组0；<br>1：当前使用的是寄存器组1。|
|            |                                    | [15:1]  | reserved                 | -    | reserved                                               |
|            |                                    | 0       | producer                 | RW   | 指示CPU配置的乒乓寄存器组：<br>0：CPU配置寄存器组0；<br>1：CPU配置寄存器组1。|
| 32'h9008   | sdp_s_lut_access_cfg               |         |                          |      | LUT访问配置寄存器。                                    |
|            |                                    | [31:18] | reserved                 | -    | reserved                                               |
|            |                                    | 17      | lut_access_type          | RW   | 选择对LUT的访问类型；<br>0：读LUT；<br>1：写LUT。      |
|            |                                    | 16      | lut_table_id             | RW   | 选择访问哪一张LUT表；<br>0：X lut（LE，linear/exponent）；<br>1：Y lut（LO，linear only）。|
|            |                                    | [15:10] | reserved                 | -    | reserved                                               |
|            |                                    | [9:0]   | lut_addr                 | RW   | 读写LUT的地址，<br>LE：0-64；<br>LO：0-256。           |
| 32'h900c   | sdp_s_lut_access_data              |         |                          |      | 当前LUT表项中的值。                                    |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:0]  | lut_data                 | RO   | LUT中表项的值。                                        |
| 32'h9010   | sdp_s_lut_cfg                      |         |                          |      | LUT配置寄存器。                                        |
|            |                                    | [31:7]  | reserved                 | -    | reserved                                               |
|            |                                    | 6       | lut_hybrid_priority      | RW   | 当两张LUT都命中或者一张发生向下溢出另一张发生向上溢出时选择哪一张LUT的输出作为最终输出；<br>0：选择X lut的输出；<br>1：选择Y lut的输出。|
|            |                                    | 5       | lut_oflow_priority       | RW   | 当两张LUT的输出都向上溢出时选择哪一张LUT的输出作为最终输出；<br>0：选择X lut的输出；<br>1：选择Y lut的输出。|
|            |                                    | 4       | lut_uflow_priority       | RW   | 当两张LUT的输出都向下溢出时选择哪一张LUT的输出作为最终输出；<br>0：选择X lut的输出；<br>1：选择Y lut的输出。|
|            |                                    | [3:1]   | reserved                 | -    | reserved                                               |
|            |                                    | 0       | lut_le_function          | RW   | LE LUT的工作模式；<br>0：指数LUT模式；<br>1：线性LUT模式。|
| 32'h9014   | sdp_s_lut_info                     |         |                          |      |                                                        |
|            |                                    | [31:24] | reserved                 | -    | reserved                                               |
|            |                                    | [23:16] | lut_lo_index_select      | RW   | LO LUT 查表index计算公式中的-M。                       |
|            |                                    | [15:8]  | lut_le_index_select      | RW   | LE LUT 线性模式查表index计算公式中的-M。               |
|            |                                    | [7:0]   | lut_le_index_offset      | RW   | LE LUT指数模式查表inde计算公式中的M+exp_start。        |
| 32'h9018   | sdp_s_lut_le_start                 |         |                          |      |                                                        |
|            |                                    | [31:0]  | lut_le_start             | RW   | LE LUT指数模式查表inde计算公式中的Sfin(linear_start-Oin)。 |
| 32'h901c   | sdp_s_lut_le_end                   |         |                          |      |                                                        |
|            |                                    | [31:0]  | lut_le_end               | RW   | LE LUT  inde的最大值。                                 |
| 32'h9020   | sdp_s_lut_lo_start                 |         |                          |      |                                                        |
|            |                                    | [31:0]  | lut_lo_start             | RW   | LO LUT 查表index计算公式中的Olut。                     |
| 32'h9024   | sdp_s_lut_lo_end                   |         |                          |      |                                                        |
|            |                                    | [31:0]  | lut_lo_end               | RW   | LO LUT  inde的最大值。                                 |
| 32'h9028   | sdp_s_lut_le_slope_scale           |         |                          |      |                                                        |
|            |                                    | [31:16] | lut_le_slope_oflow_scale | RW   | LE LUT发生overflow时计算输出的scale。                  |
|            |                                    | [15:0]  | lut_le_slope_uflow_scale | RW   | LE LUT发生underflow时计算输出的scale。                 |
| 32'h902c   | sdp_s_lut_le_slope_shift           |         |                          |      |                                                        |
|            |                                    | [31:10] | reserved                 | -    | reserved                                               |
|            |                                    | [9:5]   | lut_le_slope_oflow_shift | RW   | LE LUT发生overflow时计算输出的shift。                  |
|            |                                    | [4:0]   | lut_le_slopw_uflow_shift | RW   | LE LUT发生underflow时计算输出的shift。                 |
| 32'h9030   | sdp_s_lut_lo_slope_scale           |         |                          |      |                                                        |
|            |                                    | [31:16] | lut_lo_slope_oflow_scale | RW   | LO LUT发生overflow时计算输出的scale。                  |
|            |                                    | [15:0]  | lut_lo_slope_uflow_scale | RW   | LO LUT发生underflow时计算输出的scale。                 |
| 32'h9034   | sdp_s_lut_lo_slope_shift           |         |                          |      |                                                        |
|            |                                    | [31:10] | reserved                 | -    | reserved                                               |
|            |                                    | [9:5]   | lut_lo_slope_oflow_shift | RW   | LO LUT发生overflow时计算输出的shift。                  |
|            |                                    | [4:0]   | lut_lo_slopw_uflow_shift | RW   | LO LUT发生underflow时计算输出的shift。                 |
| 32'h9038   | sdp_d_op_enable                    |         |                          |      | SDP使能。                                              |
|            |                                    | [31:1]  | reserved                 | -    | reserved                                               |
|            |                                    | 0       | op_en                    | RW   | SDP使能（该寄存器的读出值与写入值不一定相同）；<br>0：不使能；<br>1：使能。|
| 32'h903c   | sdp_d_data_cube_width              |         |                          |      | 输入数据的宽度。                                       |
|            |                                    | [31:13] | reserved                 | -    | reserved                                               |
|            |                                    | [12:0]  | width                    | RW   | SDP输入数据的宽度，减1配置。                           |
| 32'h9040   | sdp_d_data_cube_height             |         |                          |      | 输入数据的高度。                                       |
|            |                                    | [31:13] | reserved                 | -    | reserved                                               |
|            |                                    | [12:0]  | height                   | RW   | SDP输入数据的高度，减1配置。                           |
| 32'h9044   | sdp_d_data_cube_channel            |         |                          |      | 输入数据的通道数。                                     |
|            |                                    | [31:13] | reserved                 | -    | reserved                                               |
|            |                                    | [12:0]  | channel                  | RW   | SDP输入数据的通道数，减1配置。                         |
| 32'h9048   | sdp_d_dst_base_addr_low            |         |                          |      | 输出数据写出目的地址的低32位。                         |
|            |                                    | [31:0]  | dst_base_addr_low        | RW   | 输出数据写出目的地址的低32位。                         |
| 32'h904c   | sdp_d_dst_base_addr_high           |         |                          |      | 输出数据写出目的地址的低32位。                         |
|            |                                    | [31:0]  | dst_base_addr_high       | RW   | 输出数据写出目的地址的高32位。                         |
| 32'h9050   | sdp_d_dst_line_stride              |         |                          |      | 输出数据写出时相邻行之间的地址偏移。                   |
|            |                                    | [31:0]  | dst_line_stride          | RW   | 输出数据写出时相邻行之间的地址偏移。                   |
| 32'h9054   | sdp_d_dst_surface_stride           |         |                          |      | 输出数据写出时相邻surface之间的地址偏移。              |
|            |                                    | [31:0]  | dst_surface_stride       | RW   | 输出数据写出时相邻surface之间的地址偏移。              |
| 32'h9058   | sdp_d_dp_bs_cfg                    |         |                          |      | X1（BS）配置寄存器。                                   |
|            |                                    | [31:7]  | reserved                 | -    | reserved                                               |
|            |                                    | 6       | bs_relu_bypass           | RW   | BS中的Relu计算是否bypass；<br>0：不bypass，开启Relu计算；<br>1：bypass。|
|            |                                    | 5       | bs_mul_prelu             | RW   | BS中的MUL计算（乘系数）是否是Prelu计算；<br>0：不是PRelu；<br>1：是PRelu。|
|            |                                    | 4       | bs_mul_bypass            | RW   | BS中的MUL计算（乘系数）是否bypass；<br>0：不bypass，开启MUL计算；<br>1：bypass。|
|            |                                    | [3:2]   | bs_alu_algo              | RW   | BS中的ALU计算的运算类型；<br>0：求最大值；<br>1：求最小值；<br>2：加bias；<br>3：保留。|
|            |                                    | 1       | bs_alu_bypass            | RW   | BS中的ALU计算（最大/最小/加bias）是否bypass；<br>0：不bypass，开启ALU计算；<br>1：bypass。|
|            |                                    | 0       | bs_bypass                | RW   | X1（BS）模块是否bypass；<br>0：不bypass，开启BS模块；<br>1：bypass。|
| 32'h905c   | sdp_d_dp_bs_alu_cfg                |         |                          |      | BS中ALU运算的配置。                                    |
|            |                                    | [31:14] | reserved                 | -    | reserved                                               |
|            |                                    | [13:8]  | bs_alu_shift_value       | RW   | BS中ALU计算操作数（除主通路的数据之外的另一路输入）的左移位数。|
|            |                                    | [7:1]   | reserved                 | RW   | reserved                                               |
|            |                                    | 0       | bs_alu_src               | RW   | BS中ALU计算操作数（除主通路的数据之外的另一路输入）的来源；<br>0：来源于寄存器配置；<br>1：来源于SRAM或DRAM。|
| 32'h9060   | sdp_d_dp_bs_alu_src_value          |         |                          |      | BS中ALU运算的操作数。                                  |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:0]  | bs_alu_operand           | RW   | BS中ALU计算的操作数。                                  |
| 32'h9064   | sdp_d_dp_bs_mul_cfg                |         |                          |      | BS中MUL运算的配置。                                    |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:8]  | bs_mul_shift_value       | RW   | BS中ALU计算的右移位数。                                |
|            |                                    | [7:1]   | reserved                 | RW   | reserved                                               |
|            |                                    | 0       | bs_mul_src               | RW   | BS中MUL计算操作数（除主通路的数据之外的另一路输入）的来源；<br>0：来源于寄存器配置；<br>1：来源于SRAM或DRAM。|
| 32'h9068   | sdp_d_dp_bs_mul_src_value          |         |                          |      | BS中MUL计算的操作数。                                  |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:0]  | bs_mul_operand           | RW   | BS中MUL计算的操作数。                                  |
| 32'h906c   | sdp_d_dp_bn_cfg                    |         |                          |      | X2（BN）配置寄存器。                                   |
|            |                                    | [31:7]  | reserved                 | -    | reserved                                               |
|            |                                    | 6       | bn_relu_bypass           | RW   | BN中的Relu计算是否bypass；<br>0：不bypass，开启Relu计算；<br>1：bypass。|
|            |                                    | 5       | bn_mul_prelu             | RW   | BN中的MUL计算（乘系数）是否是Prelu计算；<br>0：不是PRelu；<br>1：是PRelu。|
|            |                                    | 4       | bn_mul_bypass            | RW   | BN中的MUL计算（乘系数）是否bypass；<br>0：不bypass，开启MUL计算；<br>1：bypass。|
|            |                                    | [3:2]   | bn_alu_algo              | RW   | BN中的ALU计算的运算类型；<br>0：求最大值；<br>1：求最小值；<br>2：加bias；<br>3：保留。|
|            |                                    | 1       | bn_alu_bypass            | RW   | BN中的ALU计算（最大/最小/加bias）是否bypass；<br>0：不bypass，开启ALU计算；<br>1：bypass。|
|            |                                    | 0       | bn_bypass                | RW   | X2（BN）模块是否bypass；<br>0：不bypass，开启BN模块；<br>1：bypass。|
| 32'h9070   | sdp_d_dp_bn_alu_cfg                |         |                          |      | BN中ALU运算的配置。                                    |
|            |                                    | [31:14] | reserved                 | -    | reserved                                               |
|            |                                    | [13:8]  | bn_alu_shift_value       | RW   | BN中ALU计算操作数（除主通路的数据之外的另一路输入）的左移位数。|
|            |                                    | [7:1]   | reserved                 | RW   | reserved                                               |
|            |                                    | 0       | bn_alu_src               | RW   | BN中ALU计算操作数（除主通路的数据之外的另一路输入）的来源；<br>0：来源于寄存器配置；<br>1：来源于SRAM或DRAM。|
| 32'h9074   | sdp_d_dp_bn_alu_src_value          |         |                          |      | BN中ALU运算的操作数。                                  |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:0]  | bn_alu_operand           | RW   | BN中ALU计算的操作数。                                  |
| 32'h9078   | sdp_d_dp_bn_mul_cfg                |         |                          |      | BN中MUL运算的配置。                                    |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:8]  | bn_mul_shift_value       | RW   | BN中ALU计算的右移位数。                                |
|            |                                    | [7:1]   | reserved                 | RW   | reserved                                               |
|            |                                    | 0       | bn_mul_src               | RW   | BN中MUL计算操作数（除主通路的数据之外的另一路输入）的来源；<br>0：来源于寄存器配置；<br>1：来源于SRAM或DRAM。|
| 32'h907c   | sdp_d_dp_bn_mul_src_value          |         |                          |      | BN中MUL运算的操作数。                                  |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:0]  | bn_mul_operand           | RW   | BN中MUL计算的操作数。                                  |
| 32'h9080   | sdp_d_dp_ew_cfg                    |         |                          |      | Y（EW）配置寄存器。                                    |
|            |                                    | [31:7]  | reserved                 | -    | reserved                                               |
|            |                                    | 6       | ew_lut_bypass            | RW   | EW中的LUT模块是否bypass；<br>0：不bypass，开启LUT计算；<br>1：bypass。|
|            |                                    | 5       | ew_mul_prelu             | RW   | EW中的MUL计算（乘系数）是否是Prelu计算；<br>0：不是PRelu；<br>1：是PRelu。|
|            |                                    | 4       | ew_mul_bypass            | RW   | EW中的MUL计算（乘系数）是否bypass；<br>0：不bypass，开启MUL计算；<br>1：bypass。|
|            |                                    | [3:2]   | ew_alu_algo              | RW   | EW中的ALU计算的运算类型；<br>0：求最大值；<br>1：求最小值；<br>2：加bias；<br>3：判断是否相等。|
|            |                                    | 1       | ew_alu_bypass            | RW   | EW中的ALU计算（最大/最小/加bias/判断是否相等）是否bypass；<br>0：不bypass，开启ALU计算；<br>1：bypass。|
|            |                                    | 0       | ew_bypass                | RW   | Y（EW）模块是否bypass；<br>0：不bypass，开启EW模块；<br>1：bypass。|
| 32'h9084   | sdp_d_dp_ew_alu_cfg                |         |                          |      | EW中ALU运算的配置。                                    |
|            |                                    | [31:2]  | reserved                 | -    | reserved                                               |
|            |                                    | 1       | ew_alu_cvt_bypass        | RW   | EW中对ALU计算操作数（除主通路的数据之外的另一路输入）进行convert的计算是否bypass；<br>0：不bypass，对ALU的操作数进行convert；<br>1：bypass。|
|            |                                    | 0       | ew_alu_src               | RW   | EW中ALU计算操作数（除主通路的数据之外的另一路输入）的来源；<br>0：来源于寄存器配置；<br>1：来源于SRAM或DRAM。|
| 32'h9088   | sdp_d_dp_ew_alu_src_value          |         |                          |      | EW中ALU运算的操作数。                                  |
|            |                                    | [31:0]  | ew_alu_operand           | RW   | EW中ALU计算的操作数。                                  |
| 32'h908c   | sdp_d_dp_ew_alu_cvt_offset_value   |         |                          |      | EW ALU convert的offset。                               |
|            |                                    | [31:0]  | ew_alu_cvt_offset        | RW   | EW中对ALU计算操作数（除主通路的数据之外的另一路输入）进行convert的offset。|
| 32'h9090   | sdp_d_dp_ew_alu_cvt_scale_value    |         |                          |      | EW ALU convert的scale。                                |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:0]  | ew_alu_cvt_scale         | RW   | EW中对ALU计算操作数（除主通路的数据之外的另一路输入）进行convert的scale。|
| 32'h9094   | sdp_d_dp_ew_alu_cvt_truncate_value |         |                          |      | EW ALU convert的右移位数。                             |
|            |                                    | [31:6]  | reserved                 | -    | reserved                                               |
|            |                                    | [5:0]   | ew_alu_cvt_truncate      | RW   | EW中对ALU计算操作数（除主通路的数据之外的另一路输入）进行convert的右移位数。|
| 32'h9098   | sdp_d_dp_ew_mul_cfg                |         |                          |      | EW中MUL运算的配置。                                    |
|            |                                    | [31:2]  | reserved                 | -    | reserved                                               |
|            |                                    | 1       | ew_mul_cvt_bypass        | RW   | EW中对MUL计算操作数（除主通路的数据之外的另一路输入）进行convert的计算是否bypass；<br>0：不bypass，对MUL的操作数进行convert；<br>1：bypass。|
|            |                                    | 0       | ew_mul_src               | RW   | EW中MUL计算操作数（除主通路的数据之外的另一路输入）的来源；<br>0：来源于寄存器配置；<br>1：来源于SRAM或DRAM。|
| 32'h909c   | sdp_d_dp_ew_mul_src_value          |         |                          |      | EW中MUL运算的操作数。                                  |
|            |                                    | [31:0]  | ew_mul_operand           | RW   | EW中MUL计算的操作数。                                  |
| 32'h90a0   | sdp_d_dp_ew_mul_cvt_offset_value   |         |                          |      | EW MUL convert的offset。                               |
|            |                                    | [31:0]  | ew_mul_cvt_offset        | RW   | EW中对MUL计算操作数（除主通路的数据之外的另一路输入）进行convert的offset。|
| 32'h90a4   | sdp_d_dp_ew_mul_cvt_scale_value    |         |                          |      | EW MUL convert的scale。                                |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:0]  | ew_mul_cvt_scale         | RW   | EW中对MUL计算操作数（除主通路的数据之外的另一路输入）进行convert的scale。|
| 32'h90a8   | sdp_d_dp_ew_mul_cvt_truncate_value |         |                          |      | EW MUL convert的右移位数。                             |
|            |                                    | [31:6]  | reserved                 | -    | reserved                                               |
|            |                                    | [5:0]   | ew_mul_cvt_truncate      | RW   | EW中对MUL计算操作数（除主通路的数据之外的另一路输入）进行convert的右移位数。|
| 32'h90ac   | sdp_d_dp_ew_truncate_value         |         |                          |      | EW MUL的右移位数。                                     |
|            |                                    | [31:10] | reserved                 | -    | reserved                                               |
|            |                                    | [9:0]   | ew_truncate              | RW   | EW中MUL运算的右移位数。                                |
| 32'h90b0   | sdp_d_feature_mode_cfg             |         |                          |      | 运行模式配置。                                         |
|            |                                    | [31:7]  | reserved                 | -    | reserved                                               |
|            |                                    | [12:8]  | batch_number             | RW   | batch数。                                              |
|            |                                    | [7:4]   | reserved                 | -    | reserved                                               |
|            |                                    | 3       | nan_to_zero              | RW   | 该位域没用到。                                         |
|            |                                    | 2       | winograd                 | RW   | 该位域没用到。                                         |
|            |                                    | 1       | output_dst               | RW   | SDP输出数据的写出目的地；<br>0：由SDP_WDMA模块写出到DRAM或SRAM；<br>1：输出给后级模块。|
|            |                                    | 0       | flying_mode              | RW   | SDP的运行模式；<br>0：off-fly模式，输入来自DRAM或SRAM；<br>1：on-fly模式，输入来自前级的CACC模块。|
| 32'h90b4   | sdp_d_dst_dma_cfg                  |         |                          |      | 数据写出时memory的类型。                               |
|            |                                    | [31:1]  | reserved                 | -    | reserved                                               |
|            |                                    | 0       | dst_ram_type             | RW   | 写出数据时memory的类型；<br>0：SRAM；<br>1：DRAM。     |
| 32'h90b8   | sdp_d_dst_batch_stride             |         |                          |      | 写出数据相邻batch之间的地址偏移。                      |
|            |                                    | [31:0]  | dst_batch_stride         | RW   | 写出数据时相邻batch之间的地址偏移。                    |
| 32'h90bc   | sdp_d_data_format                  |         |                          |      | 数据格式配置。                                         |
|            |                                    | [31:4]  | reserved                 | -    | reserved                                               |
|            |                                    | [3:2]   | out_precision            | RW   | 输出数据的精度；<br>0：int8；<br>1：int16；<br>2：fp16；<br>3：保留。|
|            |                                    | [1:0]   | proc_precision           | RW   | 数据处理精度；<br>0：int8；<br>1：int16；<br>2：fp16；<br>3：保留。|
| 32'h90c0   | sdp_d_cvt_offset                   |         |                          |      | SDP convertor的offset。                                |
|            |                                    | [31:0]  | cvt_offset               | RW   | 对SDP的输出进行convert的offset。                       |
| 32'h90c4   | sdp_d_cvt_scale                    |         |                          |      | SDP convertor的scale。                                 |
|            |                                    | [31:16] | reserved                 | -    | reserved                                               |
|            |                                    | [15:0]  | cvt_scale                | RW   | 对SDP的输出进行convert的scale。                        |
| 32'h90c8   | sdp_d_cvt_shift                    |         |                          |      | SDP convertor的右移位数。                              |
|            |                                    | [31:6]  | reserved                 | -    | reserved                                               |
|            |                                    | [5:0]   | cvt_shift                | RW   | 对SDP的输出进行convert的右移位数。                     |
| 32'h90cc   | sdp_d_status                       |         |                          |      | SDP输出数据的状态。                                    |
|            |                                    | [31:1]  | reserved                 | -    | reserved                                               |
|            |                                    | 0       | status_unequal           | RO   | SDP的输出数据是否全是0；<br>0：全是0；<br>1：有非零值。|
| 32'h90d0   | sdp_d_status_nan_input_num         |         |                          |      | 输入数据中nan的数量。                                  |
|            |                                    | [31:0]  | status_nan_input_num     | RO   | 输入数据中nan的数量，该寄存器未用到。                  |
| 32'h90d4   | sdp_d_status_inf_input_num         |         |                          |      | 输入数据中inf的数量。                                  |
|            |                                    | [31:0]  | status_inf_input_num     | RO   | 输入数据中inf的数量，该寄存器未用到。                  |
| 32'h90d8   | sdp_d_status_nan_output_num        |         |                          |      | 输出数据中nan的数量。                                  |
|            |                                    | [31:0]  | status_nan_output_num    | RO   | 输出数据中nan的数量，该寄存器未用到。                  |
| 32'h90dc   | sdp_d_perf_enable                  |         |                          |      | 性能统计使能。                                         |
|            |                                    | [31:4]  | reserved                 | -    | reserved                                               |
|            |                                    | 3       | perf_nan_inf_count_en    | RW   | 该位域没用到。                                         |
|            |                                    | 2       | perf_sat_en              | RW   | SDP输出饱和数据统计使能；<br>0：不使能；<br>1：使能。  |
|            |                                    | 1       | perf_lut_en              | RW   | LUT性能统计使能；<br>0：不使能；<br>1：使能。          |
|            |                                    | 0       | perf_dma_en              | RW   | WDMA性能统计使能；<br>0：不使能；<br>1：使能。         |
| 32'h90e0   | sdp_d_perf_wdma_write_stall        |         |                          |      | 写出数据时被阻塞的周期数。                             |
|            |                                    | [31:0]  | wdma_stall               | RO   | WDMA写出数据时被阻塞的周期数。                         |
| 32'h90e4   | sdp_d_perf_lut_uflow               |         |                          |      | 查表时（选择最为最终结果的LUT表）发生向下溢出的次数。  |
|            |                                    | [31:0]  | lut_uflow                | RO   | 查表时（选择作为最终结果的LUT表）发生向下溢出的次数。  |
| 32'h90e8   | sdp_d_perf_lut_oflow               |         |                          |      | 查表时（选择最为最终结果的LUT表）发生向上溢出的次数。  |
|            |                                    | [31:0]  | lut_oflow                | RO   | 查表时（选择最为最终结果的LUT表）发生向上溢出的次数。  |
| 32'h90ec   | sdp_d_perf_out_saturation          |         |                          |      | 输出数据中饱和数据的数量。                             |
|            |                                    | [31:0]  | out_saturation           | RO   | SDP输出数据中饱和数据的数量。                          |
| 32'h90f0   | sdp_d_perf_lut_hybrid              |         |                          |      | 两张LUT都命中或只命中一张LUT的次数。                   |
|            |                                    | [31:0]  | lut_hybrid               | RO   | 两张LUT都命中或只命中一张LUT的次数。                   |
| 32'h90f4   | sdp_d_perf_lut_le_hit              |         |                          |      | 命中X lut的次数。                                      |
|            |                                    | [31:0]  | lut_le_hit               | RO   | 命中X lut的次数。                                      |
| 32'h90f8   | sdp_d_perf_lut_lo_hit              |         |                          |      | 命中Y lut的次数。                                      |
|            |                                    | [31:0]  | lut_lo_hit               | RO   | 命中Y lut的次数。                                      |


## CVIF
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|----------------|--------------------------|---------|--------------------|------|--------------------------------------------------------------|
| 32'hf000   | mcif_cfg_rd_weight_0     |         |                    |      | 读通道各master的权重，读通道的仲裁采用WRR（weighted round robin，带权重的轮询），该寄存器配置各模块的权重。|
|            |                          | [31:24] | rd_weight_cdp      | RW   | CDP（master 7）的权重，默认值为1。                                      |
|            |                          | [23:16] | rd_weight_pdp      | RW   | PDP（master 6）的权重，默认值为1。                                      |
|            |                          | [15:8]  | rd_weight_sdp      | RW   | SDP（master 2）的权重，默认值为1。                                      |
|            |                          | [7:0]   | rd_weight_bdma     | RW   | BDMA（master 8）的权重，默认值为1。                                     |
| 32'hf004   | mcif_cfg_rd_weight_1     |         |                    |      | 读通道各master的权重。                                                  |
|            |                          | [31:24] | rd_weight_cdma_dat | RW   | CDMA_DAT（master 0）的权重，默认值为1。                                 |
|            |                          | [23:16] | rd_weight_sdp_e    | RW   | SDP_E（master 5）的权重，默认值为1。                                    |
|            |                          | [15:8]  | rd_weight_sdp_n    | RW   | SDP_N（master 4）的权重，默认值为1。                                    |
|            |                          | [7:0]   | rd_weight_sdp_b    | RW   | SDP_B（master 3）的权重，默认值为1。                                    |
| 32'hf008   | mcif_cfg_rd_weight_2     |         |                    |      | 读通道各master的权重。                                                  |
|            |                          | [31:16] | reserved           | -    | reserved                                                                |
|            |                          | [15:8]  | rd_weight_rbk      | RW   | RUBIK的权重，默认值为1，当前版本不支持RUBIK。                           |
|            |                          | [7:0]   | rd_weight_cdma_wt  | RW   | CDMA_WEIGHT（master 1）的权重，默认值为1。                              |
| 32'hf00c   | mcif_cfg_wr_weight_0     |         |                    |      | 写通道各master的权重，写通道的仲裁采用WRR（weighted round robin，带权重的轮询），该寄存器配置各master的权重。|
|            |                          | [31:24] | wr_weight_cdp      | RW   | CDP（master 2）的权重，默认值为1。                                      |
|            |                          | [23:16] | wr_weight_pdp      | RW   | PDP（master 1）的权重，默认值为1。                                      |
|            |                          | [15:8]  | wr_weight_sdp      | RW   | SDP（master 0）的权重，默认值为1。                                      |
|            |                          | [7:0]   | wr_weight_bdma     | RW   | BDMA（master 3）的权重，默认值为1。                                     |
| 32'hf010   | mcif_cfg_wr_weight_1     |         |                    |      | 写通道各master的权重。                                                  |
|            |                          | [31:8]  | reserved           | -    | reserved                                                                |
|            |                          | [7:0]   | wr_weight_rbk      | RW   | RUBIK的权重，默认值为1，当前版本不支持RUBIK。                           |
| 32'hf014   | mcif_cfg_outstanding_cnt |         |                    |      | outstanding配置寄存器。                                                 |
|            |                          | [31:16] | reserved           | -    | reserved                                                                |
|            |                          | [15:8]  | wr_os_cnt          | RW   | 写通道的outstanding，默认值是255。                                      |
|            |                          | [7:0]   | rd_os_cnt          | RW   | 读通道的outstanding，默认值是255。                                      |
| 32'hf018   | mcif_status              |         |                    |      | 状态寄存器。                                                            |
|            |                          | [31:16] | reserved           | -    | reserved                                                                |
|            |                          | 8       | idle               | RO   | 该位域的值固定为1，没有实际作用。                                       |
|            |                          | [7:0]   | reserved           | -    | reserved                                                                |



## BDMA
| 寄存器地址 &emsp;&emsp;&emsp;&emsp;&emsp; | 寄存器名称 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | Bits &emsp;&emsp;&emsp; | 位域名 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; | 读写属性 &emsp;&emsp;&emsp;&emsp; | 描述 |
|------------|------------------------------|---------|--------------------------------------|------|-----------------------------------------------------------|
| 32'h1_0000 | bdma_cfg_src_addr_low        |         |                                      |      |                                                           |
|            |                              | [31:5]  | bdma_cfg_src_addr_low                | RW   | 源地址的[31:5]bit（最低5bit补零），源地址应该32byte对齐。 |
|            |                              | [4:0]   | reserved                             | -    | reserved                                                  |
| 32'h1_0004 | bdma_cfg_src_addr_high       |         |                                      |      |                                                           |
|            |                              | [31:0]  | bdma_cfg_src_addr_high               | RW   | 源地址的[63:32]bit。                                      |
| 32'h1_0008 | bdma_cfg_dst_addr_low        |         |                                      |      |                                                           |
|            |                              | [31:5]  | bdma_cfg_dst_addr_low                | RW   | 目的地址的[31:5]bit（最低5bit补零），目的地址应该32byte对齐。|
|            |                              | [4:0]   | reserved                             | -    | reserved                                                  |
| 32'h1_000c | bdma_cfg_dst_addr_high       |         |                                      |      |                                                           |
|            |                              | [31:0]  | bdma_cfg_dst_addr_high               | RW   | 目的地址的[63:32]bit。                                    |
| 32'h1_0010 | bdma_cfg_line                |         |                                      |      |                                                           |
|            |                              | [31:13] | reserved                             | -    | reserved                                                  |
|            |                              | [12:0]  | bdma_cfg_line_0_size                 | RW   | line的数据量，以32byte为单位，真实值减1配置。             |
| 32'h1_0014 | bdma_cfg_cmd                 |         |                                      |      |                                                           |
|            |                              | [31:2]  | reserved                             | -    | reserved                                                  |
|            |                              | 1       | bdma_cfg_cmd_0_dst_ram_type          | RW   | 数据搬移目的地的memory的类型；<br>0：SRAM；<br>1：DRAM；  |
|            |                              | 0       | bdma_cfg_cmd_0_src_ram_type          | RW   | 存储源数据memory的类型；<br>0：SRAM；<br>1：DRAM；        |
| 32'h1_0018 | bdma_cfg_line_repeat         |         |                                      |      |                                                           |
|            |                              | [31:24] | reserved                             | -    | reserved                                                  |
|            |                              | [23:0]  | bdma_cfg_line_repeat_0_number        | RW   | 一个surface之内line的数量，减1配置。                      |
| 32'h1_001c | bdma_cfg_src_line            |         |                                      |      |                                                           |
|            |                              | [31:5]  | bdma_cfg_src_line_0_stride           | RW   | 源数据存储时相邻line之间的地址偏移，以32byte为单位，该偏移应该32byte对齐。|
|            |                              | [4:0]   | reserved                             | -    | reserved                                                  |
| 32'h1_0020 | bdma_cfg_dst_line            |         |                                      |      |                                                           |
|            |                              | [31:5]  | bdma_cfg_dst_line_0_stride           | RW   | 将数据写出到目的memory时相邻line之间的地址偏移，以32byte为单位，该偏移应该32byte对齐。|
|            |                              | [4:0]   | reserved                             | -    | reserved                                                  |
| 32'h1_0024 | bdma_cfg_surf_repeat         |         |                                      |      |                                                           |
|            |                              | [31:24] | reserved                             | -    | reserved                                                  |
|            |                              | [23:0]  | bdma_cfg_surf_repeat_0_number        | RW   | 整个传输过程中surface的数量，减1配置。                    |
| 32'h1_0028 | bdma_cfg_src_surf            |         |                                      |      |                                                           |
|            |                              | [31:5]  | bdma_cfg_src_surf_0_stride           | RW   | 源数据存储时相邻surface之间的地址偏移，以32byte为单位，该偏移应该32byte对齐。|
|            |                              | [4:0]   | reserved                             | -    | reserved                                                  |
| 32'h1_002c | bdma_cfg_dst_surf            |         |                                      |      |                                                           |
|            |                              | [31:5]  | bdma_cfg_dst_surf_0_stride           | RW   | 将数据写出到目的memory时相邻surface之间的地址偏移，以32byte为单位，该偏移应该32byte对齐。|
|            |                              | [4:0]   | reserved                             | -    | reserved                                                  |
| 32'h1_0030 | bdma_cfg_op                  |         |                                      |      |                                                           |
|            |                              | [31:1]  | reserved                             | -    | reserved                                                  |
|            |                              | 0       | bdma_cfg_op_0_en                     | RW   | BDMA使能；<br>0：不使能；<br>1：使能。                    |
| 32'h1_0034 | bdma_cfg_launch0             |         |                                      |      |                                                           |
|            |                              | [31:1]  | reserved                             | -    | reserved                                                  |
|            |                              | 0       | bdma_cfg_launch0_0_grp0_launch       | RW   | 启动group0的传输。                                        |
| 32'h1_0038 | bdma_cfg_launch1             |         |                                      |      |                                                           |
|            |                              | [31:1]  | reserved                             | -    | reserved                                                  |
|            |                              | 0       | bdma_cfg_launch1_0_grp1_launch       | RW   | 启动group1的传输。                                        |
| 32'h1_003c | bdma_cfg_status              |         |                                      |      |                                                           |
|            |                              | [31:1]  | reserved                             | -    | reserved                                                  |
|            |                              | 0       | bdma_cfg_status_0_stall_count_en     | RW   | 统计DMA读写被阻塞周期数的使能；<br>0：不使能；<br>1：使能。|
| 32'h1_0040 | bdma_status                  |         |                                      |      |                                                           |
|            |                              | [31:11] | reserved                             | -    | reserved                                                  |
|            |                              | 10      | bdma_status_0_grp1_busy              | RO   | group1正在进行数据传输。                                  |
|            |                              | 9       | bdma_status_0_grp0_busy              | RO   | group0正在进行数据传输。                                  |
|            |                              | 8       | bdma_status_0_idle                   | RO   | BDMA空闲标志。                                            |
|            |                              | [7:0]   | bdma_status_0_free_slot              | RO   | BDMA内部命令FIFO空闲的存储单元数。                        |
| 32'h1_0044 | bdma_status_grp0_read_stall  |         |                                      |      |                                                           |
|            |                              | [31:0]  | bdma_status_grp0_read_stall_0_count  | RO   | group0在读数时被阻塞的周期数。                            |
| 32'h1_0048 | bdma_status_grp0_write_stall |         |                                      |      |                                                           |
|            |                              | [31:0]  | bdma_status_grp0_write_stall_0_count | RO   | group0在写数时被阻塞的周期数。                            |
| 32'h1_004c | bdma_status_grp1_read_stall  |         |                                      |      |                                                           |
|            |                              | [31:0]  | bdma_status_grp1_read_stall_0_count  | RO   | group1在读数时被阻塞的周期数。                            |
| 32'h1_0050 | bdma_status_grp1_write_stall |         |                                      |      |                                                           |
|            |                              | [31:0]  | bdma_status_grp1_write_stall_0_count | RO   | group1在写数时被阻塞的周期数。                            |
