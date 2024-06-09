/*********************************************************************************************************************************
 * Name                 : cntr_rorb_test.sv
 * Creation Date        : 03-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : Extended test case for testing if the counter is rolling over and back after max and min values respectively
**********************************************************************************************************************************/
`ifndef COUNTER_RORB_TEST
`define COUNTER_RORB_TEST

class rorb_test extends cntr_base_test;
   `uvm_component_utils(rorb_test)
  
   rorb_seqs rseqs[];

   function new(string name="rorb_test", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      //creates sequences
      rseqs = new[no_of_dut];
      foreach(rseqs[i]) begin 
         rseqs[i] = rorb_seqs::type_id::create($sformatf("rseqs%0d",i));
      end
   endfunction

   virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("RORB_TEST","In rorb_test run_phase",UVM_MEDIUM)
      
      phase.raise_objection(this);
      `uvm_info("RORB_TEST","In rorb_test raised objection",UVM_MEDIUM)

      foreach(rseqs[i]) begin
         fork
            int j = i;
            rseqs[j].start(env_h.agent[j].seqr_h);
         join_none
      end
      wait fork;
      phase.drop_objection(this);
   endtask
endclass  

`endif
