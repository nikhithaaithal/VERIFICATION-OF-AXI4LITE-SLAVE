class axi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(axi_scoreboard)
  uvm_tlm_analysis_fifo#(trans)inp_wr_fifo;
  uvm_tlm_analysis_fifo#(trans)out_wr_fifo;
  uvm_tlm_analysis_fifo#(trans)inp_rd_fifo;
  uvm_tlm_analysis_fifo#(trans)out_rd_fifo;

  function new(string name="axi_scoreboard",uvm_component parent);
    super.new(name,parent); 
  endfunction

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
   inp_wr_fifo=new("inp_wr_fifo",this);
   out_wr_fifo=new("out_wr_fifo",this);
   inp_rd_fifo=new("inp_rd_fifo",this);
   out_rd_fifo=new("out_rd_fifo",this);
 endfunction

 trans inp_wr;
 trans out_wr;
 trans inp_rd;
 trans out_rd;
  bit [31:0] array [int];

task run_phase(uvm_phase phase);
 fork 
   begin
    forever begin
      inp_wr_fifo.get(inp_wr);
      out_wr_fifo.get(out_wr);
      checker_logic(inp_wr);
      check_res(inp_wr,out_wr);
    end
   end
  begin
    forever begin
      inp_rd_fifo.get(inp_rd);
      out_rd_fifo.get(out_rd);
      checker_logic(inp_rd);
      check_res(inp_rd,out_rd);
    end 
  end
 join_none
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
        array[t.AWADDR][i*8 +:8] = t.WDATA[i*8 +: 8];
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
      t.RDATA   = array[t.ARADDR];
     end
  endtask

  task check_res(trans inp,trans ch);
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
