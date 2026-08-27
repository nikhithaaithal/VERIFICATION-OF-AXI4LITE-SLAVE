class axi_test extends uvm_test;
 `uvm_component_utils(axi_test)
  axi_environment env;

 function new(string name ="axi_test", uvm_component parent);
  super.new(name,parent);
 endfunction

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  env=axi_environment::type_id::create("env",this);
 endfunction

endclass

class write extends axi_test;
 `uvm_component_utils(write)
  axi_sequence seq1;
  function new(string name="write",uvm_component parent);
	super.new(name,parent);
  endfunction


  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   seq1=axi_sequence::type_id::create("seq1");
   seq1.start(env.agt1.seqr);
   phase.drop_objection(this);
  endtask
endclass
