//-------------------------------------------------------------- 
//  main_scu_ahb2esram_async_bridge.sv                                      
//                                                                               
//  Author(s):WangMingming (wangmingming02@inspur.com)                           
//                                                                               
//  The main_scu_ahb2esram_async_bridge.sv is generated at 2021-11-12 18:25:50         
//                                                                               
//  Register interface Version : V0.8                                            
//                      
//  Please don't manual modify!!!    
//-------------------------------------------------------------- 
//  Copyright 2019-2029 INSPUR Corporation
//  All Rights Reserved Worldwide
//-------------------------------------------------------------- 
//  NOTE: 
//  1. ONLY support word,halfword,Byte access 
//  2. Not support SPLIT,RETRY 
//-------------------------------------------------------------- 
//TODO??
//1. can put read response to HRESP to reflect the read errors(if there is any) 
//2. Performance can improved by remove the FIFOs??
//3. to check all default jump in FSM is correct or not ? 
module main_scu_ahb2esram_async_bridge
#(
parameter   p_bus_address_width        = 24 ,
parameter   p_reg_response_width       = 3  
)
(
 //AHB interface 
  input                              HCLK            ,// system bus clock
  input                              HRESETn         ,// system bus reset
  input                              HSEL            ,// AHB peripheral select
  input                              HREADY          ,// AHB ready input
  input[1:0]                         HTRANS          ,// AHB transfer type
  input[2:0]                         HSIZE           ,// AHB hsize
  input                              HWRITE          ,// AHB hwrite
  input[p_bus_address_width-1:0]     HADDR           ,// AHB address bus
  input[31:0]                        HWDATA          ,// AHB write data bus
  output                             HREADYOUT       ,// AHB ready output to S->M mux
  output[1:0]                        HRESP           ,// AHB response
  output[31:0]                       HRDATA          ,// AHB read data bus
 //Extend-SRAM interface 
  input                              bus_clk_i       ,
  input                              bus_rstn_i      ,
  output                             bus_csb_o       ,
  output                             bus_wr_o        ,
  output[p_bus_address_width-3:0]    bus_address_o   , //the 2LSB is not connected since it is used for byte_en decode 
  output[31:0]                       bus_write_data_o,
  output[3:0]                        bus_byte_en_o   ,
  input [31:0]                       bus_read_data_i ,
  //three signals are added based on SRAM interface 
  //if it is standard SRAM interface, please tie 
    //bus_req_ready and bus_res_ready to 1 
    //bus_reponse to 0
  input                              bus_req_ready_i ,//request ready to notify the request has accepted 
  input                              bus_res_ready_i ,//response ready to notify the response and read_data(when it is read) is ready
  input[p_reg_response_width-1:0]    bus_response_i  
);

localparam  p_esram_fsm_width          = 1   ; //ESRAM FSM state width 
//emum define for FSM 
typedef enum logic[p_esram_fsm_width-1:0] {
   ESRAM_IDLE                 = 0,
   ESRAM_REQUEST_STALL        = 1 
} esram_request_fsm_state_t;

   // ----------------------------------------------------------
   // Internal state
   // ----------------------------------------------------------
   //---
   esram_request_fsm_state_t      esram_request_fsm_state_cur  ;
   esram_request_fsm_state_t      esram_request_fsm_state_nxt  ;

   //FIFO signals 
   wire                          wdata_fifo_push_s  ;  
   reg                           wdata_fifo_pop_s   ;  
   wire[31:0]                    wdata_fifo_wdata_s ;  
   wire[31:0]                    wdata_fifo_rdata_s ;  
   wire                          wdata_fifo_full_s  ; 
   wire                          wdata_fifo_empty_s ; 
   //---
   wire                          rdata_fifo_push_s  ;  
   wire                          rdata_fifo_pop_s   ;  
   wire[31:0]                    rdata_fifo_wdata_s ;  
   wire[31:0]                    rdata_fifo_rdata_s ;  
   wire                          rdata_fifo_full_s  ;  
   wire                          rdata_fifo_empty_s ; 
   //---
   wire                          cmd_fifo_push_s    ;  
   reg                           cmd_fifo_pop_s     ;  
   wire[p_bus_address_width+2:0] cmd_fifo_wdata_s   ;  
   wire[p_bus_address_width+2:0] cmd_fifo_rdata_s   ;  
   wire                          cmd_fifo_full_s    ;  
   wire                          cmd_fifo_empty_s   ; 
  //TODO?? use full is okay? 
   wire                          cmd_fifo_almost_full_s;
   wire[3:0]                     cmd_fifo_avail_s;

   // ----------------------------------------------------------
   // AHB Read/write control logic
   // ----------------------------------------------------------
   wire ahb_access_s  = HTRANS[1] & HSEL & HREADY &HREADYOUT;
   wire ahb_write_s   = ahb_access_s &   HWRITE ; 
   wire ahb_read_s    = ahb_access_s & (~HWRITE);
   // ----------------------------------------------------------
   // Byte lane decoder 
   // ----------------------------------------------------------
   wire       tx_byte_s    = (~HSIZE[1]) & (~HSIZE[0]);
   wire       tx_half_s    = (~HSIZE[1]) &   HSIZE[0];
   wire       tx_word_s    =   HSIZE[1];

   wire       byte_at_00_s = tx_byte_s & (~HADDR[1]) & (~HADDR[0]);
   wire       byte_at_01_s = tx_byte_s & (~HADDR[1]) &   HADDR[0];
   wire       byte_at_10_s = tx_byte_s &   HADDR[1]  & (~HADDR[0]);
   wire       byte_at_11_s = tx_byte_s &   HADDR[1]  &   HADDR[0];

   wire       half_at_00_s = tx_half_s & (~HADDR[1]);
   wire       half_at_10_s = tx_half_s &   HADDR[1];

   wire       word_at_00_s = tx_word_s;

   wire       byte_sel_0_s = word_at_00_s | half_at_00_s | byte_at_00_s;
   wire       byte_sel_1_s = word_at_00_s | half_at_00_s | byte_at_01_s;
   wire       byte_sel_2_s = word_at_00_s | half_at_10_s | byte_at_10_s;
   wire       byte_sel_3_s = word_at_00_s | half_at_10_s | byte_at_11_s;

   //---ESRAM side read/write signals 
   wire                           esram_valid_read_req_s   ;
   wire                           esram_valid_write_req_s  ;
   wire                           bus_csb_strb_s             ; // high active 
   reg                            bus_csb_strb_pending_s     ; // high active 
   reg[p_bus_address_width+2:0]   cmd_fifo_rdata_buffer_s  ; // buffer the control in case it is backpreesured by bus_req_ready
   reg[31:0]                      wdata_fifo_rdata_buffer_s; // buffer the data in case it is backpreesured by bus_req_ready
   //---
   reg                            rdata_capture_r;
   //--AHB write,read indicator signals  
   reg                            ahb_write_data_cycle_s;
   reg                            ahb_read_data_cycles_s;

  //valid data cycle indication for AHB_WRITE,AHB_READ
  always_ff@(posedge HCLK or negedge HRESETn)  begin : data_cycle_seq
    if(!HRESETn) begin
       ahb_write_data_cycle_s <= 1'b0; 
       ahb_read_data_cycles_s <= 1'b0; 
    end 
    else begin
      //---data cycle set has high priority when address/data phase are overlap
      if(ahb_write_s) begin
         ahb_write_data_cycle_s <= 1'b1; 
      end
      else if (ahb_write_data_cycle_s & HREADYOUT) begin//TODO?? shall we make the write happen when HREADYOUT=1(the end of data cycle)? or at the beginning of data cycle ??
         ahb_write_data_cycle_s <= 1'b0; //once it is in data cycle, data can be write to wdata fifo immediately 
      end 
      //---data cycle set has high priority when address/data phase are overlap
      if(ahb_read_s) begin
         ahb_read_data_cycles_s <= 1'b1;
      end 
      else if(~rdata_fifo_empty_s) begin //once RDATA fifo is NOT empty,READ data cycle can end 
         ahb_read_data_cycles_s <= 1'b0;
      end
    end 
  end 


//TODO?? remove the below code
//synopsys translate_off
//to Detect if there is a confict for write and read cmd push to fifo ...

always_ff@(posedge bus_clk_i) begin 
if(cmd_fifo_pop_s & cmd_fifo_empty_s) begin 
  $display("there is POP when cmd fifo is EMPTY!!,Please check RTL design!!");
  $stop();
end 
if(wdata_fifo_pop_s & wdata_fifo_empty_s) begin 
  $display("there is POP when wdata fifo is EMPTY!!,Please check RTL design!!");
  $stop();
end 

if(rdata_fifo_push_s & rdata_fifo_full_s) begin 
  $display("there is PUSH when rdata fifo is FULL!!,Please check RTL design!!");
  $stop();
end 
end 
  
always_ff@(posedge HCLK) begin  

if(cmd_fifo_push_s & cmd_fifo_full_s) begin 
  $display("there is PUSH when cmd fifo is FULL!!,Please check RTL design!!");
  $stop();
end 
if(wdata_fifo_push_s & wdata_fifo_full_s) begin 
  $display("there is PUSH when wdata fifo is FULL!!,Please check RTL design!!");
  $stop();
end 

if(rdata_fifo_pop_s & rdata_fifo_empty_s) begin 
  $display("there is POP when rdata fifo is EMPTY!!,Please check RTL design!!");
  $stop();
end 
end 
//synopsys translate_on

//ESRAM Request FSM 
//---State trans
always_ff@(posedge bus_clk_i or negedge bus_rstn_i) begin : esram_fsm_seq
  if(!bus_rstn_i) begin 
     esram_request_fsm_state_cur <= ESRAM_IDLE;
  end 
  else begin 
    esram_request_fsm_state_cur  <= esram_request_fsm_state_nxt ;
  end 
end 

//handle the csb is issued but it is not accepted at this cycle..
always_ff@(posedge bus_clk_i or negedge bus_rstn_i) begin  : bus_csb_strb_pending_seq
  if(!bus_rstn_i) begin 
      bus_csb_strb_pending_s      <= 1'b0;
      cmd_fifo_rdata_buffer_s   <=  'h0;
      wdata_fifo_rdata_buffer_s <=  'h0;
  end 
  else begin 
    if (bus_csb_strb_s & ~bus_req_ready_i) begin  //there is a strb requeset, but not accept 
       bus_csb_strb_pending_s     <= 1'b1;
       cmd_fifo_rdata_buffer_s  <= cmd_fifo_rdata_s;
       wdata_fifo_rdata_buffer_s<= wdata_fifo_rdata_s;
    end 
    else if (bus_csb_strb_pending_s & bus_req_ready_i) begin //one pending csb, it is accepted 
       bus_csb_strb_pending_s     <= 1'b0;
    end 
  end 
end 

assign esram_valid_write_req_s = ~cmd_fifo_empty_s &  cmd_fifo_rdata_s[0] & ~wdata_fifo_empty_s ;
assign esram_valid_read_req_s  = ~cmd_fifo_empty_s & ~cmd_fifo_rdata_s[0]                       ;
assign bus_csb_strb_s            =  cmd_fifo_pop_s                                                ;

//TODO??
//two implement way
//1. only if the bus_req_ready=1, trig the read to cmd_fifo,wdata_fifo
//2. OR read the fifo first and stall the csb,address,wdata if the bus_req_ready=0
  // currently way 1 is used, in case some slave it will issue the bus_req_ready after it see the csb is assert 

always_comb  begin : esram_fsm_comb
  esram_request_fsm_state_nxt  = esram_request_fsm_state_cur;
  cmd_fifo_pop_s               = 1'b0;
  wdata_fifo_pop_s             = 1'b0;
  case(esram_request_fsm_state_cur) 
    ESRAM_IDLE : 
    if(esram_valid_write_req_s & bus_req_ready_i) begin       //is WRITE request in CMD FIFO && WDATA is ready && bus can accept this request 
      cmd_fifo_pop_s                = 1'b1;
      wdata_fifo_pop_s              = 1'b1;
    end 
    else if (esram_valid_read_req_s & bus_req_ready_i) begin  //is READ request in CMD FIFO && bus can accept this request 
       cmd_fifo_pop_s               = 1'b1;
    end 
    else if(esram_valid_write_req_s & ~bus_req_ready_i) begin //is WRITE request in CMD FIFO && WDATA is ready && bus CANNOT accept this request , just pop it out and wait. 
      esram_request_fsm_state_nxt   = ESRAM_REQUEST_STALL ; 
      cmd_fifo_pop_s                = 1'b1;
      wdata_fifo_pop_s              = 1'b1;
    end 
    else if(esram_valid_read_req_s & ~bus_req_ready_i) begin  //is READ request in CMD FIFO && bus CANNOT accept this request , just pop it out and wait 
       cmd_fifo_pop_s               = 1'b1;
       esram_request_fsm_state_nxt  = ESRAM_REQUEST_STALL ; 
    end 
    ESRAM_REQUEST_STALL:  
    if(bus_req_ready_i) begin 
       esram_request_fsm_state_nxt = ESRAM_IDLE; 
    end 
  endcase 
end 


//********ESRAM Request FSM related ********Begin >>>>>>
//CMD FIFO, WDATA FIFO logic generation for Read direction 
assign bus_csb_o        = ~(bus_csb_strb_s | bus_csb_strb_pending_s)                                                                   ;
assign bus_write_data_o = bus_csb_strb_s ? wdata_fifo_rdata_s                        : wdata_fifo_rdata_buffer_s                       ;
assign bus_address_o    = bus_csb_strb_s ? cmd_fifo_rdata_s[p_bus_address_width+2:5] : cmd_fifo_rdata_buffer_s[p_bus_address_width+2:5];
assign bus_byte_en_o    = bus_csb_strb_s ? cmd_fifo_rdata_s[4                    :1] : cmd_fifo_rdata_buffer_s[4                    :1];
assign bus_wr_o         = bus_csb_strb_s ? cmd_fifo_rdata_s[0                      ] : cmd_fifo_rdata_buffer_s[0                      ];
//********ESRAM Request FSM related ********End >>>>>>


//RDATA FIFO control logic 
//record if there is one pending read data request ..
always_ff@(posedge bus_clk_i or negedge bus_rstn_i) begin : rdata_capture_seq
  if(~bus_rstn_i) begin
    rdata_capture_r <=1'b0;
  end 
  else begin 
    if(~bus_csb_o & ~bus_wr_o & bus_req_ready_i)  begin
      rdata_capture_r <=1'b1;
    end 
    else if(rdata_capture_r & bus_res_ready_i) begin
      rdata_capture_r <=1'b0;
    end 
  end 
end 
//RDATA FIFO push and wdata 
assign rdata_fifo_push_s  = bus_res_ready_i & rdata_capture_r ; 
assign rdata_fifo_wdata_s = bus_read_data_i ; 

//WDATA FIFO --size is 4(D)*32bit(W)
//...data orgnization ...
//   31:0
//   wdata
stdcc_asyncfifo_wrapper #(
.FIFO_DATA_WIDTH ( 32 ) ,
.FIFO_PTR_WIDTH  ( 3  ) 
) wdata_fifo
(
.wclk_i        (HCLK               ),
.wrst_n_i      (HRESETn            ),
.rclk_i        (bus_clk_i            ),
.rrst_n_i      (bus_rstn_i           ),
.winc_i        (wdata_fifo_push_s  ),
.wdata_i       (wdata_fifo_wdata_s ),
.rinc_i        (wdata_fifo_pop_s   ),
.rdata_o       (wdata_fifo_rdata_s ),
.wspace_avai_o (/*OPEN */          ),
.rdata_avai_o  (/*OPEN */          ),
.wfull_o       (wdata_fifo_full_s  ),
.rempty_o      (wdata_fifo_empty_s ) 
);                                                
                                                  
//                                                
//CMD FIFO --size is 4(D)*(5+p_bus_address_width)bit(W)
//...data orgnization ...
//(p_bus_address_width+2):5      4:1       0                
//address                       byte_en   access_type
stdcc_asyncfifo_wrapper #(
.FIFO_DATA_WIDTH ( p_bus_address_width+3  ) ,
.FIFO_PTR_WIDTH  ( 3  ) 
) cmd_fifo
(
.wclk_i        (HCLK               ),
.wrst_n_i      (HRESETn            ),
.rclk_i        (bus_clk_i            ),
.rrst_n_i      (bus_rstn_i           ),
.winc_i        (cmd_fifo_push_s    ),
.wdata_i       (cmd_fifo_wdata_s   ),
.rinc_i        (cmd_fifo_pop_s     ),
.rdata_o       (cmd_fifo_rdata_s   ),
.wspace_avai_o (cmd_fifo_avail_s   ),
.rdata_avai_o  (/*OPEN */          ),
.wfull_o       (cmd_fifo_full_s    ),
.rempty_o      (cmd_fifo_empty_s   ) 
);
//
//RDATA FIFO --size is 2(D)*32bit(W)
//...data orgnization ...
//   31:0
//   rdata
stdcc_asyncfifo_wrapper #(
.FIFO_DATA_WIDTH ( 32 ) ,
.FIFO_PTR_WIDTH  ( 2  ) 
) rdata_fifo
(
.wclk_i        (bus_clk_i              ),
.wrst_n_i      (bus_rstn_i             ),
.rclk_i        (HCLK                 ),
.rrst_n_i      (HRESETn              ),
.winc_i        (rdata_fifo_push_s    ),
.wdata_i       (rdata_fifo_wdata_s   ),
.rinc_i        (rdata_fifo_pop_s     ),
.rdata_o       (rdata_fifo_rdata_s   ),
.wspace_avai_o (/*OPEN */            ),
.rdata_avai_o  (/*OPEN */            ),
.wfull_o       (rdata_fifo_full_s    ),
.rempty_o      (rdata_fifo_empty_s   ) 
);

//assign cmd_fifo_almost_full_s = (cmd_fifo_avail_s<=1) ? 1'b1:1'b0;
//TODO??
assign cmd_fifo_almost_full_s = cmd_fifo_full_s ;

assign cmd_fifo_push_s        =  ahb_access_s; // ONLY if cmd fifo not full, data can write to it
assign cmd_fifo_wdata_s       = {HADDR[p_bus_address_width-1:2],byte_sel_3_s,byte_sel_2_s,byte_sel_1_s,byte_sel_0_s,HWRITE};

assign wdata_fifo_push_s      = ahb_write_data_cycle_s & HREADYOUT;
assign wdata_fifo_wdata_s     = HWDATA;

assign rdata_fifo_pop_s       = ~rdata_fifo_empty_s ; 
assign HRDATA                 =  rdata_fifo_rdata_s ; 
//when cmd fifo is full                          OR
//there is a read but read data is not returned
//Then HREADY=0
assign HREADYOUT              = (cmd_fifo_almost_full_s || (ahb_read_data_cycles_s & rdata_fifo_empty_s ) ) ? 1'b0: 1'b1;
//TODO??
assign HRESP                  = 2'b00;
endmodule 