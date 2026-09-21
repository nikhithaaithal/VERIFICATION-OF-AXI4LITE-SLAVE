class axi_sequence extends uvm_sequence#(trans);
 `uvm_object_utils(axi_sequence)
 function new( string name= "axi_sequence");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  repeat(50) begin
   start_item(req);
     assert(req.randomize() with { flag ==2'b01; });
   finish_item(req);
  end
 endtask
endclass

class read_seq extends uvm_sequence#(trans);
  `uvm_object_utils(read_seq)
  function new( string name= "read_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  repeat(50) begin
   start_item(req);
     assert(req.randomize() with {wait_a ==8; wait_d ==1; flag ==2'b01;});
   finish_item(req);
  end
  repeat(50) begin
    start_item(req);
     assert(req.randomize() with {wait_r == 6;  flag == 2'b10; });
    finish_item(req);
  end
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
    assert(req.randomize() with {wait_a == 1; wait_d == 5; flag == 2'b01; WSTRB ==i;  AWADDR == i*4;});
  finish_item(req);
  start_item(req);
    assert(req.randomize() with {wait_r == 1; flag == 2'b10; ARADDR == i*4;});
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
   assert(req.randomize() with {wait_a ==1; wait_d ==2; flag ==2'b01; AWADDR == 32'h14; });
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_r ==1; flag == 2'b10; ARADDR == 32'h14;});
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
   assert(req.randomize() with {wait_a ==1; wait_d ==10; flag ==2'b01; AWADDR == 32'h10; });
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_r ==11;  flag == 2'b10; ARADDR == 32'h10;});
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_a ==1; wait_d ==2; flag ==2'b01; AWADDR == 32'h10;WDATA == 32'h100; });
  finish_item(req);
   start_item(req);
   assert(req.randomize() with {wait_r == 1; flag == 2'b10; ARADDR == 32'h10;});
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
  repeat(20) begin
  start_item(req);
    assert(req.randomize() with {wait_a ==6; wait_d ==1; flag ==2'b01;});
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
   for(int i=1;i<=10;i++) begin
  start_item(req);
     assert(req.randomize() with {wait_a ==7; wait_d ==1; flag ==2'b01; WDATA ==i*8;  AWADDR == i * 4;});
  finish_item(req);
  end
   for(int i=1;i<=10;i++)begin
  start_item(req);
     assert(req.randomize() with {wait_r == 2;  flag == 2'b10;  ARADDR == i * 4; });
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
   assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01; AWADDR == 32'hFFFF_FFFC; });
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
   assert(req.randomize() with {wait_a ==2; wait_d ==7; WDATA == 32'h14; flag ==2'b01; AWADDR == 32'h3C; });
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_r ==2;  flag ==2'b10; ARADDR == 32'h3C;});
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01; AWADDR == 32'hFFFF_FFFC; });
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_r ==2;  flag ==2'b10; ARADDR == 32'h3C;});
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
   assert(req.randomize() with {wait_a ==2; wait_d ==5; flag ==2'b01; AWADDR == 1;});
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_r ==5;  flag ==2'b01; AWADDR == 32'd10;});
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
   assert(req.randomize() with {wait_a ==8; flag ==2'b10; ARADDR == 32'hA; });
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
   assert(req.randomize() with {wait_a ==9; wait_d ==1; flag ==2'b01; AWADDR == 32'h2C; });
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
   assert(req.randomize() with {wait_r ==6; flag ==2'b10; ARADDR == 32'h34; });
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
   assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01; AWADDR == 32'h20; });
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1;wait_r ==2; flag ==2'b11; AWADDR == 32'h18; ARADDR == 32'h20; });
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1;wait_r ==3; flag ==2'b11; });
  finish_item(req);
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
   assert(req.randomize() with {wait_a ==6; wait_d ==2; wait_r==8; flag ==2'b11; AWADDR == 32'h1C; ARADDR == 32'h1C; });
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
   assert(req.randomize() with {wait_a ==1; wait_d ==4;  flag ==2'b01; AWADDR == 32'h4E; });
  finish_item(req);
 start_item(req);
   assert(req.randomize() with {wait_r==2;  flag==2'b10; ARADDR==32'h4E;});
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
  for(int i=0;i<8;i++) begin
  start_item(req);
   assert(req.randomize() with {wait_a == 1; wait_d == 6; AWPROT ==i; flag == 2'b01; });
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_r == 1; ARPROT ==i; flag == 2'b10; });
  finish_item(req);
  end
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
    assert(req.randomize() with {wait_a ==5; wait_d ==2; flag ==2'b01; AWADDR == 32'h18;});
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
   assert(req.randomize() with {wait_a ==10; wait_d ==2;  flag ==2'b01; AWADDR == 32'h4; });
  finish_item(req);
   repeat(3) begin
  start_item(req);
     assert(req.randomize() with {wait_r == 1; ARADDR == 32'h4; flag == 2'b10; });
  finish_item(req);
  end
 endtask
endclass





class awaddr_unaligned_readcheck_seq extends uvm_sequence#(trans);
 `uvm_object_utils(awaddr_unaligned_readcheck_seq)
 function new( string name= "awaddr_unaligned_readcheck_seq");
   super.new(name);
 endfunction
 task body();
  req=trans::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {wait_a ==7; wait_d ==1; flag ==2'b01; AWADDR == 32'h4;});
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_r ==2; flag ==2'b10; ARADDR == 32'h4; });
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_a ==2; wait_d ==1; flag ==2'b01; AWADDR == 32'h5;});
  finish_item(req);
  start_item(req);
   assert(req.randomize() with {wait_r ==2; flag ==2'b10; ARADDR == 32'h4; });
  finish_item(req);
 endtask
endclass


