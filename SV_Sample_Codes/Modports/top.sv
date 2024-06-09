/***********************************************************************************************************************
 * Name                 : top.sv
 * Creation Date        : 10-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : This file is the dut for problem:
 Use modport inside interface to perform write and read operations for DUT and TESTBENCH interaction. The interface is having bus with clk, read, enable and 8-bit address and data signals. 
 Select modport during module definition or module instantiation and synchronize clock.
 **************************************************************************************************************************/

`include <inf.sv>
//`include <testbench.sv>
`include <dut.sv>

module top;
   logic clk;
   initial begin
    clk=0;
    forever #5 clk = ~clk;
   end
   //instances
   inf io(clk);
   //testbench tb(.io(io));
   dut d1(.clk(clk), .read(io.read), .write(io.write), .enable(io.enable), .rdata(io.rdata), .wdata(io.wdata), .raddr(io.raddr), .waddr(io.waddr));

   initial begin
         //accessing variables of the variables in the interface.
         io.write = 0;
         io.raddr = 4;
         io.read = 1;
         io.enable = 1;
      #6 $display("Read data, at address %0d: %0d",io.raddr,io.rdata);// this output is not coming if i take #5 delay
         io.wdata = 22;
      #10 io.read =0;

      //write operation
          io.waddr =5;
      #10 io.write =1;
      $display("write data to be sent: %0d",io.wdata);
      #10 $finish; //if i dont give #10 delay, then write is not working
   end
endmodule
