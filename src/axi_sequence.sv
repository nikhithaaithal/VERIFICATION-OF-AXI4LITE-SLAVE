class axi_sequence extends uvm_sequence#(trans);
 `uvm_object_utils(axi_sequence)
 function new( string name= "axi_sequence");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1; AWVALID ==1;WVALID ==1; flag ==2'b01; AWADDR == 32'd24; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class read_seq extends uvm_sequence#(trans);
  `uvm_object_utils(read_seq)
  function new( string name= "read_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a == 1; wait_d == 2; ARVALID ==1;flag == 2'b10; ARADDR == 32'd24;});
  finish_item(req);
 endtask
endclass

class write_strobe_seq extends uvm_sequence#(trans);
  `uvm_object_utils(write_strobe_seq)
  function new( string name= "write_strobe_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  for(int i=0;i<16;i++) begin
  start_item(req);
    assert(req.randomize() with {wait_a == 1; wait_d == 2; flag == 2'b01; WSTRB ==i;  AWADDR[1:0] ==2'b00; AWADDR == i*4;});
  finish_item(req);
  start_item(req);
    assert(req.randomize() with {wait_a == 1; wait_d == 2; flag == 2'b10; ARADDR == i*4;});
  finish_item(req);
  end
 endtask
endclass


class write_read_seq extends uvm_sequence#(trans);
 `uvm_object_utils(write_read_seq)
 function new( string name= "write_read_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==1; wait_d ==2; flag ==2'b01; AWADDR == 32'd20;ARADDR == 32'd20; WSTRB== 4'b1111;});
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_a ==1; wait_d ==2; flag == 2'b10; ARADDR == 32'd20;AWADDR == 32'd20;});
  finish_item(req);
 endtask
endclass

class read_write_seq extends uvm_sequence#(trans);
 `uvm_object_utils(read_write_seq)
 function new( string name= "read_write_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==1; wait_d ==2; flag ==2'b01; AWADDR == 32'd20;WDATA == 32'd55; WSTRB== 4'b1111;});
   finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_a == 1; wait_d ==2; flag == 2'b10; ARADDR == 32'd20;});
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_a ==1; wait_d ==2; flag ==2'b01; AWADDR == 32'd20;WDATA == 32'd177; WSTRB== 4'b1111;});
  finish_item(req);
   start_item(req);
   assert(req.randomize() with {wait_a == 1; wait_d ==2; flag == 2'b10; ARADDR == 32'd20;});
  finish_item(req);
 endtask
endclass

class backtoback_write_seq extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_write_seq)
 function new( string name= "backtoback_write_seq");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  repeat(10) begin
  start_item(req);
    assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01;AWADDR[1:0] ==2'b00; WSTRB== 4'b1111;AWADDR <= 32'h3C;});
  finish_item(req);
  end
 endtask
endclass

class backtoback_read_seq extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_read_seq)
 function new( string name= "backtoback_read_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
   for(int i=1;i<=5;i++) begin
  start_item(req);
     assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01;AWADDR[1:0] == 2'b00; WDATA ==i*16; WSTRB== 4'b1111; AWADDR == i * 4;});
  finish_item(req);
  end
   for(int i=1;i<=5;i++)begin
  start_item(req);
     assert(req.randomize() with {wait_a == 2; wait_d == 1; flag == 2'b10; ARADDR[1:0] == 2'b00; ARADDR == i * 4; });
  finish_item(req);
  end
 endtask
endclass

class awaddr_out_of_range_seq extends uvm_sequence#(trans);
 `uvm_object_utils(awaddr_out_of_range_seq)
 function new( string name= "awaddr_out_of_range_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01; AWADDR == 32'hFFFF_FFFC; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class araddr_out_of_range_seq extends uvm_sequence#(trans);
  `uvm_object_utils(araddr_out_of_range_seq)
  function new( string name= "araddr_out_of_range_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==1; flag ==2'b10; ARADDR == 32'hFFFF_FFFC; });
  finish_item(req);
 endtask
endclass


class awaddr_unaligned_seq extends uvm_sequence#(trans);
 `uvm_object_utils(awaddr_unaligned_seq)
 function new( string name= "awaddr_unaligned_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01; AWADDR == 32'd10; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class araddr_unaligned_seq extends uvm_sequence#(trans);
  `uvm_object_utils(araddr_unaligned_seq)
  function new( string name= "araddr_unaligned_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==2; flag ==2'b10; ARADDR == 32'd10; });
  finish_item(req);
 endtask
endclass


class write_ro_seq extends uvm_sequence#(trans);
  `uvm_object_utils(write_ro_seq)
  function new( string name= "write_ro_seq");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01; AWADDR == 32'd44; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class read_wo_seq extends uvm_sequence #(trans);
  `uvm_object_utils(read_wo_seq)
  function new( string name= "read_wo_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==2; flag ==2'b10; ARADDR == 32'd52; });
  finish_item(req);
 endtask
endclass

class  simultaneous_seq extends uvm_sequence #(trans);
  `uvm_object_utils(simultaneous_seq)
  function new( string name= "simultaneous_seq");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b11; AWADDR == 32'd24; ARADDR == 32'd32; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class no_transaction_seq extends uvm_sequence#(trans);
 `uvm_object_utils( no_transaction_seq)
 function new( string name= " no_transaction_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a == 1; wait_d == 2; flag == 2'b01; AWVALID ==0;WVALID ==0; ARVALID ==0;});
  finish_item(req);
 endtask
endclass

class err_priority_seq extends uvm_sequence#(trans);
  `uvm_object_utils(err_priority_seq)
  function new( string name= "err_priority_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==1; wait_d ==2; AWVALID ==1;WVALID ==1; flag ==2'b01; AWADDR == 32'd78; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class prot_seq extends uvm_sequence#(trans);
 `uvm_object_utils(prot_seq)
 function new( string name= "prot_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  //for(int i=0;i<8;i++) begin
  start_item(req);
   assert(req.randomize() with {wait_a == 1; wait_d == 2; AWPROT ==3'd4; flag == 2'b11; AWVALID ==1;AWADDR ==32'd12;});
  finish_item(req);
  //end
 endtask
endclass


class backtoback_write_addr_seq extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_write_addr_seq)
 function new( string name= "backtoback_write_addr_seq");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  repeat(3) begin
  start_item(req);
    assert(req.randomize() with {wait_a ==1; wait_d ==2; AWVALID ==1;WVALID ==1; flag ==2'b01; AWADDR == 32'd24; WSTRB== 4'b1111;});
  finish_item(req);
  end
 endtask
endclass

class backtoback_read_addr_seq extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_read_addr_seq)
 function new( string name= "backtoback_read_addr_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
   start_item(req);
   assert(req.randomize() with {wait_a ==1; wait_d ==2; AWVALID ==1;WVALID ==1; flag ==2'b01; AWADDR == 32'd4; WSTRB== 4'b1111;});
  finish_item(req);
   repeat(3) begin
  start_item(req);
     assert(req.randomize() with {wait_a == 1; wait_d == 2; ARADDR == 32'd4; flag == 2'b10; });
  finish_item(req);
  end
 endtask
endclass



class simultaneous_addr_seq extends uvm_sequence #(trans);
  `uvm_object_utils(simultaneous_addr_seq)
  function new( string name= "simultaneous_addr_seq");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==1; wait_d ==2; flag ==2'b11; AWADDR == 32'd28; ARADDR == 32'd28; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

/*

class write_delay_addr extends uvm_sequence#(trans);
 `uvm_object_utils(write_delay_addr)
 function new( string name= "write_delay_addr");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==2; wait_d ==0; WVALID ==1; flag ==2'b01; AWADDR == 32'd08; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class write_delay_data extends uvm_sequence#(trans);
 `uvm_object_utils(write_delay_data)
 function new( string name= "write_delay_data");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d == 4; WVALID ==1; flag ==2'b01; AWADDR == 32'd04; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class read_delay_addr extends uvm_sequence#(trans);
 `uvm_object_utils(read_delay_addr)
 function new( string name= "read_delay_addr");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a == 3; wait_d == 0;flag == 2'b10; ARADDR == 32'd24;});
  finish_item(req);
 endtask
endclass

class backtoback_write_delay extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_write_delay)
 function new( string name= "backtoback_write_delay");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  repeat(10) begin
  start_item(req);
  assert(req.randomize() with {wait_a ==2; wait_d ==3; flag ==2'b01; WSTRB== 4'b1111;});
  finish_item(req);
  end
 endtask
endclass

class backtoback_read_delay extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_read_delay )
 function new( string name= "backtoback_read_delay ");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  repeat(10) begin
  start_item(req);
  assert(req.randomize() with {wait_a == 3; wait_d == 3; flag == 2'b10; });
  finish_item(req);
  end
 endtask
endclass

*/

