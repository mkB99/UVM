//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_env 
// File                : base_seqs.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : Base sequence class for uvm_counter. 
//                       This class is extended from uvm_sequence.
//----------------------------------------------------------------------
`ifndef COUNTER_BASE_SEQUENCE
`define COUNTER_BASE_SEQUENCE

class cntr_base_seqs extends uvm_sequence #(cntr_trans);
   //Factory registration
   `uvm_object_utils(cntr_base_seqs)
   `uvm_declare_p_sequencer(cntr_seqr)

   //seq_item for generating random sequences
   cntr_trans trans_h;
   int no_txns=30; //variable for setting how many transactions to be sent 
   int N=0; //variable for setting the random constraint according to the requirement
   
   //Constructor
   function new (string name = "cntr_base_seqs");
      super.new(name);
   endfunction

   task pre_body();       
      if(starting_phase != null) begin
         starting_phase.raise_objection(this);
      end
   endtask

   task post_body();       
      if(starting_phase != null) begin
         starting_phase.drop_objection(this);
      end
   endtask

   //task for applying reset using the method from environment using the p_sequencer.
   task apply_reset(time reset_time=10ns);
      p_sequencer.env.apply_reset(reset_time); 
   endtask

   //methods for creating, starting and also applying initial reset
   task create_start_seqs();
      trans_h = cntr_trans::type_id::create("trans_h");
      start_item(trans_h);
   endtask

   task init_reset();
      create_start_seqs(); 
      assert(trans_h.randomize() with {trans_h.mode == LOAD;});
      apply_reset();
      finish_item(trans_h);
   endtask
endclass

`endif
