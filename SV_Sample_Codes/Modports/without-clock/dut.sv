//`include <inf.sv>
module dut( read, write, enable, address,rdata,wdata);

input bit read, write, enable;
output bit [7:0] rdata;
input bit [7:0] address,wdata;
bit [7:0] memory[7:0];

always_comb
begin
memory = '{40,21,42,35,46,59,66,17};

if( enable) begin
if( read)
begin
rdata = memory[address];
$display("data at address=%d is rdata=%d \n",address,rdata);
end

else
begin
$display("memory before writing: %p", memory);
memory[address] = wdata;
$display("memory after writing wdata=%d at address=%d is : %p",wdata,address,memory);
end
end
end

endmodule
