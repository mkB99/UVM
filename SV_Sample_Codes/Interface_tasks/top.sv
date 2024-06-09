/***********************************************************************************************************************
 * Name                 : top.sv
 * Creation Date        : 10-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : This file is the top module for problem:
 Use an interface and interface tasks to perform write and read operations on RAM module. 
 The interface has 8 bits of data/address bus along with RWn (Read/Write enable) signal. The Read and Write are synchronized with posedge of clock.
**************************************************************************************************************************/
`include <inf.sv>
`include <dut.sv>

module top;
    logic clk;
    initial begin
       clk=0;
       forever #5 clk = ~clk;
    end
    //instances of interface and dut
    inf io(clk);
    //testbench tb(.io(io));
    dut d1(.clk(clk), .RWn(io.RWn), .rdata(io.rdata), .wdata(io.wdata), .raddr(io.raddr), .waddr(io.waddr));

initial begin
   //accessing interface's properties and using interface methods. 
   io.raddr = 2;
   io.doRead();
   #10 $display("@%0t read value at address %0d: %0d", $time, io.raddr, io.rdata);

   io.waddr = 5;
   io.wdata = 29;
   io.doWrite();
   #10 $display("@%0t write value at address %0d: %0d", $time, io.waddr, io.wdata);

   io.waddr = 3;
   io.wdata = 12;
   io.doWrite();
   #10 $display("@%0t write value at address %0d: %0d", $time, io.waddr, io.wdata);
   
   #1 $finish;
end
endmodule
