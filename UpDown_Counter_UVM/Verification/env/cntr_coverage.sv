/*********************************************************************************************************************************
 * Name                 : cntr_coverage.sv
 * Creation Date        : 10-09-2022
----------------------------------------------------------------------------------------------------------------------------------
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
----------------------------------------------------------------------------------------------------------------------------------
 * Description          : This file contains the generic covergroup for uvm updown counter project
**********************************************************************************************************************************/
`ifndef COUNTER_COVERAGE
`define COUNTER_COVERAGE

   covergroup counter_cg with function sample(bit Reset, mode_e mode, mode1, mode2, error_mode_e emode, emode1, emode2, bit [`WIDTH-1:0] InData, InData1, InData2, OutData);
      option.per_instance = 1;
      type_option.merge_instances = 1;

      option.comment = "This coverage is for checking reset and its priority against Enable,Load, UpDown";
      
      //coverpoint for reset
      RESET_PRIORITY: coverpoint {Reset, (InData inside {['h01:'hFE]}), mode, OutData}{
         bins bin1 =          {[13'b1_1_110_0000_0000:13'b1_1_110_0000_0000]}; 
         wildcard bins bin2 = ([13'b0_1_100_0000_0001:13'b0_1_100_1111_1110] => 13'b1_1_100_0000_0000); 
         wildcard bins bin3 = ([13'b0_1_110_0000_0001:13'b0_1_110_1111_1110] => 13'b1_1_110_0000_0000);
         wildcard bins bin4 = ([13'b0_1_101_0000_0001:13'b0_1_101_1111_1110] => 13'b1_1_101_0000_0000);
      }

      //coverpoint for checking Enable, Load, UpDown
      ELU: coverpoint {Reset, (InData inside {['h00:'hff]}), mode, emode, OutData} {
         wildcard bins elu_bin_1 = {16'b0_1_000_010_0000_0000};
         wildcard bins elu_bin_2 = {[16'b0_1_000_010_0000_0000 : 16'b0_1_000_010_1111_1111]};
         wildcard bins elu_bin_3 = {[16'b0_1_110_000_0000_0000 : 16'b0_1_110_000_1111_1111]};
         wildcard bins elu_bin_4 = {[16'b0_1_101_000_0000_0000 : 16'b0_1_101_000_1111_1111]};
         wildcard bins elu_bin_5 = {[16'b0_1_100_000_0000_0000 : 16'b0_1_100_000_1111_1111]};
      }

      //coverpoint for rollback and rollover test
      RORB: coverpoint {mode, OutData} {
         wildcard bins rorb_bin_1 = (11'b101_1111_1111 => 11'b101_0000_0000);
         wildcard bins rorb_bin_2 = (11'b100_0000_0000 => 11'b100_1111_1111);
      }

      //coverpoint for checking the priority
      PRIORITY: coverpoint {Reset, InData, mode, emode, OutData} {
         bins priority_bin_1 = (23'b0_0000_0101_110_000_0000_0101 => 23'b0_0000_0101_000_010_0000_0101);
         bins priority_bin_2 = (23'b0_0000_0110_110_111_0000_0110 => 23'b0_0000_0110_000_001_0000_0110);
         bins priority_bin_3 = (23'b0_0000_0101_100_000_0000_0100 => 23'b0_0000_0101_110_000_0000_0101);
         bins priority_bin_4 = (23'b0_0000_0101_101_000_0000_0110 => 23'b0_0000_0101_110_111_0000_0101);
      }

      //coverpoints for checking ports
      PORTS: coverpoint {Reset, (InData1 == 'd5), mode1, emode1, (InData2 == 'd20), mode2, emode2} {
         bins ports_bin_1 = {15'b0_1_000_010__1_110_000};
         bins ports_bin_2 = {15'b0_1_110_000__1_000_010};
         bins ports_bin_3 = {15'b0_1_101_000__1_100_000};
      }
   endgroup
`endif
