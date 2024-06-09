/*********************************************************************************************************************************
 * Name                 : fifo_reset_test.sv
 * Creation Date        : 13-04-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : This is test class for testing reset of the async_fifo
**********************************************************************************************************************************/
`ifndef FIFO_RESET_TEST
`define FIFO_RESET_TEST

class reset_test extends base_test;
   environment env;

   reset_gen rstgen;

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

      rstgen = new(env.gen.gen2wr_drv, env.gen.gen2rd_drv);
      
      env.gen = rstgen;
      rstgen.no_transactions = 40;
      fork
         //hard reset
             wr_drv_vintf.clear_n <= 0;
         #15 wr_drv_vintf.clear_n <= 1;
         
         apply_reset(0,15);
         
         //intermediate reset
         apply_reset(75,10);
         apply_reset(125,5);
         apply_reset(185,30);

         //environment run
         env.run();
      join
   endtask
endclass

`endif
