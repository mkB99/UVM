// ------------------------------------------------------------------------- //
//  File Name:    dut_top.sv
//  Version:      0.1
//  Project Name: tb_counter
//  Description:  The file is a top module of two up down counter. The inputs
//                to the module are Clock, Reset, Enable_1, Enable_2, Load_1,
//                Load_2, UpDown_1, UpDown_2, In_Data_1, In_Data_2, and Output
//                are Out_Data_1 and Out_Data_2.
//  Dependencies:
// ------------------------------------------------------------------------- //

`include "counter_up_down_1.sv"
`include "counter_up_down_2.sv"

module dut_top (

// ----- Input Ports -----
  input Clk, Reset, Enable_1, Enable_2, Load_1, Load_2, UpDown_1, UpDown_2,
  input  bit [7:0]  In_Data_1, In_Data_2,

// ----- Output Ports -----
  output bit [7:0] Out_Data_1, Out_Data_2 );

// ----- Counter 1 Instance -----
  counter_up_down_1 DUT_1 (
                           .Clk(Clk),
                           .Reset(Reset),
                           .Enable_1(Enable_1),
                           .Load_1(Load_1),
                           .UpDown_1(UpDown_1),
                           .In_Data_1(In_Data_1),
                           .Out_Data_1(Out_Data_1) );

// ----- Counter 2 Instance -----
  counter_up_down_2 DUT_2 (
                           .Clk(Clk),
                           .Reset(Reset),
                           .Enable_2(Enable_2),
                           .Load_2(Load_2),
                           .UpDown_2(UpDown_2),
                           .In_Data_2(In_Data_2),
                           .Out_Data_2(Out_Data_2) );

endmodule : dut_top
