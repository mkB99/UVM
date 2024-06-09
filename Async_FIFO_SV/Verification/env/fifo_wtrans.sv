/*********************************************************************************************************************************
 * Name                 : wtrans.sv
 * Creation Date        : 12-05-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description           : Transaction class for write transactions for fifo testbench
**********************************************************************************************************************************/
`ifndef FIFO_WRITE_TRANSACTION
`define FIFO_WRITE_TRANSACTION

class wtrans;

   //properties
   rand bit [`WIDTH-1:0]din;
   randc wr_ctrl wr_en;
   //rand logic wr_en,rd_en;
   bit full,almost_full;
   bit wr_ack,wr_err;
   //logic [`DEPTH-1:0]wr_count, rd_count;

   //static constraints
	constraint c_default{soft din inside {[5:200]};}
   
   //functions for displaying
   function void display(string name, wtrans tr);
      $write("@%0t:   In %s\t  ",$time, name);
      print();
     // $display("- a = %0d, b = %0d",a,b);
     // $display("din = %0d",din);
	endfunction

   function void print();
      $display("din: %0d, wr_en: %s full: %0d, almost_full: %0d, wr_ack: %0d, wr_err: %0d",this.din, this.wr_en, this.full, this.almost_full, this.wr_ack, this.wr_err);
   endfunction

  /*
  function void copy(Transaction rhs);
     din = rhs.din;
  endfunction

  function Transaction clone();
     clone = new();
     clone.copy(this);
  endfunction
*/

endclass

`endif
