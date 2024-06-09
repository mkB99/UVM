class fifo_wdr extends uvm_driver #(fifo_wtrans);

   `uvm_component_utils(fifo_wdr)
  
   virtual fifo_if.WDR_MP vif;
   agent_config m_cfg;
    
   function new (string name = "fifo_wdr", uvm_component parent);
       super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(agent_config) :: get(this, "", "agent_config", m_cfg))
         `uvm_fatal("WR_DRIVER", "Cannot get()");
         super.build_phase(phase);
   endfunction
   
   function void connect_phase(uvm_phase phase);
      vif = m_cfg.vif;
   endfunction

   task run_phase(uvm_phase phase);
     repeat(10) begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done();
      req.print();
    end
   endtask
   
   task send_to_dut(fifo_wtrans req);
   //reset wait
   //signal drive   
      vif.wdr_cb.wr_en <= req.wr_en;
      vif.wdr_cb.din <= req.din;
   endtask
   
endclass
