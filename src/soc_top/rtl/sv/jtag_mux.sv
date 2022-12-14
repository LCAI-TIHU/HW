// This system-verilog module was generated by Vega
//               Please do not edit!

//---------------------------------------------------------------------------
//                                                                           
//              Inspur Confidential                                          
// Copyright (c) 2021 Inspur. All rights reserved
//                                                                           
// File    : /nfs/work/shared/aipu.work/dingzhiming/workspace/dingzhiming.aipu.default/env_repo/design_repo/rtl/soc_top/rtl/sv/jtag_mux.sv
// Author  : Inspur Xi'an R&D                                                
// History : 2021-Sep-29 11:27:34 AM - Created    
//                                                                           
//---------------------------------------------------------------------------

module jtag_mux(
    u_soc_top_JTAG_MUX_i,
    u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_i,
    u_uncore_top_jtag2ahb_tdo_i,
    u_soc_top_TDI_i,
    u_soc_top_TMS_i,
    u_tdo_mux_z_o,
    u_tdi_rmux_z_o,
    u_tms_rmux_z_o,
    u_tdi_ahbmux_z_o,
    u_tms_ahbmux_z_o
);
input u_soc_top_JTAG_MUX_i;
input u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_i;
input u_uncore_top_jtag2ahb_tdo_i;
input u_soc_top_TDI_i;
input u_soc_top_TMS_i;
output u_tdo_mux_z_o;
output u_tdi_rmux_z_o;
output u_tms_rmux_z_o;
output u_tdi_ahbmux_z_o;
output u_tms_ahbmux_z_o;

// input wires
wire u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_s;
wire u_soc_top_JTAG_MUX_s;
wire u_soc_top_TDI_s;
wire u_soc_top_TMS_s;
wire u_uncore_top_jtag2ahb_tdo_s;

// output wires
wire u_tdi_ahbmux_z_s;
wire u_tdi_rmux_z_s;
wire u_tdo_mux_z_s;
wire u_tms_ahbmux_z_s;
wire u_tms_rmux_z_s;

// internal wires

// input assign
assign u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_s = u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_i;
assign u_soc_top_JTAG_MUX_s = u_soc_top_JTAG_MUX_i;
assign u_soc_top_TDI_s = u_soc_top_TDI_i;
assign u_soc_top_TMS_s = u_soc_top_TMS_i;
assign u_uncore_top_jtag2ahb_tdo_s = u_uncore_top_jtag2ahb_tdo_i;

// output assign
assign u_tdi_ahbmux_z_o = u_tdi_ahbmux_z_s;
assign u_tdi_rmux_z_o = u_tdi_rmux_z_s;
assign u_tdo_mux_z_o = u_tdo_mux_z_s;
assign u_tms_ahbmux_z_o = u_tms_ahbmux_z_s;
assign u_tms_rmux_z_o = u_tms_rmux_z_s;

// internal assign

//u_tdi_rmux instance
stdcc_mux u_tdi_rmux(
    //input ports
    .a(1'b0),
    .b(u_soc_top_TDI_s),
    .sel(u_soc_top_JTAG_MUX_s),
    //output ports
    .z(u_tdi_rmux_z_s)
    //inout ports
);

//u_tms_rmux instance
stdcc_mux u_tms_rmux(
    //input ports
    .a(1'b0),
    .b(u_soc_top_TMS_s),
    .sel(u_soc_top_JTAG_MUX_s),
    //output ports
    .z(u_tms_rmux_z_s)
    //inout ports
);

//u_tdi_ahbmux instance
stdcc_mux u_tdi_ahbmux(
    //input ports
    .a(u_soc_top_TDI_s),
    .b(1'b0),
    .sel(u_soc_top_JTAG_MUX_s),
    //output ports
    .z(u_tdi_ahbmux_z_s)
    //inout ports
);

//u_tms_ahbmux instance
stdcc_mux u_tms_ahbmux(
    //input ports
    .a(u_soc_top_TMS_s),
    .b(1'b0),
    .sel(u_soc_top_JTAG_MUX_s),
    //output ports
    .z(u_tms_ahbmux_z_s)
    //inout ports
);

//u_tdo_mux instance
stdcc_mux u_tdo_mux(
    //input ports
    .a(u_uncore_top_jtag2ahb_tdo_s),
    .b(u_SiFive_CoreIPSubsystem_debug_systemjtag_jtag_TDO_data_s),
    .sel(u_soc_top_JTAG_MUX_s),
    //output ports
    .z(u_tdo_mux_z_s)
    //inout ports
);

endmodule