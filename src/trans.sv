class trans extends uvm_sequence_item;
 
 rand logic [`ADDR_WIDTH-1:0]AWADDR;
 rand logic [`DATA_WIDTH -1:0] WDATA;
 rand logic [(`DATA_WIDTH / 8)-1:0] WSTRB;
 rand logic [`ADDR_WIDTH-1:0]ARADDR;
 rand logic AWVALID;
 rand logic WVALID;
 rand logic BREADY;
 rand logic ARVALID;
 rand logic RREADY;
 rand logic [2:0] AWPROT;
 rand logic [2:0] ARPROT;
 rand bit [3:0] wait_a;
 rand bit [3:0] wait_d;
 rand bit [1:0] flag;

 logic AWREADY;
 logic WREADY;
 logic BVALID;
 logic ARREADY;
 logic [`DATA_WIDTH -1:0]RDATA;
 logic [1:0]BRESP;
 logic [1:0]RRESP;
 logic RVALID;
 constraint c1 { flag inside {[1:3]};}
 constraint c2 { soft AWPROT == 0; soft ARPROT == 0;}
 constraint c3 {wait_a != wait_d;}

`uvm_object_utils_begin(trans)
 `uvm_field_int(AWADDR,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(AWVALID,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(WDATA,UVM_ALL_ON|UVM_HEX)
 `uvm_field_int(WSTRB,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(WVALID,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(BREADY,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(ARADDR,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(ARVALID,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(RREADY,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(AWREADY,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(WREADY,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(BRESP,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(BVALID,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(ARREADY,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(RDATA,UVM_ALL_ON|UVM_HEX)
 `uvm_field_int(RRESP,UVM_ALL_ON|UVM_DEC)
 `uvm_field_int(RVALID,UVM_ALL_ON|UVM_DEC)
`uvm_object_utils_end

function new(string name="trans");
 super.new(name);
endfunction
endclass
