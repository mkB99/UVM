/*********************************************************************************************************************************
 * Name                 : testbench.sv
 * Creation Date        : 15-02-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : base_test class for async_fifo
**********************************************************************************************************************************/

`ifndef FIFO_BASE_TEST
`define FIFO_BASE_TEST

class base_test;
   
   virtual wintf.wr_driver_mp wr_drv_vintf;
   virtual rintf.rd_driver_mp rd_drv_vintf;
   virtual wintf.wr_monitor_mp wr_mon_vintf;
   virtual rintf.rd_monitor_mp rd_mon_vintf;
   virtual wintf.clear_mp rst_vintf; 
   
   //declaring environment instance
   environment env;
  
  //testcases
   function new(virtual wintf.wr_driver_mp wr_drv_vintf,
                virtual rintf.rd_driver_mp rd_drv_vintf,
                virtual wintf.wr_monitor_mp wr_mon_vintf,
                virtual rintf.rd_monitor_mp rd_mon_vintf, 
                virtual wintf.clear_mp rst_vintf); 
      //$display("interfaces created? --yes");
      this.wr_drv_vintf = wr_drv_vintf;
      this.rd_drv_vintf = rd_drv_vintf;
      this.wr_mon_vintf = wr_mon_vintf;
      this.rd_mon_vintf = rd_mon_vintf;
      this.rst_vintf = rst_vintf;
   endfunction

   //creating environment
   virtual task build_and_run();
      env = new(wr_drv_vintf, rd_drv_vintf, wr_mon_vintf, rd_mon_vintf,rst_vintf);
      env.build();
      //this.env.gen.no_transactions = 30;

      //calling run of env, it interns calls generator and driver main tasks
      //env.run();
   endtask

   //task for applying reset
   virtual task apply_reset(time start_time=0, time duration=10);
      #(start_time) wr_drv_vintf.clear_n <= 0;
      #(duration) wr_drv_vintf.clear_n <= 1;
   endtask
endclass

`endif
