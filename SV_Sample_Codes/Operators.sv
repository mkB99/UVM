/***********************************************************************************************************
 * Name                 : Operators.sv
 * Creation Date        : 25-10-2021
 * Last Modified        : 29-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Exercising different operators
************************************************************************************************************/

module Operators;
reg [31:0] A,B,C;
reg [31:0] U;
reg[3:0] a=4'b1010;
int i;
string s="";
reg [7:0] D [2:0]; 
reg [7:0] d1,d2,d3;


initial begin

//ASSIGNMENT OPERATORS
   $display("--------------------------------------------------------\nASSIGNMENT OPERATORS");
   $display("A,B before assignment: %0b, %0b", A,B);
   A=10505;B=5;
   $display("A: %b: %0d \nB: %b: %0d",A,A,B,B);
//Arithmetic:
   $display("A += B: %0d",(A += B));
   A=10505;B=5;
   $display("A -= B: %0d",(A -= B));
   A=10505;B=5;
   $display("A *= B: %0d",(A *= B));
   A=10505;B=5;
   $display("A /= B: %0d",(A /= B));
   A=10505;B=5;
   $display("A %%= B: %0d",(A %= B));
   A=10505;B=5;
//Bitwise, Arithmetic shifts:
   $display("A <<= 2: %b: %0d",(A <<= 2), (A <<= 2));
   A=10505;B=5;
   $display("A >>= 2: %b: %0d",(A >>= 2), (A >>= 2));
   A=10505;B=5;
   $display("A <<<= 2: %b: %0d",(A <<<= 2), (A <<<= 2));
   A=10505;B=5;
   $display("A >>>= 2: %b: %0d",(A >>>= 2), (A >>>= 2));
 
//Logical operations:
/*   $display("A &= B: %b: %0d",(A &= 2), (A &= 2));
   $display("A |= B: %b: %0d",(A |= 2), (A |= 2));
   $display("A ^= B: %b: %0d",(A ^= 2), (A ^= 2));

*/


//CONCATENATION OPERATOR: 
   $display("--------------------------------------------------------\nCONCATENATION OPERATORS");
   $display("Before concatenation \nA:%0d, B:%0d \nA:%0b, B:%0b", A,B,A,B);
//concatenation
   $display("Right side concatenation A: %0b", {A,B});
   $display("Left side concatenation A: %0b", {B,A});
//Rotation using concatenation
   $display("a before rotation: a:%0b", a);
   $display("a after 1-bit left rotation: a:%0b", {a[2:0], a[3]});

// EQUALITY OPERATORS:
   $display("--------------------------------------------------------\nEQUALITY OPERATORS");
   A='h12345; B='h123x5;
   $display("All values are in hexadecimal\nA: %0h, B: %0h",A,B);
   
   i=(A == 'h12345);
   if(i == 1) s="TRUE";
      else if (i == 0) s="FALSE";
         else s= "UNKNOWN"; 
   $display("A is equal to 12345? : %s",s);
    
   i=(A === 'h123x5);
   if(i == 1) s="TRUE";
      else if (i == 0) s="FALSE";
         else s= "UNKNOWN"; 
   $display("A is equal to 123x5? : %s",s);

   i=(A ==? 'h123x5);
   if(i == 1) s="TRUE";
      else if (i == 0) s="FALSE";
         else s= "UNKNOWN"; 
   $display("A is equal to 123x5? - wildcard : %s",s);

   i=(B == 'h123x5);
   if(i == 1) s="TRUE";
      else if (i == 0) s="FALSE";
         else s= "UNKNOWN"; 
   $display("B is equal to 123x5? : %s",s);

   i=(B === 'h123x5);
   if(i == 1) s="TRUE";
      else if (i == 0) s="FALSE";
         else s= "UNKNOWN"; 
   $display("B is equal to 123x5 for four state values? : %s",s);

   i=(B ==? 'h12xx5);
   if(i == 1) s="TRUE";
      else if (i == 0) s="FALSE";
         else s= "UNKNOWN"; 
   $display("B is equal to 12xx5? - wild card : %s",s);


//LOGICAL IMPLICATION AND EQUIVALENCE OPERATORS
   $display("--------------------------------------------------------\nLOGICAL IMPLICATION AND EQUIVALENCE OPERATORS");
   A=1000; B=0;
   //(A == 1000) -> B = 2000;
   $display("%0d ,  %b", A->B,B->A);
   $display("%0d ,  %b", (A <-> B), (A <-> B));

//SHIFT OPERATORS
   $display("--------------------------------------------------------\nSHIFT OPERATORS");
   A=10000; B=-10000; U=10000; C=10'b1xx111z0z0;
 // shift on signed +ve integer  
   $display("A: %b, %0d --> signed +ve integer ", A, A);
   $display("A after logical left shift %b, %0d", A << 2, A << 2);
   $display("A after Arithmetic left shift %b, %0d", A >>> 2, A >>> 2);
   $display("A after logical right shift %b, %0d", A << 2, A << 2);
   $display("A after Arithmetic right shift %b, %0d", A <<< 2, A <<< 2);
 // shift on signed -ve integer  
   $display("\nB: %b, %0d --> signed -ve integer", B, B);
   $display("B after logical left shift %b, %0d", B << 2, B << 2);
   $display("B after Arithmetic left shift %b, %0d", B >>> 2, B >>> 2);
   $display("B after logical right shift %b, %0d", B << 2, B << 2);
   $display("B after Arithmetic right shift %b, %0d", B <<< 2, B <<< 2);
 // shift on unsigned integer  
   $display("\nU: %b, %0d -->  unsigned integer", U, U);
   $display("U after logical left shift %b, %0d", U << 2, U << 2);
   $display("U after Arithmetic left shift %b, %0d", U >>> 2, U >>> 2);
   $display("U after logical right shift %b, %0d", U << 2, U << 2);
   $display("U after Arithmetic right shift %b, %0d", U <<<2, U <<<2);
 // Integer with Xs, Zs
   $display("\nC: %b, '%0d' --> with X, Z ", C, C);
   $display("C after Arithmetic right shift %b, %0d", C <<<2, C <<<2);


//STREAMING OPERATORS
   $display("--------------------------------------------------------\nSTREAMING OPERATORS");
   
   D='{12,23,43};
   $write("D:");
   foreach(D[i]) $write("%b", D[i]);
   $write(" : %p -> originally\n",D);
   
   {<<{D}}= D;
   $write("D:");
   foreach(D[i]) $write("%b", D[i]);
   $write(" : %p -> reordered D: from LSB to MSB\n",D);
   
   {<<{D}}= D;
   
   {>>{D}}= D;
   $write("D:");
   foreach(D[i]) $write("%b", D[i]);
   $write(" : %p -> reordered to original: from MSB to LSB\n",D);

   {>>{d1,d2,d3}}= D;
   $display("d1:%0d, d2:%0d, d3:%0d -> unpacking from LSB to MSB",d1,d2,d3);
   
   {<<{d1,d2,d3}}= D;
   $display("d1:%0d, d2:%0d, d3:%0d -> unpacking from MSB to LSB",d1,d2,d3);
   $display("d1:%0b, d2:%0b, d3:%0b in bits",d1,d2,d3);
   
   A = {>>{d1,d2,d3}};
   $display("A: %b :  %p -> packed into a vector",A, A);
   
   D = {>>{d1,d2,d3}};
   i=0;
   $write("D:");
   foreach(D[i]) $write("%b", D[i]);
   $write(" : %p -> packed into array", D);

end
endmodule

//OUTPUT:
//--------------------------------------------------------
//ASSIGNMENT OPERATORS
//A,B before assignment: x, x
//A: 00000000000000000010100100001001: 10505 
//B: 00000000000000000000000000000101: 5
//A += B: 10510
//A -= B: 10500
//A *= B: 52525
//A /= B: 2101
//A %= B: 0
//A <<= 2: 00000000000000001010010000100100: 168080
//A >>= 2: 00000000000000000000101001000010: 656
//A <<<= 2: 00000000000000001010010000100100: 168080
//A >>>= 2: 00000000000000000000101001000010: 656
//--------------------------------------------------------
//CONCATENATION OPERATORS
//Before concatenation 
//A:656, B:5 
//A:1010010000, B:101
//Right side concatenation A: 101001000000000000000000000000000000000101
//Left side concatenation A: 10100000000000000000000001010010000
//a before rotation: a:1010
//a after 1-bit left rotation: a:101
//--------------------------------------------------------
//EQUALITY OPERATORS
//All values are in hexadecimal
//A: 12345, B: 123x5
//A is equal to 12345? : TRUE
//A is equal to 123x5? : FALSE
//A is equal to 123x5? - wildcard : TRUE
//B is equal to 123x5? : FALSE
//B is equal to 123x5 for four state values? : TRUE
//B is equal to 12xx5? - wild card : TRUE
//--------------------------------------------------------
//LOGICAL IMPLICATION AND EQUIVALENCE OPERATORS
//0 ,  1
//0 ,  0
//--------------------------------------------------------
//SHIFT OPERATORS
//A: 00000000000000000010011100010000, 10000 --> signed +ve integer 
//A after logical left shift 00000000000000001001110001000000, 40000
//A after Arithmetic left shift 00000000000000000000100111000100, 2500
//A after logical right shift 00000000000000001001110001000000, 40000
//A after Arithmetic right shift 00000000000000001001110001000000, 40000
//
//B: 11111111111111111101100011110000, 4294957296 --> signed -ve integer
//B after logical left shift 11111111111111110110001111000000, 4294927296
//B after Arithmetic left shift 00111111111111111111011000111100, 1073739324
//B after logical right shift 11111111111111110110001111000000, 4294927296
//B after Arithmetic right shift 11111111111111110110001111000000, 4294927296
//
//U: 00000000000000000010011100010000, 10000 -->  unsigned integer
//U after logical left shift 00000000000000001001110001000000, 40000
//U after Arithmetic left shift 00000000000000000000100111000100, 2500
//U after logical right shift 00000000000000001001110001000000, 40000
//U after Arithmetic right shift 00000000000000001001110001000000, 40000
//
//C: 00000000000000000000001xx111z0z0, 'X' --> with X, Z 
//C after Arithmetic right shift 000000000000000000001xx111z0z000, X
//--------------------------------------------------------
//STREAMING OPERATORS
//D:000011000001011100101011 : '{12, 23, 43} -> originally
//D:110101001110100000110000 : '{212, 232, 48} -> reordered D: from LSB to MSB
//D:000011000001011100101011 : '{12, 23, 43} -> reordered to original: from MSB to LSB
//d1:12, d2:23, d3:43 -> unpacking from LSB to MSB
//d1:212, d2:232, d3:48 -> unpacking from MSB to LSB
//d1:11010100, d2:11101000, d3:110000 in bits
//A: 11010100111010000011000000000000 :  3571986432 -> packed into a vector
//110101001110100000110000 : '{212, 232, 48} -> packed into array# End time: 16:10:09 on Jun 06,2022, Elapsed time: 0:00:04
//Errors: 0, Warnings: 1
//
