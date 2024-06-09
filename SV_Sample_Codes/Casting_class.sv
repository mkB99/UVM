/***********************************************************************************************************
 * Name                 : Casting.sv
 * Creation Date        : 09-11-2021
 * Last Modified        : 10-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Create two classes with different properties and method to print these. Extend one class to another. Now assign child class handle to parent class and observe parent class properties. Also repeat above steps by assigning parent class handle to child class and observe child class properties. Then use $cast operator for the same.
************************************************************************************************************/
module Casting;
//we can typedef classes so that we can write the classes after creating the objects of the class if needed.
typedef class series;
typedef class bigbang;

series suits;
bigbang season1;

//Base class
class series;
   string title, mainChar, seasons;
   
   function print();
      $display("title: %s, main_char: %s, seasons: %s",title, mainChar, seasons);
   endfunction
endclass

//Derived class
class bigbang extends series;
   int friends, episodes;
endclass

initial begin
   suits = new();
   season1 = new();

   //assigning derived class object to base class object
   suits = season1;
   suits.title = "Suits";
   suits.mainChar= "Harvey";
   //suits.episodes = 23; -> not possible because object of type series doesnot have 'episodes' property.
   $display("Main character in %s: %s ", suits.title, suits.mainChar);

   //assigning base class object to derived class object --> not possible
   //season1 = suits;
   //season1.friends=3;
   //suits.episodes = 23;
   
   //assigning base class object to derived class object using cast 
   $cast(season1, suits);
   season1.title = "Big bang theory";
   season1.mainChar = "Sheldon";
   season1.friends= 5;
   $display("Main character in %s : %s, No.of freinds: %0d ",season1.title, season1.mainChar, season1.friends);

end
endmodule

//OUTPUT:
// Main character in Suits: Harvey 
// Main character in Big bang theory : Sheldon, No.of freinds: 5 
// End time: 16:22:02 on Jun 06,2022, Elapsed time: 0:00:03
// Errors: 0, Warnings: 1
