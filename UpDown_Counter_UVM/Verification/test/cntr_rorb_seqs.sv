/*********************************************************************************************************************************
 * Name                 : rorb.sv
 * Creation Date        : 02-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : sequence class for giving required stimulus for rorb_test
**********************************************************************************************************************************/

`ifndef COUNTER_RORB_SEQUENCE
`define COUNTER_RORB_SEQUENCE

class rorb_seqs extends cntr_base_seqs;
`uvm_object_utils(rorb_seqs)
   
   function new (string name = "rorb_seqs");
      super.new(name);
   endfunction
 
   virtual task body();
         init_reset();

         repeat(1) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == LOAD; trans_h.InData == (8'hff - 8'h5);});
            finish_item(trans_h);
         end
         
         repeat(7) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == UP;});
            finish_item(trans_h);
         end
         
         repeat(1) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == LOAD; trans_h.InData == 8'h5;});
            finish_item(trans_h);
         end
         
         repeat(7) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == DOWN;});
            finish_item(trans_h);
         end
      `uvm_info("RORB_SEQUENCE","Done generations of transaction items",UVM_HIGH)
   endtask

endclass
`endif
