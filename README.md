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

## Build FPGA  
* Follow _Vivado Design Suite User Guide: Release Notes,Installation,and Licensing(UG973)_ to install vivado.   

## Lisence  
TIHU is licensed under the Apache-2.0 license. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
