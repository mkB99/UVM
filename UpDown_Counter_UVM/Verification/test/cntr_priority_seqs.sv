/*********************************************************************************************************************************
 * Name                 : cntr_priority_seqs.sv
 * Creation Date        : 03-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : sequence class for sending required stimulus for priority_test
**********************************************************************************************************************************/

`ifndef COUNTER_PRIORITY_SEQUENCE
`define COUNTER_PRIORITY_SEQUENCE

class priority_seqs extends cntr_base_seqs;
`uvm_object_utils(priority_seqs)
   
   function new (string name = "priority_seqs");
      super.new(name);
   endfunction
 
   virtual task body();
         init_reset();

         repeat(2) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == LOAD; trans_h.InData == 5;});
            finish_item(trans_h);
         end
         repeat(2) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == DISABLE; trans_h.emode == DISABLE_LOAD; trans_h.InData == 5;});
            finish_item(trans_h);
         end

         repeat(2) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == LOAD; trans_h.emode == LOAD_UP; trans_h.InData == 6;});
            finish_item(trans_h);
         end

         repeat(1) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == DISABLE; trans_h.emode == DISABLE_UP; trans_h.InData == 6;});
            finish_item(trans_h);
         end

         repeat(1) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == LOAD; trans_h.InData == 5;});
            finish_item(trans_h);
         end

         repeat(1) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == DOWN; trans_h.InData == 5;});
            finish_item(trans_h);
         end

         repeat(1) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == LOAD; trans_h.InData == 5;});
            finish_item(trans_h);
         end

         repeat(1) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == UP; trans_h.InData == 5;});
            finish_item(trans_h);
         end

         repeat(2) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == LOAD; trans_h.emode == LOAD_UP; trans_h.InData == 5;});
            finish_item(trans_h);
         end
         repeat(5) begin
            create_start_seqs(); 
            assert(trans_h.randomize() with {trans_h.mode == LOAD; trans_h.emode == DISABLE_LOAD_UP; trans_h.InData == 5;});
            finish_item(trans_h);
         end
      `uvm_info("PRIORITY_SEQUENCE","Done generations of transaction items",UVM_HIGH)
   endtask
endclass

`endif
