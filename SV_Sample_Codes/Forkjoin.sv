/****************************************************************************
 * Name                 : Forkjoin.sv
 * Creation Date        : 22-10-2021
 * Last Modified        : 29-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Write a program using fork?join to call a method 4 times (that displays time and passes value) with #1 delay between each method call and print fields. Add forever loop outside fork?join and repeat above steps.
 ****************************************************************************/

module Forkjoin;
int a;

//task for displaying time and, value of a
task Disp(int a);
   $display("time: %0t, value: %0d", $time, a);
endtask

initial begin
   a=5;
   //thread for running 4 display statements with #1 delay between them.
   fork
      #1 Disp(a);
      #2 Disp(a);
      #3 Disp(a);
      #4 Disp(a);
   join
   //simulation will not end until break key is hit
   forever begin
   end

end
endmodule

//OUTPUT:
// time: 1, value: 5
// time: 2, value: 5
// time: 3, value: 5
// time: 4, value: 5
// Break key hit
// Break in Module Forkjoin at Forkjoin.sv line 28
// End time: 12:45:54 on Jun 02,2022, Elapsed time: 0:00:09
// Errors: 0, Warnings: 1
//
