`include "defines.svh"
`include "axi_interface.sv"
`include "axi4_lite_slave.v"
`include "axi_assertion.sv"
`include "axi_package.sv"
module top();
 import uvm_pkg::*;
 import axi_package::*;
 bit ACLK;
 bit ARESETn;
 axi_interface duv_if(ACLK,ARESETn);
 
axi4_lite_slave duv(.ACLK(duv_if.ACLK),.ARESETn( duv_if.ARESETn),.AWADDR(duv_if.AWADDR),.AWPROT(duv_if.AWPROT),.AWVALID(duv_if.AWVALID),
    .AWREADY(duv_if.AWREADY),.WDATA(duv_if.WDATA),.WSTRB(duv_if.WSTRB),.WVALID(duv_if.WVALID),.WREADY(duv_if.WREADY),.BRESP(duv_if.BRESP),
    .BVALID(duv_if.BVALID),.BREADY(duv_if.BREADY),.ARADDR(duv_if.ARADDR),.ARPROT(duv_if.ARPROT),.ARVALID(duv_if.ARVALID),.ARREADY(duv_if.ARREADY),
    .RDATA(duv_if.RDATA),.RRESP(duv_if.RRESP),.RVALID(duv_if.RVALID),.RREADY(duv_if.RREADY));

bind axi4_lite_slave  axi_assertion assertion
(.ACLK(ACLK),
.ARESETn(ARESETn),
.AWADDR(AWADDR),
.AWPROT(AWPROT),
.AWVALID(AWVALID),
.AWREADY(AWREADY),
.WDATA(WDATA),
.WSTRB(WSTRB),
.WVALID(WVALID),
.WREADY(WREADY),
.BRESP(BRESP),
.BVALID(BVALID),
.BREADY(BREADY),
.ARADDR(ARADDR),
.ARPROT(ARPROT),
.ARVALID(ARVALID),
.ARREADY(ARREADY),
.RDATA(RDATA),
.RRESP(RRESP),
.RVALID(RVALID),
.RREADY(RREADY));

 initial begin
  ARESETn = 0;
  #7;
  ARESETn =1;
  #1;
  ARESETn = 0;
  #1;
  ARESETn =1;
 end
 initial begin
   ACLK=0;
  forever #5 ACLK = ~ACLK;
 end

 initial begin
 uvm_config_db#(virtual axi_interface.DRV)::set(null, "*", "interface", duv_if);
 uvm_config_db#(virtual axi_interface.MON_INP)::set(null, "*", "interface", duv_if);
 uvm_config_db#(virtual axi_interface.MON_OUT)::set(null, "*", "interface", duv_if); 
 run_test();
 end
endmodule
