interface inf(input clk);
   bit read, enable;
   bit [7:0] data, address;

   modport dut_ports(
      input clk, read, enable, address,
      output data
   );

   modport tb_ports(
      output clk, read, enable, address,
      input data
   );
endinterface 
