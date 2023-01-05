// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba    <zarubaf@iis.ee.ethz.ch>, ETH Zurich
//         Michael Schaffner <schaffner@iis.ee.ethz.ch>, ETH Zurich
// Date: 15.08.2018
// Description: SRAM wrapper for FPGA (requires the fpga-support submodule)
//
// Note: the wrapped module contains two different implementations for
// ALTERA and XILINX tools, since these follow different coding styles for
// inferrable RAMS with byte enable. define `FPGA_TARGET_XILINX or
// `FPGA_TARGET_ALTERA in your build environment (default is ALTERA)

module lmu_ram #(
    parameter NUM_WORDS  = 1024,
    parameter OUT_REGS   = 0     // enables output registers in FPGA macro (read lat = 2)
)(
   input  logic                          clk_i,
   input  logic                          rst_ni,
   input  logic                          req_i,
   input  logic                          we_i,
   input  logic [$clog2(NUM_WORDS)-1:0]  addr_i,
   input  logic [32-1:0]                 wdata_i,
   input  logic [(32+7)/8-1:0]           be_i,
   output logic [32-1:0]                 rdata_o
);


`ifdef  USE_BEHAVIOR_MODEL

// unused byte-enable segments (8bits) are culled by the tool
SyncSpRamBeNx32 #(
  .ADDR_WIDTH($clog2(NUM_WORDS)),
  .DATA_DEPTH(NUM_WORDS),
  .OUT_REGS (0),
  // this initializes the memory with 0es. adjust to taste...
  // 0: no init, 1: zero init, 2: random init, 3: deadbeef init
  .SIM_INIT (0)
) i_ram (
    .Clk_CI    ( clk_i                     ),
    .Rst_RBI   ( rst_ni                    ),
    .CSel_SI   ( req_i                     ),
    .WrEn_SI   ( we_i                      ),
    .BEn_SI    ( be_i                      ),
    .WrData_DI ( wdata_i                   ),
    .Addr_DI   ( addr_i                    ),
    .RdData_DO ( rdata_o                   )
);

`else

  `ifdef  USE_FPGA_DESIGN
  wire [3:0] byte_en = {be_i[3] & we_i, be_i[2] & we_i, be_i[1] & we_i, be_i[0] & we_i};

  sram1048576x32 sram_1048576x32_inst
  (
      .clka(clk_i),
      .ena(req_i),
      .wea(byte_en),
      .addra(addr_i),
      .dina(wdata_i),
      .douta(rdata_o)
    );

  `else 

  $display("LMU_RAM : either USE_BEHAVIOR_MODEL or USE_FPGA_DESIGN shoule be defined !!! ");

  `endif 
`endif


endmodule 


