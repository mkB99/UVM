/*********************************************************************************************************************************
 * Name                 : semophores.sv
 * Creation Date        : 16-11-2021
 * Last Modified        : 21-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Semophores for synchronization
**********************************************************************************************************************************/
/*class packet;
   rand byte address, data;
   constraint c{
   //values will be between 0 and 510 = 2(2^8 -1) (2(2^n -1))
      address>0;
      data > 0; 
   }
endclass

//typedef uparray packet[4];

class generator;
   packet p1[1:4];

   function void gen();
      int i=1;
      for(i=1; i<=4; i++)begin
         p1[i] = new();
      end
      for(i=1; i<=4; i++)begin
         p1[i].randomize();
      end
      $display("%p",p1);
   endfunction
endclass
*/


module semaphores;
int i;
semaphore s = new(1);

class Ethernet_driver;
   task recieve(string str);
      s.get();
      $display("%s, got the key at %0t", str, $time);
      #2;
      s.put();
      $display("%s, put the key at %0t",str, $time);
      #2;
      s.try_get();
      $display("%s, try_get at %0t",str,$time);
   endtask
endclass

initial begin
Ethernet_driver p[1:4];
   for(i=1;i<=4; i++) begin
      p[i] = new();
   end

   fork
      p[1].recieve("process - 1");
      p[2].recieve("process - 2");
      p[3].recieve("process - 3");
      p[4].recieve("process - 4");
   join

#50 $finish;
end
endmodule

//OUTPUT:
// Sv_Seed = 1589310803
// process - 1, got the key at 0
// process - 1, put the key at 2
// process - 2, got the key at 2
// process - 1, try_get at 4
// process - 2, put the key at 4
// process - 3, got the key at 4
// process - 2, try_get at 6
// process - 3, put the key at 6
// process - 4, got the key at 6
// process - 3, try_get at 8
// process - 4, put the key at 8
// process - 4, try_get at 10
// ** Note: $finish    : semaphores.sv(67)
//    Time: 60 ns  Iteration: 0  Instance: /semaphores
// End time: 17:21:30 on Nov 23,2021, Elapsed time: 0:00:12
// Errors: 0, Warnings: 1
