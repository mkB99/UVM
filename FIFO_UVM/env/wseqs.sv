class fifo_base_wseqs extends uvm_sequence #(fifo_wtrans);

   `uvm_object_utils(fifo_base_wseqs)

    fifo_wtrans trans_h;
   
    function new (string name = "fifo_base_wseqs");
       super.new(name);
    endfunction
 
 task body();
  repeat(10) begin
   //`uvm_do(trans);
   //`uvm_do_with(trans with {wr_addr<7;});
   trans_h = fifo_wtrans::type_id::create("trans_h");
   start_item(trans_h);
   assert(trans_h.randomize());
   finish_item(trans_h);
  end
 endtask

endclass
		
		
		
