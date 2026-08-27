class axi_sequencer extends uvm_sequencer#(trans);
 `uvm_component_utils(axi_sequencer)
 function new( string name ="axi_sequencer",uvm_component parent);
  super.new(name,parent);
 endfunction
endclass

