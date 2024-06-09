//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_env 
// File                : seqr.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : Sequencer class for uvm_counter. 
//                       This class is extended from uvm_sequencer
//----------------------------------------------------------------------
`ifndef COUNTER_SEQUENCER
`define COUNTER_SEQUENCER

typedef class cntr_env;
class cntr_seqr extends uvm_sequencer #(cntr_trans);
   //Factory registration
   `uvm_component_utils(cntr_seqr)
   
   cntr_env env;

   //Constructor
   function new (string name = "cntr_seqr", uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

`endif
