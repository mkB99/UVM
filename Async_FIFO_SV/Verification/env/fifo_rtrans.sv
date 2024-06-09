/*********************************************************************************************************************************
 * Name                 : rtrans.sv
 * Creation Date        : 21-03-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Class for transactions sent to/recieved from the fifo.
**********************************************************************************************************************************/
`ifndef FIFO_READ_TRANSACTION
`define FIFO_READ_TRANSACTION

class rtrans;

   bit [`WIDTH-1:0]dout;
   randc rd_ctrl rd_en;
   bit almost_empty,empty; 
   bit rd_ack,rd_err;	
   
   //display function for knowing in which component
   function void display(string name, rtrans tr);
      $write("@%0t    In %s\t  ",$time, name);
      print();
     // $display("- a = %0d, b = %0d",a,b);
	endfunction

   //print function - for printitng transaction values
   function void print();
      $display("dout: %0d,rd_en: %s almost_empty: %0d, empty: %0d, rd_ack: %0d,rd_err: %0d",this.dout, this.rd_en, this.almost_empty, this.empty, this.rd_ack, this.rd_err);
   endfunction
endclass

`endif
