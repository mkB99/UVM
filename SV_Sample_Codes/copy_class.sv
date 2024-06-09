/***********************************************************************************************************
 * Name                 : copy.sv
 * Creation Date        : 01-11-2021
 * Last Modified        : 10-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Create a class packet that has the properties of 32-bit type (addr, data) and object type (address_range). Now create objects of class packet p1 & p2 (allocate memory) and copy p1 to p2. Now make changes with respect to object p2 and observe class properties of p1(i.e. addr, data, address_range). Repeat the above steps with the use of custom copy method and observe the difference. 
************************************************************************************************************/

class address_range;
   integer min, max;

   function new(min, max);
      this.min = min;
      this.max = max;
   endfunction
   
   //deep copy method
   function void copy(address_range rhs);
      min = rhs.min;
      max = rhs.max;
   endfunction
endclass : address_range

class packet;
   integer addr, data;

   //object of type class address_range
   address_range range;
   function new(integer a, integer b, integer min, integer max);
      range = new(min,max);
      this.addr = a;
      this.data = b;
      range = new(min, max);
   endfunction
   
   //Deep copy method
   function void copy(packet rhs);
      addr = rhs.addr;
      data = rhs.data;
      range.copy(rhs.range);
   endfunction

   function void display1();
      $write("address: %0d, data: %0d, address range: %0d:%0d", addr,data, range.min, range.max );
   endfunction
endclass : packet

module copy;

packet p1, p2,p3;

initial begin
   //contructing object
   p1 = new(1000, 54, 0, 5000);
   $write("p1 before change: ");
   p1.display1();
   $display("\n");
   
   //shallow copy
   p2 = new p1;
   p2.addr = 2000;
   p2.range.min = 100;

   $write("\np1:");
   p1.display1();
   $write("\np2:");
   p2.display1();
   $display("\n");
   
   //deep copy
   p3 = new(1000, 54, 0, 5000);
   p3.copy(p1);
   p3.range.max= 6000;
   
   $write("\np1:");
   p1.display1();
   $write("\np3:");
   p3.display1();
   $display("\n");
end
endmodule

//OUTPUT:
// p1 before change: address: 1000, data: 54, address range: 0:0
// 
// 
// p1:address: 1000, data: 54, address range: 100:0
// p2:address: 2000, data: 54, address range: 100:0
// 
// 
// p1:address: 1000, data: 54, address range: 100:0
// p3:address: 1000, data: 54, address range: 100:6000
// 
// End time: 17:52:34 on Jun 01,2022, Elapsed time: 0:00:03
// Errors: 0, Warnings: 1
