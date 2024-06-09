/*********************************************************************************************************************************
 * Name                 : cntr_priority_test.sv
 * Creation Date        : 03-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : Extended test case for testing the priorities of the Enable, Load, UpDown ports of counter : Enable > Load > UpDown
**********************************************************************************************************************************/
`ifndef COUNTER_PRIORITY_TEST
`define COUNTER_PRIORITY_TEST

class priority_test extends cntr_base_test;
   `uvm_component_utils(priority_test)
  
   priority_seqs pseqs[];

   function new(string name="priority_test", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      //creates sequences
      pseqs = new[no_of_dut];
      foreach(pseqs[i]) begin 
         pseqs[i] = priority_seqs::type_id::create($sformatf("pseqs%0d",i));
      end
   endfunction

   virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("PRIORITY_TEST","In priority_test run_phase",UVM_MEDIUM)
      
      phase.raise_objection(this);
      `uvm_info("PRIORITY_TEST","In priority_test raised objection",UVM_MEDIUM)

      foreach(pseqs[i]) begin
         fork
            int j = i;
            pseqs[j].start(env_h.agent[j].seqr_h);
         join_none
      end
      wait fork;
      phase.drop_objection(this);
   endtask
endclass  

`endif
