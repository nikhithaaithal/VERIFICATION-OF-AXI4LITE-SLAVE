class axi_inp_monitor extends uvm_monitor;
 `uvm_component_utils(axi_inp_monitor)
  trans mon;
  uvm_analysis_port #(trans) mon_port_wr;
    uvm_analysis_port #(trans) mon_port_rd;
  virtual axi_interface.MON_INP vif;
 function new(string name = "axi_inp_monitor", uvm_component parent);
   super.new(name,parent);
 endfunction
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual axi_interface )::get( this,"","interface",vif))
    `uvm_fatal(get_type_name(),"Input monitor failed")
   mon_port_wr=new("mon_port_wr",this);
   mon_port_rd=new("mon_port_rd",this);
 endfunction

task run_phase (uvm_phase phase);
forever begin
 @(vif.mon_inp_cb);

   $display(" Input monitor");
 if(vif.mon_inp_cb.AWVALID && vif.mon_inp_cb.WVALID && vif.mon_inp_cb.AWREADY && vif.mon_inp_cb.WREADY)
 begin
  mon=trans::type_id::create("mon",this);
  mon.AWADDR  = vif.mon_inp_cb.AWADDR;
  mon.AWPROT  = vif.mon_inp_cb.AWPROT;
  mon.WDATA   = vif.mon_inp_cb.WDATA;
  mon.WSTRB   = vif.mon_inp_cb.WSTRB;
  mon.BREADY  = vif.mon_inp_cb.BREADY;
  `uvm_info("INPUT_MONITOR",$sformatf("Input MONITOR\n%s",mon.sprint()),UVM_NONE)
  mon_port_wr.write(mon);
 end
  if(vif.mon_inp_cb.ARVALID && vif.mon_inp_cb.ARREADY)
  begin
  mon=trans::type_id::create("mon",this);
   mon.ARADDR  = vif.mon_inp_cb.ARADDR;
   mon.RREADY  = vif.mon_inp_cb.RREADY;
   mon.ARPROT  = vif.mon_inp_cb.ARPROT;
   `uvm_info("INPUT_MONITOR",$sformatf("Input MONITOR\n%s",mon.sprint()),UVM_NONE)
   mon_port_rd.write(mon);
  end
  
end
endtask
endclass
