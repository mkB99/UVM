/**********************************************************************************************
 * Name                 : inheritance.sv
 * Creation Date        : 17-10-2021
 * Last Modified        : 18-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Constraints inheritance 
**********************************************************************************************/
module inheritance;
class Person;
   rand byte age=0;
   constraint c_age1{
      age > 0;
   }
   constraint c_age{
      age<100;
   }
endclass

class Student extends Person;
   constraint c_age{
      age<25;
   }
endclass

Person p;
Student s;
initial begin
   s=new();
   p=s;
   repeat(10) begin
      if(p.randomize())//as randomize is virtual method, the randomization is based on the type of object rather than the type of handle
         $display("Person's age: %0d", p.age);
      else $display("Not randomized ");
   end
end
endmodule

//OUTPUT:
// values before manipulation 
// a=10, b-15, c=1, d=0, e=1, f-0
// b=25 --> int + int
// b=11 --> int + bit
// d=1 --> bit +bit
// b=1 --> bit + int stored in bit 
// --------------------- 
// f=0 --> bit + logic
// f=1 --> logic + logic
// f=1 --> logic + int stored in logic
// b=11 --> int + logic stored in int
//  -----------------------
// c=0,d=0 --> bit cannot take x,z as values - 2 state only
// X and Z values not allowed in decimal constants.
// End time: 16:48:07 on Oct 22,2021, Elapsed time: 0:00:06
// Errors: 0, Warnings: 1
