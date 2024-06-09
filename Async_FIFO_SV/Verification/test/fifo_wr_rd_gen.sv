/*********************************************************************************************************************************
 * Name                 : fifo_wr_rd_gen.sv
 * Creation Date        : 31-03-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : This generator generates transactions for performing test on fifo for write and read functionality. 
**********************************************************************************************************************************/
`ifndef FIFO_WRITE_READ_GENERATOR
`define FIFO_WRITE_READ_GENERATOR

class wr_rd_gen extends fifo_base_gen;

	function new(mailbox #(wtrans) gen2wr_drv, mailbox #(rtrans) gen2rd_drv);
		super.new(gen2wr_drv, gen2rd_drv); 
	endfunction

	virtual task run();
		repeat(no_transactions) begin
			data2wr_drv = new();
			data2rd_drv = new();

         //writing data into fifo
			if(N<=10) begin
				if (!data2wr_drv.randomize() with {wr_en == WRITE; din != 0; unique{din};})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");

				if (!data2rd_drv.randomize() with {rd_en == DONT_READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end
         //reading data into fifo
			else if(N<=20) begin
				if (!data2wr_drv.randomize() with {wr_en == DONT_WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");

				if (!data2rd_drv.randomize() with {rd_en == READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end

         /*
         //writing data into fifo again, after emptying
			else begin
				if (!data2wr_drv.randomize() with {wr_en == WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");

				if (!data2rd_drv.randomize() with {rd_en == dONT_READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end
         */

		  gen2wr_drv.put(data2wr_drv);
		  gen2rd_drv.put(data2rd_drv);
        N++;
		end
		//data2wr_drv.display("WR_RD_GEN",data2wr_drv);
		->ended;
	endtask
endclass

`endif
