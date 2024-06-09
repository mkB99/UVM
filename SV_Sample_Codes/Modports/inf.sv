/***********************************************************************************************************************
 * Name                 : inf.sv
 * Creation Date        : 10-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : This file is the interface for problem:
 Use modport inside interface to perform write and read operations for DUT and TESTBENCH interaction. The interface is having bus with clk, read, enable and 8-bit address and data signals. 
 Select modport during module definition or module instantiation and synchronize clock.
 **************************************************************************************************************************/

interface inf(input clk);
   bit read, write, enable;
   logic [7:0] rdata, wdata, raddr, waddr;

   modport dut_ports(
      input clk, read, write, enable, raddr, waddr, wdata,
      output rdata
   );

   modport tb_ports(
      output clk, read, write, enable, raddr, waddr, wdata,
      input rdata
   );
endinterface 
