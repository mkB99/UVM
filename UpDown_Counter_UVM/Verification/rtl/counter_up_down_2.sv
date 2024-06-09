// ------------------------------------------------------------------------- //
//  File Name:    counter_up_down_2.sv
//  Version:      0.1
//  Project Name: tb_counter
//  Description:  The file is a module of the up down counter. The inputs to
//                module are Clock, Reset, Enable_2, Load_2, UpDown_2,
//                In_Data_2, and Output is Out_Data_2.
//  Dependencies:
// ------------------------------------------------------------------------- //
module counter_up_down_2 (

// ----- Input Ports -----
  input Clk, Reset, Enable_2, Load_2, UpDown_2,
  input  bit [7:0] In_Data_2,

// ----- Output Ports -----
  output bit [7:0] Out_Data_2 );

  always @(posedge Clk)
  begin
    if (Reset) begin
      Out_Data_2 <= 8'h0;
    end
    else if ((Enable_2 == 1) && (Load_2 == 1)) begin
      Out_Data_2 <= In_Data_2;
    end
    else if ((Enable_2 == 1) && (UpDown_2 == 1)) begin
      Out_Data_2 += 1;
    end
    else if ((Enable_2 == 1) && (UpDown_2 == 0)) begin
      Out_Data_2 -= 1;
    end
  end // always

endmodule : counter_up_down_2
