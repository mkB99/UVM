/*********************************************************************************************************************************
 * Name                 : rd_monitor.sv
 * Creation Date        : 12-02-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Read monitor class  
**********************************************************************************************************************************/

`ifndef FIFO_READ_MONITOR
`define FIFO_READ_MONITOR

class rd_monitor;

//interface for getting data from dut
virtual rintf.rd_monitor_mp vintf;

//mailboxes
mailbox #(rtrans) rd_mon2scb;
mailbox #(rtrans) rd_mon2rm;

//transaction for holding data to be sent to reference model and scoreboard
rtrans rd_data2rmsc = new();
int no_transactions;

function new(virtual rintf.rd_monitor_mp vintf, mailbox #(rtrans) rd_mon2rm, mailbox #(rtrans) rd_mon2scb);
   this.vintf = vintf;
   this.rd_mon2rm = rd_mon2rm;
   this.rd_mon2scb = rd_mon2scb;
endfunction

//task for getting data from dut and converting into transaction type data
task rd_monitor();
	@(vintf.rd_monitor_cb);
      rd_data2rmsc.rd_en = rd_ctrl'(vintf.rd_monitor_cb.rd_en);
		rd_data2rmsc.dout = vintf.rd_monitor_cb.dout;
		rd_data2rmsc.rd_ack = vintf.rd_monitor_cb.rd_ack;
		rd_data2rmsc.rd_err = vintf.rd_monitor_cb.rd_err;
		rd_data2rmsc.almost_empty = vintf.rd_monitor_cb.almost_empty;
		rd_data2rmsc.empty = vintf.rd_monitor_cb.empty;
endtask

//task for running the monitor
task run();
	forever begin
		rd_monitor();
		rd_mon2scb.put(rd_data2rmsc);
		rd_mon2rm.put(rd_data2rmsc);
	end
endtask
endclass

`endif
