class axi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(axi_scoreboard)
  uvm_tlm_analysis_fifo#(trans)inp_fifo;
  uvm_tlm_analysis_fifo#(trans)out_fifo;

  function new(string name="axi_scoreboard",uvm_component parent);
    super.new(name,parent); 
  endfunction

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  inp_fifo=new("inp_fifo",this);
  out_fifo=new("out_fifo",this);
 endfunction

 trans inp;
 trans out;
  bit [31:0] array [int];

 task run_phase(uvm_phase phase);
 forever begin
  inp_fifo.get(inp);
  out_fifo.get(out);
  checker_logic(inp);
  check_res(out);
 end
 endtask
 
 

 task checker_logic(trans t);
   begin 
     if(t.flag[0])
       begin
        write_op(t);
       end
     if(t.flag[1])read_op(t);  
   end
 endtask

  task write_op (trans t);
    if(t.AWADDR >32'h3C)
     t.BRESP = 2'b11;
   else if(t.AWADDR >=32'h28 && t.AWADDR <= 32'h30)
      t.BRESP = 2'b10;
   else if(t.AWADDR[1:0] !=2'b00)
      t.BRESP = 2'b10;
   else 
      begin
      t.BRESP =2'b00;
      for(int i=0;i<4; i++)
       begin
        if(t.WSTRB[i])
        array[t.AWADDR[5:2]][i*8 +:8] = t.WDATA[i*8 +: 8];
      end
     end
  endtask

  task read_op(trans t);

     if(t.ARADDR > 32'h3C )
      begin
       t.RRESP   = 2'b11;
       t.RDATA    = 0;
      end
    else if(t.ARADDR>= 32'h34 && t.ARADDR <= 32'h38)
      begin
       t.RRESP   = 2'b10;
       t.RDATA    = 0;
      end
    else if(t.ARADDR[1:0] != 2'b00)
      begin
       t.RRESP   = 2'b10;
       t.RDATA    = 0;
      end
   else
     begin
      t.RRESP   = 2'b00;
      t.RDATA   = array[t.ARADDR[5:2]];
     end
  endtask

 task check_res(trans ch);
   if(inp.flag[0] && ch.flag[0] ) begin
    if(ch.BRESP == inp.BRESP) begin
      `uvm_info(get_type_name(), $sformatf("BRESP correct: BRESP = %0b, exp_BRESP=%0b wstrb =%d", ch.BRESP, inp.BRESP,inp.WSTRB), UVM_LOW)
    end
    else begin
      `uvm_error(get_type_name(), $sformatf("WRONG BRESP: BRESP = %0b, exp_BRESP=%0b", ch.BRESP, inp.BRESP))
    end
  end
  
   if(inp.flag[1] && ch.flag[1])begin
     
    if(ch.RDATA == inp.RDATA) begin
      `uvm_info(get_type_name(), $sformatf("RDATA correct: RDATA = %0h, exp_RDATA=%0h", ch.RDATA, inp.RDATA), UVM_LOW)
    end
    else 
      `uvm_error(get_type_name(), $sformatf("WRONG RDATA: RDATA = %0h, exp_RDATA=%0h, ARADDR= %d", ch.RDATA, inp.RDATA,inp.ARADDR))
   
   if(ch.RRESP == inp.RRESP) begin
      `uvm_info(get_type_name(), $sformatf("RRESP correct: RRESP = %0b, exp_RRESP=%0b", ch.RRESP, inp.RRESP), UVM_LOW)
    end
    else begin
      `uvm_error(get_type_name(), $sformatf("WRONG RRESP: RRESP = %0b, exp_RRESP=%0b", ch.RRESP, inp.RRESP))
    end
    
  end

 endtask 

 endclass
