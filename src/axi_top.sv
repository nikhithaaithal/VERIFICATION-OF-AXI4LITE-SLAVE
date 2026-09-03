
`include "axi_interface.sv"
`include "axi_package.sv"
`include "axi4_lite_slave.v"

module top();
 import uvm_pkg::*;
 import axi_package::*;
 bit ACLK;
 bit ARESETn;
 axi_interface duv_if(ACLK,ARESETn);
 
axi4_lite_slave duv(.ACLK(duv_if.ACLK),.ARESETn( duv_if.ARESETn),.AWADDR(duv_if.AWADDR),.AWPROT(duv_if.AWPROT),.AWVALID(duv_if.AWVALID),
    .AWREADY(duv_if.AWREADY),.WDATA(duv_if.WDATA),.WSTRB(duv_if.WSTRB),.WVALID(duv_if.WVALID),.WREADY(duv_if.WREADY),.BRESP(duv_if.BRESP),
    .BVALID(duv_if.BVALID),.BREADY(duv_if.BREADY),.ARADDR(duv_if.ARADDR),.ARPROT(duv_if.ARPROT),.ARVALID(duv_if.ARVALID),.ARREADY(duv_if.ARREADY),
    .RDATA(duv_if.RDATA),.RRESP(RRESP),.RVALID(RVALID),.RREADY(RREADY));

 initial begin
  #3;
  ARESETn = 0;
  #5;
  ARESETn = 1;
 end
 initial begin
   ACLK=0;
  forever #5 ACLK = ~ACLK;
 end

 initial begin
  uvm_config_db#(virtual axi_interface)::set(null,"*","interface",duv_if);
  run_test();
 end
endmodule
