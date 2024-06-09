/*********************************************************************************************************************************
 * Name                 : .sv
 * Creation Date        : --2022
 * Last Modified        : --2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : 
**********************************************************************************************************************************/

module bool_seq;
   bit clk=0;
   int a,b;
   
   always 
      #5 clk=~clk;
   
   sequence S1;
      @(posedge clk) 
         (a==0) ##5 (b==2);
   endsequence

   initial begin
      a=0;
      b=3;
      #30;
      a=1;
      b=2;
      #30;
      a=1;
      b=4;
   end

   initial begin
      #100;
      $finish;
   end

   assert property (@(posedge clk) b == a+3) $display("boolean pass");
   else $display("boolean fail");

   assert property (S1) $display("sequence pass");
   else $display("sequence pass");

endmodule
