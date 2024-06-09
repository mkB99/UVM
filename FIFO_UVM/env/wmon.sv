class fifo_wmon extends uvm_monitor;

   `uvm_component_utils(fifo_wmon)
  
   fifo_wtrans data_sent;
   virtual fifo_if.WMON_MP vif;
	agent_config m_cfg;
    
	uvm_analysis_port #(fifo_wtrans) mon_port;

   function new (string name = "fifo_wmon", uvm_component parent);
       super.new(name,parent);
		 mon_port = new("mon_port", this);
   endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(agent_config) :: get(this, "", "agent_config", m_cfg))
			`uvm_fatal("WR_MONITOR", "Cannot get()");
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
   
   task get_from_dut(fifo_wtrans req);
   //reset wait
   //signal drive   vif.wdr_cb.wr_addr <= req.wr_addr;
   endtask
   
endclass
