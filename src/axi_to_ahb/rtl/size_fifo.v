module size_fifo(
    input                   	wclk,
    input                   	rclk,
    input                   	resetn,
    input       [2:0]   	   	data_in,
    input                   	write_en,
    input                   	read_en,
    output      [2:0]	      	data_out,
    output                  	full,
    output                  	empty
);
    reg     	[2:0]        	ram[127:0];
    reg     	[7:0]        	write_addr_wclk;
    reg     	[7:0]        	read_addr_rclk;

    wire    	[7:0]        	write_addr_gray_wclk;
    reg     	[7:0]        	write_addr_gray_rclk0;
    reg     	[7:0]        	write_addr_gray_rclk1;

    wire    	[7:0]        	read_addr_gray_rclk;
    reg     	[7:0]        	read_addr_gray_wclk0;
    reg     	[7:0]        	read_addr_gray_wclk1;

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
			ram[0] <= 3'b0;
			ram[1] <= 3'b0;
			ram[2] <= 3'b0;
			ram[3] <= 3'b0;
			ram[4] <= 3'b0;
			ram[5] <= 3'b0;
			ram[6] <= 3'b0;
			ram[7] <= 3'b0;
			ram[8] <= 3'b0;
			ram[9] <= 3'b0;
			ram[10] <= 3'b0;
			ram[11] <= 3'b0;
			ram[12] <= 3'b0;
			ram[13] <= 3'b0;
			ram[14] <= 3'b0;
			ram[15] <= 3'b0;
			ram[16] <= 3'b0;
			ram[17] <= 3'b0;
			ram[18] <= 3'b0;
			ram[19] <= 3'b0;
			ram[20] <= 3'b0;
			ram[21] <= 3'b0;
			ram[22] <= 3'b0;
			ram[23] <= 3'b0;
			ram[24] <= 3'b0;
			ram[25] <= 3'b0;
			ram[26] <= 3'b0;
			ram[27] <= 3'b0;
			ram[28] <= 3'b0;
			ram[29] <= 3'b0;
			ram[30] <= 3'b0;
			ram[31] <= 3'b0;
			ram[32] <= 3'b0;
			ram[33] <= 3'b0;
			ram[34] <= 3'b0;
			ram[35] <= 3'b0;
			ram[36] <= 3'b0;
			ram[37] <= 3'b0;
			ram[38] <= 3'b0;
			ram[39] <= 3'b0;
			ram[40] <= 3'b0;
			ram[41] <= 3'b0;
			ram[42] <= 3'b0;
			ram[43] <= 3'b0;
			ram[44] <= 3'b0;
			ram[45] <= 3'b0;
			ram[46] <= 3'b0;
			ram[47] <= 3'b0;
			ram[48] <= 3'b0;
			ram[49] <= 3'b0;
			ram[50] <= 3'b0;
			ram[51] <= 3'b0;
			ram[52] <= 3'b0;
			ram[53] <= 3'b0;
			ram[54] <= 3'b0;
			ram[55] <= 3'b0;
			ram[56] <= 3'b0;
			ram[57] <= 3'b0;
			ram[58] <= 3'b0;
			ram[59] <= 3'b0;
			ram[60] <= 3'b0;
			ram[61] <= 3'b0;
			ram[62] <= 3'b0;
			ram[63] <= 3'b0;
			ram[64] <= 3'b0;
			ram[65] <= 3'b0;
			ram[66] <= 3'b0;
			ram[67] <= 3'b0;
			ram[68] <= 3'b0;
			ram[69] <= 3'b0;
			ram[70] <= 3'b0;
			ram[71] <= 3'b0;
			ram[72] <= 3'b0;
			ram[73] <= 3'b0;
			ram[74] <= 3'b0;
			ram[75] <= 3'b0;
			ram[76] <= 3'b0;
			ram[77] <= 3'b0;
			ram[78] <= 3'b0;
			ram[79] <= 3'b0;
			ram[80] <= 3'b0;
			ram[81] <= 3'b0;
			ram[82] <= 3'b0;
			ram[83] <= 3'b0;
			ram[84] <= 3'b0;
			ram[85] <= 3'b0;
			ram[86] <= 3'b0;
			ram[87] <= 3'b0;
			ram[88] <= 3'b0;
			ram[89] <= 3'b0;
			ram[90] <= 3'b0;
			ram[91] <= 3'b0;
			ram[92] <= 3'b0;
			ram[93] <= 3'b0;
			ram[94] <= 3'b0;
			ram[95] <= 3'b0;
			ram[96] <= 3'b0;
			ram[97] <= 3'b0;
			ram[98] <= 3'b0;
			ram[99] <= 3'b0;
			ram[100] <= 3'b0;
			ram[101] <= 3'b0;
			ram[102] <= 3'b0;
			ram[103] <= 3'b0;
			ram[104] <= 3'b0;
			ram[105] <= 3'b0;
			ram[106] <= 3'b0;
			ram[107] <= 3'b0;
			ram[108] <= 3'b0;
			ram[109] <= 3'b0;
			ram[110] <= 3'b0;
			ram[111] <= 3'b0;
			ram[112] <= 3'b0;
			ram[113] <= 3'b0;
			ram[114] <= 3'b0;
			ram[115] <= 3'b0;
			ram[116] <= 3'b0;
			ram[117] <= 3'b0;
			ram[118] <= 3'b0;
			ram[119] <= 3'b0;
			ram[120] <= 3'b0;
			ram[121] <= 3'b0;
			ram[122] <= 3'b0;
			ram[123] <= 3'b0;
			ram[124] <= 3'b0;
			ram[125] <= 3'b0;
			ram[126] <= 3'b0;
			ram[127] <= 3'b0;
		end
        else if(full == 1'b0 && write_en == 1'b1)
            ram[write_addr_wclk[6:0]] <= data_in;


    assign full = (write_addr_gray_wclk[7] != read_addr_gray_wclk1[7])?
                  (write_addr_gray_wclk[6] != read_addr_gray_wclk1[6])?
                  (write_addr_gray_wclk[5:0] == read_addr_gray_wclk1[5:0])?1'b1:1'b0:1'b0:1'b0;
    assign empty = (write_addr_gray_rclk1 == read_addr_gray_rclk)?1'b1:1'b0;
    
	assign data_out = ((read_en == 1'b1) && (empty != 1'b1))?ram[read_addr_rclk[6:0]]:31'b0;
    
	assign write_addr_gray_wclk = (write_addr_wclk>>1)^write_addr_wclk;
    assign read_addr_gray_rclk = (read_addr_rclk>>1)^read_addr_rclk;

endmodule 
