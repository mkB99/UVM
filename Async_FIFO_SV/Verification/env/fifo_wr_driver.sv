/*********************************************************************************************************************************
 * Name                 : wr_driver.sv
 * Creation Date        : 11-02-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Class for write driver
**********************************************************************************************************************************/
`ifndef FIFO_WRITE_DRIVER
`define FIFO_WRITE_DRIVER

class wr_driver;

//transaction, interface, mailbox for getting data from generator and, writing data to interface
wtrans data2dut;
virtual wintf.wr_driver_mp vintf;
mailbox #(wtrans) gen2wr_drv;
//int no_transactions;
int N=1;

function new(virtual wintf.wr_driver_mp vintf, mailbox #(wtrans) gen2wr_drv);
   this.vintf = vintf;
   this.gen2wr_drv = gen2wr_drv;
	//cg_wr_drv = new();
endfunction

//task for driving transaction items to interface signals
virtual task wr_drive(); 
	@(vintf.wr_driver_cb);
	
   //Not in use code. Just for reference
   //for driving reset correctly
   /*if(N==1) begin
		vintf.wr_driver_cb.clear_n<=1'b0;
		$display("Write driver Reset Started");
		repeat(2) @(vintf.wr_driver_cb); //wait for two posedge clock cycles
		vintf.wr_driver_cb.clear_n<=1'b1;
		$display("Write driver Reset Ended");
		//cg_wr_drv.sample();
	end*/
   vintf.wr_driver_cb.wr_en <= data2dut.wr_en;
	vintf.wr_driver_cb.din <= data2dut.din;
	//data2dut.display(" Write Driver:", data2dut);
	//N++;
endtask

//task for getting from generator mailbox and running driver task
virtual task run(); 
   forever begin
     gen2wr_drv.get(data2dut);
     wr_drive();
   end
endtask
endclass

`endif
