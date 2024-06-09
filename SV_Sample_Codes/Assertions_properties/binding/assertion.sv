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

module assertion_module(input wire clk_ip,input wire req_ip,input wire reset_ip,input wire gnt_ip);
  // Sequence Layer
  sequence req_gnt_seq;
    (~req_ip & gnt_ip) ##1 (~req_ip & ~gnt_ip);
  endsequence

  // Property Specification Layer
  property req_gnt_prop;
    @(posedge clk_ip)
      disable iff (reset_ip)
        req_ip |=> req_gnt_seq;
  endproperty

  // Assertion Directive Layer
  assert property (req_gnt_prop)  $display("@%0dns Assertion passed", $time);
    else  $display("@%0dns Assertion Failed", $time);
endmodule
