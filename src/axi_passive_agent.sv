class axi_passive_agent extends uvm_agent;
 `uvm_component_utils(axi_passive_agent)
  axi_out_monitor mon_out;
 function new(string name= "axi_passive_agent", uvm_component parent);
  super.new(name,parent);
 endfunction
 
 function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 mon_out=axi_out_monitor::type_id::create("mon_out",this);
endfunction

endclass
 

