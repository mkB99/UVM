/*********************************************************************************************************************************
 * Name                 : expect.sv
 * Creation Date        : 14-05-2022
 * Last Modified        : 14-05-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
* Description          : Assertions - expect statement
**********************************************************************************************************************************/
module expect_m;
int a,b;
logic clk=0,ctrl;
   always #5 clk = ~clk; 

   property p1;
      @(posedge clk) a == b;
   endproperty

   always @(posedge clk) begin
   if(ctrl) 
      expect (p1) 
         $display("@%0t p1 passed", $time); 
      else 
         $display("@%0t p1 failed. So, execution is blocked", $time);
   end

   initial begin
      ctrl = 0;
      a=1;
      b=1;
      #15 a=4; b=5;
      #25 ctrl=1; a=5; b=5;
      #25 ctrl=1; a=5; b=6;
      #25 ctrl=1; a=6; b=6;

      #25 $finish;
   end
endmodule

//OUTPUT:
//@55 p1 passed
//@75 p1 failed. So, execution is blocked
//@95 p1 passed

