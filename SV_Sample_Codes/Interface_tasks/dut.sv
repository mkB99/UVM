/***********************************************************************************************************************
 * Name                 : dut.sv
 * Creation Date        : 10-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : This file is DUT for problem:
 Use an interface and interface tasks to perform write and read operations on RAM module. 
 The interface has 8 bits of data/address bus along with RWn (Read/Write enable) signal. The Read and Write are synchronized with posedge of clock.
**************************************************************************************************************************/
module dut(clk, RWn, raddr, waddr, rdata, wdata);

input bit clk, RWn;
output bit [7:0] rdata;
input bit [7:0] raddr, waddr, wdata;


bit [7:0] memory[0:7];

initial begin
   memory = '{40,21,42,35,46,59,66,17};
end

always@(posedge clk) begin
   //if read happens when read == 1. write happens if write == 1
   if(RWn) begin
       rdata = memory[raddr]; 
   end
   if(!RWn) begin
      $display("memory before writing: %p", memory);
      memory[waddr] = wdata;
      $display("memory after writing at address %0d: %p", waddr, memory);
   end
end
endmodule
