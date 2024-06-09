/*********************************************************************************************************************************
 * Name                 : fifo_error_test.sv
 * Creation Date        : 16-04-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : This test is for sending different erroneous scenarios for testing fifo. 
**********************************************************************************************************************************/
`ifndef FIFO_ERROR_TEST
`define FIFO_ERROR_TEST

class error_test extends base_test;
   environment env;

   //generator
   error_gen egen;

   function new(virtual wintf.wr_driver_mp wr_drv_vintf,
                virtual rintf.rd_driver_mp rd_drv_vintf,
                virtual wintf.wr_monitor_mp wr_mon_vintf,
                virtual rintf.rd_monitor_mp rd_mon_vintf, 
                virtual wintf.clear_mp rst_vintf);
      super.new(wr_drv_vintf, rd_drv_vintf, wr_mon_vintf, rd_mon_vintf, rst_vintf);
   endfunction
      
   virtual task build_and_run();
      super.build_and_run();
      env = new(wr_drv_vintf, rd_drv_vintf, wr_mon_vintf, rd_mon_vintf, rst_vintf);
      env.build();
      
      //creating the custom generator, setting it to work as the environments generator
      egen = new(env.gen.gen2wr_drv, env.gen.gen2rd_drv);
      egen.no_transactions = 50;
      env.gen = egen;
      fork
         //hard reset
         apply_reset();

         //environment run
         env.run();
      join
   endtask
endclass

`endif
