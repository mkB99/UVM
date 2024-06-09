//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_test 
// File                : cntr_pkg.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : Package file for uvm_counter. 
//----------------------------------------------------------------------

`ifndef COUNTER_PACKAGE
`define COUNTER_PACKAGE

`timescale 1ns/1ns

`include "cntr_inf.sv"

package cntr_pkg;

   import uvm_pkg::*;
   `include "uvm_macros.svh"

   `include "cntr_defines.sv"
   `include "cntr_trans.sv"
   `include "cntr_config.sv"
   `include "cntr_callbacks.sv"

   `include "cntr_drv.sv"
   `include "cntr_mon.sv"
   `include "cntr_seqr.sv"
   `include "cntr_agent.sv"

   `include "cntr_coverage.sv"
   `include "cntr_base_seqs.sv"
   `include "cntr_sb.sv"
   `include "cntr_env.sv"

   `include "cntr_base_test.sv"

   `include "cntr_reset_seqs.sv"
   `include "cntr_elu_seqs.sv"
   `include "cntr_rorb_seqs.sv"
   `include "cntr_ports_seqs.sv"
   `include "cntr_priority_seqs.sv"
   `include "cntr_InData_seqs.sv"

   `include "cntr_reset_test.sv"
   `include "cntr_callback_reset_test.sv"
   `include "cntr_elu_test.sv"
   `include "cntr_rorb_test.sv"
   `include "cntr_ports_test.sv"
   `include "cntr_priority_test.sv"
   `include "cntr_InData_test.sv"
endpackage

`endif
