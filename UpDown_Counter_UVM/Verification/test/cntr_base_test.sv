//----------------------------------------------------------------------------------
// Project              : UVM_COUNTER
// Unit                 : counter_test 
// File                 : base_test.sv
//----------------------------------------------------------------------------------
// Created by           : Badam Mayur Krishna
// Creation Date        : 15 May 2022 
//-----------------------------------------------------------------------------------
// Description          : Base test class for uvm_counter. 
//                        This class is extended from uvm_test
//-----------------------------------------------------------------------------------

`ifndef COUNTER_BASE_TEST
`define COUNTER_BASE_TEST

class cntr_base_test extends uvm_test;
 
   `uvm_component_utils(cntr_base_test)
   
   cntr_env env_h;

   int no_of_dut;

   virtual cntr_inf vif[];
   virtual cntr_inf rst_vif;
  
   function new (string name = "base_test", uvm_component parent=null);
      super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
      super.build_phase(phase);

      if(!uvm_config_db #(int)::get(this, "*","no_of_dut", no_of_dut))
         `uvm_fatal("VIF_CONFIG","cannot get")         

      env_h = cntr_env::type_id::create("env_h",this);
      vif = new[no_of_dut];

      foreach(vif[i]) begin
         if(!uvm_config_db #(virtual cntr_inf)::get(this, "",$sformatf("vif_%0d",i), vif[i]))
            `uvm_fatal("VIF_CONFIG","cannot get")         
         if(!uvm_config_db #(virtual cntr_inf)::get(this, "","rst_vif", rst_vif))
            `uvm_fatal("RST_VIF_CONFIG","cannot get")         

         uvm_config_db#(virtual cntr_inf)::set(this,$sformatf("env_h.agent[%0d]",i),"vif",vif[i]);
      end

      //create sequences

   endfunction

   function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);

      foreach(vif[i]) begin
         env_h.agent[i].seqr_h.env=env_h;
      end
      
  endfunction
   
   virtual task run_phase (uvm_phase phase);
      phase.phase_done.set_drain_time(this,10);
   endtask

   virtual function void extract_phase(uvm_phase phase);
      `uvm_info("EXTRACT", $sformatf("@%0d: RUN COMPLETE",$time), UVM_HIGH) 
   endfunction

   function void report_phase(uvm_phase phase);
      uvm_report_server server1;

      server1 = uvm_report_server::get_server();

      if((server1.get_severity_count(UVM_ERROR) > 0) || (server1.get_severity_count(UVM_FATAL) > 0)) begin
         $display(" =============================================================");
         $display("                                                              ");
         $display("               ######    ##    #####  #                       "); 
         $display("               #        #  #     #    #                       "); 
         $display("               #       #    #    #    #                       "); 
         $display("               ######  ######    #    #                       "); 
         $display("               #       #    #    #    #                       "); 
         $display("               #       #    #    #    #                       "); 
         $display("               #       #    #  #####  #####                   "); 
         $display("                                                              ");
         $display(" =============================================================");
      end
      else begin
         $display("==============================================================");
         $display("                                                              ");
         $display("               #####     ##     ####   ####                   "); 
         $display("               #    #   #  #   #      #                       ");
         $display("               #    #  #    #  #      #                       "); 
         $display("               #####   ######   ###    ###                   "); 
         $display("               #       #    #      #      #                   "); 
         $display("               #       #    #      #      #                   "); 
         $display("               #       #    #  ####   ####                    "); 
         $display("                                                              "); 
         $display("==============================================================");
      end
   endfunction

   virtual task apply_reset(int a=20);
      vif[0].Reset <= 1;
      rst_vif.Reset <= 1;
      $display("time: %t", $time);
      #(a) $display("time: %t", $time);
      vif[0].Reset <= 0;
      rst_vif.Reset <= 0;
   endtask
endclass

`endif
