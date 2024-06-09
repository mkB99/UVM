/***********************************************************************************************************
 * Name                 : inheritance.sv
 * Creation Date        : 06-11-2021
 * Last Modified        : 07-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Create two classes with different properties and same method. Extend one class to another. Now access parent class properties and methods through child class. Use super keyword and display methods of parent class.
************************************************************************************************************/
module inheritance;

//class person which has common features
class person;
   int id, age;
   string name,fname="B",mname="Mayur", address;

   function string getname();
      return mname;
   endfunction
endclass

//class student is inherited from class person.
class student extends person;
   int rollno, year;
   string branch;

   //method to get name 
   function string getname();
      return {fname,". ",mname};
   endfunction

   //method to get name from super class
   function string getnamesuper();
      return (super.getname());
   endfunction
endclass

person mayur1;
student mayur, mayur2;

initial begin
   mayur = new();
   mayur1 = new();
   mayur2 = new();

   //accessing names from different objects
   mayur.name = mayur.getname();
   mayur1.name = mayur1.getname();
   mayur2.name = mayur2.getnamesuper();

   mayur.id = 12345;
   mayur.age = 22;
   mayur.rollno = 47;
   mayur.branch = "EIE";
 
   $display("name: %s -> student \nname: %s -> person \nname: %s -> student2 \nid: %0d \nage: %0d \nrollno: %0d \nbranch: %s", mayur.name, mayur1.name, mayur2.name ,mayur.id, mayur.age, mayur.rollno, mayur.branch);
end
endmodule

//OUTPUT:
// name: B. Mayur -> student 
// name: Mayur -> person 
// name: Mayur -> student2 
// id: 12345 
// age: 22 
// rollno: 47 
// branch: EIE
// End time: 11:14:16 on Nov 11,2021, Elapsed time: 0:00:06
// Errors: 0, Warnings: 1

