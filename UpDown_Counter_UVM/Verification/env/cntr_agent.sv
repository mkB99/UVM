//----------------------------------------------------------------------------------
// Project              : UVM_COUNTER
// Unit                 : cntr_agent 
// File                 : cntr_agent.sv
//----------------------------------------------------------------------------------
// Created by           : Badam Mayur Krishna
// Creation Date        : 15 May 2022 
//-----------------------------------------------------------------------------------
// Description          : This is agent class for uvm_counter. 
//                        This class is extended from uvm_agent
//-----------------------------------------------------------------------------------
`ifndef COUNTER_AGENT
`define COUNTER_AGENT

class cntr_agent extends uvm_agent;
   //Factory registration
   `uvm_component_utils(cntr_agent)
   
   //Virtual interface handle
   virtual cntr_inf vif;
   
   //components handles
   cntr_seqr seqr_h;
   cntr_drv drv_h;
   cntr_mon mon_h;

   //configuration class handle
   cntr_config agnt_cfg; 
   
   //constructor method
   function new (string name = "cntr_agent", uvm_component parent);
     super.new(name,parent);
   endfunction
   
   //build phase - for setting up
   function void build_phase (uvm_phase phase);
      super.build_phase(phase);

      //creating components
      mon_h = cntr_mon::type_id::create("mon_h",this);
      drv_h = cntr_drv::type_id::create("drv_h",this);
      seqr_h = cntr_seqr::type_id::create("seqr_h",this);

      //getting virtual interface vif from the config_db, which is available only for agent[i]
      if (!uvm_config_db #(virtual cntr_inf)::get(this,"","vif", vif)) 
        `uvm_fatal("AGENT", "The virtual interface get failed")

      //After getting vif, setting them to be available for all the components in the lower hierarchy
      uvm_config_db #(virtual cntr_inf)::set(this,"*","vif", vif);
   endfunction
   
   //Connect phase - for connections
   function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      
      //connecting driver's default seq_item_port to sequencer's seq_item_export
      drv_h.seq_item_port.connect(seqr_h.seq_item_export);
   endfunction
endclass

`endif
