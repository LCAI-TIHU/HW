module axi2fifo #(
  parameter AXI_ID_WIDTH = 8   
)(
    input                             aclk,
    input                             aresetn,
    //aw channel
    input       [AXI_ID_WIDTH-1:0]    awid,
    input       [31:0]                awaddr,
    input       [7:0]                 awlen,
    input       [2:0]                 awsize,
    input       [1:0]                 awburst,
    input                             awvalid,
    output                            awready,
    //w channel
    input       [63:0]                wdata,
    input       [7:0]                 wstrb,
    input                             wlast,
    input                             wvalid,
    output                            wready,
    //ar channel
    input       [AXI_ID_WIDTH-1:0]    arid,
    input       [31:0]                araddr,
    input       [7:0]                 arlen,
    input       [2:0]                 arsize,
    input       [1:0]                 arburst,
    input                             arvalid,
    output                            arready,
    //addr fifo in
    output reg  [31:0]                axi_addr,
    output reg                        addr_w_en,
    input                             addr_fifo_full,
    //data fifo in
    output reg  [63:0]                axi_data,
    output reg                        data_w_en,
    input                             data_fifo_full,
    //write fifo in
    output reg                        axi_write,
    output reg                        state_w_en,
    input                             state_fifo_full,
    //id_send fifo in
    output reg  [AXI_ID_WIDTH+1-1:0]  axi_id,
    output reg                        id_send_w_en,
    input                             id_send_fifo_full,
    //size fifo
    output reg  [2:0]                 axi_size,
    output reg                        size_w_en,
    input                             size_fifo_full
);//rlast state set at highest bit of id fifo

    parameter
                        IDLE         = 6'b000001,
                        WRITE        = 6'b000010,
                        WRITE_WRAP   = 6'b000100,
                        READ         = 6'b001000,
                        READ_INCR    = 6'b010000,
                        READ_WRAP    = 6'b100000;

    //aw channel
    reg        [AXI_ID_WIDTH-1:0]     awid_reg;
    reg        [31:0]                 awaddr_reg;
    reg        [7:0]                  awlen_reg;
    reg        [2:0]                  awsize_reg;
    reg        [1:0]                  awburst_reg;
    reg                               awvalid_reg;
    //ar channel
    reg        [AXI_ID_WIDTH-1:0]     arid_reg;
    reg        [31:0]                 araddr_reg;
    reg        [7:0]                  arlen_reg;
    reg        [2:0]                  arsize_reg;
    reg        [1:0]                  arburst_reg;
    reg                               arvalid_reg;

    reg                               write_finished,read_finished;

    reg     [7:0]                     awlen_temp;
    reg     [7:0]                     arlen_temp;
    reg     [31:0]                    waddr_upper_bound,waddr_lower_bound,raddr_upper_bound,raddr_lower_bound;
    reg                               lower_bound_shift;

    reg     [5:0]                     cstate,nstate;
    
    reg                               single_write_flag;

    wire    [63:0]                    data_mask;

    wire                              fifo_access;
    
    assign fifo_access = addr_fifo_full|data_fifo_full|id_send_fifo_full|state_fifo_full|size_fifo_full;

    assign data_mask[7:0]   = wstrb[0]?8'b1111_1111:8'b0000_0000;
    assign data_mask[15:8]  = wstrb[1]?8'b1111_1111:8'b0000_0000;
    assign data_mask[23:16] = wstrb[2]?8'b1111_1111:8'b0000_0000;
    assign data_mask[31:24] = wstrb[3]?8'b1111_1111:8'b0000_0000;
    assign data_mask[39:32] = wstrb[4]?8'b1111_1111:8'b0000_0000;
    assign data_mask[47:40] = wstrb[5]?8'b1111_1111:8'b0000_0000;
    assign data_mask[55:48] = wstrb[6]?8'b1111_1111:8'b0000_0000;
    assign data_mask[63:56] = wstrb[7]?8'b1111_1111:8'b0000_0000;

    //write control
    always@(posedge aclk or negedge aresetn)
        if(!aresetn)
            write_finished <= 1'b1;
        else if(wlast == 1'b1 && fifo_access == 1'b0)
            write_finished <= 1'b1;
        else if(wvalid == 1'b1)
            write_finished <= 1'b0;
        else
            write_finished <= write_finished;

    always@(posedge aclk or negedge aresetn)
        if(!aresetn)begin
            awid_reg <= 'b0;
            awaddr_reg <= 32'b0;
            awlen_reg <= 8'b0;
            awsize_reg <= 3'b0;
            awburst_reg <= 2'b0;    
        end
        else if(write_finished == 1'b1)begin
            awid_reg <= awid;
            awaddr_reg <= awaddr;
            awlen_reg <= awlen;
            awsize_reg <= awsize;
            awburst_reg <= awburst;
        end

    always@(posedge aclk or negedge aresetn)
        if(!aresetn)begin
            waddr_upper_bound <= 32'b0;
            waddr_lower_bound <= 32'b0;
        end
        else if(awburst == 2'b10 && write_finished == 1'b1)begin
            waddr_lower_bound <= (awaddr/((8'd1<<awsize)*(awlen+1'b1)))*(8'd1<<awsize)*(awlen+1'b1);
            waddr_upper_bound <= (awaddr/((8'd1<<awsize)*(awlen+1'b1)))*(8'd1<<awsize)*(awlen+1'b1) + (8'd1<<awsize)*(awlen+1'b1);
        end
        else if(lower_bound_shift == 1'b1 || (write_finished == 1'b0 && (awaddr_reg + awlen_temp*(8'b1<<awsize_reg) >= waddr_upper_bound)))
            waddr_lower_bound <= waddr_lower_bound + (8'b1<<awsize_reg);

    always@(posedge aclk or negedge aresetn)
        if(!aresetn)
            awlen_temp <= 8'b0;
        else if(wlast == 1'b1 && fifo_access == 1'b0)
            awlen_temp <= 8'b0;
        //else if(wvalid == 1'b1 && fifo_access == 1'b0)
        else if(wvalid && wready && fifo_access == 1'b0)
            awlen_temp <= awlen_temp + 1'b1;
        else
            awlen_temp <= awlen_temp;

    assign awready = ~fifo_access && read_finished;
    assign wready  = ~fifo_access && read_finished;    
    
    //read control
    always@(posedge aclk or negedge aresetn)
        if(!aresetn)
            read_finished <= 1'b1;
        else if((nstate == READ_INCR || nstate == READ_WRAP) && read_finished == 1'b1 && arlen != 8'b0)
            read_finished <= 1'b0;
        else if(arlen_reg == arlen_temp && fifo_access == 1'b0)
            read_finished <= 1'b1;
        else
            read_finished <= read_finished;

    always@(posedge aclk or negedge aresetn)
        if(!aresetn)begin
            arid_reg <= 'b0;
            araddr_reg <= 32'b0;
            arlen_reg <= 8'b0;
            arsize_reg <= 3'b0;
            arburst_reg <= 2'b0;    
        end
        else if(read_finished == 1'b1)begin
            arid_reg <= arid;
            araddr_reg <= araddr;
            arlen_reg <= arlen;
            arsize_reg <= arsize;
            arburst_reg <= arburst;
        end

    always@(posedge aclk or negedge aresetn)
        if(!aresetn)
            arlen_temp <= 8'b0;
		else if(/*cstate==WRITE || cstate==WRITE_WRAP || */nstate==WRITE || nstate==WRITE_WRAP)
            arlen_temp <= 8'b0;
        else if(arlen_reg == arlen_temp && read_finished == 1'b0 && fifo_access == 1'b0)
            arlen_temp <= 8'b0;
        else if(arvalid == 1'b1 && arlen != arlen_temp && fifo_access == 1'b0 && read_finished == 1'b1)
        //else if(arvalid && arready && arlen != arlen_temp && fifo_access == 1'b0 && read_finished == 1'b1)
            arlen_temp <= arlen_temp + 1'b1;
        else if(arlen_reg != arlen_temp && fifo_access == 1'b0 && read_finished == 1'b0)
            arlen_temp <= arlen_temp + 1'b1;
        else
            arlen_temp <= arlen_temp;

    always@(posedge aclk or negedge aresetn)
        if(!aresetn)begin
            raddr_upper_bound <= 32'b0;
            raddr_lower_bound <= 32'b0;
        end
        else if(arburst == 2'b10 && read_finished == 1'b1)begin
            raddr_lower_bound <= (araddr/((8'd1<<arsize)*(arlen+1'b1)))*(8'd1<<arsize)*(arlen+1'b1);
            raddr_upper_bound <= (araddr/((8'd1<<arsize)*(arlen+1'b1)))*(8'd1<<arsize)*(arlen+1'b1) + (8'd1<<arsize)*(arlen+1'b1);
        end
        else if(lower_bound_shift == 1'b1 || (read_finished == 1'b0 && (araddr_reg + arlen_temp*(8'b1<<arsize_reg) >= raddr_upper_bound)))
            raddr_lower_bound <= raddr_lower_bound + (1'b1<<arsize_reg);


    assign arready = (write_finished==1'b0 || read_finished == 1'b0 || fifo_access == 1'b1 || (awvalid&awready) || (nstate==WRITE) || (nstate==WRITE_WRAP)) ? 1'b0 : 1'b1;

    //state machine
    always@(posedge aclk or negedge aresetn)
        if(!aresetn)
            cstate <= IDLE;
        else
            cstate <= nstate;

    always@(*)
        case(cstate)
            IDLE:begin
                if(awvalid == 1'b1 && (awburst == 2'b0 || awburst == 2'b1))
                    nstate = WRITE;
                else if(awvalid == 1'b1 && awburst == 2'b10)
                    nstate = WRITE_WRAP;
                else if(arvalid == 1'b1 && arburst == 2'b0)
                    nstate = READ;
                else if(arvalid == 1'b1 && arburst == 2'b1)
                    nstate = READ_INCR;
                else if(arvalid == 1'b1 && arburst == 2'b10)
                    nstate = READ_WRAP;
                else
                    nstate = IDLE;
            end
            WRITE:begin
                if(arvalid == 1'b0 && awvalid == 1'b0 && write_finished == 1'b1 && single_write_flag == 1'b1)
                    nstate = IDLE;
                else if(awvalid == 1'b1 && awburst == 2'b10 && write_finished == 1'b1 && single_write_flag == 1'b1)
                    nstate = WRITE_WRAP;
                else if(arvalid == 1'b1 && arburst == 2'b0 && write_finished == 1'b1 && single_write_flag == 1'b1)
                    nstate = READ;
                else if(arvalid == 1'b1 && arburst == 2'b1 && write_finished == 1'b1 && single_write_flag == 1'b1)
                    nstate = READ_INCR;
                else if(arvalid == 1'b1 && arburst == 2'b10 && write_finished == 1'b1 && single_write_flag == 1'b1)
                    nstate = READ_WRAP;
                else
                    nstate = WRITE;    
            end
            WRITE_WRAP:begin
                if(arvalid == 1'b0 && awvalid == 1'b0 && write_finished == 1'b1)
                    nstate = IDLE;
                else if(awvalid == 1'b1 && (awburst == 2'b0 || awburst == 2'b1) && write_finished == 1'b1)
                    nstate = WRITE;
                else if(arvalid == 1'b1 && arburst == 2'b0 && write_finished == 1'b1)
                    nstate = READ;
                else if(arvalid == 1'b1 && arburst == 2'b1 && write_finished == 1'b1)
                    nstate = READ_INCR;
                else if(arvalid == 1'b1 && arburst == 2'b10 && write_finished == 1'b1)
                    nstate = READ_WRAP;
                else
                    nstate = WRITE_WRAP;    
            end
            READ:begin
                if(arvalid == 1'b0 && awvalid == 1'b0 && read_finished == 1'b1)
                    nstate = IDLE;
                else if(awvalid == 1'b1 && (awburst == 2'b0 || awburst == 2'b1) && read_finished == 1'b1)
                    nstate = WRITE;
                else if(awvalid == 1'b1 && awburst == 2'b10 && read_finished == 1'b1)
                    nstate = WRITE_WRAP;
                else if(arvalid == 1'b1 && arburst == 2'b1 && read_finished == 1'b1)
                    nstate = READ_INCR;
                else if(arvalid == 1'b1 && arburst == 2'b10 && read_finished == 1'b1)
                    nstate = READ_WRAP;
                else
                    nstate = READ;    
            end
            READ_INCR:begin
                if(arvalid == 1'b0 && awvalid == 1'b0 && read_finished == 1'b1)
                    nstate = IDLE;
                else if(awvalid == 1'b1 && (awburst == 2'b0 || awburst == 2'b1) && read_finished == 1'b1)
                    nstate = WRITE;
                else if(awvalid == 1'b1 && awburst == 2'b10 && read_finished == 1'b1)
                    nstate = WRITE_WRAP;
                else if(arvalid == 1'b1 && arburst == 2'b0 && read_finished == 1'b1)
                    nstate = READ;
                else if(arvalid == 1'b1 && arburst == 2'b10 && read_finished == 1'b1)
                    nstate = READ_WRAP;
                else
                    nstate = READ_INCR;    
            end
            READ_WRAP:begin
                if(arvalid == 1'b0 && awvalid == 1'b0 && read_finished == 1'b1)
                    nstate = IDLE;
                else if(awvalid == 1'b1 && (awburst == 2'b0 || awburst == 2'b1) && read_finished == 1'b1)
                    nstate = WRITE;
                else if(awvalid == 1'b1 && awburst == 2'b10 && read_finished == 1'b1)
                    nstate = WRITE_WRAP;
                else if(arvalid == 1'b1 && arburst == 2'b0 && read_finished == 1'b1)
                    nstate = READ;
                else if(arvalid == 1'b1 && arburst == 2'b1 && read_finished == 1'b1)
                    nstate = READ_INCR;
                else
                    nstate = READ_WRAP;    
            end
        endcase

    always@(posedge aclk or negedge aresetn)
        if(!aresetn)begin
            axi_addr <= 31'b0;
            axi_data <= 64'b0;
            axi_write <= 1'b1;
            axi_id <= 'b0;
            axi_size <= 3'b0;
            addr_w_en <= 1'b0;
            data_w_en <= 1'b0;
            state_w_en <= 1'b0;
            id_send_w_en <= 1'b0;
            size_w_en <= 1'b0;
            lower_bound_shift <= 1'b0;
            single_write_flag <= 1'b0;
        end
        else
            case(nstate)
                IDLE:begin
                    axi_addr <= 31'b0;
                    axi_data <= 64'b0;
                    axi_write <= 1'b1;
                    axi_id <= 'b0;
                    axi_size <= 3'b0;
                    addr_w_en <= 1'b0;
                    data_w_en <= 1'b0;
                    state_w_en <= 1'b0;
                    id_send_w_en <= 1'b0;
                    size_w_en <= 1'b0;
                    lower_bound_shift <= 1'b0;
                    single_write_flag <= 1'b0;
                end
                WRITE:begin
                    lower_bound_shift <= 1'b0;
                    if(wvalid == 1'b1 && fifo_access == 1'b0 && write_finished == 1'b1)begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= awaddr + awlen_temp*(8'b1<<awsize);
                        axi_data <= wdata&data_mask;
                        axi_write <= 1'b1;
                        axi_size <= awsize;
                        single_write_flag <= 1'b1;
                        if(wlast == 1'b1)
                            axi_id <= {1'b1,awid};
                        else
                            axi_id <= {1'b0,awid};
                    end
                    else if(wvalid == 1'b1 && fifo_access == 1'b0 && write_finished == 1'b0)begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= awaddr_reg + awlen_temp*(8'b1<<awsize_reg);
                        axi_data <= wdata&data_mask;
                        axi_write <= 1'b1;
                        axi_size <= awsize_reg;
                        single_write_flag <= 1'b1;
                        if(wlast == 1'b1)
                            axi_id <= {1'b1,awid_reg};
                        else
                            axi_id <= {1'b0,awid_reg};
                    end
                    else begin
                        axi_addr <= 31'b0;
                        axi_data <= 64'b0;
                        axi_write <= 1'b1;
                        axi_id <= 'b0;
                        axi_size <= 3'b0;
                        addr_w_en <= 1'b0;
                        data_w_en <= 1'b0;
                        state_w_en <= 1'b0;
                        id_send_w_en <= 1'b0;
                        size_w_en <= 1'b0;
                    end
                end
                WRITE_WRAP:begin
                    single_write_flag <= 1'b0;
                    if(write_finished == 1'b1 && (awaddr + (8'b1<<awsize) >= ((awaddr/((8'b1<<awsize)*(awlen+1'b1)))*(8'b1<<awsize)*(awlen+1'b1) + (8'b1<<awsize)*(awlen+1'b1))))
                        lower_bound_shift <= 1'b1;
                    else if(write_finished == 1'b0 && (awaddr_reg + awlen_temp*(8'b1<<awsize_reg) >= waddr_upper_bound))
                        lower_bound_shift <= 1'b1;
                    else
                        lower_bound_shift <= 1'b0;
                    if(wvalid == 1'b1 && fifo_access == 1'b0 && write_finished == 1'b1)begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= awaddr + awlen_temp*(8'b1<<awsize);
                        axi_data <= wdata&data_mask;
                        axi_write <= 1'b1;
                        axi_size <= awsize;
                        if(wlast == 1'b1)
                            axi_id <= {1'b1,awid};
                        else
                            axi_id <= {1'b0,awid};
                    end
                    else if(wvalid == 1'b1 && fifo_access == 1'b0 && write_finished == 1'b0 && (awaddr_reg + awlen_temp*(8'b1<<awsize_reg) < waddr_upper_bound))begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= awaddr_reg + awlen_temp*(8'b1<<awsize_reg);
                        axi_data <= wdata&data_mask;
                        axi_write <= 1'b1;
                        axi_size <= awsize_reg;
                        if(wlast == 1'b1)
                            axi_id <= {1'b1,awid_reg};
                        else
                            axi_id <= {1'b0,awid_reg};
                    end
                    else if(wvalid == 1'b1 && fifo_access == 1'b0 && write_finished == 1'b0 && (awaddr_reg + awlen_temp*(8'b1<<awsize_reg) >= waddr_upper_bound))begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= waddr_lower_bound;
                        axi_data <= wdata&data_mask;
                        axi_write <= 1'b1;
                        axi_size <= awsize_reg;
                        if(wlast == 1'b1)
                            axi_id <= {1'b1,awid_reg};
                        else
                            axi_id <= {1'b0,awid_reg};
                    end
                    else begin
                        axi_addr <= 31'b0;
                        axi_data <= 64'b0;
                        axi_write <= 1'b1;
                        axi_id <= 'b0;
                        axi_size <= 3'b0;
                        addr_w_en <= 1'b0;
                        data_w_en <= 1'b0;
                        state_w_en <= 1'b0;
                        id_send_w_en <= 1'b0;
                        size_w_en <= 1'b0;
                    end
                end
                READ:begin
                    single_write_flag <= 1'b0;
                    lower_bound_shift <= 1'b0;
                    if(arvalid == 1'b1 && fifo_access == 1'b0)begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= araddr;
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_size <= arsize;
                        axi_id <= {1'b1,arid};
                    end
                    else begin
                        axi_addr <= 31'b0;
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_id <= 'b0;
                        axi_size <= 3'b0;
                        addr_w_en <= 1'b0;
                        data_w_en <= 1'b0;
                        state_w_en <= 1'b0;
                        id_send_w_en <= 1'b0;
                        size_w_en <= 1'b0;
                    end
                end
                READ_INCR:begin
                    single_write_flag <= 1'b0;
                    lower_bound_shift <= 1'b0;
                    if(arvalid == 1'b1 && fifo_access == 1'b0 && read_finished == 1'b1)begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= araddr + arlen_temp*(8'b1<<arsize);
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_size <= arsize;
                        if(arlen == 8'b0)
                            axi_id <= {1'b1,arid};
                        else
                            axi_id <= {1'b0,arid};
                    end
                    else if(fifo_access == 1'b0 && read_finished == 1'b0)begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= araddr_reg + arlen_temp*(8'b1<<arsize_reg);
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_size <= arsize_reg;
                        if(arlen_temp == arlen_reg)
                            axi_id <= {1'b1,arid_reg};
                        else
                            axi_id <= {1'b0,arid_reg};
                    end
                    else begin
                        axi_addr <= 31'b0;
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_id <= 'b0;
                        axi_size <= 3'b0;
                        addr_w_en <= 1'b0;
                        data_w_en <= 1'b0;
                        state_w_en <= 1'b0;
                        id_send_w_en <= 1'b0;
                        size_w_en <= 1'b0;
                    end
                end
                READ_WRAP:begin
                    single_write_flag <= 1'b0;
                    if(read_finished == 1'b1 && (araddr + (8'b1<<arsize) >= ((araddr/((8'b1<<arsize)*(arlen+1'b1)))*(8'b1<<arsize)*(arlen+1'b1) + (8'b1<<arsize)*(arlen+1'b1))))
                        lower_bound_shift <= 1'b1;
                    else if(read_finished == 1'b0 && (araddr_reg + arlen_temp*(8'b1<<arsize_reg) >= raddr_upper_bound))
                        lower_bound_shift <= 1'b1;
                    else
                        lower_bound_shift <= 1'b0;
                    if(arvalid == 1'b1 && fifo_access == 1'b0 && read_finished == 1'b1)begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= araddr + arlen_temp*(8'b1<<arsize);
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_size <= arsize;    
                        axi_id <= {1'b0,arid};
                    end
                    else if(fifo_access == 1'b0 && read_finished == 1'b0 && (araddr_reg + arlen_temp*(8'b1<<arsize_reg) < raddr_upper_bound))begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= araddr_reg + arlen_temp*(8'b1<<arsize_reg);
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_size <= arsize_reg;
                        if(arlen_temp == arlen_reg)
                            axi_id <= {1'b1,arid_reg};
                        else
                            axi_id <= {1'b0,arid_reg};
                    end
                    else if(fifo_access == 1'b0 && read_finished == 1'b0 && (araddr_reg + arlen_temp*(8'b1<<arsize_reg) >= raddr_upper_bound))begin
                        addr_w_en <= 1'b1;
                        data_w_en <= 1'b1;
                        state_w_en <= 1'b1;
                        id_send_w_en <= 1'b1;
                        size_w_en <= 1'b1;
                        axi_addr <= raddr_lower_bound;
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_size <= arsize_reg;
                        if(arlen_temp == arlen_reg)
                            axi_id <= {1'b1,arid_reg};
                        else
                            axi_id <= {1'b0,arid_reg};
                    end
                    else begin
                        axi_addr <= 31'b0;
                        axi_data <= 64'b0;
                        axi_write <= 1'b0;
                        axi_id <= 'b0;
                        axi_size <= 3'b0;
                        addr_w_en <= 1'b0;
                        data_w_en <= 1'b0;
                        state_w_en <= 1'b0;
                        id_send_w_en <= 1'b0;
                        size_w_en <= 1'b0;
                    end
                end
            endcase

endmodule
