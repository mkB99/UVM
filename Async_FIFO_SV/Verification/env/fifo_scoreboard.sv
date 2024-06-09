/*********************************************************************************************************************************
 * Name                 : scoreboard.sv
 * Creation Date        : 21-03-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Scoreboard class for async_fifo testbench
**********************************************************************************************************************************/
`ifndef FIFO_SCOREBOARD
`define FIFO_SCOREBOARD

class scoreboard;

//transaction class's objects 
wtrans wr_data;
rtrans rd_data;
wtrans wexp_data;
rtrans rexp_data;

//mailboxes for getting data from monitors and reference model
mailbox #(wtrans) wr_mon2scb;
mailbox #(rtrans) rd_mon2scb;
mailbox #(wtrans) wr_rm2scb;
mailbox #(rtrans) rd_rm2scb;

//local variables
int no_transactions;
bit N=0;

function new(mailbox #(wtrans) rd_mon2scb, mailbox #(rtrans) wr_mon2scb, mailbox #(wtrans) wr_rm2scb, mailbox #(rtrans) rd_rm2scb);
   this.rd_mon2scb = rd_mon2scb;
   this.wr_mon2scb = wr_mon2scb;
   this.wr_rm2scb = wr_rm2scb;
   this.rd_rm2scb = rd_rm2scb;
endfunction

//task for displaying actual and expected data
virtual function void wr_displ();
   $display("@%0t: WRITE_DATA  Actual data\n\t%s, din: %0d, full: %0d, almost_full: %0d, wr_ack: %0d, wr_err: %0d", $time,wr_data.wr_en,wr_data.din,wr_data.full,wr_data.almost_full,wr_data.wr_ack,wr_data.wr_err);

   $display("@%0t: WRITE_DATA  Expected data\n\t%s, din: %0d, full: %0d, almost_full: %0d, wr_ack: %0d, wr_err: %0d", $time,wr_data.wr_en,wr_data.din,wexp_data.full,wexp_data.almost_full,wexp_data.wr_ack,wexp_data.wr_err);
endfunction

//task for displaying actual and expected data
virtual function void rd_displ();
   $display("@%0t: READ_DATA  Actual data\n\t%s, dout: %0d, almost_empty: %0d, empty: %0d, rd_ack: %0d, rd_err: %0d", $time,rd_data.rd_en,rd_data.dout,rd_data.almost_empty,rd_data.empty,rd_data.rd_ack,rd_data.rd_err);

   $display("@%0t:  Expected data\n\t%s, dout: %0d, almost_empty: %0d, empty: %0d, rd_ack: %0d, rd_err: %0d", $time,rd_data.rd_en,rexp_data.dout,rexp_data.almost_empty,rexp_data.empty,rexp_data.rd_ack,rexp_data.rd_err);
endfunction

//task for running scoreboard
virtual task run();
    forever begin
      fork 
         begin
            wr_mon2scb.get(wr_data);
            wr_rm2scb.get(wexp_data);
            wr_check(wr_data, wexp_data);
         end
         begin
            rd_mon2scb.get(rd_data);
            rd_rm2scb.get(rexp_data);
            rd_check(rd_data, rexp_data);
         end
      join_any
      //$display("*************************************%p", wr_data);
      //$display("*************************************%p", rd_data);
      //act_data.display("Actual Scoreboard",act_data);
      //act_data.display("Expected Scoreboard",exp_data);
      //$display("got data");

      no_transactions++;
    end
endtask

//task for checking if actual and expected data are same
virtual task wr_check(wtrans wr_data, wexp_data);
   if(wr_data.wr_ack === wexp_data.wr_ack)
      if(wr_data.wr_err === wexp_data.wr_err)
         if(wr_data.full === wexp_data.full)
            if(wr_data.almost_full === wexp_data.almost_full) begin
               $display("===========PASS==========");
            end
            else begin
               $display("===========ALMOST_FULL_FAIL==========");
            end
         else begin
            $display("===========FULL_FAIL==========");
         end
      else begin
         $display("===========WR_ERR_FAIL==========");
      end
   else begin
      $display("===========WR_ACK_FAIL==========");
   end
   wr_displ();
   $display("==============================");
endtask

//task for checking if actual and expected data are same
virtual task rd_check(rtrans rd_data, rexp_data);
   if(rd_data.dout === rexp_data.dout) 
      if(rd_data.rd_ack === rexp_data.rd_ack)
         if(rd_data.rd_err === rexp_data.rd_err)
            if(rd_data.almost_empty === rexp_data.almost_empty)
               if(rd_data.empty === rexp_data.empty) begin
                  $display("===========PASS==========");
               end
               else begin
                  $display("===========EMPTY_FAIL==========");
               end
            else begin
               $display("===========ALMOST_EMPTY_FAIL==========");
            end
         else begin
            $display("===========RD_ERR_FAIL==========");
         end
      else begin
         $display("===========RD_ACK_FAIL==========");
      end
   else begin
      $display("===========DOUT_FAIL==========");
   end
   rd_displ();
   $display("==============================");
endtask

endclass

`endif
