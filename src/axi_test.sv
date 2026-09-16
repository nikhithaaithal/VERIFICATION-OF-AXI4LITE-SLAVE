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
   #20;
   phase.drop_objection(this);
  endtask
endclass

class read extends axi_test;
 `uvm_component_utils(read)
  read_seq seq2;
  function new(string name="read",uvm_component parent);
	super.new(name,parent);
  endfunction


  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq2=read_seq::type_id::create("seq2");
   seq2.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class write_strobe extends axi_test;
 `uvm_component_utils(write_strobe)
  write_strobe_seq seq3;
  function new(string name="write_strobe",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq3=write_strobe_seq::type_id::create("seq3");
    seq3.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class write_read extends axi_test;
 `uvm_component_utils(write_read)
  write_read_seq seq4;
  function new(string name="write_read",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq4= write_read_seq::type_id::create("seq4");
    seq4.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass

class  read_write extends axi_test;
 `uvm_component_utils( read_write)
   read_write_seq seq5;
  function new(string name=" read_write",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq5=  read_write_seq::type_id::create("seq5");
    seq5.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class backtoback_write extends axi_test;
 `uvm_component_utils( backtoback_write)
   backtoback_write_seq seq6;
  function new(string name=" backtoback_write",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq6=  backtoback_write_seq::type_id::create("seq6");
    seq6.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass

class backtoback_read extends axi_test;
 `uvm_component_utils( backtoback_read)
  backtoback_read_seq seq7;
  function new(string name="backtoback_read",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq7= backtoback_read_seq::type_id::create("seq7");
    seq7.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class awaddr_out_of_range extends axi_test;
 `uvm_component_utils( awaddr_out_of_range)
  awaddr_out_of_range_seq seq8;
  function new(string name="awaddr_out_of_range",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq8= awaddr_out_of_range_seq::type_id::create("seq8");
    seq8.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class araddr_out_of_range extends axi_test;
 `uvm_component_utils( araddr_out_of_range)
  araddr_out_of_range_seq seq9;
  function new(string name="araddr_out_of_range",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq9= araddr_out_of_range_seq::type_id::create("seq9");
    seq9.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class awaddr_unaligned extends axi_test;
 `uvm_component_utils( awaddr_unaligned)
  awaddr_unaligned_seq seq10;
  function new(string name="awaddr_unaligned",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq10= awaddr_unaligned_seq::type_id::create("seq10");
    seq10.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass

class araddr_unaligned extends axi_test;
  `uvm_component_utils( araddr_unaligned)
  araddr_unaligned_seq seq11;
  function new(string name="araddr_unaligned",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq11= araddr_unaligned_seq::type_id::create("seq11");
    seq11.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class write_ro extends axi_test;
  `uvm_component_utils( write_ro)
 write_ro_seq seq12;
  function new(string name="write_ro",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq12= write_ro_seq::type_id::create("seq12");
    seq12.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
  endclass

  class read_wo extends axi_test;
  `uvm_component_utils( read_wo)
   read_wo_seq seq13;
  function new(string name="read_wo",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq13=read_wo_seq::type_id::create("seq13");
    seq13.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass



class  simultaneous extends axi_test;
  `uvm_component_utils( simultaneous)
     simultaneous_seq seq14;
  function new(string name="simultaneous",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq14= simultaneous_seq::type_id::create("seq14");
    seq14.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class err_priority extends axi_test;
  `uvm_component_utils(err_priority)
     err_priority_seq seq17;
  function new(string name="err_priority",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq17= err_priority_seq::type_id::create("seq17");
    seq17.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass



class prot extends axi_test;
  `uvm_component_utils(prot)
     prot_seq seq18;
  function new(string name="prot",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq18= prot_seq::type_id::create("seq18");
    seq18.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class  backtoback_write_addr extends axi_test;
  `uvm_component_utils( backtoback_write_addr)
     backtoback_write_addr_seq seq19;
  function new(string name="backtoback_write_addr",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq19= backtoback_write_addr_seq::type_id::create("seq19");
    seq19.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass

class  backtoback_read_addr extends axi_test;
  `uvm_component_utils( backtoback_read_addr)
     backtoback_read_addr_seq seq20;
  function new(string name="backtoback_read_addr",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq20= backtoback_read_addr_seq::type_id::create("seq20");
    seq20.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class  simultaneous_addr extends axi_test;
  `uvm_component_utils( simultaneous_addr)
     simultaneous_addr_seq seq15;
  function new(string name="simultaneous_addr",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq15= simultaneous_addr_seq::type_id::create("seq15");
    seq15.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass


class awaddr_unaligned_readcheck extends axi_test;
  `uvm_component_utils(awaddr_unaligned_readcheck)
     awaddr_unaligned_readcheck_seq seq21;
  function new(string name="awaddr_unaligned_readcheck",uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction
 
  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
    seq21= awaddr_unaligned_readcheck_seq::type_id::create("seq21");
    seq21.start(env.agt1.seqr);
   #20;
   phase.drop_objection(this);
  endtask
endclass

class regression extends axi_test;
  `uvm_component_utils(regression)

  axi_sequence              seq1;
  read_seq                   seq2;
  write_strobe_seq           seq3;
  write_read_seq             seq4;
  read_write_seq             seq5;
  backtoback_write_seq       seq6;
  backtoback_read_seq        seq7;
  awaddr_out_of_range_seq    seq8;
  araddr_out_of_range_seq    seq9;
  awaddr_unaligned_seq       seq10;
  araddr_unaligned_seq       seq11;
  write_ro_seq               seq12;
  read_wo_seq                seq13;
  simultaneous_seq           seq14;
  simultaneous_addr_seq      seq15;
  err_priority_seq           seq17;
  prot_seq                   seq18;
  backtoback_write_addr_seq  seq19;
  backtoback_read_addr_seq   seq20;
  awaddr_unaligned_readcheck_seq seq21;

  function new(string name = "regression",
               uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    seq1 = axi_sequence::type_id::create("seq1");
    seq1.start(env.agt1.seqr);
    #20;
    $display("completed 1");

    seq2 = read_seq::type_id::create("seq2");
    seq2.start(env.agt1.seqr);
    #20;
    $display("completed 2");

    seq3 = write_strobe_seq::type_id::create("seq3");
    seq3.start(env.agt1.seqr);
    #20;
    $display("completed 3");
   
    seq4 = write_read_seq::type_id::create("seq4");
    seq4.start(env.agt1.seqr);
    #20;
    $display("completed 4");
    
    seq5 = read_write_seq::type_id::create("seq5");
    seq5.start(env.agt1.seqr);
    #20;
     
    seq6 = backtoback_write_seq::type_id::create("seq6");
    seq6.start(env.agt1.seqr);
    #20;

    seq7 = backtoback_read_seq::type_id::create("seq7");
    seq7.start(env.agt1.seqr);
    #20;
  
    seq8 = awaddr_out_of_range_seq::type_id::create("seq8");
    seq8.start(env.agt1.seqr);
    #20;

    seq9 = araddr_out_of_range_seq::type_id::create("seq9");
    seq9.start(env.agt1.seqr);
    #20;
     
    seq10 = awaddr_unaligned_seq::type_id::create("seq10");
    seq10.start(env.agt1.seqr);
    #20;

    seq11 = araddr_unaligned_seq::type_id::create("seq11");
    seq11.start(env.agt1.seqr);
    #20;
      
    seq12 = write_ro_seq::type_id::create("seq12");
    seq12.start(env.agt1.seqr);
    #20;

    seq13 = read_wo_seq::type_id::create("seq13");
    seq13.start(env.agt1.seqr);
    #20;
    
    seq14 = simultaneous_seq::type_id::create("seq14");
    seq14.start(env.agt1.seqr);
    #20;
     
    seq15 = simultaneous_addr_seq::type_id::create("seq15");
    seq15.start(env.agt1.seqr);
    #20;


    seq17 = err_priority_seq::type_id::create("seq17");
    seq17.start(env.agt1.seqr);
    #20;

    seq18 = prot_seq::type_id::create("seq18");
    seq18.start(env.agt1.seqr);
    #20;
     
    seq19 = backtoback_write_addr_seq::type_id::create("seq19");
    seq19.start(env.agt1.seqr);
    #20;

    seq20 = backtoback_read_addr_seq::type_id::create("seq20");
    seq20.start(env.agt1.seqr);
    #20;

    seq21 = awaddr_unaligned_readcheck_seq::type_id::create("seq21s");
    seq21.start(env.agt1.seqr);
    #20;
     
    phase.drop_objection(this);

  endtask

endclass
