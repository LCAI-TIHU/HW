// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_GLB_CSB_reg.v
module NV_NVDLA_GLB_CSB_reg (
   reg_rd_data
  ,reg_offset
// verilint 498 off
// leda UNUSED_DEC off
  ,reg_wr_data
// verilint 498 on
// leda UNUSED_DEC on
  ,reg_wr_en
  ,nvdla_core_clk
  ,nvdla_core_rstn
  ,bdma_done_mask0
  ,bdma_done_mask1
  ,cacc_done_mask0
  ,cacc_done_mask1
  ,cdma_dat_done_mask0
  ,cdma_dat_done_mask1
  ,cdma_wt_done_mask0
  ,cdma_wt_done_mask1
  ,cdp_done_mask0
  ,cdp_done_mask1
  ,pdp_done_mask0
  ,pdp_done_mask1
  ,rubik_done_mask0
  ,rubik_done_mask1
  ,sdp_done_mask0
  ,sdp_done_mask1
  ,sdp_done_set0_trigger
  ,sdp_done_status0_trigger
  ,bdma_done_set0
  ,bdma_done_set1
  ,cacc_done_set0
  ,cacc_done_set1
  ,cdma_dat_done_set0
  ,cdma_dat_done_set1
  ,cdma_wt_done_set0
  ,cdma_wt_done_set1
  ,cdp_done_set0
  ,cdp_done_set1
  ,pdp_done_set0
  ,pdp_done_set1
  ,rubik_done_set0
  ,rubik_done_set1
  ,sdp_done_set0
  ,sdp_done_set1
  ,bdma_done_status0
  ,bdma_done_status1
  ,cacc_done_status0
  ,cacc_done_status1
  ,cdma_dat_done_status0
  ,cdma_dat_done_status1
  ,cdma_wt_done_status0
  ,cdma_wt_done_status1
  ,cdp_done_status0
  ,cdp_done_status1
  ,pdp_done_status0
  ,pdp_done_status1
  ,rubik_done_status0
  ,rubik_done_status1
  ,sdp_done_status0
  ,sdp_done_status1
  ,csb2nvdla_write
  ,cdma_op_en // modified by jiazhaorong 
  );
wire [7:0] major;
wire [15:0] minor;
wire [31:0] nvdla_glb_s_intr_mask_0_out;
wire [31:0] nvdla_glb_s_intr_set_0_out;
wire [31:0] nvdla_glb_s_intr_status_0_out;
wire [31:0] nvdla_glb_s_sdp_per_counter_0_out  ;
wire [31:0] nvdla_glb_s_cdp_per_counter_0_out  ;
wire [31:0] nvdla_glb_s_pdp_per_counter_0_out  ;
wire [31:0] nvdla_glb_s_cdma_dat_counter_0_out ;
wire [31:0] nvdla_glb_s_cdma_op_en_counter_0_out ;
wire [31:0] nvdla_glb_s_cdma_wt_counter_0_out  ;
wire [31:0] nvdla_glb_s_cacc_per_counter_0_out ;
wire [31:0] nvdla_glb_s_csb_per_counter_0_out ;
wire [31:0] nvdla_glb_s_bdma_per_counter_0_out ;
wire [31:0] nvdla_glb_s_nvdla_hw_version_0_out;
wire [11:0] reg_offset_rd_int;
wire [31:0] reg_offset_wr;
// Register control interface
output [31:0] reg_rd_data;
input [11:0] reg_offset;
input [31:0] reg_wr_data; //(UNUSED_DEC)
input reg_wr_en;
input nvdla_core_clk;
input nvdla_core_rstn;
// Writable register flop/trigger outputs
output bdma_done_mask0;
output bdma_done_mask1;
output cacc_done_mask0;
output cacc_done_mask1;
output cdma_dat_done_mask0;
output cdma_dat_done_mask1;
output cdma_wt_done_mask0;
output cdma_wt_done_mask1;
output cdp_done_mask0;
output cdp_done_mask1;
output pdp_done_mask0;
output pdp_done_mask1;
output rubik_done_mask0;
output rubik_done_mask1;
output sdp_done_mask0;
output sdp_done_mask1;
output sdp_done_set0_trigger;
output sdp_done_status0_trigger;
// Read-only register inputs
input bdma_done_set0;
input bdma_done_set1;
input cacc_done_set0;
input cacc_done_set1;
input cdma_dat_done_set0;
input cdma_dat_done_set1;
input cdma_wt_done_set0;
input cdma_wt_done_set1;
input cdp_done_set0;
input cdp_done_set1;
input pdp_done_set0;
input pdp_done_set1;
input rubik_done_set0;
input rubik_done_set1;
input sdp_done_set0;
input sdp_done_set1;
input bdma_done_status0;
input bdma_done_status1;
input cacc_done_status0;
input cacc_done_status1;
input cdma_dat_done_status0;
input cdma_dat_done_status1;
input cdma_wt_done_status0;
input cdma_wt_done_status1;
input cdp_done_status0;
input cdp_done_status1;
input pdp_done_status0;
input pdp_done_status1;
input rubik_done_status0;
input rubik_done_status1;
input sdp_done_status0;
input sdp_done_status1;
input csb2nvdla_write;
input cdma_op_en; //modified by jiazhaorong
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg bdma_done_mask0;
reg bdma_done_mask1;
reg cacc_done_mask0;
reg cacc_done_mask1;
reg cdma_dat_done_mask0;
reg cdma_dat_done_mask1;
reg cdma_wt_done_mask0;
reg cdma_wt_done_mask1;
reg cdp_done_mask0;
reg cdp_done_mask1;
reg pdp_done_mask0;
reg pdp_done_mask1;
reg [31:0] reg_rd_data;
reg rubik_done_mask0;
reg rubik_done_mask1;
reg sdp_done_mask0;
reg sdp_done_mask1;
reg [31:0] sdp_per_counter ;  
reg [31:0] cdp_per_counter ;  
reg [31:0] pdp_per_counter ;  
reg [31:0] cdma_dat_counter ;  
reg [31:0] cdma_wt_counter ;  
reg [31:0] cacc_per_counter ; 
reg [31:0] csb_per_counter, csb_per_counter_temp; 
reg [31:0] bdma_per_counter ; 
reg [31:0] cdma_op_en_counter;// used for test cdma_op_en start time
reg cdma_op_en_temp;
assign reg_offset_wr = {20'b0 , reg_offset};
wire core_intr_w;
// SCR signals
// Address decode
wire nvdla_glb_s_intr_mask_0_wren = (reg_offset_wr == (32'h4 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_intr_set_0_wren = (reg_offset_wr == (32'h8 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_intr_status_0_wren = (reg_offset_wr == (32'hc & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_sdp_per_counter_0_wren = (reg_offset_wr == (32'h10 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_cdp_per_counter_0_wren = (reg_offset_wr == (32'h14 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_pdp_per_counter_0_wren = (reg_offset_wr == (32'h18 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_cdma_dat_counter_0_wren = (reg_offset_wr == (32'h1c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_cdma_wt_counter_0_wren = (reg_offset_wr == (32'h20 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_cacc_per_counter_0_wren = (reg_offset_wr == (32'h24 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_csb_per_counter_0_wren = (reg_offset_wr == (32'h28 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_bdma_per_counter_0_wren = (reg_offset_wr == (32'h2c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire nvdla_glb_s_nvdla_hw_version_0_wren = (reg_offset_wr == (32'h0 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign major = 8'h31;
assign minor = 16'h3030;
assign nvdla_glb_s_intr_mask_0_out[31:0] = { 10'b0, cacc_done_mask1, cacc_done_mask0, cdma_wt_done_mask1, cdma_wt_done_mask0, cdma_dat_done_mask1, cdma_dat_done_mask0, 6'b0, rubik_done_mask1, rubik_done_mask0, bdma_done_mask1, bdma_done_mask0, pdp_done_mask1, pdp_done_mask0, cdp_done_mask1, cdp_done_mask0, sdp_done_mask1, sdp_done_mask0 };
assign nvdla_glb_s_intr_set_0_out[31:0] = { 10'b0, cacc_done_set1, cacc_done_set0, cdma_wt_done_set1, cdma_wt_done_set0, cdma_dat_done_set1, cdma_dat_done_set0, 6'b0, rubik_done_set1, rubik_done_set0, bdma_done_set1, bdma_done_set0, pdp_done_set1, pdp_done_set0, cdp_done_set1, cdp_done_set0, sdp_done_set1, sdp_done_set0 };
assign nvdla_glb_s_intr_status_0_out[31:0] = { 10'b0, cacc_done_status1, cacc_done_status0, cdma_wt_done_status1, cdma_wt_done_status0, cdma_dat_done_status1, cdma_dat_done_status0, 6'b0, rubik_done_status1, rubik_done_status0, bdma_done_status1, bdma_done_status0, pdp_done_status1, pdp_done_status0, cdp_done_status1, cdp_done_status0, sdp_done_status1, sdp_done_status0 };
assign nvdla_glb_s_sdp_per_counter_0_out  = {sdp_per_counter };  
assign nvdla_glb_s_cdp_per_counter_0_out  = {cdp_per_counter };  
assign nvdla_glb_s_pdp_per_counter_0_out  = {pdp_per_counter };  
assign nvdla_glb_s_cdma_dat_counter_0_out = {cdma_dat_counter};  
assign nvdla_glb_s_cdma_wt_counter_0_out  = {cdma_wt_counter };
assign nvdla_glb_s_cdma_op_en_counter_0_out  = {cdma_op_en_counter };
assign nvdla_glb_s_cacc_per_counter_0_out = {cacc_per_counter}; 
assign nvdla_glb_s_csb_per_counter_0_out  = {csb_per_counter };  
assign nvdla_glb_s_bdma_per_counter_0_out  = {bdma_per_counter };  
assign nvdla_glb_s_nvdla_hw_version_0_out[31:0] = { 8'b0, minor, major };
assign sdp_done_set0_trigger = nvdla_glb_s_intr_set_0_wren; //(W563)
assign sdp_done_status0_trigger = nvdla_glb_s_intr_status_0_wren; //(W563)
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(
  reg_offset_rd_int
  or nvdla_glb_s_intr_mask_0_out
  or nvdla_glb_s_intr_set_0_out
  or nvdla_glb_s_intr_status_0_out
  or nvdla_glb_s_nvdla_hw_version_0_out
  or nvdla_glb_s_sdp_per_counter_0_out  
  or nvdla_glb_s_cdp_per_counter_0_out  
  or nvdla_glb_s_pdp_per_counter_0_out  
  or nvdla_glb_s_cdma_dat_counter_0_out 
  or nvdla_glb_s_cdma_wt_counter_0_out  
  or nvdla_glb_s_cacc_per_counter_0_out 
  or nvdla_glb_s_csb_per_counter_0_out  
  or nvdla_glb_s_bdma_per_counter_0_out  
  or nvdla_glb_s_cdma_op_en_counter_0_out
  ) begin
  case (reg_offset_rd_int)
     (32'h4 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_intr_mask_0_out ;
                            end
     (32'h8 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_intr_set_0_out ;
                            end
     (32'hc & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_intr_status_0_out ;
                            end
     (32'h10 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_sdp_per_counter_0_out ;
                            end
     (32'h14 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_cdp_per_counter_0_out ;
                            end
     (32'h18 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_pdp_per_counter_0_out ;
                            end
     (32'h1c & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_cdma_dat_counter_0_out ;
                            end
     (32'h20 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_cdma_wt_counter_0_out ;
                            end
     (32'h24 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_cacc_per_counter_0_out ;
                            end
     (32'h28 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_csb_per_counter_0_out ;
                            end
     (32'h2c & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_bdma_per_counter_0_out ;
                            end
     (32'h30 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_cdma_op_en_counter_0_out ;
                            end
     (32'h0 & 32'h00000fff): begin
                            reg_rd_data = nvdla_glb_s_nvdla_hw_version_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
assign core_intr_w = (~sdp_done_mask0 & sdp_done_status0) |
                     (~sdp_done_mask1 & sdp_done_status1) |
                     (~cdp_done_mask0 & cdp_done_status0) |
                     (~cdp_done_mask1 & cdp_done_status1) |
                     (~pdp_done_mask0 & pdp_done_status0) |
                     (~pdp_done_mask1 & pdp_done_status1) ;
                    // (~cdma_dat_done_mask0 & cdma_dat_done_status0) |
                    // (~cdma_dat_done_mask1 & cdma_dat_done_status1) |
                    // (~cdma_wt_done_mask0 & cdma_wt_done_status0) |
                    // (~cdma_wt_done_mask1 & cdma_wt_done_status1) |
                    // (~bdma_done_mask0 & bdma_done_status0) |
                    // (~bdma_done_mask1 & bdma_done_status1) |
                    // (~cacc_done_mask0 & cacc_done_status0) |
                    // (~cacc_done_mask1 & cacc_done_status1)
					//;
reg csb2nvdla_write_temp;
reg [7:0] us_timer;
reg timer_en, timer_en_temp;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    csb2nvdla_write_temp <= 1'b0;
    us_timer <= 8'b0; 
    timer_en <= 1'b0;   
    timer_en_temp <= 1'b0;
  end else begin
    csb2nvdla_write_temp <= csb2nvdla_write;
    timer_en_temp   <= timer_en;
    if(csb2nvdla_write &(~csb2nvdla_write_temp))
        timer_en <= 1'b1;
    else if(core_intr_w)
        timer_en <= 1'b0;
    
    if((us_timer >= 8'b0110_0011) || (timer_en == 1'b0))
        us_timer <= 8'b0;
    else
        us_timer <= us_timer + 1'b1;
  end
end
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        sdp_per_counter         <= 32'b0;
        cdp_per_counter         <= 32'b0;
        pdp_per_counter         <= 32'b0;
        cdma_dat_counter        <= 32'b0;
        cdma_wt_counter         <= 32'b0;
        cacc_per_counter        <= 32'b0;
        bdma_per_counter        <= 32'b0;
        csb_per_counter         <= 32'b0;
        csb_per_counter_temp    <= 32'b0;
        cdma_op_en_counter      <= 32'b0;
		cdma_op_en_temp 		<= 1'b0;
    end else begin
		cdma_op_en_temp 		<= cdma_op_en;
        if((~timer_en_temp ) & timer_en) begin
            sdp_per_counter         <= 32'b0;
            cdp_per_counter         <= 32'b0;
            pdp_per_counter         <= 32'b0;
            cdma_dat_counter        <= 32'b0;
            cdma_wt_counter         <= 32'b0;
            cacc_per_counter        <= 32'b0;
            bdma_per_counter        <= 32'b0;
            csb_per_counter         <= 32'b0;
            csb_per_counter_temp    <= 32'b0;
			cdma_op_en_counter      <= 32'b0;
        end else if((timer_en == 1'b1) && (us_timer >= 8'b0110_0011))begin
            csb_per_counter_temp    <=  csb_per_counter_temp + 1'b1;
            if((!sdp_done_status0) & (!sdp_done_status1))
                sdp_per_counter[30:0] <= sdp_per_counter[30:0]+ 1'b1;
            if((!cdp_done_status0) & (!cdp_done_status1))
                cdp_per_counter[30:0] <= cdp_per_counter[30:0]+ 1'b1;
            if((!pdp_done_status0) & (!pdp_done_status1))
                pdp_per_counter[30:0] <= pdp_per_counter[30:0]+ 1'b1;
            if((!cdma_dat_done_status0) & (!cdma_dat_done_status1))
                cdma_dat_counter[30:0]<= cdma_dat_counter[30:0]+ 1'b1;
            if((!cdma_wt_done_status0) & (!cdma_wt_done_status1))
                cdma_wt_counter[30:0] <= cdma_wt_counter[30:0]+ 1'b1;
            if((!cacc_done_status0) & (!cacc_done_status1))
                cacc_per_counter[30:0]<= cacc_per_counter[30:0]+ 1'b1;
            if((!bdma_done_status0) & (!bdma_done_status1))
                bdma_per_counter[30:0]<= bdma_per_counter[30:0]+ 1'b1;
       end  
        
        if(csb2nvdla_write_temp &(~csb2nvdla_write))begin
            csb_per_counter       <= csb_per_counter_temp;            
        end
		if(cdma_op_en & (~cdma_op_en_temp)) begin
			cdma_op_en_counter 	  <= csb_per_counter_temp;
		end
        if(core_intr_w) begin
            if(sdp_done_status0 | sdp_done_status1)
                sdp_per_counter[31:31] <= 1'b1;
            else
                sdp_per_counter[31:31] <= 1'b0;
                
            if(cdp_done_status0 | cdp_done_status1)
                cdp_per_counter[31:31] <= 1'b1;
            else
                cdp_per_counter[31:31] <= 1'b0;
        
            if(pdp_done_status0 | pdp_done_status1)
                pdp_per_counter[31:31] <= 1'b1;
            else
                pdp_per_counter[31:31] <= 1'b0;
                
            if(cdma_dat_done_status0 | cdma_dat_done_status1)
                cdma_dat_counter[31:31] <= 1'b1;
            else
                cdma_dat_counter[31:31] <= 1'b0;

            if(cdma_wt_done_status0 | cdma_wt_done_status1)
                cdma_wt_counter[31:31] <= 1'b1;
            else
                cdma_wt_counter[31:31] <= 1'b0;

            if(cacc_done_status0 | cacc_done_status1)
                cacc_per_counter[31:31] <= 1'b1;
            else
                cacc_per_counter[31:31] <= 1'b0;
            if(bdma_done_status0 | bdma_done_status1)
                bdma_per_counter[31:31] <= 1'b1;
            else
                bdma_per_counter[31:31] <= 1'b0;
       end       
   end    
end

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    bdma_done_mask0 <= 1'b0;
    bdma_done_mask1 <= 1'b0;
    cacc_done_mask0 <= 1'b0;
    cacc_done_mask1 <= 1'b0;
    cdma_dat_done_mask0 <= 1'b0;
    cdma_dat_done_mask1 <= 1'b0;
    cdma_wt_done_mask0 <= 1'b0;
    cdma_wt_done_mask1 <= 1'b0;
    cdp_done_mask0 <= 1'b0;
    cdp_done_mask1 <= 1'b0;
    pdp_done_mask0 <= 1'b0;
    pdp_done_mask1 <= 1'b0;
    rubik_done_mask0 <= 1'b0;
    rubik_done_mask1 <= 1'b0;
    sdp_done_mask0 <= 1'b0;
    sdp_done_mask1 <= 1'b0;
  end else begin
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: bdma_done_mask0
  if (nvdla_glb_s_intr_mask_0_wren) begin
    bdma_done_mask0 <= reg_wr_data[6];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: bdma_done_mask1
  if (nvdla_glb_s_intr_mask_0_wren) begin
    bdma_done_mask1 <= reg_wr_data[7];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: cacc_done_mask0
  if (nvdla_glb_s_intr_mask_0_wren) begin
    cacc_done_mask0 <= reg_wr_data[20];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: cacc_done_mask1
  if (nvdla_glb_s_intr_mask_0_wren) begin
    cacc_done_mask1 <= reg_wr_data[21];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: cdma_dat_done_mask0
  if (nvdla_glb_s_intr_mask_0_wren) begin
    cdma_dat_done_mask0 <= reg_wr_data[16];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: cdma_dat_done_mask1
  if (nvdla_glb_s_intr_mask_0_wren) begin
    cdma_dat_done_mask1 <= reg_wr_data[17];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: cdma_wt_done_mask0
  if (nvdla_glb_s_intr_mask_0_wren) begin
    cdma_wt_done_mask0 <= reg_wr_data[18];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: cdma_wt_done_mask1
  if (nvdla_glb_s_intr_mask_0_wren) begin
    cdma_wt_done_mask1 <= reg_wr_data[19];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: cdp_done_mask0
  if (nvdla_glb_s_intr_mask_0_wren) begin
    cdp_done_mask0 <= reg_wr_data[2];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: cdp_done_mask1
  if (nvdla_glb_s_intr_mask_0_wren) begin
    cdp_done_mask1 <= reg_wr_data[3];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: pdp_done_mask0
  if (nvdla_glb_s_intr_mask_0_wren) begin
    pdp_done_mask0 <= reg_wr_data[4];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: pdp_done_mask1
  if (nvdla_glb_s_intr_mask_0_wren) begin
    pdp_done_mask1 <= reg_wr_data[5];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: rubik_done_mask0
  if (nvdla_glb_s_intr_mask_0_wren) begin
    rubik_done_mask0 <= reg_wr_data[8];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: rubik_done_mask1
  if (nvdla_glb_s_intr_mask_0_wren) begin
    rubik_done_mask1 <= reg_wr_data[9];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: sdp_done_mask0
  if (nvdla_glb_s_intr_mask_0_wren) begin
    sdp_done_mask0 <= reg_wr_data[0];
  end
// Register: NVDLA_GLB_S_INTR_MASK_0 Field: sdp_done_mask1
  if (nvdla_glb_s_intr_mask_0_wren) begin
    sdp_done_mask1 <= reg_wr_data[1];
  end
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::bdma_done_set0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::bdma_done_set1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::cacc_done_set0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::cacc_done_set1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::cdma_dat_done_set0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::cdma_dat_done_set1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::cdma_wt_done_set0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::cdma_wt_done_set1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::cdp_done_set0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::cdp_done_set1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::pdp_done_set0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::pdp_done_set1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::rubik_done_set0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::rubik_done_set1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::sdp_done_set0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_SET_0::sdp_done_set1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::bdma_done_status0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::bdma_done_status1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::cacc_done_status0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::cacc_done_status1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::cdma_dat_done_status0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::cdma_dat_done_status1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::cdma_wt_done_status0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::cdma_wt_done_status1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::cdp_done_status0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::cdp_done_status1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::pdp_done_status0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::pdp_done_status1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::rubik_done_status0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::rubik_done_status1 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::sdp_done_status0 (to be implemented outside)
// Not generating flops for field NVDLA_GLB_S_INTR_STATUS_0::sdp_done_status1 (to be implemented outside)
// Not generating flops for constant field NVDLA_GLB_S_NVDLA_HW_VERSION_0::major
// Not generating flops for constant field NVDLA_GLB_S_NVDLA_HW_VERSION_0::minor
  end
end
// spyglass enable_block STARC-2.10.1.6, NoConstWithXZ, W443
// synopsys translate_off
// VCS coverage off
initial begin
  arreggen_dump = $test$plusargs("arreggen_dump_wr");
  arreggen_abort_on_rowr = $test$plusargs("arreggen_abort_on_rowr");
  arreggen_abort_on_invalid_wr = $test$plusargs("arreggen_abort_on_invalid_wr");
`ifdef VERILATOR
`else
  $timeformat(-9, 2, "ns", 15);
`endif
end
always @(posedge nvdla_core_clk) begin
  if (reg_wr_en) begin
    case(reg_offset)
      (32'h4 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: NVDLA_GLB_S_INTR_MASK_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, nvdla_glb_s_intr_mask_0_out, nvdla_glb_s_intr_mask_0_out);
      (32'h8 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: NVDLA_GLB_S_INTR_SET_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, nvdla_glb_s_intr_set_0_out, nvdla_glb_s_intr_set_0_out);
      (32'hc & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: NVDLA_GLB_S_INTR_STATUS_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, nvdla_glb_s_intr_status_0_out, nvdla_glb_s_intr_status_0_out);
      (32'h0 & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: NVDLA_GLB_S_NVDLA_HW_VERSION_0 = 0x%h", $time, reg_wr_data);
          if (arreggen_abort_on_rowr) begin $display("ERROR: write to read-only register!"); $finish; end
        end
      default: begin
          if (arreggen_dump) $display("%t:%m: reg wr: Unknown register (0x%h) = 0x%h", $time, reg_offset, reg_wr_data);
          if (arreggen_abort_on_invalid_wr) begin $display("ERROR: write to undefined register!"); $finish; end
        end
    endcase
  end
end
// VCS coverage on
// synopsys translate_on
endmodule // NV_NVDLA_GLB_CSB_reg
