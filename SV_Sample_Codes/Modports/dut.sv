/***********************************************************************************************************************
 * Name                 : dut.sv
 * Creation Date        : 10-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : This file is the dut for problem:
 Use modport inside interface to perform write and read operations for DUT and TESTBENCH interaction. The interface is having bus with clk, read, enable and 8-bit address and data signals. 
 Select modport during module definition or module instantiation and synchronize clock.
 **************************************************************************************************************************/

module dut(clk, read, write, enable, raddr, waddr, rdata,wdata);

input bit clk, read, write, enable;
output bit [7:0] rdata;
input bit [7:0] raddr, waddr, wdata;


bit [7:0] memory[0:7];

initial begin
   //memory which is read or written in the code
   memory = '{40,21,42,35,46,59,66,17};
end

always@(posedge clk) begin
   if( enable) begin 
      if(read) begin
          rdata = memory[raddr]; 
      end

      if(write) begin
         $display("memory before writing: %p", memory);
         memory[waddr] = wdata;
         $display("memory after writing at address %0d: %p", waddr, memory);
      end
   end 
end
endmodule
