/***********************************************************************************************************
 * Name                 : HalfAdder.sv
 * Creation Date        : 25-10-2021
 * Last Modified        : 30-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Implementing dynamic Half adder using always_comb, always_latch, always_ff. Use reset and clock signals for always_ff/always_latch. Calculate parity on the Sum bits.
 ************************************************************************************************************/
module HalfAdder;
logic a,b;
logic sum1,sum2,sum3, cout1,cout2,cout3;
logic op,ep;
bit reset,clock=0;

//clock generation
always
   #5 clock = ~clock;

//half adder using always_comb
always_comb begin
   assign sum1= a^b;
   assign cout1= a&b;
   $display("always_comb: a=%b b=%b are sum1 = %b cout1= %b\n",a,b,sum1,cout1);
end

//half adder using always_latch
always_latch begin
   if(!reset) begin
      assign sum2= a^b;
      assign cout2= a&b;
      $display("always_latch: a=%b b=%b are sum2 = %b cout2= %b\n",a,b,sum2,cout2);
   end
   /*
   else begin
      sum2 = 0;
      cout2 = 0;
   end
   */
end

//half adder using always_ff
always_ff@(posedge clock) begin
   if(!reset) begin
      assign sum3= a^b;
      assign cout3= a&b;
      $display("always_ff: a=%b b=%b are sum3 = %b cout3= %b\n",a,b,sum3,cout3);
   end
   /*
   else begin
      sum3 = 0;
      cout3 = 0;
   end
   */
end

//calculating odd and even parities
always_ff@(posedge clock) begin
   $monitor("even parity and odd parity on all sum bits: sum1=%b sum2=%b sum3=%b are ep=%b op=%b\n", sum1, sum2,sum3,ep,op);
   if(sum1^sum2^sum3) begin
      ep=1'b1;
      op=1'b0;
   end
   else begin
      op=1'b1;
      ep=1'b0;
   end
end

initial begin
   //giving inputs
   reset=1'b0;
   a=1'b0;b=1'b0;
   #10;
   a=1'b0;b=1'b1;
   #10;

   a=1'b1;b=1'b0;
   #10;

   a=1'b1;b=1'b1;
   #10;

   reset=1'b1;
   a=1'b1;b=1'b0;
   $finish;
end
endmodule

//OUPUT:
// always_latch: a=0 b=0 are sum2 = 0 cout2= 0
// 
// always_comb: a=0 b=0 are sum1 = 0 cout1= 0
// 
// always_ff: a=0 b=0 are sum3 = 0 cout3= 0
// 
// even parity and odd parity on all sum bits: sum1=0 sum2=0 sum3=0 are ep=0 op=1
// 
// always_comb: a=0 b=1 are sum1 = 1 cout1= 0
// 
// always_latch: a=0 b=1 are sum2 = 1 cout2= 0
// 
// even parity and odd parity on all sum bits: sum1=1 sum2=1 sum3=1 are ep=0 op=1
// 
// always_ff: a=0 b=1 are sum3 = 1 cout3= 0
// 
// even parity and odd parity on all sum bits: sum1=1 sum2=1 sum3=1 are ep=1 op=0
// 
// always_comb: a=1 b=0 are sum1 = 1 cout1= 0
// 
// always_latch: a=1 b=0 are sum2 = 1 cout2= 0
// 
// always_ff: a=1 b=0 are sum3 = 1 cout3= 0
// 
// even parity and odd parity on all sum bits: sum1=1 sum2=1 sum3=1 are ep=1 op=0
// 
// always_comb: a=1 b=1 are sum1 = 0 cout1= 1
// 
// always_latch: a=1 b=1 are sum2 = 0 cout2= 1
// 
// even parity and odd parity on all sum bits: sum1=0 sum2=0 sum3=0 are ep=1 op=0
// 
// always_ff: a=1 b=1 are sum3 = 0 cout3= 1
// 
// even parity and odd parity on all sum bits: sum1=0 sum2=0 sum3=0 are ep=0 op=1
// 
// ** Note: $finish    : HalfAdder.sv(84)
//    Time: 40 ns  Iteration: 0  Instance: /HalfAdder
// End time: 12:34:24 on Jun 02,2022, Elapsed time: 0:00:07
// Errors: 0, Warnings: 1
