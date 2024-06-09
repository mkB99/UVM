/*********************************************************************************************************************************
 * Name                 : rintf.sv
 * Creation Date        : 21-03-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Interface for async_fifo
**********************************************************************************************************************************/
`ifndef FIFO_READ_INTERFACE
`define FIFO_READ_INTERFACE

`define	WIDTH	8
`define	DEPTH	16

interface rintf(input rd_clk);
   //interface signals
   logic rd_en;	
   logic almost_empty,empty; 
   logic rd_ack,rd_err;	;
   logic [`WIDTH-1:0]dout;
   
   //clocking blocks for driver and monitor
   clocking rd_driver_cb @ (posedge rd_clk);
      default input #0 output #2;
      output rd_en;
   endclocking

   clocking rd_monitor_cb @ (posedge rd_clk);
      default input #0 output #2;
      input rd_en,dout,rd_ack,rd_err,almost_empty,empty;
   endclocking

   //modports
   modport rd_driver_mp(input rd_clk, clocking rd_driver_cb);
   modport rd_monitor_mp(output rd_clk, clocking rd_monitor_cb);

endinterface

`endif
