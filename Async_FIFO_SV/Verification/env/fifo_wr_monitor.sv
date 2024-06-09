/*********************************************************************************************************************************
 * Name                 : wr_monitor.sv
 * Creation Date        : 15-02-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Write monitor class
**********************************************************************************************************************************/
`ifndef FIFO_WRITE_MONITOR
`define FIFO_WRITE_MONITOR

class wr_monitor;

//transaction, interface, mailbox for getting data from dut and, sending to reference model and scoreboard.
wtrans wr_data2rm = new();
wtrans wr_data2scb = new();
virtual wintf.wr_monitor_mp vintf;
mailbox #(wtrans) wr_mon2rm;
mailbox #(wtrans) wr_mon2scb;

function new(virtual wintf.wr_monitor_mp vintf, mailbox #(wtrans) wr_mon2rm, wr_mon2scb);
   this.vintf = vintf;
   this.wr_mon2rm = wr_mon2rm;
   this.wr_mon2scb = wr_mon2scb;
endfunction

//task for getting write signals from dut and converting into transactions
task wr_monitor();
   //using transaction class's full for storing clear_n. There is no use of full in scoreboard
	@(vintf.wr_monitor_cb);
      //type casting to enum type 
		wr_data2rm.wr_en = wr_ctrl'(vintf.wr_monitor_cb.wr_en);
		wr_data2rm.din = vintf.wr_monitor_cb.din;
		//wr_data2rm.dout = vintf.wr_monitor_cb.dout;
		wr_data2rm.full = vintf.wr_monitor_cb.full;
		wr_data2rm.almost_full = vintf.wr_monitor_cb.almost_full;
		wr_data2rm.wr_ack = vintf.wr_monitor_cb.wr_ack;
		wr_data2rm.wr_err = vintf.wr_monitor_cb.wr_err;
		//wr_data2rm.display("Write Monitor:", wr_data2rm);
endtask

//task for running monitor task, sending data to scoreboard and reference model
task run();
		forever begin
			wr_monitor();
         wr_data2scb = wr_data2rm;
			wr_mon2rm.put(wr_data2rm);
			wr_mon2scb.put(wr_data2scb);
		end
endtask
endclass

`endif
