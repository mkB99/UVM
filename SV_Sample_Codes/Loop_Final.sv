/***********************************************************************************************************
 * Name                 : Loop_Final.sv
 * Creation Date        : 24-10-2021
 * Last Modified        : 27-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Write a code to multiply a loop variable by 2 starting from 1 to 25. 
 Use break and continue in the loops to control the loop flow and print statements for the result. 
 Use final block to print time and the last count value.
************************************************************************************************************/

module Loop_Final;
int count;
initial begin
   forever begin
      int i;
      i++;
      //multiplying the local variable of loop by 2
      count= i*2;
      $display("%0d x 2 = %0d",i,count);

      //Using break and continue to control the loop flow
      if(i < 25) continue;
         else break;  
   end
end

//Using final block to print the last values because, final block executes once, just before end of simulation
final begin
  $display("Simulation time: %0t, Last count: %0d", $time, count);
end
endmodule


//OUPUT:
//1 x 2 = 2
//2 x 2 = 4
//3 x 2 = 6
//4 x 2 = 8
//5 x 2 = 10
//6 x 2 = 12
//7 x 2 = 14
//8 x 2 = 16
//9 x 2 = 18
//10 x 2 = 20
//11 x 2 = 22
//12 x 2 = 24
//13 x 2 = 26
//14 x 2 = 28
//15 x 2 = 30
//16 x 2 = 32
//17 x 2 = 34
//18 x 2 = 36
//19 x 2 = 38
//20 x 2 = 40
//21 x 2 = 42
//22 x 2 = 44
//23 x 2 = 46
//24 x 2 = 48
//25 x 2 = 50
//Simulation time: 0, Last count: 50
//End time: 14:59:58 on Oct 27,2021, Elapsed time: 0:00:05
//Errors: 0, Warnings: 1
