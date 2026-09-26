class trans extends uvm_sequence_item;
 
 rand bit [`ADDR_WIDTH-1:0]AWADDR;
 rand bit [`DATA_WIDTH -1:0] WDATA;
 rand bit [(`DATA_WIDTH / 8)-1:0] WSTRB;
 rand bit [`ADDR_WIDTH-1:0]ARADDR;
 rand bit AWVALID;
 rand bit WVALID;
 rand bit BREADY;
 rand bit ARVALID;
 rand bit RREADY;
 rand bit [2:0] AWPROT;
 rand bit [2:0] ARPROT;
 rand bit [3:0] wait_a;
 rand bit [3:0] wait_d;
 rand bit [1:0] flag;
 rand bit [3:0] wait_r; 
 bit AWREADY;
 bit WREADY;
 bit BVALID;
 bit ARREADY;
 bit [`DATA_WIDTH -1:0]RDATA;
 bit [1:0]BRESP;
 bit [1:0]RRESP;
 bit RVALID;
 constraint c1 { flag inside {[1:3]};}
 constraint c2 { soft AWPROT == 0; soft ARPROT == 0;}
 constraint c3 {wait_a != wait_d;}
 constraint c4{ soft AWADDR[1:0] ==2'b00;soft  AWADDR <= 32'h3C;}
 constraint c5 { soft ARADDR[1:0] ==2'b00; soft ARADDR <= 32'h3C;}
 constraint c6 { soft WSTRB== 4'b1111;}
`uvm_object_utils_begin(trans)
 `uvm_field_int(AWADDR,UVM_ALL_ON)
 `uvm_field_int(AWVALID,UVM_ALL_ON)
 `uvm_field_int(WDATA,UVM_ALL_ON)
 `uvm_field_int(WSTRB,UVM_ALL_ON)
 `uvm_field_int(WVALID,UVM_ALL_ON)
 `uvm_field_int(BREADY,UVM_ALL_ON)
 `uvm_field_int(ARADDR,UVM_ALL_ON)
 `uvm_field_int(ARVALID,UVM_ALL_ON)
 `uvm_field_int(RREADY,UVM_ALL_ON)
 `uvm_field_int(AWREADY,UVM_ALL_ON)
 `uvm_field_int(WREADY,UVM_ALL_ON)
 `uvm_field_int(BRESP,UVM_ALL_ON)
 `uvm_field_int(BVALID,UVM_ALL_ON)
 `uvm_field_int(ARREADY,UVM_ALL_ON)
 `uvm_field_int(RDATA,UVM_ALL_ON)
 `uvm_field_int(RRESP,UVM_ALL_ON)
 `uvm_field_int(RVALID,UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="trans");
 super.new(name);
endfunction
endclass
