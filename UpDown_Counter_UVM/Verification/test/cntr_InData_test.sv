/*********************************************************************************************************************************
 * Name                 : cntr_InData_test.sv
 * Creation Date        : 11-07-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : Extended test for testing the InData port of the counter with different possible values for InData.
**********************************************************************************************************************************/
`ifndef COUNTER_INDATA_TEST
`define COUNTER_INDATA_TEST

class InData_test extends cntr_base_test;
   `uvm_component_utils(InData_test)
  
   InData_seqs iseqs[];

   function new(string name="InData_test", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      //creating sequences
      iseqs = new[no_of_dut];
      foreach(iseqs[i]) begin 
         iseqs[i] = InData_seqs::type_id::create($sformatf("iseqs%0d",i));
      end
   endfunction

   virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("IN_DATA_TEST","In InData_test run_phase",UVM_MEDIUM)
      
      phase.raise_objection(this);
      `uvm_info("IN_DATA_TEST","In InData_test raised objection",UVM_MEDIUM)

      foreach(iseqs[i]) begin
         fork
            int j = i;
            iseqs[j].start(env_h.agent[j].seqr_h);
         join_none
      end
      wait fork;
      phase.drop_objection(this);
   endtask
endclass  

`endif
