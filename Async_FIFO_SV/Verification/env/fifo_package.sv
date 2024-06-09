/*********************************************************************************************************************************
 * Name                 : package.sv
 * Creation Date        : 29-03-2022
 * Last Modified        : 29-03-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Package for Asynchronous fifo testbench
**********************************************************************************************************************************/
`ifndef FIFO_PACKAGE
`define FIFO_PACKAGE

   `include "fifo_wintf.sv"
   `include "fifo_rintf.sv"
package fifo_pkg;
	//int no_transactions = 50;
   //`include "configure.sv"
   `include "fifo_defines.sv"
   `include "fifo_wtrans.sv"
   `include "fifo_rtrans.sv"
   
   `include "fifo_base_gen.sv"
	`include "fifo_reset_gen.sv"
	`include "fifo_wr_rd_gen.sv"
	`include "fifo_flags_handshake_gen.sv"
	`include "fifo_error_gen.sv"

   `include "fifo_wr_driver.sv"
   `include "fifo_rd_driver.sv"
   
   `include "fifo_wr_monitor.sv"
   `include "fifo_rd_monitor.sv"
	
   `include "fifo_reference.sv"
   `include "fifo_scoreboard.sv"
   
   `include "fifo_environment.sv"

   `include "fifo_base_test.sv"
   `include "fifo_reset_test.sv"
   `include "fifo_wr_rd_test.sv"
   `include "fifo_flags_handshake_test.sv"
   `include "fifo_error_test.sv"
endpackage

`endif
