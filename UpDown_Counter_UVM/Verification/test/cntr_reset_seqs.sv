/*********************************************************************************************************************************
 * Name                 : cntr_reset_seqs.sv
 * Creation Date        : 01-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : sequence class for giving required stimulus for reset_test
**********************************************************************************************************************************/

`ifndef COUNTER_RESET_SEQUENCE
`define COUNTER_RESET_SEQUENCE

class reset_seqs extends cntr_base_seqs;
`uvm_object_utils(reset_seqs)
    
   function new (string name = "reset_seqs");
      super.new(name);
   endfunction
 
   virtual task body();
         init_reset();

         repeat(5) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.InData == 20; trans_h.mode == LOAD;});
            finish_item(trans_h);
         end
         apply_reset(10);

         repeat(5) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.InData == 20; trans_h.mode == DOWN;});
            finish_item(trans_h);
         end
         apply_reset(10);

         repeat(5) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.InData == 20; trans_h.mode == LOAD;});
            finish_item(trans_h);
         end

         apply_reset(20);

         repeat(5) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.InData == 20; trans_h.mode == UP;});
            finish_item(trans_h);
         end

         apply_reset(20);

         repeat(5) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == DOWN;});
            finish_item(trans_h);
         end
         apply_reset(5);
      `uvm_info("RESET_SEQS","Done generations of transaction items",UVM_HIGH)
   endtask

endclass
`endif
