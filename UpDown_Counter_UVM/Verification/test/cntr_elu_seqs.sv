/*********************************************************************************************************************************
 * Name                 : cntr_elu_seqs.sv
 * Creation Date        : 02-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : Sequence class for sending the required stimulus for the elu_test
**********************************************************************************************************************************/

`ifndef COUNTER_ELU_SEQUENCE
`define COUNTER_ELU_SEQUENCE

class elu_seqs extends cntr_base_seqs;
`uvm_object_utils(elu_seqs)
   cntr_trans trans_h;
   
   function new (string name = "elu_seqs");
      super.new(name);
   endfunction
 
   virtual task body();
      //setting no of sequences to be sent
      no_txns = 50;
      repeat(no_txns) begin
         trans_h = cntr_trans::type_id::create("trans_h");
         start_item(trans_h);
         
         if(N < 5) begin
               apply_reset(10); 
               assert(trans_h.randomize() with {trans_h.mode == DISABLE; trans_h.emode == DISABLE_LOAD;}); 
         end
         else if(N >= 5 && N < 10) begin
               apply_reset(10); 
               assert(trans_h.randomize() with {trans_h.mode == LOAD;}); 
         end
         else if(N >= 10 && N < 15) begin
            assert(trans_h.randomize() with {trans_h.mode == DISABLE;});
         end
         
         else if(N >= 15 && N < 20) begin
            assert(trans_h.randomize() with {trans_h.mode == LOAD;});
         end

         else if(N >= 20 && N < 25) begin
            assert(trans_h.randomize() with {trans_h.mode == UP;});
         end

         else if(N >= 25 && N < 30) begin
            assert(trans_h.randomize() with {trans_h.mode == DOWN;});
         end
         else
            assert(trans_h.randomize());

         finish_item(trans_h);
         N++;
      end
      `uvm_info("ELU_SEQUENCE","Done generations of transaction items",UVM_HIGH)
   endtask

endclass
`endif
