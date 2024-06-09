`include <inf.sv>
//`include <testbench.sv>
`include <dut.sv>

module top;
inf io();
dut d1( .read(io.read), .write(io.write), .enable(io.enable), .rdata(io.rdata), .wdata(io.wdata), .address(io.address));

initial begin
io.read = 1;
#10;
io.address = 4;
io.enable = 1;
#100;
io.read =0;
io.address =5;
io.wdata = 22;
#1000 $finish;
end
endmodule
