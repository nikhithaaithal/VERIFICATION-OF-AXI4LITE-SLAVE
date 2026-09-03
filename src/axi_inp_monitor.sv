class axi_inp_monitor extends uvm_monitor;
 `uvm_component_utils(axi_inp_monitor)
  trans mon;
  uvm_analysis_port #(trans) mon_port;
  virtual axi_interface.MON_INP vif;
  bit address ;
  bit data;
  bit read;
 function new(string name = "axi_inp_monitor", uvm_component parent);
   super.new(name,parent);
 endfunction
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual axi_interface )::get( this,"","interface",vif))
    `uvm_fatal(get_type_name(),"Input monitor failed")
   mon_port=new("mon_port",this);
 endfunction

task run_phase (uvm_phase phase);
forever begin
 @(vif.mon_inp_cb);
 mon=trans::type_id::create("mon",this);
 collect_data();
 if((address && data) || read)
  begin
   mon_port.write(mon);
   address = 0;
   data = 0;
   read = 0;
  end
end
endtask

task collect_data();
 if(vif.mon_inp_cb.AWVALID && vif.mon_inp_cb.AWREADY)
  begin
     mon.AWADDR  = vif.mon_inp_cb.AWADDR;
     mon.AWPROT  = vif.mon_inp_cb.AWPROT;
     address =1;
  end
 if(vif.mon_inp_cb.WVALID && vif.mon_inp_cb.WREADY)
   begin
     mon.WDATA  = vif.mon_inp_cb.WDATA;
     mon.WSTRB  = vif.mon_inp_cb.WSTRB;
     data =1;
  end
 if(vif.mon_inp_cb.ARADDR && vif.mon_inp_cb.ARREADY)
   begin
     mon.ARADDR  = vif.mon_inp_cb.ARADDR;
     mon.ARPROT  = vif.mon_inp_cb.ARPROT;
     read=1;
   end
endtask
  
endclass
