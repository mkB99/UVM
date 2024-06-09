//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_top 
// File                : top.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : Top module of uvm_counter. 
//----------------------------------------------------------------------
`timescale 1ns/1ns

module top();
   import uvm_pkg::*;
   import cntr_pkg::*;
   `include "uvm_macros.svh"
   
  bit Clk=1;
  
  cntr_inf inf[no_dut](Clk);
  cntr_inf rst_inf(Clk);
  
  //dut instantiation - no way to make it configurable
   dut_top dut(.Clk(inf[0].Clk), 
               .Reset(rst_inf.Reset), 
               .Enable_1(inf[0].Enable), 
               .Load_1(inf[0].Load), 
               .UpDown_1(inf[0].UpDown), 
               .In_Data_1(inf[0].InData), 
               .Out_Data_1(inf[0].OutData), 
               .Enable_2(inf[1].Enable), 
               .Load_2(inf[1].Load), 
               .UpDown_2(inf[1].UpDown), 
               .In_Data_2(inf[1].InData), 
               .Out_Data_2(inf[1].OutData)); 

   //generating clock
   always
      #(CLK_PERIOD/2) Clk = ~Clk;

   //using generate-endgenerate block for setting the interfaces as virtual interafces into config_db
   generate 
      for(genvar i=0; i<no_dut; i++) begin
         initial begin
            uvm_config_db #(virtual cntr_inf)::set(null,"*",$sformatf("vif_%0d",i), inf[i]);
         end 
      end
      initial begin 
         uvm_config_db #(virtual cntr_inf)::set(null,"*","rst_vif", rst_inf);
         uvm_config_db #(int)::set(null,"*","no_of_dut", no_dut);
      end
   endgenerate

   //run_test default method - for running test
   initial begin
      run_test("cntr_base_test");
   end
endmodule
