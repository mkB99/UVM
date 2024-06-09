/*********************************************************************************************************************************
 * Name                 : cntr_callbacks.sv
 * Creation Date        : 24-08-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : This file is for declaring callback base and extended classes for counter project
**********************************************************************************************************************************/

`ifndef COUNTER_CALLBACK
`define COUNTER_CALLBACK

virtual class driver_callback extends uvm_callback; //virtual class because, i think: methods should be fixed and could be changed by implementor only acc. to the need. Users should extend and write methods

   //`uvm_object_utils(driver_callback)- we should register this in the class, where it is used using `uvm_register_cb

   function new(string name = "driver_callback");
      super.new(name);
   endfunction

   virtual task pre_drive(); endtask
   virtual task post_drive(); endtask
endclass

class post_driver_callback extends driver_callback;

   `uvm_object_utils(post_driver_callback)

   function new(string name = "post_driver_callback");
      super.new(name);
   endfunction

   virtual task post_drive();
      `uvm_info("CALLBACK", "Driving signals complete", UVM_FULL)
   endtask
endclass

`endif
