// Do not edit - auto-generated
module plic_regs (
  input logic [30:0][2:0] prio_i,
  output logic [30:0][2:0] prio_o,
  output logic [30:0] prio_we_o,
  output logic [30:0] prio_re_o,
  input logic [0:0][30:0] ip_i,
  output logic [0:0] ip_re_o,
  input logic [1:0][30:0] ie_i,
  output logic [1:0][30:0] ie_o,
  output logic [1:0] ie_we_o,
  output logic [1:0] ie_re_o,
  input logic [1:0][2:0] threshold_i,
  output logic [1:0][2:0] threshold_o,
  output logic [1:0] threshold_we_o,
  output logic [1:0] threshold_re_o,
  input logic [1:0][4:0] cc_i,
  output logic [1:0][4:0] cc_o,
  output logic [1:0] cc_we_o,
  output logic [1:0] cc_re_o,
  // Bus Interface
  input  reg_intf::reg_intf_req_a32_d32 req_i,
  output reg_intf::reg_intf_resp_d32    resp_o
);
always_comb begin
  resp_o.ready = 1'b1;
  resp_o.rdata = '0;
  resp_o.error = '0;
  prio_o = '0;
  prio_we_o = '0;
  prio_re_o = '0;
  ie_o = '0;
  ie_we_o = '0;
  ie_re_o = '0;
  threshold_o = '0;
  threshold_we_o = '0;
  threshold_re_o = '0;
  cc_o = '0;
  cc_we_o = '0;
  cc_re_o = '0;
  if (req_i.valid) begin
    if (req_i.write) begin
      unique case(req_i.addr)
        32'h40b00000: begin
          prio_o[0][2:0] = req_i.wdata[2:0];
          prio_we_o[0] = 1'b1;
        end
        32'h40b00004: begin
          prio_o[1][2:0] = req_i.wdata[2:0];
          prio_we_o[1] = 1'b1;
        end
        32'h40b00008: begin
          prio_o[2][2:0] = req_i.wdata[2:0];
          prio_we_o[2] = 1'b1;
        end
        32'h40b0000c: begin
          prio_o[3][2:0] = req_i.wdata[2:0];
          prio_we_o[3] = 1'b1;
        end
        32'h40b00010: begin
          prio_o[4][2:0] = req_i.wdata[2:0];
          prio_we_o[4] = 1'b1;
        end
        32'h40b00014: begin
          prio_o[5][2:0] = req_i.wdata[2:0];
          prio_we_o[5] = 1'b1;
        end
        32'h40b00018: begin
          prio_o[6][2:0] = req_i.wdata[2:0];
          prio_we_o[6] = 1'b1;
        end
        32'h40b0001c: begin
          prio_o[7][2:0] = req_i.wdata[2:0];
          prio_we_o[7] = 1'b1;
        end
        32'h40b00020: begin
          prio_o[8][2:0] = req_i.wdata[2:0];
          prio_we_o[8] = 1'b1;
        end
        32'h40b00024: begin
          prio_o[9][2:0] = req_i.wdata[2:0];
          prio_we_o[9] = 1'b1;
        end
        32'h40b00028: begin
          prio_o[10][2:0] = req_i.wdata[2:0];
          prio_we_o[10] = 1'b1;
        end
        32'h40b0002c: begin
          prio_o[11][2:0] = req_i.wdata[2:0];
          prio_we_o[11] = 1'b1;
        end
        32'h40b00030: begin
          prio_o[12][2:0] = req_i.wdata[2:0];
          prio_we_o[12] = 1'b1;
        end
        32'h40b00034: begin
          prio_o[13][2:0] = req_i.wdata[2:0];
          prio_we_o[13] = 1'b1;
        end
        32'h40b00038: begin
          prio_o[14][2:0] = req_i.wdata[2:0];
          prio_we_o[14] = 1'b1;
        end
        32'h40b0003c: begin
          prio_o[15][2:0] = req_i.wdata[2:0];
          prio_we_o[15] = 1'b1;
        end
        32'h40b00040: begin
          prio_o[16][2:0] = req_i.wdata[2:0];
          prio_we_o[16] = 1'b1;
        end
        32'h40b00044: begin
          prio_o[17][2:0] = req_i.wdata[2:0];
          prio_we_o[17] = 1'b1;
        end
        32'h40b00048: begin
          prio_o[18][2:0] = req_i.wdata[2:0];
          prio_we_o[18] = 1'b1;
        end
        32'h40b0004c: begin
          prio_o[19][2:0] = req_i.wdata[2:0];
          prio_we_o[19] = 1'b1;
        end
        32'h40b00050: begin
          prio_o[20][2:0] = req_i.wdata[2:0];
          prio_we_o[20] = 1'b1;
        end
        32'h40b00054: begin
          prio_o[21][2:0] = req_i.wdata[2:0];
          prio_we_o[21] = 1'b1;
        end
        32'h40b00058: begin
          prio_o[22][2:0] = req_i.wdata[2:0];
          prio_we_o[22] = 1'b1;
        end
        32'h40b0005c: begin
          prio_o[23][2:0] = req_i.wdata[2:0];
          prio_we_o[23] = 1'b1;
        end
        32'h40b00060: begin
          prio_o[24][2:0] = req_i.wdata[2:0];
          prio_we_o[24] = 1'b1;
        end
        32'h40b00064: begin
          prio_o[25][2:0] = req_i.wdata[2:0];
          prio_we_o[25] = 1'b1;
        end
        32'h40b00068: begin
          prio_o[26][2:0] = req_i.wdata[2:0];
          prio_we_o[26] = 1'b1;
        end
        32'h40b0006c: begin
          prio_o[27][2:0] = req_i.wdata[2:0];
          prio_we_o[27] = 1'b1;
        end
        32'h40b00070: begin
          prio_o[28][2:0] = req_i.wdata[2:0];
          prio_we_o[28] = 1'b1;
        end
        32'h40b00074: begin
          prio_o[29][2:0] = req_i.wdata[2:0];
          prio_we_o[29] = 1'b1;
        end
        32'h40b00078: begin
          prio_o[30][2:0] = req_i.wdata[2:0];
          prio_we_o[30] = 1'b1;
        end
        32'h40b02000: begin
          ie_o[0][30:0] = req_i.wdata[30:0];
          ie_we_o[0] = 1'b1;
        end
        32'h40b02080: begin
          ie_o[1][30:0] = req_i.wdata[30:0];
          ie_we_o[1] = 1'b1;
        end
        32'h40d00000: begin
          threshold_o[0][2:0] = req_i.wdata[2:0];
          threshold_we_o[0] = 1'b1;
        end
        32'h40d01000: begin
          threshold_o[1][2:0] = req_i.wdata[2:0];
          threshold_we_o[1] = 1'b1;
        end
        32'h40d00004: begin
          cc_o[0][4:0] = req_i.wdata[4:0];
          cc_we_o[0] = 1'b1;
        end
        32'h40d01004: begin
          cc_o[1][4:0] = req_i.wdata[4:0];
          cc_we_o[1] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end else begin
      unique case(req_i.addr)
        32'h40b00000: begin
          resp_o.rdata[2:0] = prio_i[0][2:0];
          prio_re_o[0] = 1'b1;
        end
        32'h40b00004: begin
          resp_o.rdata[2:0] = prio_i[1][2:0];
          prio_re_o[1] = 1'b1;
        end
        32'h40b00008: begin
          resp_o.rdata[2:0] = prio_i[2][2:0];
          prio_re_o[2] = 1'b1;
        end
        32'h40b0000c: begin
          resp_o.rdata[2:0] = prio_i[3][2:0];
          prio_re_o[3] = 1'b1;
        end
        32'h40b00010: begin
          resp_o.rdata[2:0] = prio_i[4][2:0];
          prio_re_o[4] = 1'b1;
        end
        32'h40b00014: begin
          resp_o.rdata[2:0] = prio_i[5][2:0];
          prio_re_o[5] = 1'b1;
        end
        32'h40b00018: begin
          resp_o.rdata[2:0] = prio_i[6][2:0];
          prio_re_o[6] = 1'b1;
        end
        32'h40b0001c: begin
          resp_o.rdata[2:0] = prio_i[7][2:0];
          prio_re_o[7] = 1'b1;
        end
        32'h40b00020: begin
          resp_o.rdata[2:0] = prio_i[8][2:0];
          prio_re_o[8] = 1'b1;
        end
        32'h40b00024: begin
          resp_o.rdata[2:0] = prio_i[9][2:0];
          prio_re_o[9] = 1'b1;
        end
        32'h40b00028: begin
          resp_o.rdata[2:0] = prio_i[10][2:0];
          prio_re_o[10] = 1'b1;
        end
        32'h40b0002c: begin
          resp_o.rdata[2:0] = prio_i[11][2:0];
          prio_re_o[11] = 1'b1;
        end
        32'h40b00030: begin
          resp_o.rdata[2:0] = prio_i[12][2:0];
          prio_re_o[12] = 1'b1;
        end
        32'h40b00034: begin
          resp_o.rdata[2:0] = prio_i[13][2:0];
          prio_re_o[13] = 1'b1;
        end
        32'h40b00038: begin
          resp_o.rdata[2:0] = prio_i[14][2:0];
          prio_re_o[14] = 1'b1;
        end
        32'h40b0003c: begin
          resp_o.rdata[2:0] = prio_i[15][2:0];
          prio_re_o[15] = 1'b1;
        end
        32'h40b00040: begin
          resp_o.rdata[2:0] = prio_i[16][2:0];
          prio_re_o[16] = 1'b1;
        end
        32'h40b00044: begin
          resp_o.rdata[2:0] = prio_i[17][2:0];
          prio_re_o[17] = 1'b1;
        end
        32'h40b00048: begin
          resp_o.rdata[2:0] = prio_i[18][2:0];
          prio_re_o[18] = 1'b1;
        end
        32'h40b0004c: begin
          resp_o.rdata[2:0] = prio_i[19][2:0];
          prio_re_o[19] = 1'b1;
        end
        32'h40b00050: begin
          resp_o.rdata[2:0] = prio_i[20][2:0];
          prio_re_o[20] = 1'b1;
        end
        32'h40b00054: begin
          resp_o.rdata[2:0] = prio_i[21][2:0];
          prio_re_o[21] = 1'b1;
        end
        32'h40b00058: begin
          resp_o.rdata[2:0] = prio_i[22][2:0];
          prio_re_o[22] = 1'b1;
        end
        32'h40b0005c: begin
          resp_o.rdata[2:0] = prio_i[23][2:0];
          prio_re_o[23] = 1'b1;
        end
        32'h40b00060: begin
          resp_o.rdata[2:0] = prio_i[24][2:0];
          prio_re_o[24] = 1'b1;
        end
        32'h40b00064: begin
          resp_o.rdata[2:0] = prio_i[25][2:0];
          prio_re_o[25] = 1'b1;
        end
        32'h40b00068: begin
          resp_o.rdata[2:0] = prio_i[26][2:0];
          prio_re_o[26] = 1'b1;
        end
        32'h40b0006c: begin
          resp_o.rdata[2:0] = prio_i[27][2:0];
          prio_re_o[27] = 1'b1;
        end
        32'h40b00070: begin
          resp_o.rdata[2:0] = prio_i[28][2:0];
          prio_re_o[28] = 1'b1;
        end
        32'h40b00074: begin
          resp_o.rdata[2:0] = prio_i[29][2:0];
          prio_re_o[29] = 1'b1;
        end
        32'h40b00078: begin
          resp_o.rdata[2:0] = prio_i[30][2:0];
          prio_re_o[30] = 1'b1;
        end
        32'h40b01000: begin
          resp_o.rdata[30:0] = ip_i[0][30:0];
          ip_re_o[0] = 1'b1;
        end
        32'h40b02000: begin
          resp_o.rdata[30:0] = ie_i[0][30:0];
          ie_re_o[0] = 1'b1;
        end
        32'h40b02080: begin
          resp_o.rdata[30:0] = ie_i[1][30:0];
          ie_re_o[1] = 1'b1;
        end
        32'h40d00000: begin
          resp_o.rdata[2:0] = threshold_i[0][2:0];
          threshold_re_o[0] = 1'b1;
        end
        32'h40d01000: begin
          resp_o.rdata[2:0] = threshold_i[1][2:0];
          threshold_re_o[1] = 1'b1;
        end
        32'h40d00004: begin
          resp_o.rdata[4:0] = cc_i[0][4:0];
          cc_re_o[0] = 1'b1;
        end
        32'h40d01004: begin
          resp_o.rdata[4:0] = cc_i[1][4:0];
          cc_re_o[1] = 1'b1;
        end
        default: resp_o.error = 1'b1;
      endcase
    end
  end
end
endmodule
