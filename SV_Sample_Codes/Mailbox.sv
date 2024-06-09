/*********************************************************************************************************************************
 * Name                 : Mailbox.sv
 * Creation Date        : 20-11-2021
 * Last Modified        : 23-11-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : Using mailbox for communication between generator and driver
 **********************************************************************************************************************************/
module mailbox;

class packet;
   rand byte address, data;
   constraint c1 {
      address>100;
      data inside {[0:100]};
   }
endclass

class generator;
packet p1;
  task send(mailbox mb);
     p1=new();
     if(!p1.randomize()) $display("packet p1 not randomized");
     $display("Packet after randomization: address: %0d, data: %0d",p1.address, p1.data);
     mb.put(p1);
     #5ns;
     mbx.peek(p1);
     $display("Packet sent!\t address:%0d, data:%0d, no.of elements in the mailbox: %0d ",p1.address,p1.data,mbx.num());
  endtask
endclass

class driver;
packet p2;
  task recieve(mailbox mb);
     p2=new();
     mb.get(p2);
     $display("Packet Recieved!:\t address:%0d, data:%0d, no.of elements in the mailbox: %0d ",p2.address,p2.data,mbx.num());
  endtask
endclass

mailbox mbx;
generator gen;
driver drv;

initial begin
   mbx = new();
   gen = new();
   drv = new();
   #5ns gen.send(mbx);
   #5ns drv.recieve(mbx);
end
endmodule

//OUTPUT:
// Packet after randomization: address: 103, data: 80
// Packet sent!	 address:103, data:80, no.of elements in the mailbox: 1 
// Packet Recieved!:	 address:103, data:80, no.of elements in the mailbox: 0 
// End time: 10:54:46 on Nov 23,2021, Elapsed time: 0:00:15
// Errors: 0, Warnings: 1
