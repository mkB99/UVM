/*********************************************************************************************************************************
 * Name                 : flags_handshake_test.sv
 * Creation Date        : 13-04-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : This test tests if flags and handshaking signals are generating correctly for the fifo
**********************************************************************************************************************************/
`ifndef FIFO_FLAGS_TEST
`define FIFO_FLAGS_TEST

class flags_handshake_test extends base_test;
   environment env;

   flags_handshake_gen fhgen;
   
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

      fhgen = new(env.gen.gen2wr_drv, env.gen.gen2rd_drv);
      fhgen.no_transactions = 70;
      env.gen = fhgen;
      fork
         //hard reset
         apply_reset();
         //environment run
         env.run();
      join
   endtask
endclass

`endif
