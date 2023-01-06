module axi2ahb_bridge_top #(
  parameter AXI_ID_WIDTH = 8   
)(
    input                       aclk,
    input                       aresetn,
    input                       hclk,
    input                       hresetn,

    //axi side
    //aw channel
    input  [AXI_ID_WIDTH-1:0]   awid,
    input  [31:0]               awaddr,
    input  [7:0]                awlen,
    input  [2:0]                awsize,
    input  [1:0]                awburst,
    input                       awvalid,
    output                      awready,
    //w channel
    input  [63:0]               wdata,
    input  [7:0]                wstrb,
    input                       wlast,
    input                       wvalid,
    output                      wready,
    //ar channel
    input  [AXI_ID_WIDTH-1:0]   arid,
    input  [31:0]               araddr,
    input  [7:0]                arlen,
    input  [2:0]                arsize,
    input  [1:0]                arburst,
    input                       arvalid,
    output                      arready,
    //b response
    output [AXI_ID_WIDTH-1:0]   bid,
    output [1:0]                bresp,
    output                      bvalid,
    input                       bready,
    //r response
    output [AXI_ID_WIDTH-1:0]   rid,
    output [63:0]               rdata,
    output [1:0]                rresp,
    output                      rlast,
    output                      rvalid,
    input                       rready,

    //ahb_side
    //ahb output
    output [31:0]               haddr,
    output [1:0]                htrans,
    output                      hwrite,
    output [2:0]                hsize,
    output [2:0]                hburst,
    output [63:0]               hwdata,
    output                      hbusreq,
    output                      hlock,
    //ahb input
    input  [63:0]               hrdata,
    input                       hready,
    input  [1:0]                hresp,
    input                       hgrant,
    input  [3:0]                hmaster
);

    wire   [31:0]                  axi_addr;
    wire                           addr_w_en;
    wire                           addr_r_en;
    wire   [31:0]                  ahb_addr;
    wire                           addr_fifo_full;
    wire                           addr_fifo_empty;
    //data_fifo
    wire   [63:0]                  axi_data;
    wire                           data_w_en;
    wire                           data_r_en;
    wire   [63:0]                  ahb_data;
    wire                           data_fifo_full;
    wire                           data_fifo_empty;
    // write or read state fifo (1 write   0 read)
    wire                           axi_write;
    wire                           state_w_en;
    wire                           state_r_en;
    wire                           ahb_write;
    wire                           state_fifo_full;
    wire                           state_fifo_empty;
    //id_send_fifo
    wire   [AXI_ID_WIDTH+1-1:0]    axi_id;
    wire                           id_send_w_en;
    wire                           id_send_r_en;
    wire   [AXI_ID_WIDTH+1-1:0]    ahb_id;
    wire                           id_send_fifo_full;
    wire                           id_send_fifo_empty;
    //size_fifo
    wire   [2:0]                   axi_size;
    wire                           size_w_en;
    wire                           size_r_en;
    wire   [2:0]                   ahb_size;
    wire                           size_fifo_full;
    wire                           size_fifo_empty;
    //rdata_fifo
    wire   [63:0]                  ahb_rdata;
    wire                           rdata_w_en;
    wire                           rdata_r_en;
    wire   [63:0]                  axi_rdata;
    wire                           rdata_fifo_full;
    wire                           rdata_fifo_empty;
    //resp_fifo
    wire   [1:0]                   ahb_resp;
    wire                           resp_w_en;
    wire                           resp_r_en;
    wire   [1:0]                   axi_resp;
    wire                           resp_fifo_full;
    wire                           resp_fifo_empty;
    //id_resp
    wire   [AXI_ID_WIDTH+2-1:0]    ahb_id_resp;
    wire                           id_resp_w_en;
    wire                           id_resp_r_en;
    wire   [AXI_ID_WIDTH+2-1:0]    axi_id_resp;
    wire                           id_resp_fifo_full;
    wire                           id_resp_fifo_empty;

axi_controller 
#(
  .AXI_ID_WIDTH(AXI_ID_WIDTH)
) axi_mod 
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
    .size_fifo_full(size_fifo_full),



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
);

fifo_wrapper 
#(
  .AXI_ID_WIDTH(AXI_ID_WIDTH)
) fifo_mod 
(
    .aclk(aclk),
    .aresetn(aresetn),
    .hclk(hclk),
    .hresetn(hresetn),

    .axi_addr(axi_addr),
    .addr_w_en(addr_w_en),
    .addr_r_en(addr_r_en),
    .ahb_addr(ahb_addr),
    .addr_fifo_full(addr_fifo_full),
    .addr_fifo_empty(addr_fifo_empty),

    .axi_data(axi_data),
    .data_w_en(data_w_en),
    .data_r_en(data_r_en),
    .ahb_data(ahb_data),
    .data_fifo_full(data_fifo_full),
    .data_fifo_empty(data_fifo_empty),

    .axi_write(axi_write),
    .state_w_en(state_w_en),
    .state_r_en(state_r_en),
    .ahb_write(ahb_write),
    .state_fifo_full(state_fifo_full),
    .state_fifo_empty(state_fifo_empty),

    .axi_id(axi_id),
    .id_send_w_en(id_send_w_en),
    .id_send_r_en(id_send_r_en),
    .ahb_id(ahb_id),
    .id_send_fifo_full(id_send_fifo_full),
    .id_send_fifo_empty(id_send_fifo_empty),

    .axi_size(axi_size),
    .size_w_en(size_w_en),
    .size_r_en(size_r_en),
    .ahb_size(ahb_size),
    .size_fifo_full(size_fifo_full),
    .size_fifo_empty(size_fifo_empty),

    .ahb_rdata(ahb_rdata),
    .rdata_w_en(rdata_w_en),
    .rdata_r_en(rdata_r_en),
    .axi_rdata(axi_rdata),
    .rdata_fifo_full(rdata_fifo_full),
    .rdata_fifo_empty(rdata_fifo_empty),

    .ahb_resp(ahb_resp),
    .resp_w_en(resp_w_en),
    .resp_r_en(resp_r_en),
    .axi_resp(axi_resp),
    .resp_fifo_full(resp_fifo_full),
    .resp_fifo_empty(resp_fifo_empty),

    .ahb_id_resp(ahb_id_resp),
    .id_resp_w_en(id_resp_w_en),
    .id_resp_r_en(id_resp_r_en),
    .axi_id_resp(axi_id_resp),
    .id_resp_fifo_full(id_resp_fifo_full),
    .id_resp_fifo_empty(id_resp_fifo_empty)
);

ahb_controller 
#(
  .AXI_ID_WIDTH(AXI_ID_WIDTH)
) ahb_mod 
(
    .hclk(hclk),
    .hresetn(hresetn),

    .haddr(haddr),
    .htrans(htrans),
    .hwrite(hwrite),
    .hsize(hsize),
    .hburst(hburst),
    .hwdata(hwdata),
    .hbusreq(hbusreq),
    .hlock(hlock),

    .hrdata(hrdata),
    .hready(hready),
    .hresp(hresp),
    .hgrant(hgrant),
    .hmaster(hmaster),

    .addr_r_en(addr_r_en),
    .ahb_addr(ahb_addr),
    .addr_fifo_empty(addr_fifo_empty),

    .data_r_en(data_r_en),
    .ahb_data(ahb_data),
    .data_fifo_empty(data_fifo_empty),

    .state_r_en(state_r_en),
    .ahb_write(ahb_write),
    .state_fifo_empty(state_fifo_empty),

    .id_send_r_en(id_send_r_en),
    .ahb_id(ahb_id),
    .id_send_fifo_empty(id_send_fifo_empty),

    .size_r_en(size_r_en),
    .ahb_size(ahb_size),
    .size_fifo_empty(size_fifo_empty),

    .rdata_w_en(rdata_w_en),
    .ahb_rdata(ahb_rdata),
    .rdata_fifo_full(rdata_fifo_full),
    .rdata_fifo_empty(rdata_fifo_empty),

    .resp_w_en(resp_w_en),
    .ahb_resp(ahb_resp),
    .resp_fifo_full(resp_fifo_full),

    .id_resp_w_en(id_resp_w_en),
    .ahb_id_resp(ahb_id_resp),
    .id_resp_fifo_full(id_resp_fifo_full)
);

endmodule
