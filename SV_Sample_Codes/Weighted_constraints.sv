/**********************************************************************************************
 * Name                 : randCase.sv
 * Creation Date        : 17-11-2021
 * Last Modified        : 18-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : 
**********************************************************************************************/
module randCase;

initial begin
   for(int i= 0; i < 10;i++) begin
      randcase
         1: $display("statement 1 is executed");
         2: $display("statement 2 is executed");
         3: $display("statement 3 is executed");
         4: $display("statement 4 is executed");
         5: $display("statement 5 is executed");
         6: $display("statement 6 is executed");
         7: $display("statement 7 is executed");
         8: $display("statement 8 is executed");
      endcase
   end
end
endmodule

//OUTPUT:
// statement 1 is executed
// statement 5 is executed
// statement 5 is executed
// statement 7 is executed
// statement 7 is executed
// statement 5 is executed
// statement 7 is executed
// statement 8 is executed
// statement 5 is executed
// statement 5 is executed
// End time: 16:01:21 on Nov 17,2021, Elapsed time: 0:00:10
// Errors: 0, Warnings: 1
