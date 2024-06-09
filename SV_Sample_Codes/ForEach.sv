/***********************************************************************************************************
 * Name                 : Loop_Final.sv
 * Creation Date        : 24-10-2021
 * Last Modified        : 27-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Using Dynamic arrays
************************************************************************************************************/

module DynamicArray;

logic [3:0] arr1[];
int i=0;

initial begin
   arr1 = new[12];
   foreach(arr1[i]) begin
      arr1[i] = $urandom;
   end

   $display("Array: %p, size: %0d", arr1, arr1.size);

   arr1 = new[24](arr1);
   $display("New array: %p, size: %0d", arr1, arr1.size);

   i=0;

   foreach(arr1[i]) begin
      $display("array[%0d]: %0d", i, arr1[i]);
   end
end
endmodule

//OUTPUT:
// Array: '{8, 6, 6, 6, 6, 6, 2, 14, 7, 10, 10, 4}, size: 12
// New array: '{8, 6, 6, 6, 6, 6, 2, 14, 7, 10, 10, 4, x, x, x, x, x, x, x, x, x, x, x, x}, size: 24
// array[0]: 8
// array[1]: 6
// array[2]: 6
// array[3]: 6
// array[4]: 6
// array[5]: 6
// array[6]: 2
// array[7]: 14
// array[8]: 7
// array[9]: 10
// array[10]: 10
// array[11]: 4
// array[12]: x
// array[13]: x
// array[14]: x
// array[15]: x
// array[16]: x
// array[17]: x
// array[18]: x
// array[19]: x
// array[20]: x
// array[21]: x
// array[22]: x
// array[23]: x
// End time: 23:31:10 on Oct 26,2021, Elapsed time: 0:00:06
// Errors: 0, Warnings: 1
