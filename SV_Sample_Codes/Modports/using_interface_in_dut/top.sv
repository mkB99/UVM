`include <inf.sv>
//`include <testbench.sv>
`include <dut.sv>

module top;
    logic clk;
    initial begin
       clk=1;
       forever #5 clk = ~clk;
    end
    inf io(clk);
    //testbench tb(.io(io));
    dut d1(io.dut_ports);

initial begin
   io.data = 0;
   #10 io.enable = 1;
   #10 io.read = 1;
   #10 io.address = 4;
   #10 $display("data: %0d",io.data);
   #10 $finish;
end
endmodule
