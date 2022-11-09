## SoC Address Mapping

|SubSystem &nbsp;|SubModule &nbsp;|Size (Hex) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|Size &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|Start Address (Hex) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|End Address (Hex) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|Remark &nbsp;|
|:----|:----|:----|:----|:----|:----|:----|
| |Reserved|40000000|1024 MB|00000000|3FFFFFFF| |
|ROM|ROM|20000|128 KB|40000000|4001FFFF| |
| |Reserved|D0000|832 KB|40020000|400EFFFF| |
| |Reserved|10000|64 KB|400F0000|400FFFFF| |
|peripheral|UART|10000|64 KB|40100000|4010FFFF| |
| |Timer0|10000|64 KB|40110000|4011FFFF| |
| |Timer1|10000|64 KB|40120000|4012FFFF| |
| |Reserved|10000|64 KB|40130000|4013FFFF| |
| |Reserved|10000|64 KB|40140000|4014FFFF| |
| |Reserved|10000|64 KB|40150000|4015FFFF| |
| |Reserved|10000|64 KB|40160000|4016FFFF| |
| |Reserved|10000|64 KB|40170000|4017FFFF| |
| |Reserved|10000|64 KB|40180000|4018FFFF| |
| |Reserved|70000|448 KB|40190000|401FFFFF| |
| |Reserved|100000|1 MB|40200000|402FFFFF| |
|SCU|SCU|10000|64 KB|40300000|4030FFFF|accessible by PCIe AXI lite Bar0|
| |Reserved|F0000|960 KB|40310000|403FFFFF| |
|MAC|MAC|40000|256 KB|40400000|4043FFFF| |
| |Reserved|10000|64 KB|40440000|4044FFFF| |
|DMA|DMA|10000|64 KB|40450000|4045FFFF| |
|PCIe|PCIe CFG|10000|64 KB|40460000|4046FFFF|accessible by PCIe AXI lite Bar0|
| |Reserved|90000|576 KB|40470000|404FFFFF| |
| |Reserved|100000|1 MB|40500000|405FFFFF| |
|RAM|RAM|400000|4 MB|40600000|409FFFFF|accessible by PCIe AXI lite Bar0|
| |CLINT|C0000|768 KB|40A00000|40ABFFFF| |
| |Reserved|40000|256 KB|40AC0000|40AFFFFF| |
| |PLIC|4000000|64 MB|40B00000|44AFFFFF| |
| |Reserved|1B500000|437 MB|44B00000|5FFFFFFF| |
| |Reserved|20000000|512 MB|60000000|7FFFFFFF| |
|DDR4|DDR4|80000000|2048 MB|80000000|FFFFFFFF| |
