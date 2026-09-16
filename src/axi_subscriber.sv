class axi_subscriber extends uvm_subscriber #(trans);
 `uvm_component_utils(axi_subscriber)
 trans tr;
 covergroup axi_cg;
 awaddr_cp: coverpoint tr.AWADDR {
  bins b1 = {[32'h00000000 : 32'h00000024]};
  bins b2 = {[32'h00000028 : 32'h00000030]};
  bins b3 = {[32'h00000034 : 32'h00000038]};
  bins b4 = {32'h0000003C};
  bins others = default;
}

 wdata_cp: coverpoint tr.WDATA {
  bins low  = {[32'h0000_0000 : 32'h5555_5555]};
  bins mid  = {[32'h5555_5556 : 32'hAAAA_AAAA]};
  bins high = {[32'hAAAA_AAAB : 32'hFFFF_FFFF]};
} 

 wstrb_cp:coverpoint tr.WSTRB{
 bins b[]={[4'b0000:4'b1111]};}

 awprot_cp:coverpoint tr.AWPROT{
 bins b[]={[3'b000:3'b111]};}

 arprot_cp:coverpoint tr.ARPROT{
 bins b[]={[3'b000:3'b111]};}

 araddr_cp:coverpoint tr.ARADDR{
  bins b1 = {[32'h00000000 : 32'h00000024]};
  bins b2 = {[32'h00000028 : 32'h00000030]};
  bins b3 = {[32'h00000034 : 32'h00000038]};
  bins b4 = {32'h0000003C};
  bins others = default;
}

 endgroup

 function new(string name, uvm_component parent);
  super.new(name,parent);
  axi_cg=new();
 endfunction
 function void write (trans t);
  tr=t;
   axi_cg.sample();
 endfunction
endclass
