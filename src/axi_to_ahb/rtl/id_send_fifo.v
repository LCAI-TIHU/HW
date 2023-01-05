module id_send_fifo #(
  parameter AXI_ID_WIDTH = 8   
)(
    input                          wclk,
    input                          rclk,
    input                          resetn,
    input  [AXI_ID_WIDTH+1-1:0]    data_in,
    input                          write_en,
    input                          read_en,
    output [AXI_ID_WIDTH+1-1:0]    data_out,
    output                         full,
    output                         empty
);
    reg    [AXI_ID_WIDTH+1-1:0]    ram[127:0];
    reg    [7:0]                   write_addr_wclk;
    reg    [7:0]                   read_addr_rclk;

    wire   [7:0]                   write_addr_gray_wclk;
    reg    [7:0]                   write_addr_gray_rclk0;
    reg    [7:0]                   write_addr_gray_rclk1;

    wire   [7:0]                   read_addr_gray_rclk;
    reg    [7:0]                   read_addr_gray_wclk0;
    reg    [7:0]                   read_addr_gray_wclk1;

    always@(posedge wclk or negedge resetn)//write addr wclk operation
        if(!resetn)
            write_addr_wclk <= 8'b0;
        else if(write_en == 1'b1 && full != 1'b1)
            write_addr_wclk <= write_addr_wclk + 1'b1;
        else
            write_addr_wclk <= write_addr_wclk;
    
    always@(posedge rclk or negedge resetn)//read addr read operation
        if(!resetn)
            read_addr_rclk <= 8'b0;
        else if(read_en == 1'b1 && empty != 1'b1)
            read_addr_rclk <= read_addr_rclk + 1'b1;
        else
            read_addr_rclk <= read_addr_rclk;
    
    always@(posedge wclk or negedge resetn)//sync
        if(!resetn)begin
            read_addr_gray_wclk0 <= 8'b0;
            read_addr_gray_wclk1 <= 8'b0;
        end
        else begin
            read_addr_gray_wclk0 <= read_addr_gray_rclk;
            read_addr_gray_wclk1 <= read_addr_gray_wclk0;
        end
    
    always@(posedge rclk or negedge resetn)//sync
        if(!resetn)begin
            write_addr_gray_rclk0 <= 8'b0;
            write_addr_gray_rclk1 <= 8'b0;
        end
        else begin
            write_addr_gray_rclk0 <= write_addr_gray_wclk;
            write_addr_gray_rclk1 <= write_addr_gray_rclk0;
        end

    always@(posedge wclk or negedge resetn)//data out
        if(!resetn)begin
            ram[0]  <= 'b0;
            ram[1]  <= 'b0;
            ram[2]  <= 'b0;
            ram[3]  <= 'b0;
            ram[4]  <= 'b0;
            ram[5]  <= 'b0;
            ram[6]  <= 'b0;
            ram[7]  <= 'b0;
            ram[8]  <= 'b0;
            ram[9]  <= 'b0;
            ram[10] <= 'b0;
            ram[11] <= 'b0;
            ram[12] <= 'b0;
            ram[13] <= 'b0;
            ram[14] <= 'b0;
            ram[15] <= 'b0;
			ram[16] <= 'b0;
			ram[17] <= 'b0;
			ram[18] <= 'b0;
			ram[19] <= 'b0;
			ram[20] <= 'b0;
			ram[21] <= 'b0;
			ram[22] <= 'b0;
			ram[23] <= 'b0;
			ram[24] <= 'b0;
			ram[25] <= 'b0;
			ram[26] <= 'b0;
			ram[27] <= 'b0;
			ram[28] <= 'b0;
			ram[29] <= 'b0;
			ram[30] <= 'b0;
			ram[31] <= 'b0;
			ram[32] <= 'b0;
			ram[33] <= 'b0;
			ram[34] <= 'b0;
			ram[35] <= 'b0;
			ram[36] <= 'b0;
			ram[37] <= 'b0;
			ram[38] <= 'b0;
			ram[39] <= 'b0;
			ram[40] <= 'b0;
			ram[41] <= 'b0;
			ram[42] <= 'b0;
			ram[43] <= 'b0;
			ram[44] <= 'b0;
			ram[45] <= 'b0;
			ram[46] <= 'b0;
			ram[47] <= 'b0;
			ram[48] <= 'b0;
			ram[49] <= 'b0;
			ram[50] <= 'b0;
			ram[51] <= 'b0;
			ram[52] <= 'b0;
			ram[53] <= 'b0;
			ram[54] <= 'b0;
			ram[55] <= 'b0;
			ram[56] <= 'b0;
			ram[57] <= 'b0;
			ram[58] <= 'b0;
			ram[59] <= 'b0;
			ram[60] <= 'b0;
			ram[61] <= 'b0;
			ram[62] <= 'b0;
			ram[63] <= 'b0;
			ram[64] <= 'b0;
			ram[65] <= 'b0;
			ram[66] <= 'b0;
			ram[67] <= 'b0;
			ram[68] <= 'b0;
			ram[69] <= 'b0;
			ram[70] <= 'b0;
			ram[71] <= 'b0;
			ram[72] <= 'b0;
			ram[73] <= 'b0;
			ram[74] <= 'b0;
			ram[75] <= 'b0;
			ram[76] <= 'b0;
			ram[77] <= 'b0;
			ram[78] <= 'b0;
			ram[79] <= 'b0;
			ram[80] <= 'b0;
			ram[81] <= 'b0;
			ram[82] <= 'b0;
			ram[83] <= 'b0;
			ram[84] <= 'b0;
			ram[85] <= 'b0;
			ram[86] <= 'b0;
			ram[87] <= 'b0;
			ram[88] <= 'b0;
			ram[89] <= 'b0;
			ram[90] <= 'b0;
			ram[91] <= 'b0;
			ram[92] <= 'b0;
			ram[93] <= 'b0;
			ram[94] <= 'b0;
			ram[95] <= 'b0;
			ram[96] <= 'b0;
			ram[97] <= 'b0;
			ram[98] <= 'b0;
			ram[99] <= 'b0;
			ram[100] <= 'b0;
			ram[101] <= 'b0;
			ram[102] <= 'b0;
			ram[103] <= 'b0;
			ram[104] <= 'b0;
			ram[105] <= 'b0;
			ram[106] <= 'b0;
			ram[107] <= 'b0;
			ram[108] <= 'b0;
			ram[109] <= 'b0;
			ram[110] <= 'b0;
			ram[111] <= 'b0;
			ram[112] <= 'b0;
			ram[113] <= 'b0;
			ram[114] <= 'b0;
			ram[115] <= 'b0;
			ram[116] <= 'b0;
			ram[117] <= 'b0;
			ram[118] <= 'b0;
			ram[119] <= 'b0;
			ram[120] <= 'b0;
			ram[121] <= 'b0;
			ram[122] <= 'b0;
			ram[123] <= 'b0;
			ram[124] <= 'b0;
			ram[125] <= 'b0;
			ram[126] <= 'b0;
			ram[127] <= 'b0;
        end
        else if(full == 1'b0 && write_en == 1'b1)
            ram[write_addr_wclk[6:0]] <= data_in;


    assign full = (write_addr_gray_wclk[7] != read_addr_gray_wclk1[7])?
                  (write_addr_gray_wclk[6] != read_addr_gray_wclk1[6])?
                  (write_addr_gray_wclk[5:0] == read_addr_gray_wclk1[5:0])?1'b1:1'b0:1'b0:1'b0;
    assign empty = (write_addr_gray_rclk1 == read_addr_gray_rclk)?1'b1:1'b0;
    
    assign data_out = ((read_en == 1'b1) && (empty != 1'b1))?ram[read_addr_rclk[6:0]]:'b0;
    
    assign write_addr_gray_wclk = (write_addr_wclk>>1)^write_addr_wclk;
    assign read_addr_gray_rclk = (read_addr_rclk>>1)^read_addr_rclk;

endmodule 
