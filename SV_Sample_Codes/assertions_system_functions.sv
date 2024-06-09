/*********************************************************************************************************************************
 * Name                 : System_functions.sv
 * Creation Date        : 04-05-2022
 * Last Modified        : 06-05-2022
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Small snippet on assertion for verifying $rose, $fell, $countones, $stable, $past and other methods. 
 **********************************************************************************************************************************/
module System_functions;
logic a=0,b=1,c;
logic [7:0] d;
logic clk=0;

initial
   forever
      #5 clk = ~clk;

sequence s_a1;
   @(posedge clk) ($rose(a) and $onehot0(b));
endsequence

sequence s_b;
   @(posedge clk)  $fell(b);
endsequence

sequence s_c;
   @(posedge clk) $stable(c);
      //@($rose(a)) $stable(c);
endsequence

sequence s_d1;
   @(posedge clk) ($countones(d)>2);
endsequence

sequence s_d2;
   @(posedge clk) $past(d,2) !== 'd3;
endsequence

assert property(s_a1) $display("s_a1 pass"); 
else $display("s_a1 fail");

assert property(s_b) $display("s_b pass"); 
else $display("s_b fail");

assert property(s_c) $display("s_c pass"); 
else $display("s_c fail");

assert property(s_d1) $display("no.of 1's in d is greater than 3");
else $display("s_d1 fail");

assert property(s_d2) $display("'d' before 2 cycles is not equal to 3");
else $display("s_d2 fail: d was 3 before 2 cycles");

always @(posedge clk) begin
   a <= ~b;
   b <= a;
   c = 1;
   //d = $urandom();
end

initial begin
   #5 d = 8'b1101_1100; 
   #10 d = 8'b1101_1100; 
   #10 d = 8'b1101_1100; 
   #10 d = 8'b1101_1100; 
   #10 d = 8'b0000_0011; 
   #50 d = 8'b1101_1100;
   #120 $finish; 
end
endmodule

//OUTPUT:
// 'd' before 2 cycles is not equal to 3
// s_d1 fail
// s_c pass
// s_b fail
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c fail
// s_b pass
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 pass
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// s_d1 fail
// s_c pass
// s_b pass
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// s_d1 fail
// s_c pass
// s_b fail
// s_a1 pass
// s_d2 fail: d was 3 before 2 cycles
// s_d1 fail
// s_c pass
// s_b fail
// s_a1 fail
// s_d2 fail: d was 3 before 2 cycles
// s_d1 fail
// s_c pass
// s_b fail
// s_a1 fail
// s_d2 fail: d was 3 before 2 cycles
// s_d1 fail
// s_c pass
// s_b pass
// s_a1 fail
// s_d2 fail: d was 3 before 2 cycles
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 pass
// s_d2 fail: d was 3 before 2 cycles
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b pass
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 pass
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b pass
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 pass
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 fail
// 'd' before 2 cycles is not equal to 3
// no.of 1's in d is greater than 3
// s_c pass
// s_b fail
// s_a1 fail
// ** Note: $finish    : 1_10_1.sv(68)
//    Time: 215 ns  Iteration: 0  Instance: /System_functions
// End time: 21:59:43 on Jun 06,2022, Elapsed time: 0:00:19
// Errors: 0, Warnings: 1
