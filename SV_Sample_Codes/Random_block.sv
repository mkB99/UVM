/**********************************************************************************************
 * Name                 : blocks.sv
 * Creation Date        : 17-11-2021
 * Last Modified        : 18-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Write a program to generate random data packet with random size and set constraint using set membership (inside) & iterative (foreach) method to assign to data packet, variable ordering (solve_before) & distributions (dist) for weighted probabilities and print the data packet after randomization (post_randomize). Also check whether the size is normal/oversized/runt using implication for random length of packet.
**********************************************************************************************/
module blocks;
class packet;
   rand bit[3:0] addr,size, j, data[4];
   int i=0; string ch;

   //membership constraint
   constraint c1{
      addr inside {[5:12]};
      //unique constraint
      unique {addr, size};
   }

   //weighted constraint
   constraint c2{
      size dist {2:=5, [8:12]:=7};
      addr dist {6:/4, [8:12]:/6};
   }

   //solve before
   constraint c3{
      solve size before addr;
      size inside {[1:10],[12:15]};
      addr == size-3;
   }

   //iterative constraint
   constraint c4{
      foreach(data[i]) data[i] inside {2,10,3,12,8,6};  
   }
   
   //implication
   constraint c5{
      j inside {1,2,3};
      (size<5) -> (j==1);
      (size>5 && size<10) -> (j==2);
      (size>10) -> (j==3);
   }
endclass

packet p1;

initial begin
p1 = new();
   repeat(5) begin
      //randomizing p1
      if(p1.randomize()) begin
      //checking if the size is normal, oversized or runt
      case(p1.j) 
         1: p1.ch = "Normal";
         2: p1.ch = "Oversized";
         3: p1.ch = "Runt";
      endcase
      $display("Address: %0d", p1.addr);
      $display("Size: %0d", p1.size);
      $display("Data4: %p", p1.data);
      $display("Size is : %s\n", p1.ch);
      end
      else
         $display("Not randomized");
   end
end
endmodule

//OUTPUT:
// Address: 9
// Size: 12
// Data4: '{8, 2, 6, 6}
// Size is : Runt
// 
// Address: 6
// Size: 9
// Data4: '{10, 2, 10, 8}
// Size is : Oversized
// 
// Address: 9
// Size: 12
// Data4: '{3, 8, 3, 2}
// Size is : Runt
// 
// Address: 9
// Size: 12
// Data4: '{12, 3, 10, 10}
// Size is : Runt
// 
// Address: 9
// Size: 12
// Data4: '{12, 8, 2, 12}
// Size is : Runt
// 
// End time: 16:25:01 on Jun 06,2022, Elapsed time: 0:00:12
// Errors: 0, Warnings: 1
