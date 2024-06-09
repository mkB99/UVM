/***********************************************************************************************************
 * Name                 : DynamicProcesses.sv
 * Creation Date        : 24-10-2021
 * Last Modified        : 27-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Use fork?join_none to call a method 4 times (that displays the time and passed value) with #1 delay between each method call. Print time and disable all the threads after #5 delay. 
 Use fork...join_any for above case and wait until all threads complete their execution.
************************************************************************************************************/

module DynamicProcesses;
int a;
task display1(int a);
   $display("time: %0t, value: %0d", $time, (a++));
endtask

initial begin
   //Using fork join_none to call display() method 4 times 
   fork
      #2 display1(a);
      #(2+1) display1(a);
      #4 display1(a);
      #5 display1(a);
   join_none
   $display("outside time after delay(join_none): \%0t",$time);
   //disabling for 
   #5 disable fork;

   //Using fork join_any to call display() method 4 times 
   fork
      #2 display1(a);
      #(2+1) display1(a);
      #3 display1(a);
      #4 display1(a);
   join_any
   $display("outside time after delay(join_any): %0t",$time);
   wait fork;
   #5 $finish;
end
endmodule

//OUTPUT:
// time: 2, value: 0
// time: 4, value: 0
// time: 6, value: 0
// time: 8, value: 0
// outside time after delay: 10
// time: 12, value: 0
// time: 14, value: 0
// time: 16, value: 0
// time: 18, value: 0
// outside time after delay: 22
// End time: 11:30:38 on Nov 01,2021, Elapsed time: 0:00:05
// Errors: 0, Warnings: 1
