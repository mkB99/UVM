/*********************************************************************************************************************************
 * Name                 : Environment.sv
 * Creation Date        : 15-02-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Environment class for async_fifo test bench
**********************************************************************************************************************************/
`ifndef FIFO_ENVIRONMENT
`define FIFO_ENVIRONMENT
class environment;

//instances of the components 
fifo_base_gen gen;
wr_driver wr_drv;
rd_driver rd_drv;
wr_monitor wr_mon;
rd_monitor rd_mon;
reference rm;
scoreboard scb;

//all mailboxes for running the functionality
mailbox #(wtrans) gen2wr_drv = new();
mailbox #(rtrans) gen2rd_drv = new();
mailbox #(rtrans) rd_mon2rm = new();
mailbox #(wtrans) wr_mon2rm = new();
mailbox #(rtrans) rd_mon2scb = new();
mailbox #(wtrans) wr_mon2scb = new();
mailbox #(wtrans) wr_rm2scb = new();
mailbox #(rtrans) rd_rm2scb = new();

//virtual interfaces of modport type
virtual wintf.wr_driver_mp vintf_wr_drv;
virtual rintf.rd_driver_mp vintf_rd_drv;
virtual wintf.wr_monitor_mp vintf_wr_mon;
virtual rintf.rd_monitor_mp vintf_rd_mon;
virtual wintf.clear_mp vintf_rst;

function new(virtual wintf.wr_driver_mp vintf_wr_drv,
				 virtual rintf.rd_driver_mp vintf_rd_drv,
				 virtual wintf.wr_monitor_mp vintf_wr_mon,
				 virtual rintf.rd_monitor_mp vintf_rd_mon,
             virtual wintf.clear_mp vintf_rst);

	this.vintf_wr_drv = vintf_wr_drv; 
	this.vintf_rd_drv = vintf_rd_drv; 
	this.vintf_wr_mon = vintf_wr_mon; 
	this.vintf_rd_mon = vintf_rd_mon; 
	this.vintf_rst = vintf_rst; 

endfunction : new

//tasks for creating/building components with the interfaces and mailboxes
virtual task build;
   gen = new(gen2wr_drv, gen2rd_drv);
   wr_drv = new(vintf_wr_drv, gen2wr_drv);
   rd_drv = new(vintf_rd_drv, gen2rd_drv);
	
   wr_mon = new(vintf_wr_mon, wr_mon2rm, wr_mon2scb);
   rd_mon = new(vintf_rd_mon, rd_mon2rm, rd_mon2scb);
	rm = new(wr_mon2rm, rd_mon2rm, wr_rm2scb, rd_rm2scb, vintf_rst);
   scb = new(rd_mon2scb, wr_mon2scb, wr_rm2scb, rd_rm2scb);
endtask : build

virtual task pre_test();
  //rd_drv.reset();//
endtask

//method for running all components parallely
virtual task test();
  fork
    gen.run();
    wr_drv.run();
    rd_drv.run();

    wr_mon.run();
    rd_mon.run();
	 
	 rm.run();
    scb.run();
  join_any
endtask

virtual task post_test();
  wait(gen.ended.triggered);
    $display("gen event triggered");
endtask

virtual task run();
  pre_test();
  test();
  post_test();
  #800 $finish;
endtask
endclass

`endif
