/*********************************************************************************************************************************
 * Name                 : AssociativeArray.sv
 * Creation Date        : 21-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : 
 - Add 50 integer values at random locations (between 1 to 100) of an integer associative array.
 - Check value at index 2 and 45 exists?
 - Print the value at first index along with index.
 - Print the value at last index along with index.
 - Check the array size.
 - Delete 5th, 10th and 15th index if they exist.
 - Print array size again.
**********************************************************************************************************************************/
module AssociativeArray;
logic [32:0] a1[shortint];
int i=0;
int j,k;

initial begin
   repeat(50) begin
      a1[$urandom_range(100,0)] = $urandom_range(5000,0);
   end
   $display("Total array: %p",a1);

   //Checking value at index 2 and 45 exists?
   j= a1.exists(2) ? 1'b1 : 1'b0;
   if (j==1)
      $display("Element at index2 found"); 
      else
         $display("Element at index2 not found");
  
   j= a1.exists(45);
   if (j==1)
      $display("Element at index45 found"); 
      else
         $display("Element at index45 not found");

   //Printing the value at first and last index along with index, if found.
   if(a1.first(k))  
      $display("First element: At index: %0d, value: %0d ", k, a1[k]);

   if(a1.last(k))  
      $display("Last element: At index: %0d, value: %0d", k, a1[k]);

   //Checking the array size.
   $display("Size of the associative array: %0d", a1.size);

   //Deleting elements, if they exist.
   a1.delete(3);
   a1.delete(10);
   a1.delete(31);
   //Printing array size again.
   $display("Size of array after deleting: %0d", a1.size);
end
endmodule

//OUTPUT:
//Total array: '{0:3772, 1:4783, 3:3996, 4:4777, 6:2760, 12:3561, 20:141, 24:1061, 27:856, 28:2895, 30:1574, 31:1960, 32:198, 36:4849, 39:4996, 41:1115, 42:1961, 45:194, 50:4200, 54:4703, 55:4793, 59:4673, 61:2181, 62:4966, 65:2168, 66:617, 67:1111, 69:4765, 78:3369, 79:4679, 82:2326, 85:911, 88:432, 89:2196, 97:1920, 100:1790 }
//Element at index2 not found
//Element at index45 found
//First element: At index: 0, value: 3772 
//Last element: At index: 100, value: 1790
//Size of the associative array: 36
//Size of array after deleting: 34
//End time: 11:59:47 on Nov 19,2021, Elapsed time: 0:00:06
//Errors: 0, Warnings: 1
