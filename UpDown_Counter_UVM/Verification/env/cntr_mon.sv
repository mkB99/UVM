//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_env 
// File                : mon.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : Monitor class for uvm_counter. 
//                       This class is extended from uvm_monitor
//----------------------------------------------------------------------
`ifndef COUNTER_MONITOR
`define COUNTER_MONITOR

class cntr_mon extends uvm_monitor;
   //Factory registration
   `uvm_component_utils(cntr_mon)
   
   //transaction handle for data to be sent to scoreboard
   cntr_trans data2scb=new();

   //virtual interface handle
   virtual cntr_inf.MON_MP vif;
   
   //analysis port for sending data to scoreboard
   uvm_analysis_port #(cntr_trans) mon_port;
   
   //Constructor method
   function new (string name = "cntr_mon", uvm_component parent);
       super.new(name,parent);
       mon_port = new("mon_port", this);
   endfunction

   //build phase method
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      //getting the vif from the config_db
      if(!uvm_config_db #(virtual cntr_inf) :: get(this, "", "vif", vif))
         `uvm_fatal("MONITOR", "Monitor did not get vif")
   endfunction
   
   //connect phase
   function void connect_phase(uvm_phase phase);
   endfunction

   //run phase
   task run_phase(uvm_phase phase);
      //forever loop for getting data from dut and writing into analysis port
      forever begin
         get_from_dut(data2scb);
         `uvm_info("MONITOR", "Monitor got", UVM_DEBUG)       

         `uvm_info("MONITOR",$sformatf("Enable: %0d, Load: %0d, UpDown: %0d",vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown), UVM_FULL)
         `uvm_info("MONITOR",$sformatf("mode: %s, emode: %s, InData: %0d, OutData: %0d", data2scb.mode, data2scb.emode, data2scb.InData, data2scb.OutData),UVM_HIGH)
         mon_port.write(data2scb); 
      end
   endtask

   //task for getting data from the interface and making transactions
   task get_from_dut(cntr_trans data2scb);
      //getting data at posedge of Clk
      @(posedge vif.Clk) begin
         data2scb.InData = vif.mon_cb.InData; 
         data2scb.emode = NORMAL;

         if({vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown} == 3'b000) begin
            data2scb.mode = DISABLE;
         end
         else if({vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown} == 3'b001) begin
            data2scb.mode = DISABLE;
            data2scb.emode = DISABLE_UP;
         end
         else if({vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown} == 3'b010) begin
            data2scb.mode = DISABLE;
            data2scb.emode = DISABLE_LOAD;
         end
         else if({vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown} == 3'b011) begin
            data2scb.mode = DISABLE;
            data2scb.emode = DISABLE_LOAD_UP;
         end
         else if({vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown} == 3'b110) begin
            data2scb.mode = LOAD;
         end
         else if({vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown} == 3'b111) begin
            data2scb.mode = LOAD;
            data2scb.emode = LOAD_UP;
         end
         else if({vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown} == 3'b101) begin
            data2scb.mode = UP;
         end
         else if({vif.mon_cb.Enable, vif.mon_cb.Load, vif.mon_cb.UpDown} == 3'b100) begin
            data2scb.mode = DOWN;
         end

         data2scb.OutData = vif.mon_cb.OutData; 
      end
   endtask
endclass

`endif
