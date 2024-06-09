/***********************************************************************************************************
 * Name                 : parameter_class.sv
 * Creation Date        : 10-11-2021
 * Last Modified        : 10-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : 
 Use a parameterized class to pass the data type of data member (data), use task to set the value of data member, and use class function that returns the data member value. 
 Take three instances of the class so the data member in each object is of different type (string/integer/bit). 
 Use the set/get methods of class to set/get data member value and set the data member without using any method. 
 Make the data member local and repeat all above steps. 
 Make the data member protected type and check the effect of accessing the data member.
************************************************************************************************************/

module parameter_class;

//parameterized class packet of parameter type "Type" which has a default type int when type is not specified while creating
class packet #(parameter type Type=int);
Type data;
//local Type data;
//protected Type data;

//function setData for setting property 'data'
function void setData(Type T);
   this.data = T;
endfunction

//function getData for getting property 'data'
function Type getData();
   return data;
endfunction
endclass

class packet1 extends packet;

endclass

packet #(string) p1;
packet #(integer) p2;
packet #(bit[3:0]) p3;
packet1 p4;

initial begin
   p1 = new();
   p2 = new();
   p3 = new();
   p4 = new();
   
   //Using methods to set data 
   p1.setData("mayur");
   p2.setData(25);
   p3.setData(1011);
   p4.setData(45);

   //setting data without using method
   p4.data = 70;
   
   //If the variable is local, it cannot be changed without using the class's methods
   //p3.data = 5;
   
   p1.data = "mayur krishna";

   $display("%s", p1.getData);
   $display("%0d", p2.getData);
   $display("%b", p3.getData);
   $display("%0d", p4.getData);

end
endmodule

//OUTPUT:
// mayur krishna
// 25
// 0011
// 70
// End time: 15:52:58 on Nov 10,2021, Elapsed time: 0:00:06
// Errors: 0, Warnings: 1

