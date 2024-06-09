class fifo_wtrans extends uvm_sequence_item;

//write_signals
   logic clear_n;//clear   
   rand logic wr_en;
   rand logic [`WIDTH-1:0]din;
   logic wr_ack,wr_err;   


   
   constraint ENB {soft wr_en==1'b1;}
   
   `uvm_object_utils_begin(fifo_wtrans)
      `uvm_field_int(clear_n, UVM_ALL_ON)
      `uvm_field_int(wr_en, UVM_ALL_ON)
      `uvm_field_int(din, UVM_ALL_ON)
      `uvm_field_int(wr_ack, UVM_ALL_ON)
      `uvm_field_int(wr_err, UVM_ALL_ON)
   `uvm_object_utils_end
   
   function new (string name = "fifo_wtrans");
     super.new(name);
   endfunction

endclass
