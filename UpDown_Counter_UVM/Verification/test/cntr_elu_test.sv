/*********************************************************************************************************************************
 * Name                 : cntr_elu_test.sv
 * Creation Date        : 03-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : Extended test case for testing the Enabling, Loading, Up and Down functionalities of counter 
**********************************************************************************************************************************/
`ifndef COUNTER_ELU_TEST
`define COUNTER_ELU_TEST

class elu_test extends cntr_base_test;
   `uvm_component_utils(elu_test)
  
   elu_seqs eseqs[];

   function new(string name="elu_test", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      //creates sequences
      eseqs = new[no_of_dut];
      for(int i=0; i<no_of_dut; i++) begin 
         eseqs[i] = elu_seqs::type_id::create($sformatf("eseqs%0d",i));
      end
   endfunction

   virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("ELU_TEST","In elu_test run_phase",UVM_MEDIUM)
      
      phase.raise_objection(this);
      `uvm_info("ELU_TEST","In elu_test raised objection",UVM_MEDIUM)

      //For starting all test at the same time.
      foreach(eseqs[i]) begin
         fork
            int j = i;
            eseqs[j].start(env_h.agent[j].seqr_h);
         join_none
      end
      wait fork;
      phase.drop_objection(this);
   endtask
endclass  

`endif
