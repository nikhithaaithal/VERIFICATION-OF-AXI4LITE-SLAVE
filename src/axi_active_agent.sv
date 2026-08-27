class axi_active_agent extends uvm_agent;
 `uvm_component_utils(axi_active_agent)
  axi_driver drv;
  axi_inp_monitor mon_inp;
  axi_sequencer seqr;
 function new(string name= "axi_active_agent", uvm_component parent);
  super.new(name,parent);
 endfunction
 
 function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 mon_inp=axi_inp_monitor::type_id::create("mon_inp",this);
 if(is_active == UVM_ACTIVE)
 begin
  drv= axi_driver::type_id::create("drv", this);
  seqr=axi_sequencer::type_id::create("seqr",this);
 end
 endfunction

function void connect_phase(uvm_phase phase);
 super.connect_phase(phase);
 if(is_active == UVM_ACTIVE)
 drv.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass
 

