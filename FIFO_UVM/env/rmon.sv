class fifo_rmon extends uvm_monitor;

   `uvm_component_utils(fifo_rmon)
  
   fifo_rtrans data_sent;
   virtual fifo_if.RMON_MP vif;
   agent_config m_cfg;
    
   uvm_analysis_port #(fifo_rtrans) mon_port;

   function new (string name = "fifo_rmon", uvm_component parent);
       super.new(name,parent);
       mon_port = new("mon_port", this);
      `uvm_info("RD_MONITOR", "monitor got", UVM_MEDIUM);
   endfunction

   function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(agent_config) :: get(this, "", "agent_config", m_cfg))
         `uvm_fatal("RD_MONITOR", "Cannot get()");
         super.build_phase(phase);
   endfunction
   
   function void connect_phase(uvm_phase phase);
      vif = m_cfg.vif;
   endfunction
/*
   task run_phase(uvm_phase phase);
      get_from_dut(req);
   endtask
   */
   
   task get_from_dut(fifo_rtrans req);
   //reset wait
   //signal drive   vif.rdr_cb.wr_addr <= req.wr_addr;
   endtask
   
endclass
