/*********************************************************************************************************************************
 * Name                 : wintf.sv
 * Creation Date        : 12-05-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description          :  Interface for communicating with asyn_fifo for writing
**********************************************************************************************************************************/
`ifndef FIFO_WRITE_INTERFACE
`define FIFO_WRITE_INTERFACE

`define	WIDTH	8
`define	DEPTH	16

interface wintf(input wr_clk);
   logic [`WIDTH-1:0]din;
   logic wr_en,clear_n;	
   logic full,almost_full; 
   logic wr_ack,wr_err;	;

   //clocking blocks for driver and monitor
   clocking wr_driver_cb @(posedge wr_clk);
      default input #0 output #1;
      output din,wr_en;
   endclocking

   clocking wr_monitor_cb @ (posedge wr_clk);//do we need two monitor blocks? -- yes. To sample signals at their respective clocks. Two monitors and drivers are not needed though. Can be done in single one using two threads. 
      default input #0 output #1;
      input wr_en,din,wr_ack,wr_err,full,almost_full;
   endclocking
   
   //modports for driver, monitor, clear
   modport wr_driver_mp(input clear_n, input wr_clk, clocking wr_driver_cb);
   modport wr_monitor_mp(output clear_n, output wr_clk, clocking wr_monitor_cb);
   modport clear_mp(output clear_n);

endinterface

`endif
