/*********************************************************************************************************************************
 * Name                 : rd_driver.sv
 * Creation Date        : 11-02-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Class for read driver
**********************************************************************************************************************************/

`ifndef FIFO_READ_DRIVER
`define FIFO_READ_DRIVER

class rd_driver;

//transaction, interface, mailbox for getting data from generator and, writing data to interface
virtual rintf.rd_driver_mp vintf;
rtrans data2dut;
mailbox #(rtrans) gen2rd_drv;
//int no_transactions;
int N=1;

function new(virtual rintf.rd_driver_mp vintf, mailbox #(rtrans) gen2rd_drv);
   this.vintf = vintf;
   this.gen2rd_drv = gen2rd_drv;
endfunction

//task for driving transactions to interface signals
virtual task rd_drive();
	@(vintf.rd_driver_cb);
		vintf.rd_driver_cb.rd_en <= data2dut.rd_en;
	  //data2dut.display("Read driver:", data2dut);
	  //N++;
endtask

//task for getting from generator mailbox and running driver task
virtual task run(); 
   forever begin
     gen2rd_drv.get(data2dut);
     rd_drive();
   end
endtask

endclass
`endif
