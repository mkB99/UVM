//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_test 
// File                : cntr_pkg.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
// Last Modified Date  : 20 May 2022
//----------------------------------------------------------------------
// Description         : Package file for uvm_counter. 
//----------------------------------------------------------------------

`timescale 1ns/1ns

`include "cntr_inf.sv"

package cntr_pkg;

   import uvm_pkg::*;
   `include "uvm_macros.svh"

   `include "cntr_defines.sv"
   `include "cntr_trans.sv"
   `include "cntr_config.sv"
   //`include "env_config.sv"

   `include "cntr_drv.sv"
   `include "cntr_mon.sv"
   `include "cntr_seqr.sv"
   `include "cntr_agent.sv"

   `include "cntr_base_seqs.sv"
   `include "cntr_sb.sv"
   `include "cntr_env.sv"

   `include "cntr_base_test.sv"

   `include "cntr_reset_seqs.sv"
   `include "cntr_elu_seqs.sv"
   `include "cntr_rorb_seqs.sv"
   `include "cntr_one_seqs.sv"
   `include "cntr_two_seqs.sv"
   `include "cntr_priority_seqs.sv"

   `include "cntr_reset_test.sv"
   `include "cntr_elu_test.sv"
   `include "cntr_rorb_test.sv"
   `include "cntr_ports_test.sv"
   `include "cntr_priority_test.sv"
endpackage
