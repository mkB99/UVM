//----------------------------------------------------------------------
// Project             : UVM_COUNTER
// Unit                : counter_env 
// File                : cntr_drv.sv
//----------------------------------------------------------------------
// Created by          : Badam Mayur Krishna
// Creation Date       : 15 May 2022 
//----------------------------------------------------------------------
// Description         : Driver class for uvm_counter. 
//                       This class is extended from uvm_driver
//----------------------------------------------------------------------

`ifndef COUNTER_DRIVER
`define COUNTER_DRIVER

class cntr_drv extends uvm_driver #(cntr_trans);
   //Factory registration
   `uvm_component_utils(cntr_drv)
   `uvm_register_cb(cntr_drv, driver_callback)
  
   //virtual interface handle
   virtual cntr_inf.DRV_MP vif;

   //Constructor
   function new (string name = "cntr_drv", uvm_component parent);
       super.new(name,parent);
   endfunction

   //build phase 
   function void build_phase(uvm_phase phase);

      //getting vif from config_db, set from the agent
      if(!uvm_config_db #(virtual cntr_inf) :: get(this, "", "vif", vif))
         `uvm_fatal("DRIVER", "Driver did not get vif")
            super.build_phase(phase);
   endfunction
   
   //connect phase
   function void connect_phase(uvm_phase phase);
   endfunction

   //run phase
   task run_phase(uvm_phase phase);
      super.run_phase(phase);
      //forever loop for getting sequence_items from sequencer
      forever begin
         seq_item_port.get_next_item(req);

         `uvm_do_callbacks(cntr_drv, driver_callback, pre_drive())
         drive(req);
         `uvm_do_callbacks(cntr_drv, driver_callback, post_drive())
         seq_item_port.item_done();

         `uvm_info("DRIVER", $sformatf("mode: %s, emode: %s", req.mode, req.emode),UVM_HIGH)
      end
   endtask
   
   //task for driving transactions to the interface
   task drive(cntr_trans req);
      @(posedge vif.Clk);
         vif.drv_cb.InData <= req.InData;
         case(req.mode)
            DISABLE: begin
               case(req.emode)
                  NORMAL: begin
                     vif.drv_cb.Enable <= 0;
                     vif.drv_cb.Load <= 0;
                     vif.drv_cb.UpDown <= 0;
                  end
                  DISABLE_UP: begin
                     vif.drv_cb.Enable <= 0;
                     vif.drv_cb.Load <= 0;
                     vif.drv_cb.UpDown <= 1;
                  end
                  DISABLE_LOAD: begin
                     vif.drv_cb.Enable <= 0;
                     vif.drv_cb.Load <= 1;
                     vif.drv_cb.UpDown <= 0;
                  end
                  DISABLE_LOAD_UP: begin
                     vif.drv_cb.Enable <= 0;
                     vif.drv_cb.Load <= 1;
                     vif.drv_cb.UpDown <= 1;
                  end
               endcase
            end
           
            LOAD: begin
               case(req.emode)
                  NORMAL: begin
                     vif.drv_cb.Enable <= 1;
                     vif.drv_cb.Load <= 1;
                     vif.drv_cb.UpDown <= 0;
                  end

                  LOAD_UP: begin
                     vif.drv_cb.Enable <= 1;
                     vif.drv_cb.Load <= 1;
                     vif.drv_cb.UpDown <= 1;
                  end
               endcase
            end

            UP: begin
                  vif.drv_cb.Enable <= 1;
                  vif.drv_cb.Load <= 0;
                  vif.drv_cb.UpDown <= 1;
               end

            DOWN: begin
                    vif.drv_cb.Enable <= 1;
                    vif.drv_cb.Load <= 0;
                    vif.drv_cb.UpDown <= 0;
                 end
         endcase
      `uvm_info("DRIVER", "Driver sent data to interface", UVM_DEBUG)
   endtask
endclass

`endif
