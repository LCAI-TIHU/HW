module axi_controller #(
  parameter AXI_ID_WIDTH = 8   
)(
    input                        aclk,
    input                        aresetn,

    //axi2fifo
    //aw channel
    input  [AXI_ID_WIDTH-1:0]    awid,
    input  [31:0]                awaddr,
    input  [7:0]                 awlen,
    input  [2:0]                 awsize,
    input  [1:0]                 awburst,
    input                        awvalid,
    output                       awready,
    //w channel
    input  [63:0]                wdata,
    input  [7:0]                 wstrb,
    input                        wlast,
    input                        wvalid,
    output                       wready,
    //ar channel
    input  [AXI_ID_WIDTH-1:0]    arid,
    input  [31:0]                araddr,
    input  [7:0]                 arlen,
    input  [2:0]                 arsize,
    input  [1:0]                 arburst,
    input                        arvalid,
    output                       arready,
    //addr fifo in
    output [31:0]                axi_addr,
    output                       addr_w_en,
    input                        addr_fifo_full,
    //data fifo in
    output [63:0]                axi_data,
    output                       data_w_en,
    input                        data_fifo_full,
    //write fifo in
    output                       axi_write,
    output                       state_w_en,
    input                        state_fifo_full,
    //id_send fifo in
    output [AXI_ID_WIDTH+1-1:0]  axi_id,
    output                       id_send_w_en,
    input                        id_send_fifo_full,
    //size fifo
    output [2:0]                 axi_size,
    output                       size_w_en,
    input                        size_fifo_full,
    
    //fifo2axi
    //rdata_fifo
    output                       rdata_r_en,
    input  [63:0]                axi_rdata,
    input                        rdata_fifo_empty,
    //resp_fifo
    output                       resp_r_en,
    input  [1:0]                 axi_resp,
    input                        resp_fifo_empty,
    //id_resp
    output                       id_resp_r_en,
    input  [AXI_ID_WIDTH+2-1:0]  axi_id_resp,
    input                        id_resp_fifo_empty,
    //b response
    output [AXI_ID_WIDTH-1:0]    bid,
    output [1:0]                 bresp,
    output                       bvalid,
    input                        bready,
    //r response
    output [AXI_ID_WIDTH-1:0]    rid,
    output [63:0]                rdata,
    output [1:0]                 rresp,
    output                       rlast,
    output                       rvalid,
    input                        rready
);

axi2fifo 
#(
  .AXI_ID_WIDTH(AXI_ID_WIDTH)
) u0
(
    .aclk(aclk),
    .aresetn(aresetn),

    .awid(awid),
    .awaddr(awaddr),
    .awlen(awlen),
    .awsize(awsize),
    .awburst(awburst),
    .awvalid(awvalid),
    .awready(awready),

    .wdata(wdata),
    .wstrb(wstrb),
    .wlast(wlast),
    .wvalid(wvalid),
    .wready(wready),

    .arid(arid),
    .araddr(araddr),
    .arlen(arlen),
    .arsize(arsize),
    .arburst(arburst),
    .arvalid(arvalid),
    .arready(arready),

    .axi_addr(axi_addr),
    .addr_w_en(addr_w_en),
    .addr_fifo_full(addr_fifo_full),

    .axi_data(axi_data),
    .data_w_en(data_w_en),
    .data_fifo_full(data_fifo_full),

    .axi_write(axi_write),
    .state_w_en(state_w_en),
    .state_fifo_full(state_fifo_full),

    .axi_id(axi_id),
    .id_send_w_en(id_send_w_en),
    .id_send_fifo_full(id_send_fifo_full),

    .axi_size(axi_size),
    .size_w_en(size_w_en),
    .size_fifo_full(size_fifo_full)
);//rlast state set at highest bit of id fifo

fifo2axi 
#(
  .AXI_ID_WIDTH(AXI_ID_WIDTH)
) u1
(
    .aclk(aclk),
    .aresetn(aresetn),

    .rdata_r_en(rdata_r_en),
    .axi_rdata(axi_rdata),
    .rdata_fifo_empty(rdata_fifo_empty),

    .resp_r_en(resp_r_en),
    .axi_resp(axi_resp),
    .resp_fifo_empty(resp_fifo_empty),

    .id_resp_r_en(id_resp_r_en),
    .axi_id_resp(axi_id_resp),
    .id_resp_fifo_empty(id_resp_fifo_empty),

    .bid(bid),
    .bresp(bresp),
    .bvalid(bvalid),
    .bready(bready),

    .rid(rid),
    .rdata(rdata),
    .rresp(rresp),
    .rlast(rlast),
    .rvalid(rvalid),
    .rready(rready)
);//read directly

endmodule
