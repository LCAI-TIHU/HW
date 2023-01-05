module fifo2axi #(
  parameter AXI_ID_WIDTH = 8   
)(
    input                             aclk,
    input                             aresetn,
    //rdata_fifo
    output                            rdata_r_en,
    input       [63:0]                axi_rdata,
    input                             rdata_fifo_empty,
    //resp_fifo
    output                            resp_r_en,
    input       [1:0]                 axi_resp,
    input                             resp_fifo_empty,
    //id_resp
    output                            id_resp_r_en,
    input       [AXI_ID_WIDTH+2-1:0]  axi_id_resp,
    input                             id_resp_fifo_empty,
    //b response
    output reg  [AXI_ID_WIDTH-1:0]    bid,
    output reg  [1:0]                 bresp,
    output reg                        bvalid,
    input                             bready,
    //r response
    output reg  [AXI_ID_WIDTH-1:0]    rid,
    output reg  [63:0]                rdata,
    output reg  [1:0]                 rresp,
    output reg                        rlast,
    output reg                        rvalid,
    input                             rready
);//read directly

    wire ready;
    assign ready = bready&rready;

    wire fifo_empty;
    assign fifo_empty = rdata_fifo_empty|resp_fifo_empty|id_resp_fifo_empty;

	wire read_en;
	wire ready_for_read;
	//assign read_en = (!rdata_fifo_empty)&(!resp_fifo_empty)&(!id_resp_fifo_empty)&ready;
	//assign read_en = (!rdata_fifo_empty)&(!resp_fifo_empty)&(!id_resp_fifo_empty);
	assign ready_for_read = (~rvalid & ~bvalid) | (rvalid & rready) | (bvalid & bready);
	assign read_en = (!rdata_fifo_empty)&(!resp_fifo_empty)&(!id_resp_fifo_empty)&ready_for_read;

    assign rdata_r_en = read_en;
    assign resp_r_en = read_en;
    assign id_resp_r_en = read_en;

	//reg  ready_for_read;
	//always@(posedge aclk or negedge aresetn) begin
    //    if(!aresetn)begin
    //        ready_for_read <= 'b1;
    //    end
    //    else if(rvalid == 1'b1)begin
	//		if(rready == 1'b1) begin
    //            ready_for_read <= 'b1;
	//		end
	//		else begin
    //            ready_for_read <= 'b0;
	//		end
    //    end
    //    else if(bvalid == 1'b1)begin
	//		if(bready == 1'b1) begin
    //            ready_for_read <= 'b1;
	//		end
	//		else begin
    //            ready_for_read <= 'b0;
	//		end
    //    end
    //    else begin
    //        ready_for_read <= 'b1;
    //    end
	//end

    always@(posedge aclk or negedge aresetn)
        if(!aresetn)begin
            bid <= 'b0;
            bresp <= 2'b0;
            bvalid <= 1'b0;

            rid <= 'b0;
            rdata <= 64'b0;
            rresp <= 2'b0;
            rlast <= 1'b0;
            rvalid <= 1'b0;
        end
        else if(read_en == 1'b1)begin
            if(axi_id_resp[AXI_ID_WIDTH+1] == 1'b1)begin
                bid <= axi_id_resp[AXI_ID_WIDTH-1:0];
                bresp <= axi_resp;
                bvalid <= axi_id_resp[AXI_ID_WIDTH];

                rid <= 'b0;
                rdata <= 64'b0;
                rresp <= 2'b0;
                rlast <= 1'b0;
                rvalid <= 1'b0;
            end
            else begin
                bid <= 'b0;
                bresp <= 2'b0;
                bvalid <= 1'b0;

                rid <= axi_id_resp[AXI_ID_WIDTH-1:0];
                rdata <= axi_rdata;
                rresp <= axi_resp;
                rlast <= axi_id_resp[AXI_ID_WIDTH];
                rvalid <= 1'b1;
            end
        end
        else if(rvalid == 1'b1 && rready == 1'b0)begin
            bid <= 'b0;
            bresp <= 2'b0;
            bvalid <= 1'b0;

            rid <= rid;
            rdata <= rdata;
            rresp <= rresp;
            rlast <= rlast;
            rvalid <= 1'b1;
        end
        else if(bvalid == 1'b1 && bready == 1'b0)begin
            bid <= bid;
            bresp <= bresp;
            bvalid <= 1'b1;

            rid <= 'b0;
            rdata <= 64'b0;
            rresp <= 2'b0;
            rlast <= 1'b0;
            rvalid <= 1'b0;
        end
        else if(fifo_empty == 1'b1)begin
            bid <= 'b0;
            bresp <= 2'b0;
            bvalid <= 1'b0;

            rid <= 'b0;
            rdata <= 64'b0;
            rresp <= 2'b0;
            rlast <= 1'b0;
            rvalid <= 1'b0;
        end


endmodule
