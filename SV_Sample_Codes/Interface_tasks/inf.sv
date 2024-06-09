/***********************************************************************************************************************
 * Name                 : inf.sv
 * Creation Date        : 10-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : This file is the interface for problem:
 Use an interface and interface tasks to perform write and read operations on RAM module. 
 The interface has 8 bits of data/address bus along with RWn (Read/Write enable) signal. The Read and Write are synchronized with posedge of clock.
**************************************************************************************************************************/

interface inf(input clk);
   bit RWn;
   logic [7:0] rdata, wdata, raddr, waddr;
   //logic [7:0] memory [7:0];
   
   //doRead interface method useful for reading the variable values in the interface
   task automatic doRead(/*bit [7:0] addr*/);
      //raddr = addr;
      //@(posedge clk)
      RWn = 1; 
   endtask

   //doWrite interface method useful for writing the values of the variables in the interface
   task automatic doWrite(/*bit [7:0] addr*/);
      //@(posedge clk)
         RWn = 0;
         //waddr = addr;
   endtask

endinterface 
