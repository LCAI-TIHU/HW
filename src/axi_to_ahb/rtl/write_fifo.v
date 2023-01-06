module write_fifo(
    input                   	wclk,
    input                   	rclk,
    input                   	resetn,
    input       		      	data_in,
    input                   	write_en,
    input                   	read_en,
    output      		      	data_out,
    output                  	full,
    output                  	empty
);
    reg     	[127:0]        	ram;
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
		if(!resetn)
			ram <= 128'b0;
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
