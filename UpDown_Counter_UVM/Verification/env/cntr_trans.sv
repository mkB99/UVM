//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_env 
// File                : trans.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : Transaction class for uvm_counter. 
//                       This class is extended from uvm_sequence_item.
//----------------------------------------------------------------------
`ifndef COUNTER_TRANSACTION
`define COUNTER_TRANSACTION

class cntr_trans extends uvm_sequence_item;
   //signals
   rand mode_e mode;
   rand error_mode_e emode;
   rand bit [`WIDTH-1:0] InData;
   bit [`WIDTH-1:0] OutData;
   
   //constraints 
   constraint ENB {soft mode == LOAD;};
   constraint C_MODE_E {soft emode == NORMAL;};
   
   //Factory registration of the transaction class and the signals for field method ,macros
   `uvm_object_utils_begin(cntr_trans)
      `uvm_field_enum (mode_e, mode, UVM_ALL_ON)
      `uvm_field_enum (error_mode_e, emode, UVM_ALL_ON)
      `uvm_field_int(InData, UVM_ALL_ON)
      `uvm_field_int(OutData, UVM_ALL_ON)
   `uvm_object_utils_end
   
   //Constructor
   function new (string name = "cntr_trans");
     super.new(name);
   endfunction
endclass

`endif
