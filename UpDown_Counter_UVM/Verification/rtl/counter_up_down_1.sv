// ------------------------------------------------------------------------- //
//  File Name:    counter_up_down_1.sv
//  Version:      0.1
//  Project Name: tb_counter
//  Description:  The file is a module of the up down counter. The inputs to
//                module are Clock, Reset, Enable_1, Load_1, UpDown_1,
//                In_Data_1, and Output is Out_Data_1.
//  Dependencies:
// ------------------------------------------------------------------------- //
module counter_up_down_1 (

// ----- Input Ports -----
  input Clk, Reset, Enable_1, Load_1, UpDown_1,
  input  bit [7:0] In_Data_1,

// ----- Output Ports -----
  output bit [7:0] Out_Data_1 );

  always @(posedge Clk)
  begin
    if (Reset) begin
      Out_Data_1 <= 8'h0;
    end
    else if ((Enable_1 == 1) && (Load_1 == 1)) begin
      Out_Data_1 <= In_Data_1;
    end
    else if ((Enable_1 == 1) && (UpDown_1 == 1)) begin
      Out_Data_1 += 1;
    end
    else if ((Enable_1 == 1) && (UpDown_1 == 0)) begin
      Out_Data_1 -= 1;
    end
  end // always

endmodule : counter_up_down_1
