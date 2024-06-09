
module top();
   import uvm_pkg::*;
   import fifo_pkg::*;
   `include "uvm_macros.svh"

  bit wr_clk, rd_clk;
  
  fifo_if inf(wr_clk, rd_clk);
  
  //dut instantiation
   async_fifo dut(.wr_clk(inf.wr_clk), .rd_clk(inf.rd_clk), .din(inf.din), .wr_en(inf.wr_en), .rd_en(inf.rd_en), .clear_n(inf.clear_n), .full(inf.full), .almost_full(inf.almost_full), /*.wr_count(inf.wr_count),*/ .wr_ack(inf.wr_ack), .wr_err(inf.wr_err), .dout(inf.dout), .empty(inf.empty), .almost_empty(inf.almost_empty), .rd_ack(inf.rd_ack), .rd_err(inf.rd_err));
  
  always
   #5 wr_clk = ~wr_clk;
  always
   #5 rd_clk = ~rd_clk;
   
   initial begin
    uvm_config_db #(virtual fifo_if)::set(null,"*","fifo_vif",inf);
     run_test("fifo_base_test");
   end
   
endmodule
