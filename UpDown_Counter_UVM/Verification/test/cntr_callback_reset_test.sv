/*********************************************************************************************************************************
 * Name                 : cntr_callback_reset_test.sv
 * Creation Date        : 24-08-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : extended reset test class for implementing callback
**********************************************************************************************************************************/

`ifndef COUNTER_CALLBACK_TEST
`define COUNTER_CALLBACK_TEST

class callback_reset_test extends reset_test;
   `uvm_component_utils(callback_reset_test)
  
   post_driver_callback pd_cb[];

   function new(string name="callback_reset_test", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      //creates sequences
      pd_cb = new[no_of_dut];
      foreach(pd_cb[i]) begin 
         pd_cb[i] = post_driver_callback::type_id::create($sformatf("pd_cb[%0d]",i));
      end
   endfunction

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      foreach(pd_cb[i]) begin 
         uvm_callbacks #(cntr_drv, driver_callback)::add(env_h.agent[i].drv_h, pd_cb[i]);
      end
   endfunction

   virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
   endtask
endclass 

`endif
