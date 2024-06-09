interface inf;
bit read, write, enable;
logic [7:0] rdata, wdata, address;

modport dut_ports(
input read, write, enable, address, wdata,
output rdata
);

modport tb_ports(
output read, write, enable, address,wdata,
output rdata
);
endinterface
