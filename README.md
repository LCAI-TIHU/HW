# LCAI-TIHU HARDWARE
## Introduction  

TIHU-HW is an AI inference processor. TIHU SoC is comprised of RISC-V cpu, nvdla, NoC bus, PCIe module, DDR, SRAM, bootROM, DMA and peripherals.  

SOC parameters:  
* Support RISC-V instruction set: RV64gcv0p10;
* RISCV vector config: 1024-bit vector length, up to 128-bits of data per cycle;
* Nvdla config:  bdma + conv(64*32 int8 data per cycle) + sdp(128-bits);
* Memory: DDR -- 2GB, SRAM -- 4MB, ROM -- 128KB;
* SoC frequency: 20MHz;  
* SoC systerm: baremetal;
* Debug: uart, baud rate is 115200;

<div align=center>
<img src="https://github.com/LCAI-TIHU/SW/blob/main/doc/AIPU_structure.png" width="600" height="300" alt="TIHU"/><br/>
</div>

TIHU is tested based on the FPGA board F37X, the host can be a server or a PC, and the board is installed on the PCIe slot of the host. Each sub-module in the AI processor is interconnected through the on-chip network NOC. Modules with high data throughput and high data rate, such as PCIe bridge module, RISC-V core, DMA controller, MAC unit, DDR controller, LMU RAM, are interconnected through high-bandwidth Core-NOC. Modules with low data throughput and low data rate,such as JTAG2AHB module, SCU, WDT, UART, Timer, LMU ROM, are interconnected through the low bandwidth unCore-NOC.  

The function of the PCIe bridge module is to convert the PCIe interface into an AXI interface and an AXI-Lite interface, which is implemented by the XDMA IP provided by Xilinx. The AXI interface enables high-speed transmission of large amounts of data. The AXI-Lite interface enables the low-speed transmission of small amounts of data. In addition, the PCIe bridge module can also receive interrupts sent to the host by other modules in the system, convert them into PCIe interrupts, and feedback the status to the host.

## Build FPGA  
* Follow [_Vivado Design Suite User Guide: Release Notes,Installation,and Licensing(UG973)_](https://docs.xilinx.com/r/en-US/ug973-vivado-release-notes-install-license/Create-and-Generate-a-License-Key-File) to install vivado and download bitstream.   
* Use this instruction to verify that the bitstream was successfully burned.  
  ` lspci -vvd 10ee: `

## Lisence  
TIHU is licensed under the Apache-2.0 license. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
