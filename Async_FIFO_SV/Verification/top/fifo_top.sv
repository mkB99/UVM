/*********************************************************************************************************************************
 * Name                 : top.sv
 * Creation Date        : 21-03-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : top file for async_fifo
**********************************************************************************************************************************/
timeunit 1ns;
import fifo_pkg::*;

module top;
   
   //clock and reset signal declaration
   logic wr_clk, rd_clk;
   event wr_ev;
   event rd_ev;
   
   //clock generation
   initial begin
      wr_clk=0;
      rd_clk=0;
      fork
         forever #(WRCLK_PERIOD/2) wr_clk = ~wr_clk;
         forever #(RDCLK_PERIOD/2) rd_clk = ~rd_clk;
      join
   end

   //creating instance of interfaces, inorder to connect DUT and testcase
   wintf wintf(wr_clk);
   rintf rintf(rd_clk);
   
   //base test instance
   base_test t1;

   //Testcase instances, interface handle is passed to test as an argument
   reset_test rst_test;
   wr_rd_test wr_test;
   flags_handshake_test fh_test;
   error_test er_test;

   //DUT instance, interface signals are connected to the DUT ports
   async_fifo dut (
      .wr_clk(wintf.wr_clk),
      .din(wintf.din),
      .wr_en(wintf.wr_en),
      .rd_clk(rintf.rd_clk),
      .rd_en(rintf.rd_en),
      .clear_n(wintf.clear_n),
      .full(wintf.full),
      .almost_full(wintf.almost_full),
      .wr_ack(wintf.wr_ack),
      .wr_err(wintf.wr_err),
      .almost_empty(rintf.almost_empty),
      .empty(rintf.empty),
      .rd_ack(rintf.rd_ack),
      .rd_err(rintf.rd_err),
      .dout(rintf.dout)
   );
   
   always @ (posedge wr_clk) ->wr_ev;

   function bit full_check();
      if(wr_ev.triggered) return 1;
      else return 0;
   endfunction

   //Assertions
   //sequences and properties
   sequence full_wr;
      time leading;
      @(dut.full)
         (full_check());
   endsequence

   assert property(full_wr) $display("Full changing at write clock"); 
   else $error("Full not changing at write clock");
   
   sequence write_ack;
      @(posedge wr_clk)
         (dut.wr_en==1) ##1 (dut.wr_ack==1);
   endsequence

   property write_functions;
      write_ack;
   endproperty

   assert property(write_functions) $display("wr_ack Success"); 
   else $display("wr_ack Failure");

   sequence read_ack;
      @(posedge rd_clk)
         (dut.rd_en==1) ##1 (dut.rd_ack==1);
   endsequence

   property read_functions;
      read_ack;
   endproperty

   assert property(read_functions) $display("rd_ack Success"); 
   else $display("rd_ack Failure");

   initial begin
      if($test$plusargs("RESET_TEST")) begin
         rst_test= new(wintf, rintf, wintf, rintf, wintf);
         rst_test.build_and_run();   
      end
      if($test$plusargs("WR_RD_TEST")) begin
         wr_test= new(wintf, rintf, wintf, rintf, wintf);
         wr_test.build_and_run();   
      end
      if($test$plusargs("FLAGS_TEST")) begin
         fh_test= new(wintf, rintf, wintf, rintf, wintf);
         fh_test.build_and_run();   
      end
      if($test$plusargs("ERROR_TEST")) begin
         er_test= new(wintf, rintf, wintf, rintf, wintf);
         er_test.build_and_run();   
      end
      #250 $finish;
   end
endmodule
