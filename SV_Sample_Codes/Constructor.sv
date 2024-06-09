/***********************************************************************************************************
 * Name                 : Constructor.sv
 * Creation Date        : 02-11-2021
 * Last Modified        : 05-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Using constructor to create an object
************************************************************************************************************/
class Animal;
   string name;
   int legs, speed;

   function void display1();
      $display("Name: %s, No.of legs: %0d, Speed: %0dkmph", this.name, this.legs, this.speed);
   endfunction

   function new(string name, int legs, int speed);
      this.name = name;
      this.legs = legs;
      this.speed = speed;
   endfunction
endclass

module Constructor;
Animal a1;

initial begin
   a1=new("cheetah", 4, .speed(130));
   a1.display1();
end
endmodule

//OUTPUT:
// Name: cheetah, No.of legs: 4, Speed: 130kmph
// End time: 17:54:38 on Nov 22,2021, Elapsed time: 0:00:06
// Errors: 0, Warnings: 1
