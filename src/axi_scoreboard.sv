class axi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(axi_scoreboard)
  uvm_tlm_analysis_fifo#(trans)inp_fifo;
  uvm_tlm_analysis_fifo#(trans)out_fifo;
  virtual axi_interface vif;
  function new(string name="axi_scoreboard",uvm_component parent);
    super.new(name,parent); 
  endfunction

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
   if(!uvm_config_db#(virtual axi_interface )::get( this,"","interface",vif))
   `uvm_fatal(get_type_name()," Failed")
  inp_fifo=new("inp_fifo",this);
  out_fifo=new("out_fifo",this);
 endfunction

 trans inp;
 trans out;
 bit [31:0] mem [int];

 task run_phase(uvm_phase phase);
 forever begin
  inp_fifo.get(inp);
  out_fifo.get(out);
  checker_logic(inp);
  check_res(out);
 end
 endtask

 task checker_logic(trans t);
  if(!vif.ARESETn)
   begin
   t.AWREADY = 0;
   t.WREADY  = 0;
   t.BRESP   = 0;
   t.BVALID  = 0;
   t.ARREADY = 0;
   t.RDATA   = 0;
   t.RRESP   = 0;
   t.RVALID  = 0;
   for(int i=0; i<16;i++)
    mem[i] =32'd0;
   end
  else 
   begin
    write_op(t);
    read_op(t);  
   end
 endtask

  task write_op (trans t);

   if(t.AWADDR[1:0] !=2'b00)
     t.BRESP = 2'b10;
   else if(t.AWADDR >=32'h28 && t.AWADDR <= 32'h30)
      t.BRESP = 2'b10;
   else if(t.AWADDR >32'h3C)
      t.BRESP = 2'b11;
   else 
      begin
      t.BRESP =2'b00;
      for(int i=0;i<4; i++)
       begin
        if(t.WSTRB[i])
        mem[t.AWADDR[5:2]][i*8 +:8] = t.WDATA[i*8 +: 8];
      end
     end
  endtask

  task read_op(trans t);

     if(t.ARADDR[1:0] != 2'b00)
      begin
       t.RRESP   = 2'b10;
       t.RDATA    = 0;
      end
     else if(t.ARADDR> 32'h34 && t.ARADDR < 32'h38)
      begin
       t.RRESP   = 2'b10;
       t.RDATA    = 0;
      end
    else if(t.ARADDR > 32'h3C)
      begin
       t.RRESP   = 2'b11;
       t.RDATA    = 0;
      end
   else
     begin
      t.RRESP   = 2'b00;
      t.RDATA   = mem[t.ARADDR[5:2]];
     end
  endtask

  task check_res(trans ch);
   
   if(ch.BRESP == inp.BRESP)
    $display("BRESP correct");
   else
   `uvm_error(get_type_name(),"WRONG BRESP");

   if(ch.RDATA == inp.RDATA)
    $display("RDATA correct");
   else
   `uvm_error(get_type_name(),"WRONG RDATA");

   if(ch.RRESP == inp.RRESP)
    $display("RRESP correct");
   else
   `uvm_error(get_type_name(),"WRONG RRESP");

  endtask 

 endclass
