//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : cntr_config 
// File                : cntr_config.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : This is configuration class for agent in uvm_counter. 
//                       This class is extended from uvm_object
//----------------------------------------------------------------------

`ifndef COUNTER_CONFIG
`define COUNTER_CONFIG

class cntr_config extends uvm_object;
//Factory registration
`uvm_object_utils(cntr_config)

   //interface handle
   virtual cntr_inf vif;

   //variable for setting number of duts 
   bit no_of_dut;

   //constructor method
   function new(string name = "cntr_config");
      super.new(name);
   endfunction

endclass
`endif
