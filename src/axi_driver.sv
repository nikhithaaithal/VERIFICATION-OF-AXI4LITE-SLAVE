class axi_driver extends uvm_driver#(trans);
 `uvm_component_utils(axi_driver)
  virtual axi_interface.DRV vif;

 function new( string name="axi_driver", uvm_component parent);
  super.new(name, parent);
 endfunction
 
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
  if(!uvm_config_db#(virtual axi_interface.DRV )::get( this,"","interface",vif))
   `uvm_fatal(get_type_name(),"Driver failed")
 endfunction

task run_phase(uvm_phase phase);
  wait(vif.drv_cb.ARESETn === 1'b1);
  @(vif.drv_cb); 
  $display("[%0t]:Reset high",$time);
forever begin
  seq_item_port.get_next_item(req);
  $display("driver started");
  drive(req);
 `uvm_info("DRIVER",$sformatf("DRIVER\n%s",req.sprint()),UVM_NONE)
  seq_item_port.item_done();
end
endtask

task drive(trans t);

   if(t.flag == 2'b11)
      begin
        fork
           write_transaction(t);
           read_transaction(t); 
        join
      end
    else if(t.flag == 2'b01)
      write_transaction(t);
    else 
       read_transaction(t);
endtask

task write_transaction(trans t);
 fork
  begin
    repeat(t.wait_a) @(vif.drv_cb);
     wac(t);
  end
  begin
   repeat(t.wait_d) @(vif.drv_cb); 
   wdc(t);
  end
 join
 wrc(t);
endtask

task read_transaction(trans t);
 repeat(t.wait_a) @(vif.drv_cb);
 rac(t);
 rdc(t);
endtask

task wac(trans t);
  $display("[%0t] WAC: Starting AW transaction", $time);
 vif.drv_cb.AWADDR  <= t.AWADDR;
 vif.drv_cb.AWPROT  <=t.AWPROT;
 vif.drv_cb.AWVALID <= 1'b1;
 do
  @(vif.drv_cb);
 while (!vif.drv_cb.AWREADY);
  $display("[%0t] WAC: AWREADY received", $time);
 vif.drv_cb.AWVALID <= 1'b0;
endtask

task wdc(trans t);
 $display("[%0t] WDC: Starting W transaction", $time);
 vif.drv_cb.WDATA  <= t.WDATA;
 vif.drv_cb.WSTRB  <= t.WSTRB;
 vif.drv_cb.WVALID <= 1'b1;
 do
  @(vif.drv_cb);
 while (!vif.drv_cb.WREADY);
 
   $display("[%0t] WDC: WREADY received", $time);
 vif.drv_cb.WVALID <= 1'b0;
 endtask

task wrc(trans t);
  $display("[%0t] WRC: Starting WR transaction", $time);
 vif.drv_cb.BREADY <= 1'b1;
  
 do begin
  @(vif.drv_cb);
   $display("[%0t] WRC: Waiting for BVALID", $time); end
 while (!vif.drv_cb.BVALID);
  t.BRESP = vif.drv_cb.BRESP;
  vif.drv_cb.BREADY <= 1'b0;
  $display("[%0t] WRC: BVALID received", $time);
endtask

task rac(trans t);
  $display("[%0t] RAC: Starting RA transaction", $time);
 vif.drv_cb.ARADDR  <= t.ARADDR;
 vif.drv_cb.ARVALID <= 1'b1;
 vif.drv_cb.ARPROT <= t.ARPROT;
 do
  @(vif.drv_cb);
 while(!vif.drv_cb.ARREADY);
 vif.drv_cb.ARVALID <= 1'b0;
  $display("[%0t] RAC: ARREADY received", $time);
endtask
  

task rdc(trans t);
  $display("[%0t] RDC: Starting WD transaction", $time);
 vif.drv_cb.RREADY <= 1'b1;
 do
  @(vif.drv_cb);
  while(!vif.drv_cb.RVALID);
  t.RRESP = vif.drv_cb.RRESP;
  vif.drv_cb.RREADY <= 1'b0;
  $display("[%0t] RDC: RVALID received", $time);
endtask
endclass
