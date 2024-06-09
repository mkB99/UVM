/*********************************************************************************************************************************
 * Name                 : rd_only_gen.sv
 * Creation Date        : 31-03-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : This generator is for generating transactions for testing the reset of fifo
**********************************************************************************************************************************/

`ifndef FIFO_RESET_GENERATOR
`define FIFO_RESET_GENERATOR

class reset_gen extends fifo_base_gen;

   function new(mailbox #(wtrans) gen2wr_drv, mailbox #(rtrans) gen2rd_drv);
      super.new(gen2wr_drv, gen2rd_drv); 
   endfunction

   virtual task run();
      repeat(no_transactions) begin
         data2wr_drv = new();
         data2rd_drv = new();
         if (!data2wr_drv.randomize() with {wr_en == WRITE;})
               $error("RESET_CHECK_GEN","RANDOMIZATION FAILED");    
         if (!data2rd_drv.randomize() with {rd_en == DONT_READ;})
               $error("Reset_check_gen","RANDOMIZATION FAILED");
        gen2wr_drv.put(data2wr_drv);
        gen2rd_drv.put(data2rd_drv);
      end
      //data2wr_drv.display("Reset_check_gen",data2wr_drv);
      ->ended;
   endtask
endclass

`endif
