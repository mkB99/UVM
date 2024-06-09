/*********************************************************************************************************************************
 * Name                 : flags_handshake_gen.sv
 * Creation Date        : 13-06-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : This generator is for generating transactions for testing the flags and handshaking signals for fifo
**********************************************************************************************************************************/

`ifndef FIFO_FLAGS_GENERATOR
`define FIFO_FLAGS_GENERATOR

class flags_handshake_gen extends fifo_base_gen;

	function new(mailbox #(wtrans) gen2wr_drv, mailbox #(rtrans) gen2rd_drv);
		super.new(gen2wr_drv, gen2rd_drv); 
	endfunction

	virtual task run();
		repeat(no_transactions) begin
			data2wr_drv = new();
			data2rd_drv = new();

			if(N<=18) begin //only writing even after fifo is full - for full flag and checking wr_err signal
				if (!data2wr_drv.randomize() with {wr_en == WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
				if (!data2rd_drv.randomize() with {rd_en == DONT_READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end

			else if(N<=23) begin //only reading for 5 times
				if (!data2wr_drv.randomize() with {wr_en == DONT_WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
				if (!data2rd_drv.randomize() with {rd_en == READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end

			else if(N<=28) begin //only writing for 5 times
				if (!data2wr_drv.randomize() with {wr_en == WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
				if (!data2rd_drv.randomize() with {rd_en == DONT_READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end

			else if(N<=30) begin //wait for 2 times
				if (!data2wr_drv.randomize() with {wr_en == DONT_WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
				if (!data2rd_drv.randomize() with {rd_en == DONT_READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end

			else if(N<=46) begin //only reading till fifo is empty - for empty flag
				if (!data2wr_drv.randomize() with {wr_en == DONT_WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
				if (!data2rd_drv.randomize() with {rd_en == READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end

			else if(N<=47) begin //dont read or write 
				if (!data2wr_drv.randomize() with {wr_en == DONT_WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
				if (!data2rd_drv.randomize() with {rd_en == DONT_READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end

         else begin//only read for checking rd_err signal 
				if (!data2wr_drv.randomize() with {wr_en == DONT_WRITE;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
				if (!data2rd_drv.randomize() with {rd_en == READ;})
					$error("WR_READ_TEST","RANDOMIZATION FAILED");
			end
		  gen2wr_drv.put(data2wr_drv);
		  gen2rd_drv.put(data2rd_drv);
        N++;
		end
		//data2wr_drv.display("WR_RD_GEN",data2wr_drv);
		->ended;
	endtask
endclass


`endif
