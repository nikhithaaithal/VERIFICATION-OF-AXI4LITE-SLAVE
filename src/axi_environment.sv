class axi_environment extends uvm_env;
 `uvm_component_utils(axi_environment)
  axi_active_agent agt1;
  axi_passive_agent agt2;
  axi_scoreboard scb;
  axi_subscriber sub;

 function new(string name ="axi_environment",uvm_component parent);
  super.new(name,parent);
 endfunction

 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   agt1=axi_active_agent::type_id::create("agt1",this);
   agt2=axi_passive_agent::type_id::create("agt2",this);
   scb=axi_scoreboard::type_id::create("scb",this);
   sub=axi_subscriber::type_id::create("sub",this);
   agt2.is_active = UVM_PASSIVE;
 endfunction

 function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   agt1.mon_inp.mon_port.connect(scb.inp_fifo.analysis_export);
   agt2.mon_out.mon_port.connect(scb.out_fifo.analysis_export);
/*
   agt1.mon_inp.mon_port_wr.connect(scb.inp_fifo.analysis_export);
   agt2.mon_out.mon_port_wr.connect(scb.out_fifo.analysis_export);
   agt1.mon_inp.mon_port_rd.connect(scb.inp_fifo.analysis_export);
   agt2.mon_out.mon_port_rd.connect(scb.out_fifo.analysis_export);

*/

   agt1.mon_inp.mon_port.connect(sub.analysis_export);
 endfunction

 function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
 endfunction

endclass


