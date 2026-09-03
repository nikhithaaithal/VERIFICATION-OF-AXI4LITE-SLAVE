class axi_sequence extends uvm_sequence#(trans);
 `uvm_object_utils(axi_sequence)
 function new( string name= "axi_sequence");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==1; wait_d ==2; AWVALID ==1;WVALID ==1; flag ==2'b01; AWADDR == 32'd24; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class read extends uvm_sequence#(trans);
 `uvm_object_utils(read)
 function new( string name= "read");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; ARVALID ==1;flag == 2'b10; ARADDR == 32'd24;});
  finish_item(req);
 endtask
endclass

class write_stobe extends uvm_sequence#(trans);
 `uvm_object_utils(write_stobe)
 function new( string name= "write_stobe");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  for(int i=0;i<16;i++) begin
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; flag == 2'b01;  WSTRB ==i;});
  finish_item(req);
  end
 endtask
endclass


class write_read extends uvm_sequence#(trans);
 `uvm_object_utils(write_read)
 function new( string name= "write_read");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b01; AWADDR == 32'd20; WSTRB== 4'b1111;});
  finish_item(req);
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; flag == 2'b10; ARADDR == 32'd20;});
  finish_item(req);
 endtask
endclass

class read_write extends uvm_sequence#(trans);
 `uvm_object_utils(read_write)
 function new( string name= "read_write");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b01; AWADDR == 32'd20; WSTRB== 4'b1111;});
  finish_item(req);
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; flag == 2'b10; ARADDR == 32'd20;});
  finish_item(req);
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b01; AWADDR == 32'd20; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class backtoback_write extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_write)
 function new( string name= "backtoback_write");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  repeat(10) begin
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b01;AWADDR % 4 ==0; WSTRB== 4'b1111;});
  finish_item(req);
  end
 endtask
endclass

class backtoback_read extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_read)
 function new( string name= "backtoback_read");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; flag == 2'b10;ARADDR % 4 ==0; });
  finish_item(req);
 endtask
endclass

class awaddr_out_of_range extends uvm_sequence#(trans);
 `uvm_object_utils(awaddr_out_of_range)
 function new( string name= "awaddr_out_of_range");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b01; AWADDR == 32'd66; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class araddr_out_of_range extends uvm_sequence#(trans);
 `uvm_object_utils(araddr_out_of_range)
 function new( string name= "araddr_out_of_range");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b10; ARADDR == 32'd66; });
  finish_item(req);
 endtask
endclass

class write_ro extends uvm_sequence#(trans);
 `uvm_object_utils(write_ro)
 function new( string name= "write_ro");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b01; AWADDR == 32'd36; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class read_wo extends uvm_sequence #(trans);
 `uvm_object_utils(read_wo)
 function new( string name= "read_wo");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b10; AWADDR == 32'd52; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class simultaneous extends uvm_sequence #(trans);
 `uvm_object_utils(simultaneous)
 function new( string name= "simultaneous");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b11; AWADDR == 32'd24; ARREADY == 32'd35; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class simultaneous_addr extends uvm_sequence #(trans);
 `uvm_object_utils(simultaneous_addr)
 function new( string name= "simultaneous_addr");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b11; AWADDR == 32'd36; ARREADY == 32'd33; WSTRB== 4'b1111;});
  finish_item(req);
 endtask
endclass

class backtoback_write_addr extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_write_addr)
 function new( string name= "backtoback_write_addr");
   super.new(name);
 endfunction

 task body();
  req=trans::type_id::create("req");
  repeat(10) begin
  start_item(req);
  assert(req.randomize() with {wait_a ==0; wait_d ==0; flag ==2'b01; AWADDR == 32'd52; WSTRB== 4'b1111;});
  finish_item(req);
  end
 endtask
endclass

class backtoback_read_addr extends uvm_sequence#(trans);
 `uvm_object_utils(backtoback_read_addr)
 function new( string name= "backtoback_read_addr");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  repeat(10) begin
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; ARADDR == 32'd40; flag == 2'b10; });
  finish_item(req);
  end
 endtask
endclass

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


class no_transaction extends uvm_sequence#(trans);
 `uvm_object_utils( no_transaction)
 function new( string name= " no_transaction");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  repeat(10) begin
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; flag == 2'b11; AWVALID ==0;WVALID ==0; ARVALID ==0;});
  finish_item(req);
  end
 endtask
endclass

class err_priority extends uvm_sequence#(trans);
 `uvm_object_utils(err_priority)
 function new( string name= "err_priority");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  repeat(10) begin
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; flag == 2'b01; AWVALID ==1;AWADDR ==32'd61;});
  finish_item(req);
  end
 endtask
endclass

class prot extends uvm_sequence#(trans);
 `uvm_object_utils(prot)
 function new( string name= "prot");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
  assert(req.randomize() with {wait_a == 0; wait_d == 0; AWPROT ==3'd4; flag == 2'b11; AWVALID ==1;AWADDR ==32'd12;});
  finish_item(req);
 endtask
endclass
