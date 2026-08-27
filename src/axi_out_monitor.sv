class axi_out_monitor extends uvm_monitor;
 `uvm_component_utils(axi_out_monitor)
  trans mon;
  uvm_analysis_port #(trans) mon_port;
   virtual axi_interface.MON_OUT vif;
 function new(string name = "axi_out_monitor", uvm_component parent);
   super.new(name,parent);
 endfunction
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual axi_interface )::get( this,"","interface",vif))
    `uvm_fatal(get_type_name(),"Output monitor failed")
   mon_port=new("mon_port",this);
 endfunction
task run_phase (uvm_phase phase);
forever begin
 @(vif.mon_out_cb);

  $display(" Output monitor");
  if(vif.mon_out_cb.AWREADY && vif.mon_out_cb.WREADY && vif.mon_out_cb.AWVALID && vif.mon_out_cb.WVALID)
   begin
     mon=trans::type_id::create("mon",this);
     mon.BRESP    =  vif.mon_out_cb.BRESP;
    `uvm_info("OUTPUT_MONITOR",$sformatf("OUTPUT MONITOR\n%s",mon.sprint()),UVM_NONE)
     mon_port.write(mon);
   end
  if(vif.mon_out_cb.ARREADY && vif.mon_out_cb.ARVALID)
   begin
     mon=trans::type_id::create("mon",this);
     mon.RDATA    = vif.mon_out_cb.RDATA;
     mon.RRESP    = vif.mon_out_cb.RRESP;
    `uvm_info("OUTPUT_MONITOR",$sformatf("OUTPUT MONITOR\n%s",mon.sprint()),UVM_NONE)
     mon_port.write(mon);
   end
 
end
endtask
endclass
