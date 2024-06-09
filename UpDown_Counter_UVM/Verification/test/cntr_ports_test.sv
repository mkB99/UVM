/*********************************************************************************************************************************
 * Name                 : cntr_ports_test.sv
 * Creation Date        : 02-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : Extended test case for testing if the connections to the ports of the counter are correct by sending values to the ports of first and second counter differently for different outputs
**********************************************************************************************************************************/
`ifndef COUNTER_PORTS_TEST
`define COUNTER_PORTS_TEST

class ports_test extends cntr_base_test;
   `uvm_component_utils(ports_test)
  
   one_seqs oseqs;
   two_seqs tseqs;

   function new(string name="ports_test", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      //creates sequences
      oseqs = one_seqs::type_id::create("oseqs");
      tseqs = two_seqs::type_id::create("tseqs");
   endfunction

   virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("PORTS_TEST","In ports_test run_phase",UVM_MEDIUM)

      phase.raise_objection(this);
      `uvm_info("PORTS_TEST","In ports_test raised objection",UVM_MEDIUM)

      fork
         oseqs.start(env_h.agent[0].seqr_h);
         tseqs.start(env_h.agent[1].seqr_h);
      join
      phase.drop_objection(this);
   endtask
   
endclass  

`endif
