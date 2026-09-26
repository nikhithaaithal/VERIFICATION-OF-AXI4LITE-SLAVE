class axi_out_monitor extends uvm_monitor;
 `uvm_component_utils(axi_out_monitor)
  trans mon;
  uvm_analysis_port #(trans) mon_port_wr;
  uvm_analysis_port #(trans) mon_port_rd;
  virtual axi_interface.MON_OUT vif;
  bit write_op;
  bit read_op;
 function new(string name = "axi_out_monitor", uvm_component parent);
   super.new(name,parent);
 endfunction
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual axi_interface.MON_OUT )::get( this,"","interface",vif))
    `uvm_fatal(get_type_name(),"Output monitor failed")
     mon_port_wr=new("mon_port_wr",this);
     mon_port_rd=new("mon_port_rd",this);
 endfunction

task run_phase (uvm_phase phase);
forever begin
 @(vif.mon_out_cb);
 mon=trans::type_id::create("mon",this);
 collect_data();

  if(write_op )
  begin
    `uvm_info(get_type_name(),
   $sformatf("WRITE_RESP : BRESP=%0b", mon.BRESP),
   UVM_LOW)
   mon_port_wr.write(mon);
   write_op =0;
  end
 if(read_op)
   begin
    `uvm_info(get_type_name(),
   $sformatf("READ_DATA : RRESP=%0b RDATA=%0h", mon.RRESP, mon.RDATA),
   UVM_LOW)
   mon_port_rd.write(mon);
   read_op=0;
  end
 
end
endtask

task collect_data ();
  if(vif.mon_out_cb.BREADY && vif.mon_out_cb.BVALID)
  begin
   write_op=1;
   mon.BRESP    =  vif.mon_out_cb.BRESP;
   mon.flag[0]= 1;
  end
if(vif.mon_out_cb.RREADY && vif.mon_out_cb.RVALID)
  begin
   read_op=1;
   mon.RRESP    =  vif.mon_out_cb.RRESP;
   mon.RDATA    = vif.mon_out_cb.RDATA;
   mon.flag[1]= 1;
  end
endtask

endclass
