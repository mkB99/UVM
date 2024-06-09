/*********************************************************************************************************************************
 * Name                 : cntr_InData_seqs.sv
 * Creation Date        : 11-07-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : Sequence class for applying required stimulus for InData_test
**********************************************************************************************************************************/

`ifndef COUNTER_INDATA_SEQUENCE
`define COUNTER_INDATA_SEQUENCE

class InData_seqs extends cntr_base_seqs;
`uvm_object_utils(InData_seqs)
   cntr_trans trans_h;
   
   function new (string name = "InData_seqs");
      super.new(name);
   endfunction
 
   virtual task body();
      no_txns = 25;
      repeat(no_txns) begin
         `uvm_create(trans_h)

         if(N < 1) begin
            apply_reset();
            assert(trans_h.randomize() with {trans_h.mode == LOAD;});
         end
         
         if(N >= 1 && N<5) begin
            assert(trans_h.randomize() with {trans_h.mode == LOAD;});
            assert(trans_h.randomize() with {trans_h.InData == 00;});
         end
         
         else if(N >= 5 && N <10) begin
            assert(trans_h.randomize());
            trans_h.mode = LOAD;
            trans_h.InData = 'd254;
         end

         else if(N >= 10 && N<13) begin
            assert(trans_h.randomize());
            trans_h.mode = LOAD;
            trans_h.InData = 'd265;
         end

         else if(N >= 13 && N<15) begin
            assert(trans_h.randomize());
            trans_h.mode = LOAD;
            trans_h.InData = 'b1000_0001;
         end

         else begin
            assert(trans_h.randomize() with { trans_h.mode == DOWN;});
         end
         
         `uvm_send(trans_h) //finish_item(trans_h);
         N++;
      end
      `uvm_info("INDATA_SEQUENCE","Done generations of transaction items",UVM_HIGH)
   endtask

endclass
`endif
