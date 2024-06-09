/***********************************************************************************************************
 * Name                 : MultiDimensional.sv
 * Creation Date        : 18-10-2021
 * Last Modified        : 22-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Use multi-dimensional array to implement a memory, initialize and print its content. Pack the array, access least 3 bytes, complement them and again store at the same locations.
************************************************************************************************************/
module MultiDimensional;

logic mem[2:0][4:0];
logic [14:0] pack;
//logic [0:15] arr1 [0:2][0:4], temp [0:2][0:4];
//logic [0:15] temp;
//shortint i=0, j=0, k=0, len1=0;

initial begin
   //Using multi-dimensional array to implement a memory
   //Initializing and printing its content.
   mem= '{'{1,0,1,0,0}, '{0,1,1,0,1}, '{1,0,0,1,1}};
   $display("array mem elements: %p", mem);

   //Packing the array
   pack = {>>{mem}};
   $display("array pack elements: %b\t%d", pack, pack);

   //Access least 3 bytes, complement them and again store at the same locations
   pack[2:0] = ~pack[2:0];
   $display("--after complementing least 3 bits: %b\t%d", pack, pack);
   //If out of bounds   
      //$display("arr2[50][50]: %0d --> out of bounds", arr1[50][50]);
end
endmodule

//Outputs:
//array mem elements: '{'{1, 0, 1, 0, 0}, '{0, 1, 1, 0, 1}, '{1, 0, 0, 1, 1}}
//array pack elements: 101000110110011	20915
//--after complementing least 3 bits: 101000110110100	20916
//End time: 14:27:50 on Jun 06,2022, Elapsed time: 0:00:04
//Errors: 0, Warnings: 1
