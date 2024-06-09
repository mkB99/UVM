/**********************************************************************************************
 * Name                 : Addition.sv
 * Creation Date        : 10-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : 
 Perform addition on bit & integer type operands, logic & bit type operands. 
 Assign four state initial value (containing x, z, 1, 0) to all four types of operand. 
 Print their initial values as well as result after addition and see the effect of data types.
**********************************************************************************************/
module Addition;
integer a=10,b=15;
bit c=1,d=0;
logic e=1,f=0;

initial begin
   $display("---------------------- \nvalues before manipulation \na=%0d, b-%0d, c=%0d, d=%0d, e=%0d, f-%0d",a,b,c,d,e,f);

   //Performing addition on bit & integer type operands 
   b=a+b;
   $display("b=%0d --> int + int",b);
   b=a+c;
   $display("b=%0d --> int + bit",b);
   d=c+d;
   $display("d=%0d --> bit +bit",d);
   d=a+c;
   $display("b=%0d --> bit + int stored in bit \n--------------------- ",c);
  
   a=10;b=15;
   c=1;d=0;
   e=1;f=0;

   //Performing addition on logic & bit type operands
   f=c+e;
   $display("f=%0d --> bit + logic",f);
   f=e+f;
   $display("f=%0d --> logic + logic",f);
   f=a+f;
   $display("f=%0d --> logic + int stored in logic",f);
   b=a+f;
   $display("b=%0d --> int + logic stored in int\n -----------------------",b);

   //Assign four state initial value (containing x, z, 1, 0)
   c=1'bx; d=1'bz;
   $display("c=%0d,d=%0d --> bit cannot take x,z as values - 2 state only",c,d);

   e=1'bx; f=1'bz;
   //$display("e=%0d,f=%0d --> logic can take x,z as values - 4 states",e,f);
   //a=8'd1x; b=8'd2x;
   $display("X and Z values not allowed in decimal constants.");  
end
endmodule

//---------------------- 
//values before manipulation 
//a=10, b-15, c=1, d=0, e=1, f-0
//b=25 --> int + int
//b=11 --> int + bit
//d=1 --> bit +bit
//b=1 --> bit + int stored in bit 
//--------------------- 
//f=0 --> bit + logic
//f=1 --> logic + logic
//f=1 --> logic + int stored in logic
//b=11 --> int + logic stored in int
// -----------------------
//c=0,d=0 --> bit cannot take x,z as values - 2 state only
//X and Z values not allowed in decimal constants.
//End time: 14:13:30 on Jun 06,2022, Elapsed time: 0:00:04
//Errors: 0, Warnings: 1
