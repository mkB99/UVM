

interface interface1;
   bit clk, read, enable,
   logic [8:0] address, data;
endinterface

module modports;
   interface1 in1();

   in1.clk

endmodule
