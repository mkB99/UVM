//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_env 
// File                : cntr_env.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : This is configuration class for agent in uvm_counter. 
//                       This class is extended from uvm_env
//----------------------------------------------------------------------

`ifndef COUNTER_ENVIRONMENT
`define COUNTER_ENVIRONMENT

class cntr_env extends uvm_env;
   //Factory registration
   `uvm_component_utils(cntr_env)
   
   //components' handles - agent and scoreboard
   cntr_agent agent[];
   cntr_sb sb_h;
   virtual cntr_inf.RST_MP rst_vif;
   
   //local variable for creating the correct number of agents 
   local int no_of_dut;
   
   //constructor method
   function new (string name = "cntr_env", uvm_component parent=null);
      super.new(name,parent);
   endfunction
   
   //build phase
   function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      
      //getting the no_of_dut value from config_db
      if(!uvm_config_db #(int) :: get(this, "*", "no_of_dut", no_of_dut))
         `uvm_fatal("CONFIG","cannot get no_of_dut")
      
      //creating an array of agents of size no_of_dut
      agent = new[no_of_dut]; 

      foreach(agent[i]) begin
         agent[i] = cntr_agent::type_id::create($sformatf("agent[%0d]",i),this);
      end
      
      //getting interfaces for sending reset signal
      if(!uvm_config_db #(virtual cntr_inf)::get(this, ".","rst_vif", rst_vif))
         `uvm_fatal("VIF_CONFIG","cannot get rst_vif")         

      //creating scoreboard component
      sb_h = cntr_sb::type_id::create("sb_h",this);
   endfunction
   
   //connect phase
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      //connecting monitor's analysis port with the scoreboard's imp port
      agent[0].mon_h.mon_port.connect(sb_h.sb_imp0);
      agent[1].mon_h.mon_port.connect(sb_h.sb_imp1);//can we give two outputs to same imp.
   endfunction
   
   //End of elaboration phase
   function void end_of_elaboration_phase(uvm_phase phase);
      //printing the topology or hierarchy of the test bench
      uvm_top.print_topology();
   endfunction

   virtual task apply_reset(time a=10ns);
      #(a/10); //To avoid race condition like this without using clocking block

      rst_vif.rst_cb.Reset <= 1;
      #(a);
      rst_vif.rst_cb.Reset <= 0;
   endtask
endclass

`endif
