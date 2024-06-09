//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_env 
// File                : cntr_inf.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : Interface for uvm_counter. 
//----------------------------------------------------------------------
`ifndef COUNTER_INTERFACE
`define COUNTER_INTERFACE

//macro for setting size of the InData and OutData
`define WIDTH 8

interface cntr_inf(input Clk);
   logic Reset;
   logic Enable;
   logic Load;
   logic UpDown;
   logic [`WIDTH-1:0] InData;
   logic [`WIDTH-1:0] OutData;
   
   //clocking block for driver
   clocking drv_cb@(posedge Clk);
      default input #0 output #1;
      output  Enable, Load,UpDown,InData;
   endclocking
   
   //clocking block for monitor
   clocking mon_cb@(posedge Clk);
      default input #0 output #1;
      input OutData, Enable, Load, UpDown,InData;
   endclocking
   
   //clocking block for reset
   clocking rst_cb@(negedge Clk);
      default input #0 output #0;
      output Reset;
   endclocking

   clocking sb_rst_cb@(negedge Clk);
      default input #0 output #0;
      input Reset;
   endclocking
   
   //modports for driver, monitor
   modport DRV_MP (output Clk, clocking drv_cb);
   modport MON_MP (input Clk, clocking mon_cb);
   
   //modport for only Reset signal
   modport RST_MP (clocking rst_cb);
   modport RST_SC_MP (clocking sb_rst_cb);
endinterface

`endif
