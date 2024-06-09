/*********************************************************************************************************************************
 * Name                 : fifo_error_gen.sv
 * Creation Date        : 31-03-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : this generator is used for generating proper stimulus for fifo_error_test
**********************************************************************************************************************************/

`ifndef FIFO_ERROR_GENERATOR
`define FIFO_ERROR_GENERATOR

class error_gen extends fifo_base_gen;

	function new(mailbox #(wtrans) gen2wr_drv=null, mailbox #(rtrans) gen2rd_drv=null);
		super.new(gen2wr_drv, gen2rd_drv); 
	endfunction

	virtual task run();
      N=0;
		repeat(no_transactions) begin
			data2wr_drv = new();
			data2rd_drv = new();

         if(N <= 20) begin
            if (!data2wr_drv.randomize() with {wr_en == WRITE;})
               $error("ERROR_TEST ","RANDOMIZATION FAILED");

            if (!data2rd_drv.randomize() with {rd_en == READ;})
               $error("ERROR_TEST ","RANDOMIZATION FAILED");
         end
         if(N>20 && N <=20) begin
            if (!data2wr_drv.randomize() with {wr_en == DONT_READ;})
               $error("ERROR_TEST ","RANDOMIZATION FAILED");

            if (!data2rd_drv.randomize() with {rd_en == DONT_READ;})
               $error("ERROR_TEST ","RANDOMIZATION FAILED");
         end 
         else begin
            if (!data2wr_drv.randomize())
               $error("ERROR_TEST ","RANDOMIZATION FAILED");

            if (!data2rd_drv.randomize())
               $error("ERROR_TEST ","RANDOMIZATION FAILED");
         end
         gen2wr_drv.put(data2wr_drv);
         gen2rd_drv.put(data2rd_drv);
         N++;
		end
      
      //display statements for debugging
		//data2wr_drv.display("ERROR_GEN",data2wr_drv);
		->ended;
	endtask
endclass

`endif
