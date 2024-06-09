/*********************************************************************************************************************************
 * Name                 : reference.sv
 * Creation Date        : 29-03-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Reference model class for asynchronous fifo testbench
**********************************************************************************************************************************/
`ifndef FIFO_REFERENCE
`define FIFO_REFERENCE

class reference;

//transactions used for storing data from monitors and sending to scoreboard
wtrans wr_data = new();
rtrans rd_data = new();
wtrans wdata2scb =new();
rtrans rdata2scb =new();

//mailboxes for getting data from monitors and sending to scoreboard
mailbox #(wtrans) wr_mon2rm;
mailbox #(rtrans) rd_mon2rm;
mailbox #(wtrans) wr_rm2scb;
mailbox #(rtrans) rd_rm2scb;
int no_transactions, i;
bit dout_ok=0;

//virtual interface for reading clear value from dut
virtual interface wintf.clear_mp vintf;

protected bit w_ack,r_ack,w_err,r_err;
protected bit [`WIDTH-1:0]d_out;
protected bit clear;

logic [`WIDTH-1:0] fifo_mem [$:(`DEPTH)];

logic [`WIDTH-1:0] din_q[$];
logic [`WIDTH-1:0] dout_q[$];


   //functional coverage covergroup 
   covergroup values_cg;
      //bins for copvering the required values of the variables
      WR_EN: coverpoint wr_data.wr_en{
         bins vals[2] = {0,1};
      }
      RD_EN: coverpoint rd_data.rd_en{
         bins vals[2] = {0,1};
      }
      CLEAR: coverpoint vintf.clear_n{
         bins vals[2] = {0,1};
      }
      FULL: coverpoint wdata2scb.full{
         bins vals[2] = {0,1};  
         bins transition = (0,1=>1,0);  
      } 
      ALMOST_FULL: coverpoint wdata2scb.almost_full{
         bins vals[2] = {0,1}; 
         bins transition = (0,1=>1,0);
      } 
      ALMOST_EMPTY: coverpoint rdata2scb.almost_empty{
         bins vals[2] = {0,1};   
         bins transition = (0,1=>1,0); 
      } 
      EMPTY: coverpoint rd_data.empty{
         bins vals[2] = {0,1};   
         bins transition_01 = (0=>1);
         bins transition_10 = (1=>0);
      } 
      DOUT: coverpoint rd_data.dout{
         bins dout_range = {[255:0]};
      }
      DIN: coverpoint wr_data.din{
         bins din_range = {[255:0]};
      }
   endgroup
      
   //coverpoints and bins for covering reset scenarios for write
   covergroup write_reset_cg;
      WR_RESET: coverpoint {vintf.clear_n, wdata2scb.full, wdata2scb.almost_full}
      {
         bins wr_hard_bin = {3'b011};
         bins wr_soft_bin = (3'b100 => 3'b011);
         bins wr_after_reset_bin = {3'b100};
      }
   endgroup

   //coverpoints and bins for covering reset scenarios for read
   covergroup read_reset_cg;
      RD_RESET: coverpoint {vintf.clear_n, rdata2scb.empty, rdata2scb.almost_empty}
      {
         bins rd_hard_bin = {3'b011};
         bins rd_soft_bin = (3'b100 => 3'b011);

         bins rd_after_reset_bin = {3'b111};
      }
   endgroup

   //coverpoints and bins for covering write scenarios
   covergroup write_cg;
      WRITE:coverpoint {vintf.clear_n, wr_data.wr_en, wr_data.din, wdata2scb.wr_ack}
      {
         bins wr_bin1 = {[11'b10_0000_0000_0:11'b10_1111_1111_0]};
         bins wr_bin2 = {[11'b11_0000_0000_1:11'b11_1111_1111_1]};
      }
   endgroup

   //coverpoints and bins for covering read scenarios
   covergroup read_cg;
      READ:coverpoint {vintf.clear_n, rd_data.rd_en, rd_data.dout, rdata2scb.rd_ack}
      {
         bins rd_bin1 = {[11'b10_0000_0000_0:11'b10_1111_1111_0]};
         bins rd_bin2 = {[11'b11_0000_0000_1:11'b11_1111_1111_1]};
      }
   endgroup
         //bins rd_bin1 = {[11'b00_0000_0000_0:11'b00_1111_1111_0]};
         //bins rd_bin2 = {[11'b01_0000_0000_0:11'b01_1111_1111_0]};
   
   /*
   covergroup din_cg;
      ORDER_DIN: coverpoint wr_data.din
      { 
         bins din_order_bin = (1=>2=>3=>4=>5);
      }
   endgroup

   covergroup dout_cg;
      ORDER_DOUT: coverpoint rd_data.dout
      { 
         bins dout_order_bin = (1=>2=>3=>4=>5);
      }
   endgroup
   */
   //coverpoints and bins for covering hand shaking signals
   covergroup write_flags_handshake_cg;
      WRITE_FLAGS_HANDSHAKE:coverpoint {vintf.clear_n, wr_data.wr_en, wdata2scb.wr_ack, wdata2scb.wr_err, wdata2scb.full, wdata2scb.almost_full}
      {
         wildcard bins wr_fh_bin1 = {6'b1xxxxx};
         wildcard bins wr_fh_bin2 = {6'b0xxx11};                  
         wildcard bins wr_fh_bin3 = (6'b111001 => 6'b111011);                  
         wildcard bins wr_fh_bin4 = (6'b111000 => 6'b111001);                  
         wildcard bins wr_fh_bin5 = (6'b100000 => 6'b100000);                  
         wildcard bins wr_fh_bin6 = (6'b100000 => 6'b100000);                  
      }
   endgroup
   
   //coverpoints and bins for covering hand shaking signals
   covergroup read_flags_handshake_cg;
      READ_FLAGS_HANDSHAKE:coverpoint {vintf.clear_n, rd_data.rd_en, rdata2scb.rd_ack, rdata2scb.rd_err, rdata2scb.empty, rdata2scb.almost_empty }
      {
         wildcard bins rd_fh_bin1 = {6'b1xxxxx};
         wildcard bins rd_fh_bin2 = {6'b0xxx11};                  
         wildcard bins rd_fh_bin3 = (6'b100000 => 6'b100000);                  
         wildcard bins rd_fh_bin4 = (6'b100000 => 6'b100000);                  
         wildcard bins rd_fh_bin5 = (6'b111001 => 6'b111011);                  
         wildcard bins rd_fh_bin6 = (6'b111011 => 6'b110111);                  
      }
   endgroup

   covergroup errors_cg;
      ERROR: coverpoint {vintf.clear_n, wr_data.wr_en, rd_data.rd_en, wdata2scb.wr_ack, wdata2scb.wr_err, rdata2scb.rd_ack, rdata2scb.rd_err}
      {
         bins er_bin1 = {7'b1_11_1010};
         bins er_bin2 = {7'b1_00_0000};
      }
      WRITE: coverpoint {wr_data.wr_en, wdata2scb.wr_ack, wdata2scb.wr_err} 
      {
         bins er_transition_bin1 = (3'b100 => 3'b110);    
      }
      READ: coverpoint {rd_data.rd_en, rdata2scb.rd_ack, rdata2scb.rd_err} 
      {
         bins r_er_transition_bin1 = (3'b100 => 3'b110);    
      }
   endgroup

   function new(mailbox #(wtrans) wr_mon2rm,
                  mailbox #(rtrans) rd_mon2rm,
                     mailbox #(wtrans) wr_rm2scb,
                        mailbox #(rtrans) rd_rm2scb, 
                           virtual wintf.clear_mp vintf);
      this.wr_mon2rm = wr_mon2rm;
      this.rd_mon2rm = rd_mon2rm;
      this.wr_rm2scb = wr_rm2scb;
      this.rd_rm2scb = rd_rm2scb;
      this.vintf = vintf;

      values_cg = new();
      write_reset_cg = new();
      read_reset_cg = new();
      write_cg = new();
      read_cg = new();
      //din_cg = new();
      //dout_cg = new();
      write_flags_handshake_cg = new();
      read_flags_handshake_cg = new();
      errors_cg = new();

   endfunction

   //method for displaying the fifo size, elements in predictor
   virtual function void fifo_disp(string method);
      $display("@%0t: %s:    fifo size: %0d, fifo_mem: %p",$time, method, fifo_mem.size(),fifo_mem);
   endfunction

   //task for running the predictor
   virtual task run();

      //statements for debugging
      //$display(a);
      //rd_data.display("read data in Reference", rd_data);
      //wr_data.display("write data in Reference", wr_data);

      //thread for running tasks which predict write and read datas
      fork
         predict_wr_data();
         predict_rd_data();

         no_transactions++;
      join_none

      //#700 check_order();
      //display statements 
      //$display("=============");
      //wdata2scb.display("Write reference:", wdata2scb);
      //rdata2scb.display("Read reference:", rdata2scb);
      //$display("=============");
   endtask

   //task for predicting write data - checks for clear and wr_en and gives appropriate results
   virtual task predict_wr_data();   
      forever begin
         //$display("@%0t:---------write first",$time);
         wdata2scb.wr_ack <= w_ack; //Non-blocking
         wdata2scb.wr_err <= w_err;
         //clear = vintf.clear_n;
         $display("@%0t:    clear: %b", $time, vintf.clear_n);
         //wdata2scb =new();
         wr_mon2rm.get(wr_data);
         din_q.push_back(wr_data.din);
         wdata2scb.wr_en = wr_data.wr_en;   
         wdata2scb.din = wr_data.din;   

         if(!vintf.clear_n) begin
            wdata2scb.full = 1;   
            wdata2scb.almost_full = 1;   

            fifo_mem.delete();
            //fifo_disp("Write");
         end
         else begin
            if(wr_data.wr_en == WRITE) begin
               if(fifo_mem.size() == `DEPTH) begin
                  w_ack = 0;
                  w_err = 1;
               end
               else begin
                  fifo_mem.push_front(wr_data.din);
                  w_ack = 1;
                  w_err = 0;
               end
            end
            //When DONT_WRITE is passed. 
            else if(wr_data.wr_en == DONT_WRITE) begin
               w_ack = 0; 
               w_err = 0;
            end
            wr_flags();
         end

         fifo_disp("Write");
         //$display("@%0t:    Put write fork reference: %p\n", $time, wdata2scb);
         wr_rm2scb.put(wdata2scb);

         values_cg.sample();
         write_reset_cg.sample();
         write_cg.sample();
         //din_cg.sample();
         write_flags_handshake_cg.sample();
         errors_cg.sample();
      end
   endtask
   
   //task for predicting read data - checks for clear and rd_en and gives appropriate results
   virtual task predict_rd_data();
      forever begin
         //$display("@%0t: ---------read first",$time);
         rdata2scb.rd_ack <= r_ack;
         rdata2scb.rd_err <= r_err;
         rdata2scb.dout <= d_out; 

         rd_mon2rm.get(rd_data);


         foreach(dout_q[i]);
            if(rd_data.dout != dout_q[i])
               dout_ok = 1;
         
         //if(dout_ok) 
            if(rd_data.dout > 0)
               dout_q.push_back(rd_data.dout);
         dout_ok = 0;

         rdata2scb.rd_en = rd_data.rd_en;
         
         if(!vintf.clear_n) begin
            rdata2scb.empty = 1;   
            rdata2scb.almost_empty = 1;

            fifo_mem.delete();
            //fifo_disp("Read");
         end
         else begin
            if(rd_data.rd_en == READ) begin
               if(fifo_mem.size() == 0) begin
                  r_ack = 0;
                  r_err = 1;
               end
               else begin
                  d_out = fifo_mem.pop_back();
                  r_ack = 1;
                  r_err = 0;
               end
            end
            else if(rd_data.rd_en == DONT_READ) begin
               r_ack = 0; 
               r_err = 0;
            end
            rd_flags(); 
         end

         fifo_disp("Read");

         //$display("@%0t:\tPut read fork reference: %p\n", $time, rdata2scb);
         
         $display("size of dout_q: %0d", dout_q.size());
         rd_rm2scb.put(rdata2scb);
         
         values_cg.sample();
         read_reset_cg.sample();
         read_cg.sample();
         //dout_cg.sample();
         read_flags_handshake_cg.sample();
         errors_cg.sample();
      end
   endtask 

   function void wr_flags();
      if(fifo_mem.size() == `DEPTH) begin
         wdata2scb.full = 1;   
         wdata2scb.almost_full = 1;   
      end
      else if(fifo_mem.size() == (`DEPTH-1)) begin
         wdata2scb.full = 0;   
         wdata2scb.almost_full = 1;   
      end
      else begin
         wdata2scb.full = 0;   
         wdata2scb.almost_full = 0;
      end
   endfunction

   function void rd_flags();
      if(fifo_mem.size() == 0) begin
         rdata2scb.empty = 1;   
         rdata2scb.almost_empty = 1;   
      end
      else if(fifo_mem.size() == 1) begin
         rdata2scb.empty = 0;   
         rdata2scb.almost_empty = 1;   
      end
      else begin
         rdata2scb.empty = 0;   
         rdata2scb.almost_empty = 0;   
      end
   endfunction
   
   virtual function void check_order();
      logic [`WIDTH-1:0] din, dout;

      $display("din_q: %p", din_q);
      $display("dout_q: %p", dout_q);

      foreach(din_q[i]) begin
         din = din_q.pop_front();
         dout = dout_q.pop_front();

         if(din == dout)
            $display("dout in same order as din");
         else
            $display("dout not in same order as din");
      end
   endfunction
endclass

`endif
