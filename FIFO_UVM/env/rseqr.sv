
class fifo_rseqr extends uvm_sequencer #(fifo_rtrans);

  `uvm_component_utils(fifo_rseqr)
   
   function new (string name = "fifo_rseqr", uvm_component parent);
      super.new(name,parent);
   endfunction
   
endclass
