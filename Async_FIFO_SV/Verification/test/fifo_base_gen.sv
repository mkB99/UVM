/*********************************************************************************************************************************
 * Name                 : generator.sv
 * Creation Date        : 10-02-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : Generator class  
**********************************************************************************************************************************/
`ifndef FIFO_BASE_GENERATOR
`define FIFO_BASE_GENERATOR

class fifo_base_gen;
   wtrans data2wr_drv;
   rtrans data2rd_drv;

   mailbox #(wtrans) gen2wr_drv;//generator to write driver
   mailbox #(rtrans) gen2rd_drv;//generator to read driver
   
   event ended; //event for detecting end of the generation of seqeuences

   //varaibles for controlling the run of generator
	protected int N=0; 
   int no_transactions;
   
   function new(mailbox #(wtrans) gen2wr_drv, mailbox #(rtrans) gen2rd_drv);
      this.gen2wr_drv= gen2wr_drv;
      this.gen2rd_drv= gen2rd_drv;
   endfunction
   
   virtual task run();
				repeat(no_transactions) begin
					data2wr_drv = new();
					data2rd_drv= new();
					assert(data2wr_drv.randomize());
					assert(data2rd_drv.randomize());
					gen2wr_drv.put(data2wr_drv);
					gen2rd_drv.put(data2rd_drv);
				end
				//data2wr_drv.display("write generator", data2wr_drv);
				//data2wr_drv.display("read generator", data2wr_drv);
				-> ended;
   endtask
endclass

`endif
