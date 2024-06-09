
class fifo_wseqr extends uvm_sequencer #(fifo_wtrans);

  `uvm_component_utils(fifo_wseqr)
   
   function new (string name = "fifo_wseqr", uvm_component parent);
	  super.new(name,parent);
   endfunction
   
endclass
