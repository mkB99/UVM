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
`include "dut.sv"
`include "assertion.sv"
//`include "binding.sv"

module tb();
  reg clk = 0;
  reg reset, req = 0;
  wire gnt;
 
  dut DUT_INST_1 (clk,req,reset,gnt);
  dut DUT_INST_2 (clk,req,reset,gnt);
  dut DUT_INST_3 (clk,req,reset,gnt);
 
  // Bind by Module name : This will bind ALL instance of DUT
  bind dut assertion_module assert_ip (.clk_ip(clk), .req_ip(req), .reset_ip (reset), .gnt_ip(gnt));

  //Bind by instance name : This will bind only one particular instance of DUT
  //bind dut :$root.bind_assertion_tb.DUT_INST_1 assertion_module assert_ip (.clk_ip(clk), .req_ip(req), .reset_ip (reset), .gnt_ip(gnt));

  //Bind by instance name list : This will bind multiple instances of DUT
  //bind dut :$root.bind_assertion_tb.DUT_INST_1, $root.bind_assertion_tb.DUT_INST_2 assertion_module assert_ip (.clk_ip(clk), .req_ip(req), .reset_ip (reset), .gnt_ip(gnt));

  always #5 clk ++;
 
  initial begin
    reset <= 1;
    #20 reset <= 0;

    // Make the assertion pass
    #100 @ (posedge clk) req  <= 1;
    @(posedge clk) req <= 0;

    // Make the assertion fail
    #100 @ (posedge clk) req  <= 1;
    repeat (5) @ (posedge clk);
    req <= 0;

    // Make the assertion pass
    #100 @ (posedge clk) req  <= 1;
    @(posedge clk) req <= 0;

    #50 $finish;
  end
endmodule

//OUTPUT:
// @155ns Assertion passed
// @155ns Assertion passed
// @155ns Assertion passed
// @255ns Assertion Failed
// @255ns Assertion Failed
// @255ns Assertion Failed
// @265ns Assertion Failed
// @265ns Assertion Failed
// @265ns Assertion Failed
// @275ns Assertion Failed
// @275ns Assertion Failed
// @275ns Assertion Failed
// @285ns Assertion Failed
// @285ns Assertion Failed
// @285ns Assertion Failed
// @305ns Assertion passed
// @305ns Assertion passed
// @305ns Assertion passed
// @415ns Assertion passed
// @415ns Assertion passed
// @415ns Assertion passed

