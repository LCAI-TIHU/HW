module data_fifo(
    input                   	wclk,
    input                   	rclk,
    input                   	resetn,
    input       [63:0]      	data_in,
    input                   	write_en,
    input                   	read_en,
    output      [63:0]      	data_out,
    output                  	full,
    output                  	empty
);//data 64
    reg     	[63:0]        	ram[127:0];
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
			ram[0]  <= 64'b0;
			ram[1]  <= 64'b0;
			ram[2]  <= 64'b0;
			ram[3]  <= 64'b0;
			ram[4]  <= 64'b0;
			ram[5]  <= 64'b0;
			ram[6]  <= 64'b0;
			ram[7]  <= 64'b0;
			ram[8]  <= 64'b0;
			ram[9]  <= 64'b0;
			ram[10] <= 64'b0;
			ram[11] <= 64'b0;
			ram[12] <= 64'b0;
			ram[13] <= 64'b0;
			ram[14] <= 64'b0;
			ram[15] <= 64'b0;
			ram[16] <= 64'b0;
			ram[17] <= 64'b0;
			ram[18] <= 64'b0;
			ram[19] <= 64'b0;
			ram[20] <= 64'b0;
			ram[21] <= 64'b0;
			ram[22] <= 64'b0;
			ram[23] <= 64'b0;
			ram[24] <= 64'b0;
			ram[25] <= 64'b0;
			ram[26] <= 64'b0;
			ram[27] <= 64'b0;
			ram[28] <= 64'b0;
			ram[29] <= 64'b0;
			ram[30] <= 64'b0;
			ram[31] <= 64'b0;
			ram[32] <= 64'b0;
			ram[33] <= 64'b0;
			ram[34] <= 64'b0;
			ram[35] <= 64'b0;
			ram[36] <= 64'b0;
			ram[37] <= 64'b0;
			ram[38] <= 64'b0;
			ram[39] <= 64'b0;
			ram[40] <= 64'b0;
			ram[41] <= 64'b0;
			ram[42] <= 64'b0;
			ram[43] <= 64'b0;
			ram[44] <= 64'b0;
			ram[45] <= 64'b0;
			ram[46] <= 64'b0;
			ram[47] <= 64'b0;
			ram[48] <= 64'b0;
			ram[49] <= 64'b0;
			ram[50] <= 64'b0;
			ram[51] <= 64'b0;
			ram[52] <= 64'b0;
			ram[53] <= 64'b0;
			ram[54] <= 64'b0;
			ram[55] <= 64'b0;
			ram[56] <= 64'b0;
			ram[57] <= 64'b0;
			ram[58] <= 64'b0;
			ram[59] <= 64'b0;
			ram[60] <= 64'b0;
			ram[61] <= 64'b0;
			ram[62] <= 64'b0;
			ram[63] <= 64'b0;
			ram[64] <= 64'b0;
			ram[65] <= 64'b0;
			ram[66] <= 64'b0;
			ram[67] <= 64'b0;
			ram[68] <= 64'b0;
			ram[69] <= 64'b0;
			ram[70] <= 64'b0;
			ram[71] <= 64'b0;
			ram[72] <= 64'b0;
			ram[73] <= 64'b0;
			ram[74] <= 64'b0;
			ram[75] <= 64'b0;
			ram[76] <= 64'b0;
			ram[77] <= 64'b0;
			ram[78] <= 64'b0;
			ram[79] <= 64'b0;
			ram[80] <= 64'b0;
			ram[81] <= 64'b0;
			ram[82] <= 64'b0;
			ram[83] <= 64'b0;
			ram[84] <= 64'b0;
			ram[85] <= 64'b0;
			ram[86] <= 64'b0;
			ram[87] <= 64'b0;
			ram[88] <= 64'b0;
			ram[89] <= 64'b0;
			ram[90] <= 64'b0;
			ram[91] <= 64'b0;
			ram[92] <= 64'b0;
			ram[93] <= 64'b0;
			ram[94] <= 64'b0;
			ram[95] <= 64'b0;
			ram[96] <= 64'b0;
			ram[97] <= 64'b0;
			ram[98] <= 64'b0;
			ram[99] <= 64'b0;
			ram[100] <= 64'b0;
			ram[101] <= 64'b0;
			ram[102] <= 64'b0;
			ram[103] <= 64'b0;
			ram[104] <= 64'b0;
			ram[105] <= 64'b0;
			ram[106] <= 64'b0;
			ram[107] <= 64'b0;
			ram[108] <= 64'b0;
			ram[109] <= 64'b0;
			ram[110] <= 64'b0;
			ram[111] <= 64'b0;
			ram[112] <= 64'b0;
			ram[113] <= 64'b0;
			ram[114] <= 64'b0;
			ram[115] <= 64'b0;
			ram[116] <= 64'b0;
			ram[117] <= 64'b0;
			ram[118] <= 64'b0;
			ram[119] <= 64'b0;
			ram[120] <= 64'b0;
			ram[121] <= 64'b0;
			ram[122] <= 64'b0;
			ram[123] <= 64'b0;
			ram[124] <= 64'b0;
			ram[125] <= 64'b0;
			ram[126] <= 64'b0;
			ram[127] <= 64'b0;
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
