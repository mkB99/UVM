class fifo_rdr extends uvm_driver #(fifo_rtrans);

   `uvm_component_utils(fifo_rdr)
  
   virtual fifo_if.RDR_MP vif;
   agent_config m_cfg;
    
   function new (string name = "fifo_rdr", uvm_component parent);
       super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(agent_config) :: get(this, "", "agent_config", m_cfg)) 
         super.build_phase(phase);
         `uvm_info("RD_DRIVER", "driver built", UVM_MEDIUM)
   endfunction

   function void connect_phase(uvm_phase phase);
      vif = m_cfg.vif;
   endfunction

   task run_phase(uvm_phase phase);
      repeat(10) begin
         seq_item_port.get_next_item(req);
         send_to_dut(req);
         seq_item_port.item_done();
         `uvm_info("RD_DRIVER", "driver got trs", UVM_MEDIUM)
         `uvm_info("RD_DRIVER", $sformatf("rdrv: %p", req), UVM_MEDIUM)
         `uvm_info("RD_DRIVER", "driver transactions run", UVM_MEDIUM)
      end
   endtask
   
   task send_to_dut(fifo_rtrans req);
   //reset wait
   //signal drive   
      vif.rdr_cb.rd_en <= req.rd_en;
   endtask
   
endclass
