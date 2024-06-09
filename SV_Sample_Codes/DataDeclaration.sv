/***********************************************************************************************************************
 * Name                 : DataDeclaration.sv
 * Creation Date        : 10-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : 
 Assign {32{4'b1111}} to bit/byte/shortint/in/longint and integer data types and print them. 
 Repeat the same thing with unsigned declaration for all above data types. 
 Use four state value {32{4'bzx01}} and repeat the above steps.
**************************************************************************************************************************/
module DataDeclaration;

//Assign {32{4'b1111}} to bit/byte/shortint/in/longint and integer data types and printing them
bit [127:0] a= {32{4'b1011}}; bit unsigned [127:0] b= {32{4'b1111}}; 
byte  c= {32{4'b1111}}; byte unsigned  d= {32{4'b1111}};
int  e= {32{4'b1111}}; int unsigned  f= {32{4'b1111}};
shortint g= {32{4'b1111}}; shortint unsigned  h= {32{4'b1111}};
longint  i= {8{4'b1111}}; longint unsigned  j= {32{4'b1111}};
integer  k= {32{4'b1111}}; integer unsigned l= {32{4'b1111}};

initial begin
   $display("a: %0b, b: %0d, \nno.of bits of a: %0d, b: %0d  ", a, b, $bits(a), $bits(b));
   $display("c: %0d, d: %0d ", c, d);
   $display("e: %0d, f: %0d ", e, f);
   $display("g: %0d, h: %0d ", g, h);
   $display("i: %0d, j: %0d ", i, j);
   $display("k: %0d, l: %0d ", k,l);


//Assigning four state value to bit/byte/shortint/in/longint and integer data types and printing them
   a= {32{4'bzx01}}; b= {32{4'bzx01}}; 
   c= {32{4'bzx01}}; d= {32{4'bzx01}};
   e= {32{4'bzx01}}; f= {32{4'bzx01}};
   g= {32{4'bzx01}}; h= {32{4'bzx01}};
   i= {32{4'bzx01}}; j= {32{4'bzx01}};
   k= {7{4'bzx01}}; l= {32{4'bzx01}};

   $display("a1: %0d, b1: %0d ", a, b);
   $display("c1: %0d, d1: %0d ", c, d);
   $display("e1: %0d, f1: %0d ", e, f);
   $display("g1: %0d, h1: %0d ", g, h);
   $display("i1: %0d, j1: %0d ", i, j);
   $display("k1: %0d, l1: %0d ", k,l);
end
endmodule

//a: 10111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011, b: 340282366920938463463374607431768211455, 
//no.of bits of a: 128, b: 128  
//c: -1, d: 255 
//e: -1, f: 4294967295 
//g: -1, h: 65535 
//i: 4294967295, j: 18446744073709551615 
//k: -1, l: 4294967295 
//a1: 22685491128062564230891640495451214097, b1: 22685491128062564230891640495451214097 
//c1: 17, d1: 17 
//e1: 286331153, f1: 286331153 
//g1: 4369, h1: 4369 
//i1: 1229782938247303441, j1: 1229782938247303441 
//k1: X, l1: X 
//End time: 14:25:44 on Jun 06,2022, Elapsed time: 0:00:04
//Errors: 0, Warnings: 1
