//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_env 
// File                : cntr_defines.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : defines file for uvm_counter. 
//----------------------------------------------------------------------
`ifndef COUNTER_DEFINES
`define COUNTER_DEFINES

//Macro for setting the size of the In_Data and Out_Data
`define WIDTH 8

//parameter for clock period
parameter CLK_PERIOD = 10;
parameter no_dut=2;

//typedef enums for controlling the counter
//enum typedef for sending regular transactions
typedef enum bit [2:0]//size of the enum values is bit [2:0] because by default it is integer type - for writing coverage bins
                     {
                        DISABLE = 3'b000, 
                        LOAD = 3'b110, 
                        UP = 3'b101, 
                        DOWN = 3'b100
                       } mode_e;

//enum typedef for erroroneous scenarios
typedef enum bit [2:0] {
                        NORMAL, 
                        DISABLE_LOAD = 3'b010, 
                        DISABLE_LOAD_UP = 3'b011, 
                        DISABLE_UP = 3'b001, 
                        LOAD_UP = 3'b111
                       } error_mode_e;

`endif
