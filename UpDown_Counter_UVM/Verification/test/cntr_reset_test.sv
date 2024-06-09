/*********************************************************************************************************************************
 * Name                 : reset_test.sv
 * Creation Date        : 08-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : Extended test case for testing reset of the counter
**********************************************************************************************************************************/
`ifndef COUNTER_RESET_TEST
`define COUNTER_RESET_TEST

class reset_test extends cntr_base_test;
   `uvm_component_utils(reset_test)
  
   reset_seqs rseqs[];

   function new(string name="reset_test", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      //creating sequences
      rseqs = new[no_of_dut];
      foreach(rseqs[i]) begin 
         rseqs[i] = reset_seqs::type_id::create($sformatf("rseqs%0d",i));
      end
   endfunction

   virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("RESET_TEST","In reset_test run_phase",UVM_MEDIUM)
      
      phase.raise_objection(this);
      `uvm_info("RESET_TEST","In reset_test raised objection",UVM_MEDIUM)

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
