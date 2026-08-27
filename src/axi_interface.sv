
`include "defines.svh"
interface axi_interface( input bit ACLK,input bit ARESETn);

logic [`ADDR_WIDTH-1:0]AWADDR, ARADDR;
logic [`DATA_WIDTH -1 :0]WDATA,RDATA;
logic [(`DATA_WIDTH/8)-1 :0] WSTRB; 
logic [2:0] AWPROT;
logic [2:0] ARPROT;
logic [1:0]BRESP,RRESP;
logic AWVALID,AWREADY,WVALID,WREADY,BVALID,BREADY,ARVALID,ARREADY,RVALID,RREADY;


clocking drv_cb @(posedge ACLK);
 default input #0 output #0;
 output AWADDR,AWVALID,WDATA,WSTRB,WVALID,BREADY,ARADDR,ARVALID,RREADY,AWPROT,ARPROT;
 input AWREADY,WREADY,BRESP,BVALID,ARREADY,RDATA,RRESP,RVALID;
endclocking

clocking mon_inp_cb @(posedge ACLK);
 default input #0 output #0;
 input AWADDR,AWVALID,WDATA,WSTRB,WVALID,BREADY,ARADDR,ARVALID,RREADY,AWPROT,ARPROT;
 input AWREADY,WREADY,BRESP,BVALID,ARREADY,RDATA,RRESP,RVALID;
endclocking

clocking mon_out_cb @(posedge ACLK);
 default input #0 output #0;
 input AWREADY,WREADY,BRESP,BVALID,ARREADY,RDATA,RRESP,RVALID;
 input AWADDR,AWVALID,WDATA,WSTRB,WVALID,BREADY,ARADDR,ARVALID,RREADY,AWPROT,ARPROT;
endclocking

modport DRV(clocking drv_cb);
modport MON_INP(clocking mon_inp_cb);
modport MON_OUT(clocking mon_out_cb);

endinterface
