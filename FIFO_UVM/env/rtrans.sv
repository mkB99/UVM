class fifo_rtrans extends uvm_sequence_item;

//read_signals
   logic clear_n;//clear   
   rand logic rd_en;
   logic [`WIDTH-1:0]dout;
   logic full,almost_full,almost_empty,empty; 
   logic rd_ack,rd_err;   
   

   constraint ENB {soft rd_en==1'b1;}
   
   `uvm_object_utils_begin(fifo_rtrans)
       `uvm_field_int(clear_n, UVM_ALL_ON)
       `uvm_field_int(rd_en, UVM_ALL_ON)
       `uvm_field_int(dout, UVM_ALL_ON)
       `uvm_field_int(full, UVM_ALL_ON)
       `uvm_field_int(almost_full, UVM_ALL_ON)
       `uvm_field_int(almost_empty, UVM_ALL_ON)
       `uvm_field_int(empty, UVM_ALL_ON)
       `uvm_field_int(rd_ack, UVM_ALL_ON)
       `uvm_field_int(rd_err, UVM_ALL_ON)
   `uvm_object_utils_end
   
   function new (string name = "fifo_rtrans");
     super.new(name);
   endfunction

endclass


