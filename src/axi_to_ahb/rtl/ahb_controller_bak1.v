module ahb_controller(
	input					hclk,
	input					hresetn,
	//ahb output
	output reg	[31:0]		haddr,
	output reg	[1:0]		htrans,
	output reg				hwrite,
	output reg	[2:0]		hsize,
	output reg	[2:0]		hburst,
	output reg 	[63:0]		hwdata,
	output reg 				hbusreq,
	output reg				hlock,
	//ahb input
	input		[63:0]		hrdata,
	input					hready,
	input		[1:0]		hresp,
	input					hgrant,
	input		[3:0]		hmaster,
	//addr_fifo in
	output 					addr_r_en,
	input		[31:0]		ahb_addr,
	input					addr_fifo_empty,
	//data_fifo in
	output 					data_r_en,
	input		[63:0]		ahb_data,
	input					data_fifo_empty,
	// write or read state fifo (1 write   0 read) in
	output 					state_r_en,
	input					ahb_write,
	input					state_fifo_empty,
	//id_send_fifo in
	output 					id_send_r_en,
	input		[8:0]		ahb_id,
	input					id_send_fifo_empty,
	//size_fifo in
	output 					size_r_en,
	input		[2:0]		ahb_size,
	input					size_fifo_empty,
	//rdata_fifo out
	output 					rdata_w_en,
	output reg	[63:0]		ahb_rdata,
	input					rdata_fifo_full,
	input					rdata_fifo_empty,
	//resp_fifo out
	output 					resp_w_en,
	output reg	[1:0]		ahb_resp,
	input					resp_fifo_full,
	//id_resp out
	output 					id_resp_w_en,
	output reg	[9:0]		ahb_id_resp,
	input					id_resp_fifo_full
);

	parameter  
				IDLE 		= 5'b00001,
				START		= 5'b00010,
				ADDR_PHASE	= 5'b00100,	
				DATA_PHASE	= 5'b01000,	
				END_PHASE	= 5'b10000;

	reg						read_lock;

	wire					ahb_access;
	assign ahb_access = (hgrant == 1'b1 && hmaster == 4'b0)?1'b1:1'b0;

	wire					fifo_r_control_access,fifo_r_data_access,fifo_w_access;
	assign fifo_r_control_access = (read_lock == 1'b1)?1'b1:(addr_fifo_empty|state_fifo_empty|id_send_fifo_empty|size_fifo_empty);
	assign fifo_r_data_access = data_fifo_empty;
	assign fifo_w_access = rdata_fifo_full|resp_fifo_full|id_resp_fifo_full;

	reg			[4:0]		cstate,nstate;
	reg			[8:0]		id_reg;

	//addr_fifo in
	reg						addr_r_en_reg;
	assign addr_r_en = addr_r_en_reg&hready;
	//data_fifo in
	reg						data_r_en_reg;
	assign data_r_en = data_r_en_reg&hready;
	// write or read state fifo (1 write   0 read) in
	reg						state_r_en_reg;
	assign state_r_en = state_r_en_reg&hready;
	//id_send_fifo in
	reg						id_send_r_en_reg;
	assign id_send_r_en = id_send_r_en_reg&hready;
	//size_fifo in
	reg						size_r_en_reg;
	assign size_r_en = size_r_en_reg&hready;
	//rdata_fifo out
	reg						rdata_w_en_reg;
	assign rdata_w_en = rdata_w_en_reg&hready;
	//resp_fifo out
	reg						resp_w_en_reg;
	assign resp_w_en = resp_w_en_reg&hready;
	//id_resp out
	reg						id_resp_w_en_reg;
	assign id_resp_w_en = id_resp_w_en_reg&hready;


	wire reading;
	wire read_done;

	reg  ahb_read;
	reg  rdata_fifo_empty_reg;

	always@(posedge hclk or negedge hresetn) begin
		if(!hresetn)begin
			ahb_read <= 1'b0;
		end
		else if(hwrite == 1'b0) begin
			ahb_read <= 1'b1;
		end
		else if(read_done) begin
			ahb_read <= 1'b0;
		end
	end
    assign reading = (hwrite==1'b0) | ahb_read;

	always@(posedge hclk or negedge hresetn) begin
		if(!hresetn)begin
			rdata_fifo_empty_reg <= 1'b0;
		end
		else begin 
			rdata_fifo_empty_reg <= rdata_fifo_empty;
		end
	end
	assign read_done = ~rdata_fifo_empty_reg & rdata_fifo_empty;


	always@(posedge hclk or negedge hresetn)
		if(!hresetn)begin
			hbusreq <= 1'b0;
			hlock <= 1'b0;
		end
		else if(hgrant == 1'b0)
			hbusreq <= 1'b1;
		else
			hbusreq <= 1'b0;

	always@(posedge hclk or negedge hresetn)
		if(!hresetn)
			cstate <= IDLE;
		else
			cstate <= nstate;

	always@(*)
		case(cstate)
			IDLE:begin
				if(ahb_access == 1'b0)
					nstate = IDLE;
				else if(fifo_r_control_access == 1'b0)
					nstate = START;
				else
					nstate = IDLE;
			end
			START:begin
				if(hready == 1'b0)
					nstate = START;
				else
					nstate = ADDR_PHASE;
			end
			ADDR_PHASE:begin
				if(hready == 1'b1)
					nstate = DATA_PHASE;
				else
					nstate = ADDR_PHASE;
			end
			DATA_PHASE:begin
				//if(reading) begin
                //    if(read_done)
				//		nstate = END_PHASE;
				//	else
				//		nstate = DATA_PHASE;
				//end
				//else 
				if(hready == 1'b1 && (fifo_r_data_access == 1'b1 || (fifo_r_data_access == 1'b0 && read_lock == 1'b1)))
					nstate = END_PHASE;
				else
					nstate = DATA_PHASE;
			end
			END_PHASE:begin
				if(hready == 1'b1 && fifo_r_control_access == 1'b0)
					nstate = START;
				else
					nstate = IDLE;
			end
		endcase

	always@(posedge hclk or negedge hresetn)
		if(!hresetn)begin
			//ahb output
			haddr <= 32'b0;
			htrans <= 2'b0;
			hwrite <= 1'b1;
			hsize <= 3'b0;
			hburst <= 3'b0;
			hwdata <= 64'b0;
			id_reg <= 9'b0;
			//addr_fifo in
			addr_r_en_reg <= 1'b0;
			//data_fifo in
			data_r_en_reg <= 1'b0;
			// write or read state fifo (1 write   0 read) in
			state_r_en_reg <= 1'b0;
			//id_send_fifo in
			id_send_r_en_reg <= 1'b0;
			//size_fifo in
			size_r_en_reg <= 1'b0;
			//rdata_fifo out
			rdata_w_en_reg <= 1'b0;
			ahb_rdata <= 64'b0;
			//resp_fifo out
			resp_w_en_reg <= 1'b0;
			ahb_resp <= 2'b0;
			//id_resp out
			id_resp_w_en_reg <= 1'b0;
			ahb_id_resp <= 10'b0;
			read_lock <= 1'b0;
		end
		else
			case(cstate)
				IDLE:begin
					if(ahb_access == 1'b1 && hready == 1'b1 && fifo_r_control_access == 1'b0)begin
						haddr <= 32'b0;
						htrans <= 2'b0;
						hwrite <= 1'b1;
						hsize <= 3'b0;
						hburst <= 3'b0;
						hwdata <= 64'b0;
						id_reg <= 9'b0;

						addr_r_en_reg <= 1'b1;
						data_r_en_reg <= 1'b0;
						state_r_en_reg <= 1'b1;
						id_send_r_en_reg <= 1'b1;
						size_r_en_reg <= 1'b1;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b0;
						ahb_id_resp <= 10'b0;
						read_lock <= 1'b0;
					end
					else begin
						haddr <= 32'b0;
						htrans <= 2'b0;
						hwrite <= 1'b1;
						hsize <= 3'b0;
						hburst <= 3'b0;
						hwdata <= 64'b0;
						id_reg <= 9'b0;

						addr_r_en_reg <= 1'b0;
						data_r_en_reg <= 1'b0;
						state_r_en_reg <= 1'b0;
						id_send_r_en_reg <= 1'b0;
						size_r_en_reg <= 1'b0;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b0;
						ahb_id_resp <= 10'b0;
						read_lock <= 1'b0;
					end
				end
				START:begin
					if(hready == 1'b1)begin
						haddr <= ahb_addr;
						htrans <= 2'd2;
						hwrite <= ahb_write;
						hsize <= ahb_size;
						hburst <= 3'b0;
						hwdata <= 64'b0;
						id_reg <= ahb_id;

						addr_r_en_reg <= 1'b1;
						data_r_en_reg <= 1'b1;
						state_r_en_reg <= 1'b1;
						id_send_r_en_reg <= 1'b1;
						size_r_en_reg <= 1'b1;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b0;
						ahb_id_resp <= 10'b0;
						read_lock <= 1'b0;
					end
					else begin
						haddr <= 32'b0;
						htrans <= 2'b0;
						hwrite <= 1'b1;
						hsize <= 3'b0;
						hburst <= 3'b0;
						hwdata <= 64'b0;
						id_reg <= 9'b0;

						addr_r_en_reg <= 1'b1;
						data_r_en_reg <= 1'b0;
						state_r_en_reg <= 1'b1;
						id_send_r_en_reg <= 1'b1;
						size_r_en_reg <= 1'b1;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b0;
						ahb_id_resp <= 10'b0;
						read_lock <= 1'b0;
					end
				end
				ADDR_PHASE:begin
					if(hready == 1'b1 && fifo_r_control_access == 1'b0)begin
						haddr <= ahb_addr;
						htrans <= 2'd2;
						hwrite <= ahb_write;
						hsize <= ahb_size;
						hburst <= 3'b0;
						hwdata <= ahb_data;
						id_reg <= ahb_id;

						addr_r_en_reg <= 1'b1;
						data_r_en_reg <= 1'b1;
						state_r_en_reg <= 1'b1;
						id_send_r_en_reg <= 1'b1;
						size_r_en_reg <= 1'b1;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b1;
						ahb_id_resp <= {hwrite,id_reg};
					end
					else if(hready == 1'b1 && fifo_r_control_access == 1'b1)begin
						haddr <= 32'b0;
						htrans <= 2'b0;
						hwrite <= 1'b1;
						hsize <= 3'b0;
						hburst <= 3'b0;
						hwdata <= ahb_data;
						id_reg <= 9'b0;

						addr_r_en_reg <= 1'b0;
						data_r_en_reg <= 1'b1;
						state_r_en_reg <= 1'b0;
						id_send_r_en_reg <= 1'b0;
						size_r_en_reg <= 1'b0;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b1;
						ahb_id_resp <= {hwrite,id_reg};
						read_lock <= 1'b1;
					end
					else begin
						haddr <= haddr;
						htrans <= htrans;
						hwrite <= hwrite;
						hsize <= hsize;
						hburst <= hburst;
						hwdata <= hwdata;
						id_reg <= id_reg;

						addr_r_en_reg <= 1'b1;
						data_r_en_reg <= 1'b1;
						state_r_en_reg <= 1'b1;
						id_send_r_en_reg <= 1'b1;
						size_r_en_reg <= 1'b1;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b0;
						ahb_id_resp <= 10'b0;
					end
				end	
				DATA_PHASE:begin
					if(hready == 1'b1 && fifo_r_control_access == 1'b0)begin
						haddr <= ahb_addr;
						htrans <= 2'd2;
						hwrite <= ahb_write;
						hsize <= ahb_size;
						hburst <= 3'b0;
						hwdata <= ahb_data;
						id_reg <= ahb_id;

						addr_r_en_reg <= 1'b1;
						data_r_en_reg <= 1'b1;
						state_r_en_reg <= 1'b1;
						id_send_r_en_reg <= 1'b1;
						size_r_en_reg <= 1'b1;

						rdata_w_en_reg <= 1'b1;
						ahb_rdata <= hrdata;
						resp_w_en_reg <= 1'b1;
						ahb_resp <= hresp;
						id_resp_w_en_reg <= 1'b1;
						ahb_id_resp <= {hwrite,id_reg};
					end
					else if(hready == 1'b1 && fifo_r_control_access == 1'b1 && fifo_r_data_access == 1'b0 && read_lock == 1'b0)begin
						haddr <= 32'b0;
						htrans <= 2'b0;
						hwrite <= 1'b1;
						hsize <= 3'b0;
						hburst <= 3'b0;
						hwdata <= ahb_data;
						id_reg <= 9'b0;
						read_lock <= 1'b1;

						addr_r_en_reg <= 1'b0;
						data_r_en_reg <= 1'b1;
						state_r_en_reg <= 1'b0;
						id_send_r_en_reg <= 1'b0;
						size_r_en_reg <= 1'b0;

						rdata_w_en_reg <= 1'b1;
						ahb_rdata <= hrdata;
						resp_w_en_reg <= 1'b1;
						ahb_resp <= hresp;
						id_resp_w_en_reg <= 1'b1;
						ahb_id_resp <= {hwrite,id_reg};
					end
					else if(hready == 1'b1 && fifo_r_control_access == 1'b1 && (fifo_r_data_access == 1'b1 || (fifo_r_data_access == 1'b0 && read_lock == 1'b1)))begin
						haddr <= 32'b0;
						htrans <= 2'b0;
						hwrite <= 1'b1;
						hsize <= 3'b0;
						hburst <= 3'b0;
						hwdata <= 64'b0;
						id_reg <= 9'b0;

						addr_r_en_reg <= 1'b0;
						data_r_en_reg <= 1'b0;
						state_r_en_reg <= 1'b0;
						id_send_r_en_reg <= 1'b0;
						size_r_en_reg <= 1'b0;

						rdata_w_en_reg <= 1'b1;
						ahb_rdata <= hrdata;
						resp_w_en_reg <= 1'b1;
						ahb_resp <= hresp;
						id_resp_w_en_reg <= 1'b0;
						ahb_id_resp <= 10'b0;
					end
					else if(hready == 1'b0)begin
						haddr <= haddr;
						htrans <= htrans;
						hwrite <= hwrite;
						hsize <= hsize;
						hburst <= hburst;
						hwdata <= hwdata;
						id_reg <= id_reg;

						addr_r_en_reg <= 1'b1;
						data_r_en_reg <= 1'b1;
						state_r_en_reg <= 1'b1;
						id_send_r_en_reg <= 1'b1;
						size_r_en_reg <= 1'b1;
						
						if(fifo_r_control_access == 1'b0)begin
							rdata_w_en_reg <= 1'b0;
							ahb_rdata <= 64'b0;
							resp_w_en_reg <= 1'b0;
							ahb_resp <= 2'b0;
							id_resp_w_en_reg <= 1'b1;
							ahb_id_resp <= {hwrite,id_reg};
						end
						else begin
							rdata_w_en_reg <= rdata_w_en_reg;
							ahb_rdata <= ahb_rdata;
							resp_w_en_reg <= resp_w_en_reg;
							ahb_resp <= ahb_resp;
							id_resp_w_en_reg <= id_resp_w_en_reg;
							ahb_id_resp <= ahb_id_resp;
						end
					end
				end
				END_PHASE:begin
					if(hready == 1'b1 && fifo_r_control_access == 1'b0)begin
						haddr <= 32'b0;
						htrans <= 2'b0;
						hwrite <= 1'b1;
						hsize <= 3'b0;
						hburst <= 3'b0;
						hwdata <= 64'b0;

						addr_r_en_reg <= 1'b1;
						data_r_en_reg <= 1'b0;
						state_r_en_reg <= 1'b1;
						id_send_r_en_reg <= 1'b1;
						size_r_en_reg <= 1'b1;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b0;
						ahb_id_resp <= 10'b0;
					end	
					else begin
						haddr <= 32'b0;
						htrans <= 2'b0;
						hwrite <= 1'b1;
						hsize <= 3'b0;
						hburst <= 3'b0;
						hwdata <= 64'b0;

						addr_r_en_reg <= 1'b0;
						data_r_en_reg <= 1'b0;
						state_r_en_reg <= 1'b0;
						id_send_r_en_reg <= 1'b0;
						size_r_en_reg <= 1'b0;

						rdata_w_en_reg <= 1'b0;
						ahb_rdata <= 64'b0;
						resp_w_en_reg <= 1'b0;
						ahb_resp <= 2'b0;
						id_resp_w_en_reg <= 1'b0;
						ahb_id_resp <= 10'b0;
					end 
				end
			endcase
endmodule 
