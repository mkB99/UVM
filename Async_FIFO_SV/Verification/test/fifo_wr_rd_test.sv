/*********************************************************************************************************************************
 * Name                 : fifo_wr_rd_test.sv
 * Creation Date        : 14-04-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : This test is for testing the write and read functionalities of the async_fifo
**********************************************************************************************************************************/

`ifndef FIFO_WRITE_READ_TEST
`define FIFO_WRITE_READ_TEST

class wr_rd_test extends base_test;
   environment env;

   wr_rd_gen wrgen;
   
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

      wrgen = new(env.gen.gen2wr_drv, env.gen.gen2rd_drv);
      wrgen.no_transactions = 50;
      env.gen = wrgen;
      fork
         //hard reset
         apply_reset();

         //apply_reset(30,10);
         //apply_reset(60,10);
         //apply_reset(120,10);
         //apply_reset(150,10);
         //environment run
         env.run();
      join
   endtask
endclass

`endif
