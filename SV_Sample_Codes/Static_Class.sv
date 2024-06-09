/***********************************************************************************************************
 * Name                 : static.sv
 * Creation Date        : 02-11-2021
 * Last Modified        : 05-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Create a class packet with creating object p1. And p2 as handle to packet. Now assign p1 to p2 and make changes with respect to object p1 and observe the class properties of p2.
 ************************************************************************************************************/
module static1;

//class packet with static variables 
class packet;

   //static variable 'a' 
   static int a=10;
   int b,c;
   
   //static methods. Helpful for accessing static properties without creating the objects
   static function void seta(int a1);
      a = a1; 
   endfunction

   static function void dispa();
      $display("static variable a: %d", a);
   endfunction

endclass

initial $display("%0d", packet :: a);

//objects of class packet type
packet p1,p2,p3;
int a;
initial begin
   p1=new();

   //p2 points to p1. 
   p2=p1;
   p3= new();
   //assigning values to properties of the objects
   p1.b=150;
   p2.c=20;
   p3.b=200;
   p1.a=25;
   //Here, p1.a is changed but not only p2.a, p3.a will also change
   p1.a=50;
   
   //we can access static properties and methods without creating object, from class using scope resolution operator
   packet::a = 15;
   packet::seta(100);
   packet::dispa();

   $display("p1: a,b,c: %0d, %0d, %0d \np2: a,b,c: %0d, %0d, %0d \np3: a,b,c: %0d, %0d, %0d",p1.a, p1.b, p1.c, p2.a, p2.b, p2.c, p3.a, p3.b, p3.c);
 
   $display("p1,p2 values are all same because both are handles of same object. \nThe 'a' value of all handles are equal because it is static property");
/*
   p1.a=100;
   $display("p1: a,b,c: %0d, %0d, %0d \np2: a,b,c: %0d, %0d, %0d",p1.a, p1.b, p1.c, p2.a, p2.b, p2.c);
*/
end
endmodule

//OUTPUT:
// 10
// static variable a:         100
// p1: a,b,c: 100, 150, 20 
// p2: a,b,c: 100, 150, 20 
// p3: a,b,c: 100, 200, 0
// p1,p2 values are all same because both are handles of same object. 
// The 'a' value of all handles are equal because it is static property
// End time: 16:06:39 on Jun 01,2022, Elapsed time: 0:00:04
// Errors: 0, Warnings: 1
//
