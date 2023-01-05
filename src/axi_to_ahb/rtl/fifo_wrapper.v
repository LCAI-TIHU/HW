module fifo_wrapper #(
  parameter AXI_ID_WIDTH = 8   
)(
    input                          aclk,
    input                          aresetn,
    input                          hclk,
    input                          hresetn,
    //addr_fifo
    input  [31:0]                  axi_addr,
    input                          addr_w_en,
    input                          addr_r_en,
    output [31:0]                  ahb_addr,
    output                         addr_fifo_full,
    output                         addr_fifo_empty,
    //data_fifo
    input  [63:0]                  axi_data,
    input                          data_w_en,
    input                          data_r_en,
    output [63:0]                  ahb_data,
    output                         data_fifo_full,
    output                         data_fifo_empty,
    // write or read state fifo (1 write   0 read)
    input                          axi_write,
    input                          state_w_en,
    input                          state_r_en,
    output                         ahb_write,
    output                         state_fifo_full,
    output                         state_fifo_empty,
    //id_send_fifo
    input  [AXI_ID_WIDTH+1-1:0]    axi_id,
    input                          id_send_w_en,
    input                          id_send_r_en,
    output [AXI_ID_WIDTH+1-1:0]    ahb_id,
    output                         id_send_fifo_full,
    output                         id_send_fifo_empty,
    //size_fifo
    input  [2:0]                   axi_size,
    input                          size_w_en,
    input                          size_r_en,
    output [2:0]                   ahb_size,
    output                         size_fifo_full,
    output                         size_fifo_empty,
    //rdata_fifo
    input  [63:0]                  ahb_rdata,
    input                          rdata_w_en,
    input                          rdata_r_en,
    output [63:0]                  axi_rdata,
    output                         rdata_fifo_full,
    output                         rdata_fifo_empty,
    //resp_fifo
    input  [1:0]                   ahb_resp,
    input                          resp_w_en,
    input                          resp_r_en,
    output [1:0]                   axi_resp,
    output                         resp_fifo_full,
    output                         resp_fifo_empty,
    //id_resp
    input  [AXI_ID_WIDTH+2-1:0]    ahb_id_resp,
    input                          id_resp_w_en,
    input                          id_resp_r_en,
    output [AXI_ID_WIDTH+2-1:0]    axi_id_resp,
    output                         id_resp_fifo_full,
    output                         id_resp_fifo_empty
);

//ahb to axi

id_resp_fifo 
#(
  .AXI_ID_WIDTH(AXI_ID_WIDTH)
) id_resp_fifo
(
    .wclk(hclk),
    .rclk(aclk),
    .resetn(aresetn),
    .data_in(ahb_id_resp),
    .write_en(id_resp_w_en),
    .read_en(id_resp_r_en),
    .data_out(axi_id_resp),
    .full(id_resp_fifo_full),
    .empty(id_resp_fifo_empty)
);

resp_fifo resp_fifo_mod(
    .wclk(hclk),
    .rclk(aclk),
    .resetn(aresetn),
    .data_in(ahb_resp),
    .write_en(resp_w_en),
    .read_en(resp_r_en),
    .data_out(axi_resp),
    .full(resp_fifo_full),
    .empty(resp_fifo_empty)
);

rdata_fifo rdata_fifo_mod(
    .wclk(hclk),
    .rclk(aclk),
    .resetn(aresetn),
    .data_in(ahb_rdata),
    .write_en(rdata_w_en),
    .read_en(rdata_r_en),
    .data_out(axi_rdata),
    .full(rdata_fifo_full),
    .empty(rdata_fifo_empty)
);



//axi to ahb
size_fifo size_fifo_mod(
    .wclk(aclk),
    .rclk(hclk),
    .resetn(aresetn),
    .data_in(axi_size),
    .write_en(size_w_en),
    .read_en(size_r_en),
    .data_out(ahb_size),
    .full(size_fifo_full),
    .empty(size_fifo_empty)
);

id_send_fifo 
#(
  .AXI_ID_WIDTH(AXI_ID_WIDTH)
) id_send_fifo_mod
(
    .wclk(aclk),
    .rclk(hclk),
    .resetn(aresetn),
    .data_in(axi_id),
    .write_en(id_send_w_en),
    .read_en(id_send_r_en),
    .data_out(ahb_id),
    .full(id_send_fifo_full),
    .empty(id_send_fifo_empty)
);

write_fifo write_fifo_mod(
    .wclk(aclk),
    .rclk(hclk),
    .resetn(aresetn),
    .data_in(axi_write),
    .write_en(state_w_en),
    .read_en(state_r_en),
    .data_out(ahb_write),
    .full(state_fifo_full),
    .empty(state_fifo_empty)
);

data_fifo data_fifo_mod(
    .wclk(aclk),
    .rclk(hclk),
    .resetn(aresetn),
    .data_in(axi_data),
    .write_en(data_w_en),
    .read_en(data_r_en),
    .data_out(ahb_data),
    .full(data_fifo_full),
    .empty(data_fifo_empty)
);

addr_fifo addr_fifo_mod(
    .wclk(aclk),
    .rclk(hclk),
    .resetn(aresetn),
    .data_in(axi_addr),
    .write_en(addr_w_en),
    .read_en(addr_r_en),
    .data_out(ahb_addr),
    .full(addr_fifo_full),
    .empty(addr_fifo_empty)
);

endmodule
