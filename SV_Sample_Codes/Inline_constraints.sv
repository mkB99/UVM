/**********************************************************************************************
 * Name                 : inline.sv
 * Creation Date        : 17-11-2021
 * Last Modified        : 22-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Randomizing class properties using inline constraint block
 **********************************************************************************************/
module inline;
class packet;
   rand bit[15:0] data;
   int d1;
   constraint c1 { soft data > 50;} //using soft keyword, we can instruct what to do in case of conflict
endclass

task randinline(packet p);
   if(! (p.randomize() with {
      p.d1 < 100;
      p.d1 > 25;
   }))
      $display("Randomization failed");
   $display("D1: %0d", p.d1);
endtask

packet p1;

initial begin
   p1 = new();
   repeat(10) begin
      if(! (p1.randomize() with {p1.data < 50;}))
         $display("Randomization failed");
      $display("Data: %0d", p1.data);

      randinline(p1);
   end
end
endmodule

//OUTPUT:
// Data: 27
// Randomization failed
// D1: 0
// Data: 29
// Randomization failed
// D1: 0
// Data: 37
// Randomization failed
// D1: 0
// Data: 43
// Randomization failed
// D1: 0
// Data: 48
// Randomization failed
// D1: 0
// Data: 10
// Randomization failed
// D1: 0
// Data: 10
// Randomization failed
// D1: 0
// Data: 12
// Randomization failed
// D1: 0
// Data: 4
// Randomization failed
// D1: 0
// Data: 18
// Randomization failed
// D1: 0
// End time: 21:50:38 on Jun 06,2022, Elapsed time: 0:00:11
// Errors: 0, Warnings: 1
