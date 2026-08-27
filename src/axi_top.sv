
`include "axi_interface.sv"
`include "axi_package.sv"
//`include "axi_rtl.v"

module top();
 import uvm_pkg::*;
 import axi_package::*;
 bit ACLK;
 bit ARESETn;
 axi_interface duv_if(ACLK,ARESETn);
 //

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
