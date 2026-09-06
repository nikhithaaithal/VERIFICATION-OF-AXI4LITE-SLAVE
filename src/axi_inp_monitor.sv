class axi_inp_monitor extends uvm_monitor;
 `uvm_component_utils(axi_inp_monitor)
  trans mon_wr;
  trans mon_rd;
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
   if(!uvm_config_db#(virtual axi_interface.MON_INP )::get( this,"","interface",vif))
    `uvm_fatal(get_type_name(),"Input monitor failed")
   mon_port=new("mon_port",this);
 endfunction

task run_phase (uvm_phase phase);
forever begin
 @(vif.mon_inp_cb);
 collect_data();
 if(address && data) 
  begin
   mon_port.write(mon_wr);
   address = 0;
   data = 0;
   mon_wr=null;
  end
  if(read)
   begin
   mon_port.write(mon_rd);
    read = 0;
    mon_rd=null;
   end
end
endtask

task collect_data();
 if(vif.mon_inp_cb.AWVALID && vif.mon_inp_cb.AWREADY)
  begin
     if(mon_wr==null)
      mon_wr=trans::type_id::create("mon_wr",this);
     mon_wr.AWADDR  = vif.mon_inp_cb.AWADDR;
     mon_wr.AWPROT  = vif.mon_inp_cb.AWPROT;
     address = 1;
     mon_wr.flag[0]= 1;
  end
 if(vif.mon_inp_cb.WVALID && vif.mon_inp_cb.WREADY)
   begin
     if(mon_wr==null)
       mon_wr=trans::type_id::create("mon_wr",this);
     mon_wr.WDATA  = vif.mon_inp_cb.WDATA;
     mon_wr.WSTRB  = vif.mon_inp_cb.WSTRB;
     data = 1;
     mon_wr.flag[0]= 1;
  end
  if(vif.mon_inp_cb.ARVALID && vif.mon_inp_cb.ARREADY)
   begin
      if(mon_rd==null)
     mon_rd=trans::type_id::create("mon_rd",this);
     mon_rd.ARADDR  = vif.mon_inp_cb.ARADDR;
     mon_rd.ARPROT  = vif.mon_inp_cb.ARPROT;
     read=1;
     mon_rd.flag[1]=1;
   end
endtask
  
endclass
