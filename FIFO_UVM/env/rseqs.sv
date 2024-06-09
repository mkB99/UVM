class fifo_base_rseqs extends uvm_sequence #(fifo_rtrans);

   `uvm_object_utils(fifo_base_rseqs)

    fifo_rtrans trans_h;
   
    function new (string name = "fifo_base_rseqs");
       super.new(name);
    endfunction
   
    task body();
      repeat(10) begin
         trans_h = fifo_rtrans::type_id::create("trans_h");
         start_item(trans_h);
         assert(trans_h.randomize());
         finish_item(trans_h);
     end
   endtask

endclass
      
