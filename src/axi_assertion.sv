`include "defines.svh"
module axi_assertion (
 
  input bit ACLK,
  input logic ARESETn,

  input logic [`ADDR_WIDTH-1:0] AWADDR,
  input logic [2:0]AWPROT,
  input logic AWVALID,
  input logic AWREADY,

  input logic [`DATA_WIDTH-1:0] WDATA,
  input logic [(`DATA_WIDTH/8)-1:0] WSTRB,
  input logic WVALID,
  input logic WREADY,

  input logic [1:0]BRESP,
  input logic BVALID,
  input logic BREADY,

  input logic [`ADDR_WIDTH-1:0] ARADDR,
  input logic [2:0]ARPROT,
  input logic ARVALID,
  input logic ARREADY,

  input logic [`DATA_WIDTH-1:0] RDATA,
  input logic [1:0]RRESP,
  input logic RVALID,
  input logic RREADY
);

property p1;
@(posedge ACLK) disable iff (!ARESETn)
AWVALID && !AWREADY |=> AWVALID;
endproperty
assert property(p1)
 $display("Assertion Passed:p1");
else
 $error(" Write Address Handshake Assertion Failed");


property p2;
@(posedge ACLK) disable iff (!ARESETn) 
WVALID && !WREADY |=> WVALID ;
endproperty
assert property (p2)
 $display("Assertion Passed:p2");
else
 $error("Data Handshake Assertion Failed");

property p3;
@(posedge ACLK) disable iff (!ARESETn)
BVALID && !BREADY |=> BVALID ;
endproperty
assert property(p3)
 $display("Assertion Passed:p3");
else
 $error("Write Response Handshake Assertion Failed");


property p4;
@(posedge ACLK) disable iff (!ARESETn)
ARVALID && !ARREADY |=> ARVALID ;
endproperty
assert property(p4) $display("Assertion Passed :p4");
 else $error("Read Address Handshake Assertion Failed");

property p5;
@(posedge ACLK) disable iff (!ARESETn)
RVALID && !RREADY |=> RVALID ;
endproperty
assert property(p5)
 $display("Assertion Passed :p5");
 else $error("Read Response Handshake Assertion Failed");

property p6;
@(posedge ACLK) disable iff (!ARESETn)
AWVALID && AWREADY && AWADDR[1:0]!=2'b00 |->##[1:$] ( BVALID && BRESP == 2'b10);
endproperty
assert property(p6)
$display("Assertion Passed:p6");
 else $error("Address unalighned");

property p7;
@(posedge ACLK) disable iff (!ARESETn)
ARVALID && ARREADY &&(ARADDR[1:0]!=2'b00) |->##[1:$](RVALID && RRESP == 2'b10);
endproperty
assert property(p7)
 $display("Assertion Passed:p7");
 else $error("Address unalighned");


property p8;
@(posedge ACLK) disable iff (!ARESETn)
AWVALID && AWREADY && (AWADDR>32'h28 && AWADDR<32'h30) |->##[1:$](BVALID && BRESP == 2'b10);
endproperty
assert property(p8)
 $display("Assertion Passed:p8");
 else $error("Address Read only");

property p9;
@(posedge ACLK)disable iff (!ARESETn)
ARVALID && ARREADY &&(ARADDR>32'h34 && ARADDR<32'h38) |->##[1:$]( RVALID && RRESP == 2'b10);
endproperty
assert property(p9)
$display("Assertion Passed:p9");
 else $error("Address Write only");

property p10;
@(posedge ACLK) disable iff (!ARESETn)
(ARVALID && ARREADY && ARADDR>32'h3C || AWVALID && AWREADY && AWADDR>32'h3C)  |->##[1:$](RVALID && RRESP == 2'b11 || BVALID && BRESP == 2'b11);
endproperty
assert property(p10)
 $display("Assertion Passed:p10");
 else $error("Address Write only");

endmodule
