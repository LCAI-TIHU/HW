module resp_fifo(
    input                   	wclk,
    input                   	rclk,
    input                   	resetn,
    input       [1:0]   	   	data_in,
    input                   	write_en,
    input                   	read_en,
    output      [1:0]	      	data_out,
    output                  	full,
    output                  	empty
);// addr 32
    reg     	[1:0]        	ram[127:0];
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
			ram[0] <= 2'b0;
			ram[1] <= 2'b0;
			ram[2] <= 2'b0;
			ram[3] <= 2'b0;
			ram[4] <= 2'b0;
			ram[5] <= 2'b0;
			ram[6] <= 2'b0;
			ram[7] <= 2'b0;
			ram[8] <= 2'b0;
			ram[9] <= 2'b0;
			ram[10] <= 2'b0;
			ram[11] <= 2'b0;
			ram[12] <= 2'b0;
			ram[13] <= 2'b0;
			ram[14] <= 2'b0;
			ram[15] <= 2'b0;
			ram[16] <= 2'b0;
			ram[17] <= 2'b0;
			ram[18] <= 2'b0;
			ram[19] <= 2'b0;
			ram[20] <= 2'b0;
			ram[21] <= 2'b0;
			ram[22] <= 2'b0;
			ram[23] <= 2'b0;
			ram[24] <= 2'b0;
			ram[25] <= 2'b0;
			ram[26] <= 2'b0;
			ram[27] <= 2'b0;
			ram[28] <= 2'b0;
			ram[29] <= 2'b0;
			ram[30] <= 2'b0;
			ram[31] <= 2'b0;
			ram[32] <= 2'b0;
			ram[33] <= 2'b0;
			ram[34] <= 2'b0;
			ram[35] <= 2'b0;
			ram[36] <= 2'b0;
			ram[37] <= 2'b0;
			ram[38] <= 2'b0;
			ram[39] <= 2'b0;
			ram[40] <= 2'b0;
			ram[41] <= 2'b0;
			ram[42] <= 2'b0;
			ram[43] <= 2'b0;
			ram[44] <= 2'b0;
			ram[45] <= 2'b0;
			ram[46] <= 2'b0;
			ram[47] <= 2'b0;
			ram[48] <= 2'b0;
			ram[49] <= 2'b0;
			ram[50] <= 2'b0;
			ram[51] <= 2'b0;
			ram[52] <= 2'b0;
			ram[53] <= 2'b0;
			ram[54] <= 2'b0;
			ram[55] <= 2'b0;
			ram[56] <= 2'b0;
			ram[57] <= 2'b0;
			ram[58] <= 2'b0;
			ram[59] <= 2'b0;
			ram[60] <= 2'b0;
			ram[61] <= 2'b0;
			ram[62] <= 2'b0;
			ram[63] <= 2'b0;
			ram[64] <= 2'b0;
			ram[65] <= 2'b0;
			ram[66] <= 2'b0;
			ram[67] <= 2'b0;
			ram[68] <= 2'b0;
			ram[69] <= 2'b0;
			ram[70] <= 2'b0;
			ram[71] <= 2'b0;
			ram[72] <= 2'b0;
			ram[73] <= 2'b0;
			ram[74] <= 2'b0;
			ram[75] <= 2'b0;
			ram[76] <= 2'b0;
			ram[77] <= 2'b0;
			ram[78] <= 2'b0;
			ram[79] <= 2'b0;
			ram[80] <= 2'b0;
			ram[81] <= 2'b0;
			ram[82] <= 2'b0;
			ram[83] <= 2'b0;
			ram[84] <= 2'b0;
			ram[85] <= 2'b0;
			ram[86] <= 2'b0;
			ram[87] <= 2'b0;
			ram[88] <= 2'b0;
			ram[89] <= 2'b0;
			ram[90] <= 2'b0;
			ram[91] <= 2'b0;
			ram[92] <= 2'b0;
			ram[93] <= 2'b0;
			ram[94] <= 2'b0;
			ram[95] <= 2'b0;
			ram[96] <= 2'b0;
			ram[97] <= 2'b0;
			ram[98] <= 2'b0;
			ram[99] <= 2'b0;
			ram[100] <= 2'b0;
			ram[101] <= 2'b0;
			ram[102] <= 2'b0;
			ram[103] <= 2'b0;
			ram[104] <= 2'b0;
			ram[105] <= 2'b0;
			ram[106] <= 2'b0;
			ram[107] <= 2'b0;
			ram[108] <= 2'b0;
			ram[109] <= 2'b0;
			ram[110] <= 2'b0;
			ram[111] <= 2'b0;
			ram[112] <= 2'b0;
			ram[113] <= 2'b0;
			ram[114] <= 2'b0;
			ram[115] <= 2'b0;
			ram[116] <= 2'b0;
			ram[117] <= 2'b0;
			ram[118] <= 2'b0;
			ram[119] <= 2'b0;
			ram[120] <= 2'b0;
			ram[121] <= 2'b0;
			ram[122] <= 2'b0;
			ram[123] <= 2'b0;
			ram[124] <= 2'b0;
			ram[125] <= 2'b0;
			ram[126] <= 2'b0;
			ram[127] <= 2'b0;
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
