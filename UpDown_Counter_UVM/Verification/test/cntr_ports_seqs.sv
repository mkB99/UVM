/*********************************************************************************************************************************
 * Name                 : cntr_one_seqs.sv
 * Creation Date        : 03-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : Sequence classes for sending required stimulus for ports_test 
                           i. one_seqs class is for stimulus of counter1
                           ii. two_seqs class is for stimulus of counter2
**********************************************************************************************************************************/

`ifndef COUNTER_PORTS_SEQUENCE
`define COUNTER_PORTS_SEQUENCE

class one_seqs extends cntr_base_seqs;
`uvm_object_utils(one_seqs)
   
   function new (string name = "one_seqs");
      super.new(name);
   endfunction
 
   virtual task body();
   
      init_reset();

      repeat(2) begin
         `uvm_do_with(trans_h, {trans_h.InData == 5; trans_h.mode == DISABLE; trans_h.emode == DISABLE_LOAD;})
      end

      repeat(2) begin
         `uvm_do_with(trans_h, {trans_h.InData == 5; trans_h.mode == LOAD;})
      end

      repeat(2) begin
         `uvm_do_with(trans_h, {trans_h.InData == 5; trans_h.mode == LOAD;})
      end

      repeat(2) begin
         `uvm_do_with(trans_h, {trans_h.InData == 5; trans_h.mode == UP;})
      end

      `uvm_info("ONE_SEQUENCE","Done generations of transaction items",UVM_HIGH)
   endtask

endclass

class two_seqs extends cntr_base_seqs;
`uvm_object_utils(two_seqs)
   
   function new (string name = "two_seqs");
      super.new(name);
   endfunction
 
   virtual task body();

      init_reset();

      repeat(2)
         `uvm_do_with(trans_h, {trans_h.InData == 20; trans_h.mode == LOAD;})

      repeat(2)
         `uvm_do_with(trans_h, {trans_h.InData == 20; trans_h.mode == DISABLE; trans_h.emode == DISABLE_LOAD;})

      repeat(2)
         `uvm_do_with(trans_h, {trans_h.InData == 20; trans_h.mode == LOAD;})

      repeat(2)
         `uvm_do_with(trans_h, {trans_h.InData == 20; trans_h.mode == DOWN;})

      `uvm_info("TWO_SEQUENCE","Done generations of transaction items",UVM_HIGH)
   endtask
endclass

`endif
