//`include <inf.sv>
module dut(inf.dut_ports io);

bit [7:0] memory[7:0];

initial begin
   memory = '{40,21,42,35,46,59,66,17};
end

always@(posedge io.clk) begin
   //if(io.reset) memory = '{4{0,0}};
   //else begin
      if(io.enable) begin 
         if(io.read) begin
            io.data = memory[io.address]; 
	 end
      end
end
endmodule
